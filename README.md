# Implementacao-RISC-V-OAC2

## testando em verilog

iverilog -Wall -o [nome_arquivo_destino].vvp [lista_arquivos_dependentes] 
ex: iverilog -Wall -o instruction_memory_tb.vvp instruction_memory_tb.v instruction_memory.v 

# Estado inicial do banco de registradores
<img width="555" height="777" alt="Captura de tela de 2025-08-15 21-03-48" src="https://github.com/user-attachments/assets/d13bad1f-7a3f-4989-8527-9b7d66f9769f" />

# Estado inicial da memória de dados
<img width="552" height="777" alt="Captura de tela de 2025-08-15 21-05-42" src="https://github.com/user-attachments/assets/ae025f41-ed50-44e1-9a2b-19441017bf7a" />

# Código ASM utilizado para teste

ori x2, x0, 7
sb x2, 4(x0)
lb x1, 4(x0) 
add x1, x1, x2 
add x1, x1, x2
sub x1, x1, x2
sub x1, x1, x2
beq x1, x2, 12
add x1, x1, x1
sb x1, 0(x0)
and x1, x1, x2
or x1, x1, x0
sb x1, 0(x0)

# Código binário utilizado para Teste

00000000011100000110000100010011
00000000001000000000001000100011
00000000010000000000000010000011
00000000001000001000000010110011
00000000001000001000000010110011
01000000001000001000000010110011
01000000001000001000000010110011 
00000000001000001000000101100011 
00000000000100001000000010110011
00000000000100000000000000100011
00000000001000001111000010110011
00000000000000001110000010110011 
00000000000100000000000000100011
