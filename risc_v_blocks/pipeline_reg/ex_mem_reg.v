module ex_mem_reg (
  input clk,
  input rst,
  input branch_in,
  input mem_read_in,
  input mem_to_reg_in,
  input mem_write_in,
  input reg_write_in,
  input [31:0] sum_pc_in,
  input [31:0] alu_result_in,
  input alu_zero_in,
  input [31:0] read_data_b_in,
  input [4:0] rd_in,
  input [31:0] instruction_in,
  output reg branch_out,
  output reg mem_read_out,
  output reg mem_to_reg_out,
  output reg mem_write_out,
  output reg reg_write_out,
  output reg [4:0] rd_out,
  output reg [31:0] sum_pc_out,
  output reg [31:0] alu_result_out,
  output reg alu_zero_out,
  output reg [31:0] read_data_b_out,
  output reg [31:0] instruction_out
);
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      branch_out <= 0;
      mem_read_out <= 0;
      mem_to_reg_out <= 0;
      mem_write_out <= 0;
      reg_write_out <= 0;
      rd_out <= 5'b0;

      sum_pc_out <= 32'b0;
      alu_result_out <= 32'b0;
      alu_zero_out <= 0;
      read_data_b_out <= 32'b0;

      instruction_out <= 32'b0;
    end else begin

      branch_out <= branch_in;
      mem_read_out <= mem_read_in;
      mem_to_reg_out <= mem_to_reg_in;
      mem_write_out <= mem_write_in;
      reg_write_out <= reg_write_in;
      rd_out <= rd_in;

      sum_pc_out <= sum_pc_in;
      alu_result_out <= alu_result_in;
      alu_zero_out <= alu_zero_in;
      read_data_b_out <= read_data_b_in;

      instruction_out <= instruction_in;
    end
  end
  
endmodule