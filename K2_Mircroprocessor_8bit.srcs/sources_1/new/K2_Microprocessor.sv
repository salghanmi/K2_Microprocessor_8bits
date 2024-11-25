`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2024 12:35:46 PM
// Design Name: 
// Module Name: K2_Microprocessor
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
module K2_Microprocessor #(
    parameter PC_N = 4,           // Width of the program counter (address bits)
    parameter INSTR_N = 8,        // Width of instructions from ROM
    parameter REG_ADDR_WIDTH = 2, // Width of register address (D1, D0)
    parameter REG_A_B_O_WIDTH = 4, // Width of RA, RB, and RO registers
    parameter WRAP_AROUND =  4'b1000 
)(
    input clk,                    // Clock signal
    input reset,                  // Reset signal
    output [INSTR_N-1:0] rom_data, // Instruction fetched from ROM
    output [REG_A_B_O_WIDTH-1:0] RA_out, // Data output of RA
    output [REG_A_B_O_WIDTH-1:0] RB_out, // Data output of RB
    output [REG_A_B_O_WIDTH-1:0] RO_out  // Data output of RO
//    output [PC_N-1:0] program_counter
);

    // Internal signals
    wire [PC_N-1:0] program_counter;      // Program counter output
    wire [INSTR_N-1:0] instruction;       // Instruction fetched from ROM
    reg j_i, jc_i, j , jc ;                           // Jump control signals
    wire [REG_ADDR_WIDTH-1:0] reg_addr;   // Register address (D)
    wire Sreg, S;                         // ALU and Mux control signals
    wire [2:0] imm;                       // Immediate value
    reg write_enable;                    // Write enable signal
    wire en_RA, en_RB, en_RO;             // Write enables for RA, RB, RO
    wire [REG_A_B_O_WIDTH-1:0] Mux1_out, Mux2_out;   // Mux output
    wire [REG_A_B_O_WIDTH-1:0] ALU_out;   // ALU output
    wire carry;                           // ALU carry/borrow flag
    wire Dff_out;                         // Latched carry flag
    wire load;                            // Load signal for program counter
    reg load_sync;
    wire [REG_A_B_O_WIDTH-1:0] data_mem_out; // Data Memory output
    wire [1:0] mem_en;                    // Memory enable signals

    // Program Counter
    Program_Counter #(
        .N(PC_N) , .WRAP_AROUND(WRAP_AROUND)
    ) PC_inst (
        .clk(clk),
        .reset(reset),
        .load(load),
        .load_value({{(PC_N-3){1'b0}}, imm}), // Extend imm to PC width
        .pc(program_counter)
    );

    // ROM Module
    ROM #(
        .N(PC_N)
    ) rom_inst (
        .clk(clk),
        .a(program_counter), // Address input
        .b(instruction)      // Instruction output
    );

    // Control Logic
    Control_Logic control_logic_inst (
        .instruction(instruction), // Instruction input
        .j(j_i),                     // Unconditional jump
        .jc(jc_i),                   // Conditional jump
        .D(reg_addr),              // Register address
        .Sreg(Sreg),               // Mux select
        .S(S),                     // ALU operation selector
        .imm(imm),                  // Immediate value
        .mem_en(mem_en)            // Memory enable signals =======================================
    );

    // Register Write Decoder
    Decoder decoder_inst (
        .D(reg_addr),              // Register address
        .write_enable(write_enable), // Global write enable
        .en_RA(en_RA),             // Enable for RA
        .en_RB(en_RB),             // Enable for RB
        .en_RO(en_RO)              // Enable for RO
    );

    // Register RA
    Register #(
        .n(REG_A_B_O_WIDTH)
    ) RA_inst (
        .clk(clk),
        .reset(reset),
        .en(en_RA), // Storing 
        .d(Mux2_out), // Data from multiplexer number 2
        .q(RA_out)   // Data output
    );

    // Register RB
    Register #(
        .n(REG_A_B_O_WIDTH)
    ) RB_inst (
        .clk(clk),
        .reset(reset),
        .en(en_RB),
        .d(Mux2_out), // Data from multiplexer number 2 
        .q(RB_out)   // Data output
    );

    // Register RO
    Register #(
        .n(REG_A_B_O_WIDTH)
    ) RO_inst (
        .clk(clk),
        .reset(reset),
        .en(en_RO),
        .d(RA_out),  // Data from RA
        .q(RO_out)   // Data output
    );

    
     D_FF dff_inst(
     .d(carry) , 
     .reset(reset), 
    .enable(1'b1), 
    .clk(clk), 
    .q(Dff_out)
     );

    // Multiplexer number 1 
    Multiplexers #(
        .N(REG_A_B_O_WIDTH)
    ) Mux1_inst (
        .a({{(REG_A_B_O_WIDTH-3){1'b0}}, imm}), // Immediate value
        .b(ALU_out),                            // ALU output
        .select(Sreg),                          // Mux select
        .OUT(Mux1_out)                           // Mux output
    );


    // Multiplexer number 2 
    Multiplexers #(
        .N(REG_A_B_O_WIDTH)
    ) Mux2_inst (
        .b(Mux1_out), // Mux 1 output 
        .a(data_mem_out),                            // Memory Data out
        .select(mem_en[1]),                          // Mux select
        .OUT(Mux2_out)                           // Mux output
    );
    
    
    // ALU
    ALU #(
        .N(REG_A_B_O_WIDTH)
    ) alu_inst (
//        .clk(clk),
        .a(RA_out),        // Input A (RA)
        .b(RB_out),        // Input B (RB)
        .s(S),             // Operation selector
        .out(ALU_out),     // Output
        .carry(carry)      // Carry/borrow flag
    );

    // Data Memory
    Data_Memory #(
        .DATA_WIDTH(REG_A_B_O_WIDTH),
        .ADDR_WIDTH(3)
    ) data_mem_inst (
        .clk(clk),
        .imm(imm),                // Address input
        .reset(reset),
        .mem_en(mem_en),          // Memory enable signals [0] for read, [1] for write
        .data_in(RA_out),         // Data input for store operation
        .data_out(data_mem_out)   // Data output for load operation
    );

    // Load Signal Logic
    assign j = j_i & ~jc_i; 
    assign jc = jc_i & ~j_i;
    
    assign load = j || (Dff_out && jc); // Load if unconditional or conditional jump
    assign write_enable = ~(j || jc);  // Disable writes during jumps
    

    // Debugging Output
    assign rom_data = instruction;

    
always @(posedge clk ) begin
    if (reset)
        load_sync <= 0;
    else
        load_sync <= load; // Synchronize the load signal
end

endmodule


