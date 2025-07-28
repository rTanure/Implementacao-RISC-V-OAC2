`include "params.vh"

module data_memory (
  input clk,
  input MemWrite,
  input MemRead,

  input [31:0] address,
  input [7:0] write_data,

  output [7:0] read_data
);
  reg [7:0] memory[255:0];

  assign read_data = memory[address];

  always @(posedge clk) begin
    if (MemWrite) begin
      memory[address] <= write_data;
    end
  end
endmodule