`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2024 10:39:29 AM
// Design Name: 
// Module Name: Decoder
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


//module Decoder(
//   // input clk, 
//    input  [1:0] D,      // 2-bit address (D1, D0)
//    input     write_enable,  // Global write enable signal (when J =0 and jc=0)
//    output reg   en_RA,         // Write enable for register RA
//    output reg   en_RB,         // Write enable for register RB
//    output reg   en_RO          // Write enable for register RO
//);

        
//            // Enable specific register based on D when write is enabled
//    assign en_RA = (!write_enable && (D == 2'b00)) ? 1'b1 : 1'b0;
//    assign en_RB = (!write_enable && (D == 2'b01)) ? 1'b1 : 1'b0;
//    assign en_RO = (!write_enable && (D == 2'b10)) ? 1'b1 : 1'b0;
  
//endmodule

module Decoder (
    input  [1:0] D,            // Register address
    input        write_enable, // Global write enable
    output reg   en_RA,        // Enable for RA
    output reg   en_RB,        // Enable for RB
    output reg   en_RO         // Enable for RO
);

    always @(*) begin
        // Default all enables to 0
        en_RA = 1'b0;
        en_RB = 1'b0;
        en_RO = 1'b0;

        if (write_enable) begin
            case (D)
                2'b00: en_RA = 1'b1; // Write to RA
                2'b01: en_RB = 1'b1; // Write to RB
                2'b10: en_RO = 1'b1; // Write to RO
                default: ;           // No operation
            endcase
        end
    end
endmodule

//module Decoder(
//    input clk,
//    input  [1:0] D,           // 2-bit address (D1, D0)
//    input        write_enable, // Global write enable signal (1 for write enabled)
//    output reg   en_RA,       // Write enable for register RA
//    output reg   en_RB,       // Write enable for register RB
//    output reg   en_RO        // Write enable for register RO
//);

//    always @(posedge clk) begin
//        // Default all enables to 0
//        en_RA = 1'b0;
//        en_RB = 1'b0;
//        en_RO = 1'b0;
        
//        if (write_enable) begin
//            case (D)
//                2'b00: en_RA = 1'b1; // Enable RA
//                2'b01: en_RB = 1'b1; // Enable RB
//                2'b10: en_RO = 1'b1; // Enable RO
//                default: ; // Do nothing
//            endcase
//        end
//    end

//endmodule

