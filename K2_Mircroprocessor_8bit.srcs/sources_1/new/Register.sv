`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2024 10:43:14 AM
// Design Name: 
// Module Name: Register
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


//module Register#(
//    parameter n = 4 // Parameterized bit-width of the register
//)(
//    input  clk,                 
//    input  [n-1:0] d,           
//    input  en,
//    input reset    ,           
//    output reg [n-1:0] q        
//);

//    always @(posedge clk) begin 
//        if (!en | reset )             
//            q <= 0;             
//        else
//            q <= d;             
//    end 

//endmodule

//module Register#(
//    parameter n = 4 // Parameterized bit-width of the register
//)(
//    input  clk,                 
//    input  [n-1:0] d,           
//    input  en,
//    input  reset,           
//    output reg [n-1:0] q        
//);

//    always @(posedge clk) begin 
//        if (reset)             
//            q <= 0;           // Reset the register to 0
//        else if (en)          
//            q <= d;           // Store the input value if enabled
//    end 

//endmodule

//module Register #(
//    parameter n = 4 // Number of bits for the register
//)(
//    input             clk,                 
//    input             reset,               
//    input             en,                  // Write enable
//    input  [n-1:0]    d,                   // Data input
//    output reg [n-1:0] q                    // Data output
//);

//    always @(posedge clk or posedge reset) begin
//        if (reset)
//            q <= 0;                       // Reset the register to 0
//        else if (en)
//            q <= d;                       // Store the input value if enabled
//    end

//endmodule

module Register#(
    parameter n = 4 // Parameterized bit-width of the register
)(
    input  clk,                 
    input  [n-1:0] d,           
    input  en,
    input  reset,           
    output reg [n-1:0] q        
);

    always @(posedge clk ) begin 
        if (reset)             
            q <= 0;           // Reset the register to 0
        else if (en)          
            q <= d;           // Store the input value if enabled
    end 

endmodule

