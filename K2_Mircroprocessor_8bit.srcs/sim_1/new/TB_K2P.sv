`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2024 01:35:54 PM
// Design Name: 
// Module Name: TB_K2P
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

module TB_K2P;
    // Parameters
    parameter PC_N = 4;
    parameter INSTR_N = 8;
    parameter REG_ADDR_WIDTH = 2;
    parameter REG_A_B_O_WIDTH = 8;

    // Testbench signals
    reg clk;
    reg reset;
    wire [INSTR_N-1:0] rom_data;
    wire [REG_A_B_O_WIDTH-1:0] RA_out, RB_out, RO_out;

    // Instantiate the K2 Microprocessor
    K2_Microprocessor #(
        .PC_N(PC_N),
        .INSTR_N(INSTR_N),
        .REG_ADDR_WIDTH(REG_ADDR_WIDTH),
        .REG_A_B_O_WIDTH(REG_A_B_O_WIDTH)
    ) uut (
        .clk(clk),
        .reset(reset),
        .rom_data(rom_data),
        .RA_out(RA_out),
        .RB_out(RB_out),
        .RO_out(RO_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock period = 10 time units
    end

    // ROM Initialization
    initial begin

    end

    // Test procedure
    initial begin
        // Test initialization
        $display("Starting Testbench...");
        
        // Apply reset
        reset = 1;
        #10;
        reset = 0;
        #10
// Comprehensive monitor for processor states
$monitor("Time: %0t | PC: %b | ROM Data: %b | RA: %b | RB: %b | RO: %b | ALU Out: %b | Carry: %b | en_RA: %b | en_RB: %b | en_RO: %b | Imm: %b | Sreg: %b | Mux1 Out: %b |Mux2Out: %b|  J: %b | JC: %b", 
         $time, uut.program_counter, rom_data, RA_out, RB_out, RO_out, uut.ALU_out, uut.carry, uut.en_RA, uut.en_RB, uut.en_RO, uut.imm, uut.Sreg, uut.Mux1_out, uut.Mux2_out, uut.j, uut.jc);

//$monitor("Time: %0t | PC: %b | ROM Data: %b | RA: %b | RB: %b | RO: %b | ALU Out: %b | Carry: %b | en_RA: %b | en_RB: %b | en_RO: %b | Imm: %b | Sreg: %b | Mux Out: %b | J: %b | JC: %b | Load: %b", 
//         $time, uut.program_counter, rom_data, RA_out, RB_out, RO_out, uut.ALU_out, uut.carry, uut.en_RA, uut.en_RB, uut.en_RO, uut.imm, uut.Sreg, uut.Mux_out, uut.j, uut.jc, uut.load);



//        // Monitor outputs
//        $monitor("Time: %0t | ROM Data: %b | RA: %b | RB: %b | RO: %b", 
//                 $time, rom_data, RA_out, RB_out, RO_out);
//        $monitor("Time: %0t | en_RA: %b | en_RB: %b | en_RO: %b", $time, uut.en_RA, uut.en_RB, uut.en_RO);
//$monitor("Time: %0t | ALU Out: %b | Carry: %b | RA Out: %b | RB Out: %b", $time, uut.ALU_out, uut.carry, uut.RA_out, uut.RB_out);
//$monitor("Time: %0t | PC: %b | J: %b | JC: %b | Carry: %b", $time, uut.program_counter, uut.j, uut.jc, uut.DFF_out);
//// Enhanced monitor for internal debugging
//$monitor("Time: %0t | ROM Data: %b | PC: %b | RA: %b | RB: %b | RO: %b | ALU Out: %b | Carry: %b | en_RA: %b | en_RB: %b | en_RO: %b",
//         $time, rom_data, uut.program_counter, RA_out, RB_out, RO_out, uut.ALU_out, uut.carry, uut.en_RA, uut.en_RB, uut.en_RO);
//$monitor("Time: %0t | RA_out: %b | RB_out: %b | Imm: %b | Sreg: %b | Mux Out: %b", 
//         $time, RA_out, RB_out, uut.imm, uut.Sreg, uut.Mux_out);
//    $monitor("Time: %0t | Instruction: %b | Imm: %b | Sreg: %b | Mux Out: %b", 
//         $time, rom_data, imm, Sreg, Mux_out);

        #200;

        $display("Testbench completed.");
        $stop;
    end

endmodule

