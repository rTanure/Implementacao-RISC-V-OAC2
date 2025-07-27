`timescale 1ps/1ps
`include "params.vh"


module mux_2_to_1_tb();
  reg [`DATA_WIDTH-1:0] data_0;
  reg [`DATA_WIDTH-1:0] data_1;

  reg sel;

  wire [`DATA_WIDTH-1:0] out;

  mux_2_to_1 uut (
    .input_0(data_0),
    .input_1(data_1),
    .sel(sel),
    .out(out)
  );

  initial begin
    $dumpfile("mux_2_to_1_tb.vcd");
    $dumpvars(0, mux_2_to_1_tb);

    data_0 = `DATA_WIDTH'h1111;
    data_1 = `DATA_WIDTH'h2222;

    #10
    sel = 0;
    #5
    $display("Esperado: 1111, Obtido %h", out);

    #10
    sel = 1;
    #5
    $display("Esperado: 2222, Obtido %h", out);

    #10
    $finish;
  end
endmodule

