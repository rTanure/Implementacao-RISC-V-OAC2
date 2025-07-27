`include "params.vh"

module alu_control (
  input [1:0] ALUOp,
  input [31:0] instruction,
  output reg [3:0] ALUControl
);
  wire [6:0] funct7 = instruction[31:25];
  wire [2:0] funct3 = instruction[14:12];

  always @(*) begin
    case (ALUOp)
      2'b00: ALUControl = `ALU_ADD; // LW, SW (ADD)
      2'b01: ALUControl = `ALU_SUB; // BEQ (SUB)
      2'b10: begin // R-type
        case ({funct7, funct3})
          10'b0000000_000: ALUControl = `ALU_ADD; // ADD
          10'b0100000_000: ALUControl = `ALU_SUB; // SUB
          10'b0000000_111: ALUControl = `ALU_AND; // AND
          10'b0000000_110: ALUControl = `ALU_OR; // OR
          10'b0000000_100: ALUControl = `ALU_XOR; // XOR
          10'b0000000_001: ALUControl = `ALU_SLL; // SLL
          10'b0000000_101: ALUControl = `ALU_SRL; // SRL
          default:         ALUControl = 4'b1111; // NOP ou indefinido
        endcase
      end
      default: ALUControl = 4'b1111; // indefinido
    endcase
  end

endmodule
