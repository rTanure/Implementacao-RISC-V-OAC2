# Implementacao-RISC-V-OAC2

## testando em verilog

iverilog -Wall -o [nome_arquivo_destino].vvp [lista_arquivos_dependentes] 
ex: iverilog -Wall -o instruction_memory_tb.vvp instruction_memory_tb.v instruction_memory.v 