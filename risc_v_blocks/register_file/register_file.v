module register_file(
  input clk,
  input rst,
  input reg_write,

  input [4:0] read_address_a,
  input [4:0] read_address_b,
  input [4:0] write_address,

  input [31:0] write_data,

  output reg [31:0] read_data_a,
  output reg [31:0] read_data_b
);
  reg [31:0] registers [0:31];

  integer i = 0;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      
      for (i = 0; i < 32; i = i + 1) begin
        registers[i] <= 32'b0;
      end
    end else if (reg_write && write_address != 5'b0) begin
      registers[write_address] <= write_data;
    end
  end

  always @(*) begin
    read_data_a = (read_address_a == 5'b0) ? 32'b0 : registers[read_address_a];
    read_data_b = (read_address_b == 5'b0) ? 32'b0 : registers[read_address_b];
  end

endmodule