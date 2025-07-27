`include "./risc_v_blocks/instruction_memory/instruction_memory.v"

`include "./risc_v_blocks/imm_gen/imm_gen.v"
`include "./risc_v_blocks/control_unit/control_unit.v"
`include "./risc_v_blocks/register_file/register_file.v"

`include "./basic_blocks/mux_2_to_1/mux_2_to_1.v"

module cpu_sem_pipeline(
  input clk,
  input rst
);

  // IF
  reg [31:0] pc;
  wire [31:0] instruction;

  instruction_memory i_mem (
    .read_address(pc),
    .instruction_data(instruction)
  );

  always @(posedge clk, rst) begin
    if (rst)
      pc <= 0;
    else
      pc <= pc + 4;
  end

  wire [6:0] op_code = {instruction[6:0]};
  wire [4:0] rd = {instruction[11:7]};
  wire [2:0] funct3 = {instruction[14:12]};
  wire [4:0] rs1 = {instruction[19:15]};
  wire [4:0] rs2 = {instruction[24:20]};
  wire [6:0] funct7 = {instruction[31:25]};

  // ~IF

  
  // ID
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

  // always @(posedge clk) begin
  //   $display("Instruction: %b", instruction);
  //   $display("Opcode: %b", op_code);
  //   $display("Branch: %b", branch);
  //   $display("MemRead: %b", memRead);
  //   $display("MemToReg: %b", memToReg);
  //   $display("ALU_op: %b", alu_op);
  //   $display("MemWrite: %b", memWrite);
  //   $display("ALUSrcA: %b", aluSrcA);
  //   $display("RegWrite: %b", regWrite);
  //   $display("");
  // end

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

  wire [31:0] immediate;

  imm_gen imm_gen(
    .instruction(instruction),
    .immediate(immediate)
  );
  
  // always @(posedge clk) begin
  //   $display("im %b", immediate);
  // end

  wire [31:0] alu_reg_b;

  mux_2_to_1 mux_reg_alu (
    .input_0(read_data_b),
    .input_1(immediate),
    .sel(aluSrcA),
    .out(alu_reg_b)
  )

  // ~ID

  // EX

  // ~EX

endmodule