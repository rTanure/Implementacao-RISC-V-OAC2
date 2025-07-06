`include "../../params.vh"


module mux_2_to_1(
  input [`DATA_WIDTH-1:0] input_0,
  input [`DATA_WIDTH-1:0] input_1,

  input sel,

  output reg [`DATA_WIDTH-1:0] out
);
  always @(*) begin
    case (sel)
      0: out = input_0;
      1: out = input_1;
      default: out = input_0;
    endcase
  end
endmodule