`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2024 11:20:34 AM
// Design Name: 
// Module Name: Data_Memory
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
//module Data_Memory#(
//    parameter DATA_WIDTH = 8,         // Width of the data in memory (default: 8 bits)
//    parameter ADDR_WIDTH = 3          // Width of the address (default: 3 bits for 8 locations)
//)(
//    input logic clk, 
//    input logic reset,               // Reset signal for initialization
//    input logic [ADDR_WIDTH-1:0] imm, // Address 
//    input logic [1:0] mem_en,        // mem_en[0] for read, mem_en[1] for write
//    input logic [DATA_WIDTH-1:0] data_in, // Data input for write operations
//    output logic [DATA_WIDTH-1:0] data_out // Data output for read operations
//);

//    // Define the memory array
//    logic [DATA_WIDTH-1:0] memory [0:(1 << ADDR_WIDTH)-1]; // Memory array with 2^ADDR_WIDTH locations

//    // Initialize memory on reset
//    always_ff @(posedge clk ) begin
//        if (reset) begin
//            // Initialize memory values on reset
//            memory[0] <= 8'b0;  // Set datamem[0] = 0
//            memory[1] <= 8'b1;  // Set datamem[1] = 1
//            // Optionally initialize the rest of the memory to 0
//            for (int i = 2; i < (1 << ADDR_WIDTH); i = i + 1) begin
//                memory[i] <= '0; // Clear remaining memory locations
//            end
//        end else if (mem_en[1]) begin
//            // Store operation - write data to the specified address
//            memory[imm] <= data_in;
//        end
//    end

//    // Memory read logic
//    always_comb begin
//        if (mem_en[0]) begin
//            // Load operation - read data from the specified address
//            data_out = memory[imm];
//        end else begin
//            data_out = '0; // Default value when memory is not enabled
//        end
//    end

//endmodule
module Data_Memory#(
    parameter DATA_WIDTH = 8,         // Width of the data in memory (default: 8 bits)
    parameter ADDR_WIDTH = 3          // Width of the address (default: 3 bits for 8 locations)
)(
    input logic clk, 
    input logic reset,               // Reset signal for initialization
    input logic [ADDR_WIDTH-1:0] imm, // Address 
    input logic  mem_en,        // mem_en[0] for read, mem_en[1] for write
    input logic [DATA_WIDTH-1:0] data_in, // Data input for write operations
    output logic [DATA_WIDTH-1:0] data_out // Data output for read operations
);

    // Define the memory array
    logic [DATA_WIDTH-1:0] memory [0:(1 << ADDR_WIDTH)-1]; // Memory array with 2^ADDR_WIDTH locations

    // Initialize memory on reset
    always_ff @(posedge clk) begin
        if (reset) begin
            // Initialize memory values on reset
            memory[0] <= 8'b00000000; // Set datamem[0] = 0
            memory[1] <= 8'b00000001; // Set datamem[1] = 1
            // Initialize the rest of the memory to 0
            for (int i = 2; i < (1 << ADDR_WIDTH); i = i + 1) begin
                memory[i] <= 8'b00000000;
            end
        end else if (mem_en) begin
            // Store operation - write data to the specified address
            memory[imm] <= data_in;
        end
    end

    // Memory read logic
    always_comb begin
            data_out = memory[imm];
    end

endmodule

// =======================================

//module Data_Memory#(
//    parameter DATA_WIDTH = 8,         // Width of the data in memory (default: 8 bits)
//    parameter ADDR_WIDTH = 3          // Width of the address (default: 3 bits for 8 locations)
//)(
//    input logic clk, 
//    input logic reset,               // Reset signal for initialization
//    input logic [ADDR_WIDTH-1:0] imm, // Address 
//    input logic [1:0] mem_en,        // mem_en[0] for read, mem_en[1] for write
//    input logic [DATA_WIDTH-1:0] data_in, // Data input for write operations
//    output logic [DATA_WIDTH-1:0] data_out // Data output for read operations
//);

//    // Define the memory array
//    logic [DATA_WIDTH-1:0] memory [0:(1 << ADDR_WIDTH)-1]; // Memory array with 2^ADDR_WIDTH locations

//    // Initialize memory on reset
//    always_ff @(posedge clk) begin
//        if (reset) begin
//            // Initialize memory values on reset
//            memory[0] <= 8'b00000000; // Set datamem[0] = 0
//            memory[1] <= 8'b00000001; // Set datamem[1] = 1
//            // Initialize the rest of the memory to 0
//            for (int i = 2; i < (1 << ADDR_WIDTH); i = i + 1) begin
//                memory[i] <= 8'b00000000;
//            end
//        end else if (mem_en[1]) begin
//            // Store operation - write data to the specified address
//            memory[imm] <= data_in;
//        end
//    end

//    assign data_out= memory[imm];
//    // Memory read logic
////    always_comb begin
////       // if (mem_en[0]) begin
////            // Load operation - read data from the specified address
////            data_out = memory[imm];
////        //end else begin
////            data_out = '0; // Default value when memory is not enabled
////        end
////    end

//endmodule


//module Data_Memory#(
//    parameter DATA_WIDTH = 8,         // Width of the data in memory (4 bits in this case)
//    parameter ADDR_WIDTH = 3          // Width of the address (3 bits for 8 locations)
//)(
//    input logic clk, 
//    input logic [2:0] imm, // Address 
//   // input logic reset,
//    input logic [1:0] mem_en,// mem_en[0] for read and mem_en[1] for write 
//    input logic [DATA_WIDTH-1:0] data_in,
//    output logic [DATA_WIDTH-1:0] data_out
//    );


//    // Define the memory array
//    logic [DATA_WIDTH-1:0] memory [0:(1 << ADDR_WIDTH)-1]; // Memory array with 2^ADDR_WIDTH locations

//    // Memory write logic
//    always_ff @(posedge clk) begin
//        if (mem_en[1]) begin
//            // Store operation - write data to the specified address
//            memory[imm] <= data_in;
//        end
//    end

//    // Memory read logic
//    always_comb begin
//        if (mem_en[0]) begin
//            // Load operation - read data from the specified address
//            data_out = memory[imm];
//        end else begin
//            data_out = '0; // Default value when memory is not enabled
//        end
//    end

//endmodule
