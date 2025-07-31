`include "params.vh"

module data_memory (
  input clk,
  input MemWrite,
  input MemRead,

  input [31:0] address,
  input [7:0] write_data,

  output [7:0] read_data
);
  reg [7:0] memory[31:0];

  assign read_data = memory[address];

  always @(posedge clk) begin
    if (MemWrite) begin
      memory[address] <= write_data;
    end
  end

  `ifdef DATA
    integer i;
    always @(posedge clk) begin
      $display("--- MEMORIA DE DADOS ---");
      for (i = 0; i < 32; i = i + 1) begin
        $display("  M[%2d] = %10d %b", i, memory[i], memory[i]);
      end
      $display("");
    end
  `endif
endmodule