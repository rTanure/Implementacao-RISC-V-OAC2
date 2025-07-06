// Largura de dados e endereço
`define DATA_WIDTH 32
`define ADDR_WIDTH 32

// Definições da memoria de instruções
`define INST_MEM_DEPTH 256
`define INST_MEM_FILE "../../program.bin"

// Definições do branco de registradores
`define NUM_REGISTERS 32
`define REG_ADDR_WIDTH 5 // log_2(NUM_REGISTERS)

// Definições da ALU
`define ALU_OP_WIDTH = 4

// operações da ALU
`define ALU_ADD   4'b0000
`define ALU_SUB   4'b0001
`define ALU_AND   4'b0010
`define ALU_OR    4'b0011
`define ALU_XOR   4'b0100
`define ALU_SLL   4'b0101
`define ALU_SRL   4'b0110


