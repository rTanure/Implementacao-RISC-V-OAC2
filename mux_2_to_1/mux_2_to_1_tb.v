`timescale 1ps/1ps

module mux_2_to_1_tb();
  reg [31:0] data_0;
  reg [31:0] data_1;

  reg sel;

  wire [31:0] out;

  mux_2_to_1 uut (
    .input_0(data_0),
    .input_1(data_1),
    .sel(sel),
    .out(out)
  );

  initial begin
    $dumpfile("mux_2_to_1_tb.vcd");
    $dumpvars(0, mux_2_to_1_tb);

    data_0 = 32'h1111;
    data_1 = 32'h2222;

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

