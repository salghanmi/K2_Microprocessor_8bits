

module tb_Decoder;
    reg clk;                     // Clock signal
    reg [1:0] D;                 // 2-bit register address
    reg [1:0] write_enable;      // Global write enable signal
    wire en_RA, en_RB, en_RO;    // Outputs for write enables

    Decoder uut (
       // .clk(clk),
        .D(D),
        .write_enable(write_enable),
        .en_RA(en_RA),
        .en_RB(en_RB),
        .en_RO(en_RO)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Generate a clock with a period of 10 time units
    end

    // Test procedure
    initial begin
        $display("Starting Simplified Decoder Testbench...");

        // Test 1: Write to RA
        D = 2'b00; 
        write_enable = 2'b00; 
        #10; 
        $display("Test 1: D=00, write_enable=00 -> en_RA=%b, en_RB=%b, en_RO=%b", en_RA, en_RB, en_RO);

        // Test 2: Write to RB
        D = 2'b01; 
        write_enable = 2'b00; 
        #10; 
        $display("Test 2: D=01, write_enable=00 -> en_RA=%b, en_RB=%b, en_RO=%b", en_RA, en_RB, en_RO);

        // Test 3: Write to RO
        D = 2'b10; 
        write_enable = 2'b00; 
        #10; 
        $display("Test 3: D=10, write_enable=00 -> en_RA=%b, en_RB=%b, en_RO=%b", en_RA, en_RB, en_RO);

        // Test 4: Write disabled
        D = 2'b00; 
        write_enable = 2'b01; 
        #10; 
        $display("Test 4: D=00, write_enable=01 -> en_RA=%b, en_RB=%b, en_RO=%b", en_RA, en_RB, en_RO);

        $display("Testbench Completed.");
        $stop; // Stop the simulation
    end

endmodule
