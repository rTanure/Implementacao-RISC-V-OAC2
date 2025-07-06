`include "../../params.vh"

module control_unit( // pag. 282.e5
  input [6:0] op_code,

  output reg Branch,
  output reg MemRead,
  output reg MemToReg,
  output reg [1:0] ALU_op,
  output reg MemWrite,
  output reg ALUSrcA,
  output reg RegWrite
);

  always @(*) begin
    case (op_code)
      `OPCODE_R_TYPE: begin
        ALUSrcA = 0;
        MemToReg = 0;
        RegWrite = 1;
        MemRead = 0;
        MemWrite = 0;
        Branch = 0;
        ALU_op = 2'b10;
      end
      `OPCODE_LOAD: begin
        ALUSrcA = 1;
        MemToReg = 1;
        RegWrite = 1;
        MemRead = 1;
        MemWrite = 0;
        Branch = 0;
        ALU_op = 2'b00;
      end
      `OPCODE_STORE: begin
        ALUSrcA = 1;
        MemToReg = 0;
        RegWrite = 0;
        MemRead = 0;
        MemWrite = 1;
        Branch = 0;
        ALU_op = 2'b00;
      end
      `OPCODE_BRANCH: begin
        ALUSrcA = 0;
        MemToReg = 0;
        RegWrite = 0;
        MemRead = 0;
        MemWrite = 0;
        Branch = 1;
        ALU_op = 2'b01;
      end
    endcase
  end

endmodule