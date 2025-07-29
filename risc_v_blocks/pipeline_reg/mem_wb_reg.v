module mem_wb_reg (
  input clk,
  input rst,

  input mem_to_reg_in,
  input reg_write_in,

  input [31:0] read_data_in,
  input [31:0] alu_result_in,
  input [31:0] instruction_in,

  output reg mem_to_reg_out,
  output reg reg_write_out,

  output reg [31:0] read_data_out,
  output reg [31:0] alu_result_out,
  output reg [31:0] instruction_out
);
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      mem_to_reg_out <= 0;
      reg_write_out <= 0;

      read_data_out <= 32'b0;
      alu_result_out <= 32'b0;
      instruction_out <= 32'b0;
    end else begin
      mem_to_reg_out <= mem_to_reg_in;
      reg_write_out <= reg_write_in;

      read_data_out <= read_data_in;
      alu_result_out <= alu_result_in;
      instruction_out <= instruction_in;
    end
  end

endmodule