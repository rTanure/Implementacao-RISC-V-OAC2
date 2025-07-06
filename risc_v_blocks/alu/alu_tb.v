`timescale 1ps / 1ps
`include "../../params.vh"

module alu_tb ();
  reg [`DATA_WIDTH-1:0] op_a;
  reg [`DATA_WIDTH-1:0] op_b;
  reg [`ALU_OP_WIDTH-1:0] alu_op;

  wire [`DATA_WIDTH-1:0] result;
  wire zero;

  alu uut(
    .op_a(op_a),
    .op_b(op_b),
    .alu_op(alu_op),
    .result(result),
    .zero(zero)
  );

  initial begin
    $dumpfile("alu_tb.vcd");
    $dumpvars(0, alu_tb);

    op_a = `DATA_WIDTH'd50;
    op_b = `DATA_WIDTH'd20;
    alu_op = `ALU_ADD;

    #10
    $display("50 + 20 = %d (70), zero: %d", result, zero);
    #5

    alu_op = `ALU_SUB;
    #10
    $display("50 - 20 = %d (30), zero: %d", result, zero);

    #5
    alu_op = `ALU_AND;
    #10
    $display("===== AND =====");
    $display("%b", op_a);
    $display("%b", op_b);
    $display("%b", result);

    #5
    alu_op = `ALU_OR;
    #10
    $display("===== OR =====");
    $display("%b", op_a);
    $display("%b", op_b);
    $display("%b", result);

    #5
    alu_op = `ALU_XOR;
    #10
    $display("===== XOR =====");
    $display("%b", op_a);
    $display("%b", op_b);
    $display("%b", result);
    
    #5
    alu_op = `ALU_SLL;
    op_b = `DATA_WIDTH'd3;
    #10
    $display("===== sll =====");
    $display("%b", op_a);
    $display("%b", result);
    
    #5
    alu_op = `ALU_SRL;
    op_b = `DATA_WIDTH'd3;
    #10
    $display("===== srl =====");
    $display("%b", op_a);
    $display("%b", result);

    alu_op = `ALU_SUB;
    op_b = `DATA_WIDTH'd50;
    op_a = `DATA_WIDTH'd50;
    #10
    $display("===== zero =====");
    $display("50 - 50 = %d , zero: %d", result, zero);
    #5

    #20 $finish;
  end 

endmodule