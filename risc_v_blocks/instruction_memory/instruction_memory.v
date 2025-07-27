`include "params.vh"

module instruction_memory (
  input  [`ADDR_WIDTH - 1:0] read_address,
  output [`DATA_WIDTH - 1:0] instruction_data
);
  // Cria um banco de registradores
  reg [`DATA_WIDTH - 1:0] memory [0:`INST_MEM_DEPTH - 1];

  initial begin
    // Carrega o arquivo contendo o programa para a memoria de intruções
    $readmemb(`INST_MEM_FILE, memory);
  end

  // Atribui o valor da memória ao dado de instrução
  assign instruction_data = memory[read_address >> 2'd2];

endmodule