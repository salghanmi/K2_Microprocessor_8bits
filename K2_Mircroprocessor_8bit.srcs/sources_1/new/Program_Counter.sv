`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2024 10:38:11 AM
// Design Name: 
// Module Name: Program_Counter
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


//module Program_Counter #(
//    parameter N = 4 // Number of bits for the program counter
//)(
//    input                   clk,        
//    input                   reset,      
//    input                   load,       
//    input  [N-1:0]          load_value, 
//    output reg [N-1:0]      pc         
//);
//    always @(posedge clk) begin
//        if (reset || (pc == 4'b1000))
//            pc <= 0;                    // Reset PC to 0
//        else if (load)
//            pc <= load_value;           // Load the specified value when load is high
//        else
//            pc <= pc + 1;               // Increment the counter
//    end
//endmodule

module Program_Counter #(
    parameter N = 4,                  // Number of bits for the program counter
    parameter WRAP_AROUND = 4'b1000  // Wrap-around value
)(
    input                   clk,        
    input                   reset,      
    input                   load,       
    input  [N-1:0]          load_value, 
    output reg [N-1:0]      pc         
);
    always @(posedge clk) begin
        if (reset) 
            pc <= 0;                // Reset PC to 0
        else if (load) 
            pc <= load_value;       // Load specified value when load is high
//         else if (pc == WRAP_AROUND) 
//            pc <= 0;  
        else 
            pc <= pc + 1;           // Increment counter
    end
endmodule

