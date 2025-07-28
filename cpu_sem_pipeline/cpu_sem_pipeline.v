`include "./risc_v_blocks/instruction_memory/instruction_memory.v"

`include "./risc_v_blocks/imm_gen/imm_gen.v"
`include "./risc_v_blocks/control_unit/control_unit.v"
`include "./risc_v_blocks/register_file/register_file.v"

`include "./risc_v_blocks/alu_control/alu_control.v"
`include "./risc_v_blocks/alu/alu.v"

`include "./basic_blocks/mux_2_to_1/mux_2_to_1.v"

`include "./risc_v_blocks/data_memory/data_memory.v"

module cpu_sem_pipeline(
  input clk,
  input rst
);
  // =========================================
  // IF - Instruction Fetch
  // =========================================
  reg [31:0] pc;
  wire [31:0] instruction;

  instruction_memory i_mem (
    .read_address(pc),
    .instruction_data(instruction)
  );

  // Atualiza o PC
  always @(posedge clk, rst) begin
    if (rst)
      pc <= 0;
    else
      pc <= pc + 4;
  end

  // Decodifica a instrução
  wire [6:0] op_code = {instruction[6:0]};
  wire [4:0] rd = {instruction[11:7]};
  wire [2:0] funct3 = {instruction[14:12]};
  wire [4:0] rs1 = {instruction[19:15]};
  wire [4:0] rs2 = {instruction[24:20]};
  wire [6:0] funct7 = {instruction[31:25]};

  `ifdef DEBUG
  always @(posedge clk) begin
    $display("====== IF ======");
    $display("PC          : %40d", pc);
    $display("instruction : %40b", instruction);
    $display("");
    $display("op_code     : %40b", op_code);
    $display("rd          : %40b", rd);
    $display("funct3      : %40b", funct3);
    $display("rs1         : %40b", rs1);
    $display("rs2         : %40b", rs2);
    $display("funct7      : %40b", funct7);
  end
  `endif 
  
  // ==========================================
  // ID - Instruction Decode
  // ==========================================
  
  // Unidade de controle
  wire branch;
  wire memRead;
  wire memToReg;
  wire [1:0] alu_op;
  wire memWrite;
  wire aluSrcA;
  wire regWrite;

  control_unit ctrl (
    .op_code(op_code),
    .Branch(branch),
    .MemRead(memRead),
    .MemToReg(memToReg),
    .ALU_op(alu_op),
    .MemWrite(memWrite),
    .ALUSrcA(aluSrcA),
    .RegWrite(regWrite)
  );

  `ifdef DEBUG
  always @(posedge clk) begin
    $display("Instruction: %b", instruction);
    $display("Opcode: %b", op_code);
    $display("Branch: %b", branch);
    $display("MemRead: %b", memRead);
    $display("MemToReg: %b", memToReg);
    $display("ALU_op: %b", alu_op);
    $display("MemWrite: %b", memWrite);
    $display("ALUSrcA: %b", aluSrcA);
    $display("RegWrite: %b", regWrite);
    $display("");
  end
  `endif

  // Banco de registradores
  wire [31:0] write_data;
  wire [31:0] read_data_a;
  wire [31:0] read_data_b;

  register_file reg_file (
    .clk(clk),
    .rst(rst),
    .reg_write(regWrite),

    .read_address_a(rs1),
    .read_address_b(rs2),
    .write_address(rd),

    .write_data(write_data),

    .read_data_a(read_data_a),
    .read_data_b(read_data_b)
  );

  `ifdef DEBUG
  always @(posedge clk) begin
    $display("====== REGISTER ======");
    $display("reg_write      : %40b", regWrite);
    $display("read_address_a : %40b", rs1);
    $display("read_address_b : %40b", rs2);
    $display("write_address  : %40b", rd);
    $display("write_data     : %40b", write_data);
    $display("read_data_a    : %40b", read_data_a);
    $display("read_data_b    : %40b", read_data_b);
  end
  `endif

  // Gera o imediato
  wire [31:0] immediate;

  imm_gen imm_gen(
    .instruction(instruction),
    .immediate(immediate)
  );
  
  `ifdef DEBUG
  always @(posedge clk) begin
    $display("====== IMM GEN ======");
    $display("immediate      : %40b", immediate);
  end
  `endif

  // Entrada B será o dado lido do banco de registradores ou o imediato
  wire [31:0] alu_reg_b;

  mux_2_to_1 mux_reg_alu (
    .input_0(read_data_b),
    .input_1(immediate),
    .sel(aluSrcA),
    .out(alu_reg_b)
  );

  `ifdef DEBUG
  always @(posedge clk) begin
    $display("====== MUX ALU REG B ======");
    $display("input_0       : %40b", read_data_b);
    $display("input_1       : %40b", immediate);
    $display("aluSrcA       : %40b", aluSrcA);
    $display("alu_reg_b     : %40b", alu_reg_b);
  end
  `endif

  // ===========================================
  // EX - Execute
  // ===========================================
  wire [3:0] alu_operation;

  // Controlador da ALU
  alu_control alu_crtl (
    .ALUOp(alu_op),
    .instruction(instruction),
    .ALUControl(alu_operation)
  );
  
  `ifdef DEBUG
  always @(posedge clk) begin
    $display("====== ALU CONTROL ======");
    $display("ALUOp         : %40b", alu_op);
    $display("instruction   : %40b", instruction);
    $display("ALUControl    : %40b", alu_operation);
  end
  `endif

  // ALU
  wire [31:0] alu_result;
  wire alu_zero;

  alu alu (
    .op_a(read_data_a),
    .op_b(alu_reg_b),
    .alu_op(alu_operation),
    .result(alu_result),
    .zero(alu_zero)
  );

  `ifdef DEBUG
  always @(posedge clk) begin
    $display("====== ALU ======");
    $display("op_a          : %40b", read_data_a);
    $display("op_b          : %40b", alu_reg_b);
    $display("alu_op        : %40b", alu_operation);
    $display("result        : %40b", alu_result);
    $display("zero          : %40b", alu_zero);
  end
  `endif

  // ============================================
  // MEM - Memory Access
  // ============================================
  wire [31:0] read_data;

  data_memory data_memory(
    .clk(clk),
    .MemWrite(memWrite),
    .MemRead(memRead),
    .address(alu_result),
    .write_data(read_data_b),
    .read_data(read_data)
  );

  `ifdef DEBUG
  always @(posedge clk) begin
    $display("====== DATA MEMORY ======");
    $display("MemWrite      : %40b", memWrite);
    $display("MemRead       : %40b", memRead);
    $display("address       : %40b", alu_result);
    $display("write_data    : %40b", read_data_b);
    $display("read_data     : %40b", read_data);
  end
  `endif

  // Dado salvo será o resultado da ALU ou o dado lido da memória
  mux_2_to_1 mux_data_reg (
    .input_0(alu_result),
    .input_1(read_data),
    .sel(memToReg),
    .out(write_data)
  );

  `ifdef DEBUG
  always @(posedge clk) begin
    $display("====== MUX DATA REG ======");
    $display("input_0       : %40b", alu_result);
    $display("input_1       : %40b", read_data);
    $display("memToReg      : %40b", memToReg);
    $display("write_data    : %40b", write_data);
  end
  `endif

  // ~MEM

endmodule