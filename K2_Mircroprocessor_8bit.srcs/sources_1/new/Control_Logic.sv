`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2024 10:39:01 AM
// Design Name: 
// Module Name: Control_Logic
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

//module Control_Logic (
//    input  [7:0] instruction,  // Instruction from ROM
//    output       j,            // Unconditional jump
//    output       jc,           // Conditional jump
//    output [1:0] D,            // Register address
//    output       Sreg,         // Mux selector for ALU/custom input
//    output       S,            // ALU operation selector
//    output [2:0] imm,           // Immediate value
//    output reg [1:0] mem_en
//);

//    assign j    = instruction[7];          // J (Unconditional jump)
//    assign jc   = instruction[6];          // JC (Conditional jump)
//    assign D    = instruction[5:4];        // Register address (D1, D0)
//    assign Sreg = instruction[3];          // Select ALU/custom input
//    assign S    = instruction[2];          // ALU operation (0=Add, 1=Sub)
//    assign imm  = instruction[2:0];        // Immediate value (imm[2:0])
    
    
// // Memory Enable Logic
//    always_comb begin
//        case (instruction[7:3])
//            5'b11000: mem_en = 2'b10; // RA = imm (from memory), Enable read
//            5'b11010: mem_en = 2'b10; // RB = imm (from memory), Enable read
//            5'b11110: mem_en = 2'b01; // imm = RA, Enable write
//            default: mem_en = 2'b00; // No memory operation
//        endcase
//    end
     
//endmodule
// module Control_Logic (
//    input  [7:0] instruction,         // Instruction from ROM
//    output reg j,                     // Unconditional jump
//    output reg jc,                    // Conditional jump
//    output reg [1:0] D,               // Register address
//    output reg Sreg,                  // Mux selector for ALU/custom input
//    output reg S,                     // ALU operation selector
//    output reg [2:0] imm,             // Immediate value
//    output reg write_enable,          // Enable write to memory
//    output reg read_enable            // Enable read from memory
//);

//    // Decode instruction fields
//    always @(*) begin
//        // Extract fields from instruction
//        j = instruction[7];
//        jc = instruction[6];
//        D = instruction[5:4];
//        Sreg = instruction[3];
//        S = instruction[2];
//        imm = instruction[2:0];
        
//        // Memory operation control
//        write_enable = 0;
//        read_enable = 0;
//        case (instruction[7:4])
//            4'b1000: read_enable = 1;   // Example: Load RA from memory address imm
//            4'b1001: read_enable = 1;   // Example: Load RB from memory address imm
//            4'b1010: write_enable = 1;  // Example: Store RA to memory address imm
//            default: begin
//                write_enable = 0;
//                read_enable = 0;
//            end
//        endcase
//    end
//endmodule

module Control_Logic (
    input  [7:0] instruction,  // Instruction from ROM
    output       j,            // Unconditional jump
    output       jc,           // Conditional jump
    output [1:0] D,            // Register address
    output       Sreg,         // Mux selector for ALU/custom input
    output       S,            // ALU operation selector
    output [2:0] imm,           // Immediate value
    output jz,
    output reg mem_read,
    output reg  mem_write
);

    assign j    = instruction[7];          // J (Unconditional jump)
    assign jc   = instruction[6];          // JC (Conditional jump)
    assign D    = instruction[5:4];        // Register address (D1, D0)
    assign Sreg = instruction[3];          // Select ALU/custom input
    assign S    = instruction[2];          // ALU operation (0=Add, 1=Sub)
    assign imm  = instruction[2:0];        // Immediate value (imm[2:0])
    assign mem_write = (j & jc) && (D[0] & D[1]);
    assign mem_read = (j & jc) && ~(D[0] & D[1]);
    assign jz = (~j & ~jc) && ((D[0] & D[1]));
    

     
endmodule