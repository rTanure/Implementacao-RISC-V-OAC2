module mux_2_to_1(
  input [31:0] input_0,
  input [31:0] input_1,

  input sel,

  output reg [31:0] out
);
  always @(*) begin
    case (sel)
      0: out = input_0;
      1: out = input_1;
      default: out = input_0;
    endcase
  end
endmodule