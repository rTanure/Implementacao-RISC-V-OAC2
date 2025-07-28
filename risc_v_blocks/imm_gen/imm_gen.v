module imm_gen (
  input  [31:0] instruction,
  output reg [31:0] immediate
);
  wire [6:0] opcode = instruction[6:0];

  always @(*) begin
    case (opcode)
      // Tipo I:
      7'b0000011, 7'b0010011, 7'b1100111: begin
        immediate = {{20{instruction[31]}}, instruction[31:20]};
      end

      // Tipo S:
      7'b0100011: begin
        immediate = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
      end

      // Tipo B:
      7'b1100011: begin
        immediate = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
      end
      default: begin
        immediate = 32'b0;
      end
    endcase
  end
endmodule