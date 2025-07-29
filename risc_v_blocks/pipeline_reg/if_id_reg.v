module if_id_reg (
  input clk,
  input rst,

  input [31:0] instruction_in,
  input [31:0] pc_in,

  output reg [31:0] instruction_out,
  output reg [31:0] pc_out
);
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      instruction_out <= 32'b0;
      pc_out <= 32'b0;
    end else begin
      instruction_out <= instruction_in;
      pc_out <= pc_in;
    end
  end
endmodule