iverilog -Wall -o instruction_memory_tb.vvp ./risc_v_blocks/instruction_memory/*.v
vvp instruction_memory_tb.vvp
gtkwave instruction_memory_tb.vvp