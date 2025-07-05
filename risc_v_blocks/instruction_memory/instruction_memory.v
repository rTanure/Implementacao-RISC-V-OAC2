module instruction_memory (
  input  [31:0] read_address,
  output [31:0] instruction_data
);
  // Crie uma memoria de instruções com 256 palavras de 32 bits
  reg [31:0] memory [0:255];

  initial begin
    // Carrega o arquivo contendo o programa para a memoria de intruções
    $readmemb("../../program.bin", memory);
  end

  // Atribui o valor da memória ao dado de instrução
  assign instruction_data = memory[read_address >> 2'd2];

endmodule