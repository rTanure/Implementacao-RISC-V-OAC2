// 000 - ADD
// 001 - SUB
// 010 - AND
// 011 - OR
// 100 - XOR
// 101 - SLL
// 110 - SRL


module alu(
  input [31:0] op_a,
  input [31:0] op_b,
  input [3:0] alu_op,

  output reg [31:0] result,
  output reg zero
);
  always @(*) begin
    case (alu_op)
      4'b0000: result = op_a + op_b;
      4'b0001: result = op_a - op_b;
      4'b0010: result = op_a & op_b;
      4'b0011: result = op_a | op_b;
      4'b0100: result = op_a ^ op_b;
      4'b0101: result = op_a << op_b[4:0];
      4'b0110: result = op_a >> op_b[4:0];
      default: result = 32'b0;
    endcase
    zero = (result == 32'b0) ? 1 : 0;
  end

endmodule