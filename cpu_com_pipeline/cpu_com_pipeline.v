`include "./risc_v_blocks/instruction_memory/instruction_memory.v"

`include "./risc_v_blocks/imm_gen/imm_gen.v"
`include "./risc_v_blocks/control_unit/control_unit.v"
`include "./risc_v_blocks/register_file/register_file.v"

`include "./risc_v_blocks/alu_control/alu_control.v"
`include "./risc_v_blocks/alu/alu.v"

`include "./basic_blocks/mux_2_to_1/mux_2_to_1.v"
`include "./basic_blocks/mux_4_to_1/mux_4_to_1.v"

`include "./risc_v_blocks/data_memory/data_memory.v"
`include "./risc_v_blocks/forwarding_unit/forwarding_unit.v"

`include "./risc_v_blocks/pipeline_reg/if_id_reg.v"
`include "./risc_v_blocks/pipeline_reg/id_ex_reg.v"
`include "./risc_v_blocks/pipeline_reg/ex_mem_reg.v"
`include "./risc_v_blocks/pipeline_reg/mem_wb_reg.v"

module cpu_com_pipeline(
  input clk,
  input rst
);
  wire flush = pc_src;

  // =========================================
  // IF - Instruction Fetch
  // =========================================
  reg [31:0] pc;
  wire [31:0] instruction;
  wire [31:0] pc_next;
  wire [31:0] pc_branch;
  wire pc_src;

  instruction_memory i_mem (
    .read_address(pc),
    .instruction_data(instruction)
  );

  mux_2_to_1 mux_pc (
    .input_0(pc + 4),
    .input_1(sum_pc_mem),
    .sel(pc_src),
    .out(pc_next)
  );

  // Atualiza o PC
  always @(posedge clk, rst) begin
    if (rst)
      pc <= 0;
    else
      pc <= pc_next;
  end
  
  // ==========================================
  // ID - Instruction Decode
  // ==========================================

  wire [31:0] pc_id;
  wire [31:0] instruction_id;

  if_id_reg if_id (
    .clk(clk),
    .rst(flush),
    .pc_in(pc),
    .instruction_in(instruction),
    .pc_out(pc_id),
    .instruction_out(instruction_id)
  );

  wire [6:0] op_code_id = {instruction_id[6:0]};
  wire [4:0] rd_id = {instruction_id[11:7]};
  wire [4:0] rs1_id = {instruction_id[19:15]};
  wire [4:0] rs2_id = {instruction_id[24:20]};

  // Unidade de controle
  wire branch;
  wire memRead;
  wire memToReg;
  wire [1:0] alu_op;
  wire memWrite;
  wire aluSrcA;
  wire regWrite;

  control_unit ctrl (
    .op_code(op_code_id),
    .Branch(branch),
    .MemRead(memRead),
    .MemToReg(memToReg),
    .ALU_op(alu_op),
    .MemWrite(memWrite),
    .ALUSrcA(aluSrcA),
    .RegWrite(regWrite)
  );

  // Banco de registradores
  wire [31:0] write_data;
  wire [31:0] read_data_a;
  wire [31:0] read_data_b;

  register_file reg_file (
    .clk(clk),
    .rst(rst),
    .reg_write(reg_write_wb),

    .read_address_a(rs1_id),
    .read_address_b(rs2_id),
    .write_address(rd_wb),

    .write_data(write_data),

    .read_data_a(read_data_a),
    .read_data_b(read_data_b)
  );

  // Gera o imediato
  wire [31:0] immediate;

  imm_gen imm_gen(
    .instruction(instruction_id),
    .immediate(immediate)
  );

  wire [31:0] pc_ex;
  wire [31:0] instruction_ex;
  wire branch_ex;
  wire memRead_ex;
  wire memToReg_ex;
  wire [1:0] alu_op_ex;
  wire memWrite_ex;
  wire aluSrcA_ex;
  wire regWrite_ex;
  wire [31:0] read_data_a_ex;
  wire [31:0] read_data_b_ex;
  wire [31:0] immediate_ex;

  wire [4:0] rd_ex;
  wire [4:0] rs1_ex;
  wire [4:0] rs2_ex;
  
  

  id_ex_reg id_ex (
    .clk(clk),
    .rst(flush),

    .branch_in(branch),
    .mem_read_in(memRead),
    .mem_to_reg_in(memToReg),
    .alu_op_in(alu_op),
    .mem_write_in(memWrite),
    .alu_src_a_in(aluSrcA),
    .reg_write_in(regWrite),

    .read_data_a_in(read_data_a),
    .read_data_b_in(read_data_b),
    .immediate_in(immediate),
    .instruction_in(instruction_id),
    .rd_in(rd_id),
    .rs1_in(rs1_id),
    .rs2_in(rs2_id),

    .pc_in(pc_id),


    .branch_out(branch_ex),
    .mem_read_out(memRead_ex),
    .mem_to_reg_out(memToReg_ex),
    .alu_op_out(alu_op_ex),
    .mem_write_out(memWrite_ex),
    .alu_src_a_out(aluSrcA_ex),
    .reg_write_out(regWrite_ex),
    .rd_out(rd_ex),
    .rs1_out(rs1_ex),
    .rs2_out(rs2_ex),

    .pc_out(pc_ex),

    .read_data_a_out(read_data_a_ex),
    .read_data_b_out(read_data_b_ex),
    .immediate_out(immediate_ex),
    .instruction_out(instruction_ex)
  );




  // Entrada B será o dado lido do banco de registradores ou o imediato
  wire [31:0] alu_reg_b;

  mux_2_to_1 mux_reg_alu (
    .input_0(read_data_b_ex),
    .input_1(immediate_ex),
    .sel(aluSrcA_ex),
    .out(alu_reg_b)
  );

  always @(posedge clk, rst) begin
    $display("%d", read_data_b_ex);
    $display("%d", immediate_ex);
    $display("%d", aluSrcA_ex);
    $display("%d", alu_reg_b);
  end

  wire [3:0] alu_operation;

  // Controlador da ALU
  alu_control alu_crtl (
    .ALUOp(alu_op_ex),
    .instruction(instruction_ex),
    .ALUControl(alu_operation)
  );

  // ALU
  wire [31:0] alu_result;
  wire alu_zero;

  wire [31:0] alu_operand_a;
  wire [31:0] alu_operand_b;

  wire [1:0] forward_a;
  wire [1:0] forward_b;

  mux_4_to_1 mux_alu_a (
    .input_0(read_data_a_ex),
    .input_1(write_data),
    .input_2(alu_result_mem),
    .input_3(32'b0),
    .sel(forward_a),
    .out(alu_operand_a)
  );

  mux_4_to_1 mux_alu_b (
    .input_0(alu_reg_b),
    .input_1(write_data),
    .input_2(alu_result_mem),
    .input_3(32'b0),
    .sel(forward_b),
    .out(alu_operand_b)
  );

  alu alu (
    .op_a(alu_operand_a),
    .op_b(alu_operand_b),
    .alu_op(alu_operation),
    .result(alu_result),
    .zero(alu_zero)
  );

  

  assign pc_branch = pc_ex + (immediate_ex << 1);

  forwarding_unit fwd_unit (
    .instruction(instruction_ex),
    .rs1(rs1_ex),
    .rs2(rs2_ex),
    .ex_mem_rd(rd_mem),
    .mem_wb_rd(rd_wb),
    .ex_mem_reg_write(reg_write_mem),
    .mem_wb_reg_write(reg_write_wb),

    .forward_a(forward_a),
    .forward_b(forward_b)
  );

  // ============================================
  // MEM - Memory Access
  // ============================================

  wire branch_mem;
  wire mem_read_mem;
  wire mem_to_reg_mem;
  wire mem_write_mem;
  wire reg_write_mem;
  wire [31:0] sum_pc_mem;
  wire [31:0] alu_result_mem;
  wire alu_zero_mem;
  wire [31:0] read_data_b_mem;
  wire [31:0] instruction_mem;
  wire [4:0] rd_mem;

  ex_mem_reg ex_mem (
    .clk(clk),
    .rst(1'b0),

    .branch_in(branch_ex),
    .mem_read_in(memRead_ex),
    .mem_to_reg_in(memToReg_ex),
    .mem_write_in(memWrite_ex),
    .reg_write_in(regWrite_ex),

    .sum_pc_in(pc_branch),
    .alu_result_in(alu_result),
    .alu_zero_in(alu_zero),
    .read_data_b_in(read_data_b_ex),
    .rd_in(rd_ex),

    .instruction_in(instruction_ex),

    .branch_out(branch_mem),
    .mem_read_out(mem_read_mem),
    .mem_to_reg_out(mem_to_reg_mem),
    .mem_write_out(mem_write_mem),
    .reg_write_out(reg_write_mem),
    .rd_out(rd_mem),

    .sum_pc_out(sum_pc_mem),
    .alu_result_out(alu_result_mem),
    .alu_zero_out(alu_zero_mem),
    .read_data_b_out(read_data_b_mem),

    .instruction_out(instruction_mem)
  );


  wire [7:0] read_data;
  wire [31:0] extended_read_data;
  assign extended_read_data = {{25{read_data[7]}}, {read_data[6:0]}};

  data_memory data_memory(
    .clk(clk),
    .MemWrite(mem_write_mem),
    .MemRead(mem_read_mem),
    .address(alu_result_mem),
    .write_data(read_data_b_mem[7:0]),
    .read_data(read_data)
  );

  assign pc_src = alu_zero_mem & branch_mem;

  wire mem_to_reg_wb;
  wire reg_write_wb;
  wire [31:0] read_data_wb;
  wire [31:0] alu_result_wb;
  wire [31:0] instruction_wb;

  mem_wb_reg mem_wb (
    .clk(clk),
    .rst(1'b0),

    .mem_to_reg_in(mem_to_reg_mem),
    .reg_write_in(reg_write_mem),

    .read_data_in(extended_read_data),
    .alu_result_in(alu_result_mem),
    .instruction_in(instruction_mem),
    .rd_in(rd_mem),

    .mem_to_reg_out(mem_to_reg_wb),
    .reg_write_out(reg_write_wb),

    .read_data_out(read_data_wb),
    .alu_result_out(alu_result_wb),
    .instruction_out(instruction_wb),
    .rd_out(rd_wb)
  );


  // Dado salvo será o resultado da ALU ou o dado lido da memória
  mux_2_to_1 mux_data_reg (
    .input_0(alu_result_wb),
    .input_1(read_data_wb),
    .sel(mem_to_reg_wb),
    .out(write_data)
  );

  wire [4:0] rd_wb;
  assign rd_wb = instruction_wb[11:7];


  `ifdef DEBUG
    always @(posedge clk) begin
      $display("\n=================== DEBUG ===================");

      // ==========================
      // IF - Instruction Fetch
      // ==========================
      $display("====== IF : %h", instruction);
      $display("PC              : %10d", pc);

      // ==========================
      // ID - Instruction Decode
      // ==========================
      $display("====== ID : %h", instruction_id);
      $display("  RegWrite      : %1b", reg_write_wb);
      $display("  rs a          : %1d", rs1_id);
      $display("  rs b          : %1d", rs2_id);
      $display("  read data a   : %1d", read_data_a);
      $display("  read data b   : %1d", read_data_b);
      $display("  immediate     : %1d", immediate);

      // ==========================
      // EX - Execute
      // ==========================
      $display("====== EX : %h", instruction_ex);
      $display("ALU Control     : %02b", alu_operation);
      $display("ALU Operation   : %04b", alu_operation);
      $display("Operands:");
      $display("  op_a          : %032b", alu_operand_a);
      $display("  alu src       : %032b", aluSrcA_ex);
      $display("  op_b (MUX)    : %032b", alu_operand_b);
      $display("ALU Result      : %032b", alu_result);

      // ==========================
      // MEM - Memory Access
      // ==========================
      $display("====== ME : %h", instruction_mem);
      $display("MemRead         : %1b", mem_read_mem);
      $display("Address         : %032b", alu_result_mem);
      $display("MemWrite        : %1b", mem_write_mem);
      $display("Write Data      : %032b", read_data_b_mem);
      $display("Read Data (raw) : %08b", read_data);
      $display("Read Data (ext) : %032b", extended_read_data);
      $display("Branch         :  %1b", branch_mem);
      $display("PC Next         : %d", sum_pc_mem);

      // ==========================
      // WB - Write Back
      // ==========================

      $display("====== WB : %h", instruction_wb);
      $display("RegWrite        : %1b", reg_write_wb);
      $display("MemToReg        : %1b", mem_to_reg_wb);
      $display("ALU Result (0)  : %032b", alu_result_wb);
      $display("Memory Data (1) : %032b", read_data_wb);
      $display("Write Data      : %032b", write_data);
      $display("Write Address   : %05b", rd_wb);

      $display("============================================\n");
    end
  `endif

  // ~MEM

endmodule