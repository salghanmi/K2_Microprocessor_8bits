`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2024 10:25:04 PM
// Design Name: 
// Module Name: TOP_K2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TOP_K2(

    input wire CLK100MHZ,    // 100 MHz input clock from FPGA
    input wire CPU_RESETN,   // Active-low reset signal
    //input wire BTNC,         // Center button for toggling pause
   // input wire [7:0] SW,     
    output wire CA, CB, CC, CD, CE, CF, CG, DP, // Seven-segment segment outputs
    output wire  [2:0] LED,
    output wire [7:0] AN     // Seven-segment digit enables
);


logic reset;              // Reset signal (active high)
logic clk_1Hz;            // 1 Hz clock for processor
logic [7:0] rom_data;     // Debug output from ROM
logic [7:0] RA_out, RB_out, RO_out, program_counter; // Processor register outputs
reg [3:0] digits[7:0];  // Seven-segment display inputs
 reg [6:0] Seg;          // Decoded segment outputs (a-g)

// Invert CPU_RESETN to get active-high reset
assign reset = ~CPU_RESETN;
assign LED[0] = reset;
assign LED[1] = clk_1Hz; // Debug 1 Hz clock
assign LED[2] = RA_out; 


// Instantiate Clock Divider (100 MHz -> 1 Hz)
//CLK_DIV_1HZ #(
//    .N(100000000)  // 1 Hz from 100 MHz clock
//) clk_div_inst (
//    .clk(CLK100MHZ),
//    .reset(reset),    // Active-high reset
//    .out(clk_1Hz)
//);

CLK_Dividers #(
    .N(100000000)  // Clock division factor
)(
    .clk(CLK100MHZ),
    .reset(reset),
    .clk_out(clk_1Hz)
);
   

// Instantiate K2 Microprocessor
K2_Microprocessor #(
    .PC_N(4),                // Program counter width
    .INSTR_N(8),             // Instruction width
    .REG_ADDR_WIDTH(2),      // Register address width
    .REG_A_B_O_WIDTH(8),     // Register data width
    .WRAP_AROUND(4'b1100)    // Program counter wrap-around value
) processor (
    .clk(clk_1Hz),           // Use 1 Hz clock for debugging
    .reset(reset),           // Active-high reset
    .rom_data(rom_data),     // ROM data output (debugging)
    .program_counter(program_counter),
    .RA_out(RA_out),         // RA register output
    .RB_out(RB_out),         // RB register output
    .RO_out(RO_out)          // RO register output
);

// Instantiate Seven-Segment Display Controller
sev_seg_controller #(
    .display_speed(20) // Adjust speed to match FPGA clock frequency
) ssc (
    .clk(CLK100MHZ),       // 100 MHz clock for display scanning
    .resetn(reset),       // Provide active-low reset signal from active-high reset
    .digits(digits),       // Input digits
    .Seg(Seg),             // Seven-segment outputs (a-g)
    .AN(AN)                // Seven-segment digit enables
);


      // Display RA, RB, and RO on Seven-Segment Displays
    assign digits[0] = RA_out[3:0];    // Lower nibble of RA
    assign digits[1] = RA_out[7:4];    // Upper nibble of RA
    assign digits[2] = RB_out[3:0];    // Lower nibble of RB
    assign digits[3] = RB_out[7:4];    // Upper nibble of RB
    assign digits[4] = RO_out[3:0];    // Lower nibble of RO
    assign digits[5] = RO_out[7:4];    // Upper nibble of RO
    // Display the program counter on the last two digits
    assign digits[6] = program_counter[3:0]; // Lower nibble of PC
    assign digits[7] = program_counter[7:4]; // Upper nibble of PC
//    assign digits[6] = 4'b1111;        // Blank
//    assign digits[7] = 4'b1111;        // Blank
    // Map Seven-Segment Segments to Outputs
    assign CA = Seg[0];
    assign CB = Seg[1];
    assign CC = Seg[2];
    assign CD = Seg[3];
    assign CE = Seg[4];
    assign CF = Seg[5];
    assign CG = Seg[6];
    assign DP = 1'b1; // Turn off decimal point

endmodule

