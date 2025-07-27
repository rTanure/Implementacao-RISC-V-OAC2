`include "params.vh"

module mux_4_to_1(
  input [`DATA_WIDTH-1:0] input_0,
  input [`DATA_WIDTH-1:0] input_1,
  input [`DATA_WIDTH-1:0] input_2,
  input [`DATA_WIDTH-1:0] input_3,

  input [1:0] sel,

  output reg [`DATA_WIDTH-1:0] out
);
  always @(*) begin
    case (sel)
      2'b00: out = input_0;
      2'b01: out = input_1;
      2'b10: out = input_2;
      2'b11: out = input_3;
      default: out = input_0;
    endcase
  end
endmodule