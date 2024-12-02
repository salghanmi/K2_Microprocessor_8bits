`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2024 10:38:35 AM
// Design Name: 
// Module Name: ROM
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


module ROM #(
    parameter N = 4 // 4-bit address width
)(
    input clk, 
    input  [N-1:0] a,   // 4-bit address
    output reg [7:0] b  // 8-bit output (instruction)
);

    always @(*) begin
        case (a)

// Testing JZ instruction: 
            4'b0000: b = 8'b11000000; // RA = [0] 
            4'b0001: b = 8'b00011001; // RB = 1 
            4'b0010: b = 8'b00100000; // RO = RA 
            4'b0011: b = 8'b00000000; // RA = RA + RB 
            4'b0100: b = 8'b00111000; // JZ = 0 
            4'b0101: b = 8'b10110010; // J = 2 
            
             ///=============== Task ROM
//            4'b0000: b = 8'b11000000; // RA = [0]
//            4'b0001: b = 8'b11110010; // [2] = RA 
//            4'b0010: b = 8'b00100000; // RO = RA
//            4'b0011: b = 8'b11000001; // RA = [1]
//            4'b0100: b = 8'b11010010; // RB = [2]
//            4'b0101: b = 8'b00100000; // RO = RA
//            4'b0110: b = 8'b11110010; // [2] = RA            
//            4'b0111: b = 8'b00000000; // RA = RA + RB
//            4'b1000: b = 8'b01110000; // JC = 0            
//            4'b1001: b = 8'b10110100; // J = 4
            
            // ============ Without ROM or Jum0 
//            4'b0000: b = 8'b00001000; // RA = 0
//            4'b0001: b = 8'b00011001; // RB = 1
//            4'b0010: b = 8'b00100000; // RO = RA
//            4'b0011: b = 8'b00010000; // RB = RA + RB
//            4'b0100: b = 8'b01110000; // JC = 0
//            4'b0101: b = 8'b00000000; // RA = RA + RB
//            4'b0110: b = 8'b00010100; // RB = RA - RB
//            4'b0111: b = 8'b00000100; // RA = RA - RB
//            4'b1000: b = 8'b10110010; // J = 2
            
            
//            4'b1001: b = 8'b11000011; // RA=imm (3) from memory 
//            4'b1010: b = 8'b11010010; // RB = imm (2) from memory 
//            4'b1011: b = 8'b11110001; // imm = RA imm=1
//            4'b1100: b = 8'b00111001; // JZ
            default: b = 8'b00000000; // Default: No operation
        endcase
    end

endmodule



