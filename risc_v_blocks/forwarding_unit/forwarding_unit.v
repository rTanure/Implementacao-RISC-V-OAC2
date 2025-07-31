module forwarding_unit(
  input [31:0] instruction,
  input [4:0] rs1,
  input [4:0] rs2,
  input [4:0] ex_mem_rd,
  input [4:0] mem_wb_rd,
  input ex_mem_reg_write,
  input mem_wb_reg_write,

  output reg [1:0] forward_a,
  output reg [1:0] forward_b
);

  wire [6:0] opcode;
  assign opcode = instruction[6:0];

  wire is_type_i = 
    (opcode == 7'b0010011) ||
    (opcode == 7'b0000011) ||
    (opcode == 7'b1100111); 

  always @(*) begin
    forward_a = 2'b00;
    forward_b = 2'b00;

    // Forward A
    if (ex_mem_reg_write && (ex_mem_rd != 0) && (ex_mem_rd == rs1)) begin
      forward_a = 2'b10;
    end else if (mem_wb_reg_write && (mem_wb_rd != 0) && (mem_wb_rd == rs1)) begin
      forward_a = 2'b01;
    end

    // Forward B
    if (!is_type_i) begin
      if (ex_mem_reg_write && (ex_mem_rd != 0) && (ex_mem_rd == rs2)) begin
        forward_b = 2'b10;
      end else if (mem_wb_reg_write && (mem_wb_rd != 0) && (mem_wb_rd == rs2)) begin
        forward_b = 2'b01;
      end
    end
  end

endmodule