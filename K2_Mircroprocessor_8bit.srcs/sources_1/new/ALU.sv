`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2024 10:23:06 AM
// Design Name: 
// Module Name: ALU
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
module ALU #(
    parameter N = 4 // Number of bits for the inputs
)(  input clk, 
    input      [N-1:0] a,        // Input A
    input      [N-1:0] b,        // Input B
    input              s,        // Operation selector (0 = Add, 1 = Sub)
    output logic [N-1:0] out,      // ALU output
    output    logic      carry     // Carry/Borrow flag
);

    always @(*) begin
        if (s == 1'b1) begin // Subtraction
            {carry, out} = a- b;
        end else begin // Addition
            {carry, out} = a + b;
        end
    end
endmodule



