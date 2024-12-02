`timescale 1ns / 1ps

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


