`include "params.vh"

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

  
    integer i;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      for (i = 0; i < `NUM_REGISTERS; i = i + 1) begin
        registers[i] <= `ZERO;
      end
    end else if (reg_write && write_address != `REG_ADDR_WIDTH'b0) begin
      registers[write_address] <= write_data;
    end
  end


  `ifdef REG
    always @(posedge clk or posedge rst) begin
      $display("--- REGISTRADORES ---");
      for (i = 0; i < `NUM_REGISTERS; i = i + 1) begin  
        $display("  R[%2d] = %10d %b", i, registers[i], registers[i]);
      end
      $display("");
    end
  `endif

  always @(*) begin
  if (reg_write && (write_address == read_address_a) && (write_address != 0))
    read_data_a = write_data;
  else
    read_data_a = (read_address_a == 0) ? `ZERO : registers[read_address_a];
  
  if (reg_write && (write_address == read_address_b) && (write_address != 0))
    read_data_b = write_data;
  else
    read_data_b = (read_address_b == 0) ? `ZERO : registers[read_address_b];
end

endmodule
