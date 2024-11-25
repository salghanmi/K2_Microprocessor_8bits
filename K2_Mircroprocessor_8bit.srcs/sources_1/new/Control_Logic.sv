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

module Control_Logic (
    input  [7:0] instruction,  // Instruction from ROM
    output       j,            // Unconditional jump
    output       jc,           // Conditional jump
    output [1:0] D,            // Register address
    output       Sreg,         // Mux selector for ALU/custom input
    output       S,            // ALU operation selector
    output [2:0] imm,           // Immediate value
    output reg [1:0] mem_en
);

    assign j    = instruction[7];          // J (Unconditional jump)
    assign jc   = instruction[6];          // JC (Conditional jump)
    assign D    = instruction[5:4];        // Register address (D1, D0)
    assign Sreg = instruction[3];          // Select ALU/custom input
    assign S    = instruction[2];          // ALU operation (0=Add, 1=Sub)
    assign imm  = instruction[2:0];        // Immediate value (imm[2:0])
    
    
 // Memory Enable Logic
    always_comb begin
        case (instruction[7:3])
            5'b11000: mem_en = 2'b10; // RA = imm (from memory), Enable read
            5'b11010: mem_en = 2'b10; // RB = imm (from memory), Enable read
            5'b11110: mem_en = 2'b01; // imm = RA, Enable write
            default: mem_en = 2'b00; // No memory operation
        endcase
    end
     
endmodule



