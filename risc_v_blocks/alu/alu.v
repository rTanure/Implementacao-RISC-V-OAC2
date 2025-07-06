// 000 - ADD
// 001 - SUB
// 010 - AND
// 011 - OR
// 100 - XOR
// 101 - SLL
// 110 - SRL
`include "../../params.vh"


module alu(
  input [`DATA_WIDTH-1:0] op_a,
  input [`DATA_WIDTH-1:0] op_b,
  input [3:0] alu_op,

  output reg [31:0] result,
  output reg zero
);
  always @(*) begin
    case (alu_op)
      `ALU_ADD: result = op_a + op_b;
      `ALU_SUB: result = op_a - op_b;
      `ALU_AND: result = op_a & op_b;
      `ALU_OR: result = op_a | op_b;
      `ALU_XOR: result = op_a ^ op_b;
      `ALU_SLL: result = op_a << op_b[4:0];
      `ALU_SRL: result = op_a >> op_b[4:0];
      default: result = 32'b0;
    endcase
    zero = (result == 32'b0) ? 1 : 0;
  end

endmodule