iverilog -Wall -o alu_control.vvp ./risc_v_blocks/alu_control/*.v
vvp alu_control.vvp
gtkwave alu_control.vcd