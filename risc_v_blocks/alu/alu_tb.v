`timescale 1ps / 1ps

module alu_tb ();
  reg [31:0] op_a;
  reg [31:0] op_b;
  reg [3:0] alu_op;

  wire [31:0] result;
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

    op_a = 32'd50;
    op_b = 32'd20;
    alu_op = 4'b0000;

    #10
    $display("50 + 20 = %d (70), zero: %d", result, zero);
    #5

    alu_op = 4'b0001;
    #10
    $display("50 - 20 = %d (30), zero: %d", result, zero);

    #5
    alu_op = 4'b0010;
    #10
    $display("===== AND =====");
    $display("%b", op_a);
    $display("%b", op_b);
    $display("%b", result);

    #5
    alu_op = 4'b0011;
    #10
    $display("===== OR =====");
    $display("%b", op_a);
    $display("%b", op_b);
    $display("%b", result);

    #5
    alu_op = 4'b0100;
    #10
    $display("===== XOR =====");
    $display("%b", op_a);
    $display("%b", op_b);
    $display("%b", result);
    
    #5
    alu_op = 4'b0101;
    op_b = 32'd3;
    #10
    $display("===== sll =====");
    $display("%b", op_a);
    $display("%b", result);
    
    #5
    alu_op = 4'b0110;
    op_b = 32'd3;
    #10
    $display("===== sll =====");
    $display("%b", op_a);
    $display("%b", result);

    alu_op = 4'b0001;
    op_b = 32'd50;
    op_a = 32'd50;
    #10
    $display("===== zero =====");
    $display("50 - 50 = %d , zero: %d", result, zero);
    #5

    #20 $finish;
  end 

endmodule