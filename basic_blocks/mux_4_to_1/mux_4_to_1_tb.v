`timescale 1ps/1ps
`include "params.vh"

module mux_4_to_1_tb();
  reg [`DATA_WIDTH-1:0] data_0;
  reg [`DATA_WIDTH-1:0] data_1;
  reg [`DATA_WIDTH-1:0] data_2;
  reg [`DATA_WIDTH-1:0] data_3;

  reg [1:0] sel;

  wire [`DATA_WIDTH-1:0] out;

  mux_4_to_1 uut (
    .input_0(data_0),
    .input_1(data_1),
    .input_2(data_2),
    .input_3(data_3),
    .sel(sel),
    .out(out)
  );

  initial begin
    $dumpfile("mux_4_to_1_tb.vcd");
    $dumpvars(0, mux_4_to_1_tb);

    data_0 = `DATA_WIDTH'h1111;
    data_1 = `DATA_WIDTH'h2222;
    data_2 = `DATA_WIDTH'h3333;
    data_3 = `DATA_WIDTH'h4444;

    #10
    sel = 2'b00;
    #5
    $display("Esperado: 1111, Obtido %h", out);

    #10
    sel = 2'b01;
    #5
    $display("Esperado: 2222, Obtido %h", out);
    
    #10
    sel = 2'b10;
    #5
    $display("Esperado: 3333, Obtido %h", out);

    #10
    sel = 2'b11;
    #5
    $display("Esperado: 4444, Obtido %h", out);

    #10
    $finish;
  end
endmodule

