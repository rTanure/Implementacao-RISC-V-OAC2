`timescale 1ps / 1ps
`include "params.vh"

module data_memory_tb;
  reg clk = 0;
  always #5 clk = ~clk;

  reg MemWrite;
  reg MemRead;
  reg [`ADDR_WIDTH-1:0] address;
  reg [`DATA_WIDTH-1:0] write_data;

  wire [`DATA_WIDTH-1:0] read_data;

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
    write_data = 32'd0;
    
    #10
    
    // Salvando dados na memoria
    MemWrite = 1'b1;

    address = 32'd4;
    write_data = 32'hAAAAAAAA;
    #10

    address = 32'd8;
    write_data = 32'hBBBBBBBB;
    #10
    
    MemWrite = 1'b0;
    #10

    // Lendo dados da memoria
    MemRead = 1;
    
    address = 32'd4;
    #5;
    $display("esperado: %d, Valor: %h, esperado: AAAAAAAA)", address, read_data);

    address = 32'd8;
    #5;
    $display("esperado: %d, Valor: %h, esperado: BBBBBBBB)", address, read_data);

    address = 32'd12;
    #5;
    $display("esperado: %d, Valor: %h)", address, read_data);
    
    #10;$finish;
  end

endmodule