`include "../../params.vh"

module data_memory (
  input clk,
  input MemWrite,
  input MemRead,

  input [`ADDR_WIDTH-1:0] address,
  input [`DATA_WIDTH-1:0] write_data,

  output [`DATA_WIDTH-1:0] read_data
);
  reg [`DATA_WIDTH-1:0] memory[`DMEM_DEPTH-1:0];

  assign read_data = memory[address >> 2'd2];

  always @(posedge clk) begin
    if (MemWrite) begin
      memory[address >> 2'd2] <= write_data;
    end
  end
endmodule