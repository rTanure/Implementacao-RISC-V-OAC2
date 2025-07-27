`timescale 1ns / 1ps

module alu_control_tb;
  reg [1:0] ALUOp;
  reg [31:0] instruction;
  wire [3:0] ALUControl;

  alu_control uut (
    .ALUOp(ALUOp),
    .instruction(instruction),
    .ALUControl(ALUControl)
  );

  initial begin
    $display("Tempo | ALUOp | Instruction         | ALUControl | Operação Esperada");
    $display("--------------------------------------------------------------");

    // LW/SW: ADD
    ALUOp = 2'b00; instruction = 32'hXXXXXXXX; #10;
    $display("%4dns |  %b   | 0x%h |     %b     | ADD (LW/SW)", $time, ALUOp, instruction, ALUControl);

    // BEQ: SUB
    ALUOp = 2'b01; instruction = 32'hXXXXXXXX; #10;
    $display("%4dns |  %b   | 0x%h |     %b     | SUB (BEQ)", $time, ALUOp, instruction, ALUControl);

    // R-type: ADD
    ALUOp = 2'b10; instruction = 32'b0000000_00010_00001_000_00011_0110011; #10;
    $display("%4dns |  %b   | 0x%h |     %b     | ADD", $time, ALUOp, instruction, ALUControl);

    // R-type: SUB
    ALUOp = 2'b10; instruction = 32'b0100000_00010_00001_000_00011_0110011; #10;
    $display("%4dns |  %b   | 0x%h |     %b     | SUB", $time, ALUOp, instruction, ALUControl);

    // R-type: AND
    ALUOp = 2'b10; instruction = 32'b0000000_00010_00001_111_00011_0110011; #10;
    $display("%4dns |  %b   | 0x%h |     %b     | AND", $time, ALUOp, instruction, ALUControl);

    // R-type: OR
    ALUOp = 2'b10; instruction = 32'b0000000_00010_00001_110_00011_0110011; #10;
    $display("%4dns |  %b   | 0x%h |     %b     | OR", $time, ALUOp, instruction, ALUControl);

    // R-type: XOR
    ALUOp = 2'b10; instruction = 32'b0000000_00010_00001_100_00011_0110011; #10;
    $display("%4dns |  %b   | 0x%h |     %b     | XOR", $time, ALUOp, instruction, ALUControl);

    // R-type: SLL
    ALUOp = 2'b10; instruction = 32'b0000000_00010_00001_001_00011_0110011; #10;
    $display("%4dns |  %b   | 0x%h |     %b     | SLL", $time, ALUOp, instruction, ALUControl);

    // R-type: SRL
    ALUOp = 2'b10; instruction = 32'b0000000_00010_00001_101_00011_0110011; #10;
    $display("%4dns |  %b   | 0x%h |     %b     | SRL", $time, ALUOp, instruction, ALUControl);

    $finish;
  end

endmodule