module id_ex_reg (
  input clk,
  input rst,

  input branch_in,
  input mem_read_in,
  input mem_to_reg_in,
  input [1:0] alu_op_in,
  input mem_write_in,
  input alu_src_a_in,
  input reg_write_in,

  input [31:0] pc_in,

  input [31:0] read_data_a_in,
  input [31:0] read_data_b_in,
  input [31:0] immediate_in,
  input [31:0] instruction_in,

  output reg branch_out,
  output reg mem_read_out,
  output reg mem_to_reg_out,
  output reg [1:0] alu_op_out,
  output reg mem_write_out,
  output reg alu_src_a_out,
  output reg reg_write_out,

  output reg [31:0] pc_out,

  output reg [31:0] read_data_a_out,
  output reg [31:0] read_data_b_out,
  output reg [31:0] immediate_out,
  output reg [31:0] instruction_out
);
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      branch_out <= 0;
      mem_read_out <= 0;
      mem_to_reg_out <= 0;
      alu_op_out <= 2'b00;
      mem_write_out <= 0;
      alu_src_a_out <= 0;
      reg_write_out <= 0;

      pc_out <= 32'b0;

      read_data_a_out <= 32'b0;
      read_data_b_out <= 32'b0;
      immediate_out <= 32'b0;
      instruction_out <= 32'b0;
    end else begin
      branch_out <= branch_in;
      mem_read_out <= mem_read_in;
      mem_to_reg_out <= mem_to_reg_in;
      alu_op_out <= alu_op_in;
      mem_write_out <= mem_write_in;
      alu_src_a_out <= alu_src_a_in;
      reg_write_out <= reg_write_in;

      pc_out <= pc_in;

      read_data_a_out <= read_data_a_in;
      read_data_b_out <= read_data_b_in;
      immediate_out <= immediate_in;
      instruction_out <= instruction_in;
    end
  end
endmodule