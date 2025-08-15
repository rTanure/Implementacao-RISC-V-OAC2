`include "params.vh"

module hazard_detection_unit(
  input [31:0] instruction,
  input [4:0] rs1_ex,
  input [4:0] rs2_ex,
  input [4:0] rd_mem,
  input alu_zero_mem,
  input branch_mem,

  output reg stall,
  output reg pc_src
);
  reg [6:0] op_code;
  
  always @(*) begin
    op_code = instruction[6:0];
    pc_src = alu_zero_mem & branch_mem;
    stall = 0;
    if (op_code == `OPCODE_LOAD) begin
      if (rd_mem == rs1_ex || rd_mem == rs2_ex) begin
        stall = 1;
      end
    end
  end
endmodule