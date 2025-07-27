`timescale 1ps/1ps
`include "params.vh"

module control_unit_tb ();
  reg [6:0] op_code;

  wire ALUSrcA, MemToReg, RegWrite, MemRead, MemWrite, Branch;
  wire [1:0] ALU_op;

  control_unit uut(
    .op_code(op_code),
    .Branch(Branch),
    .MemRead(MemRead),
    .MemToReg(MemToReg),
    .ALU_op(ALU_op),
    .MemWrite(MemWrite),
    .ALUSrcA(ALUSrcA),
    .RegWrite(RegWrite)
  );

  initial begin
    $dumpfile("control_unit_tb.vcd");
    $dumpvars(0, control_unit_tb);

    #10
    op_code = `OPCODE_R_TYPE;
    #10
    op_code = `OPCODE_LOAD;
    #10
    op_code = `OPCODE_STORE;
    #10
    op_code = `OPCODE_BRANCH;

    #10 $finish;
  end
endmodule