iverilog -Wall -o alu_tb.vvp ./risc_v_blocks/alu/*.v
vvp alu_tb.vvp
gtkwave alu_tb.vcd