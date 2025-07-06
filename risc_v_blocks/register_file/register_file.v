`include "../../params.vh"

module register_file(
  input clk,
  input rst,
  input reg_write,

  input [`REG_ADDR_WIDTH-1:0] read_address_a,
  input [`REG_ADDR_WIDTH-1:0] read_address_b,
  input [`REG_ADDR_WIDTH-1:0] write_address,

  input [`DATA_WIDTH-1:0] write_data,

  output reg [`DATA_WIDTH-1:0] read_data_a,
  output reg [`DATA_WIDTH-1:0] read_data_b
);
  reg [`DATA_WIDTH-1:0] registers [`NUM_REGISTERS-1:0];

  integer i = 0;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      
      for (i = 0; i < `NUM_REGISTERS; i = i + 1) begin
        registers[i] <= `ZERO;
      end
    end else if (reg_write && write_address != `REG_ADDR_WIDTH'b0) begin
      registers[write_address] <= write_data;
    end
  end

  always @(*) begin
    read_data_a = (read_address_a == 5'b0) ? `ZERO : registers[read_address_a];
    read_data_b = (read_address_b == 5'b0) ? `ZERO : registers[read_address_b];
  end

endmodule