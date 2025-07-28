`timescale 1ps / 1ps
`include "params.vh"

module data_memory_tb;
  reg clk = 0;
  always #5 clk = ~clk;

  reg MemWrite;
  reg MemRead;
  reg [31:0] address;
  reg [7:0] write_data;

  wire [7:0] read_data;

  data_memory uut (
    .clk(clk),
    .MemWrite(MemWrite),
    .MemRead(MemRead),
    .address(address),
    .write_data(write_data),
    .read_data(read_data)
  );

  initial begin
    $dumpfile("data_memory_tb.vcd");
    $dumpvars(0, data_memory_tb);

    MemWrite = 0;
    MemRead = 0;
    address = 32'd0;
    write_data = 8'd0;
    
    #10
    
    // Salvando dados na memoria
    MemWrite = 1;

    address = 32'd4;
    write_data = 8'hAA;
    #10

    address = 32'd6;
    write_data = 8'hBB;
    #10
    
    MemWrite = 0;
    #10

    // Lendo dados da memoria
    MemRead = 1;
    
    address = 32'd4;
    #5;
    $display("esperado: %d, Valor: %h, esperado: AA)", address, read_data);

    address = 32'd6;
    #5;
    $display("esperado: %d, Valor: %h, esperado: BB)", address, read_data);

    address = 32'd12;
    #5;
    $display("esperado: %d, Valor: %h)", address, read_data);
    
    #10;$finish;
  end

endmodule