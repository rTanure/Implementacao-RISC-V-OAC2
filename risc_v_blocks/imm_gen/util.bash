iverilog -Wall -o imm_gen_tb.vvp ./risc_v_blocks/imm_gen/*.v
vvp imm_gen_tb.vvp
gtkwave imm_gen_tb.vvp