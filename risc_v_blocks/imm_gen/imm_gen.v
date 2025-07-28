module imm_gen (
  input  [31:0] instruction,
  output reg [31:0] immediate
);
  wire [6:0] opcode = instruction[6:0];

  always @(*) begin
    case (opcode)
      7'b0000011,
      7'b0010011:
        immediate = {{20{instruction[31]}}, instruction[31:20]};

      7'b0100011:
        immediate = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
        
      default:
        immediate = 32'b0;
    endcase
  end
endmodule