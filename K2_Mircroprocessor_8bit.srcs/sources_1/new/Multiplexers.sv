`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2024 10:21:01 AM
// Design Name: 
// Module Name: Multiplexers
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

//module Multiplexers #(
//    parameter N = 4 // Number of bits for the inputs
//)(
//    input  [N-1:0] a,     // Input A
//    input  [N-1:0] b,     // Input B
//    input          select, // Select signal
//    output [N-1:0] OUT    // Output
//);

//    assign OUT = select ? b : a; // Select between A and B
//endmodule

module Multiplexers#(
    parameter N = 4 
)(
    input  [N-1:0] a,     // Input A
    input  [N-1:0] b,     // Input B
    input  select,            // Select signal
    output [N-1:0] OUT    // Output
);

    assign OUT = select ? a : b;

endmodule


