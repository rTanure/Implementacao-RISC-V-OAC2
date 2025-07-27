module imm_gen (
  input [31:0] instruction,
  output reg [31:0] immediate
);
  always @(*) begin
    immediate = {{20{instruction[31]}}, instruction[31:20]};
  end
endmodule