module tb_Control_logic;

    // Testbench signals
    reg [7:0] instruction;     // Input instruction
    wire j;                    // Unconditional jump
    wire jc;                   // Conditional jump (carry)
    wire [1:0] D;              // Register address
    wire Sreg;                 // ALU or immediate value to register
    wire S;                    // ALU operation
    wire [2:0] imm;            // Immediate value

    // Instantiate the Control_Logic module
    Control_Logic uut (
        .instruction(instruction),
        .j(j),
        .jc(jc),
        .D(D),
        .Sreg(Sreg),
        .S(S),
        .imm(imm)
    );

    // Test procedure
    initial begin
        $display("Starting Control_Logic Testbench...");

        // Test Case 1: No jump, Add operation, imm = 3'b000
        instruction = 8'b00000000; // All bits are 0
        #10; // Wait for changes to propagate
        $display("TC1: Instruction = %b | j = %b, jc = %b, D = %b, Sreg = %b, S = %b, imm = %b",
                 instruction, j, jc, D, Sreg, S, imm);

        // Test Case 2: Unconditional jump, imm = 3'b101
        instruction = 8'b10000101; // J = 1, imm = 3'b101
        #10;
        $display("TC2: Instruction = %b | j = %b, jc = %b, D = %b, Sreg = %b, S = %b, imm = %b",
                 instruction, j, jc, D, Sreg, S, imm);

        // Test Case 3: Conditional jump (carry), imm = 3'b011
        instruction = 8'b01000011; // C = 1, imm = 3'b011
        #10;
        $display("TC3: Instruction = %b | j = %b, jc = %b, D = %b, Sreg = %b, S = %b, imm = %b",
                 instruction, j, jc, D, Sreg, S, imm);

        // Test Case 4: ALU operation with register address D = 2'b10
        instruction = 8'b00011000; // D = 2'b10, Sreg = 0, imm = 3'b000
        #10;
        $display("TC4: Instruction = %b | j = %b, jc = %b, D = %b, Sreg = %b, S = %b, imm = %b",
                 instruction, j, jc, D, Sreg, S, imm);

        // Test Case 5: Immediate load with imm = 3'b111
        instruction = 8'b00001111; // Sreg = 1, imm = 3'b111
        #10;
        $display("TC5: Instruction = %b | j = %b, jc = %b, D = %b, Sreg = %b, S = %b, imm = %b",
                 instruction, j, jc, D, Sreg, S, imm);

        $display("Control_Logic Testbench completed.");
        $stop;
    end

endmodule
