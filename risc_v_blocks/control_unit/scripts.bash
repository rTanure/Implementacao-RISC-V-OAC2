iverilog -Wall -o control_unit_tb.vvp ./risc_v_blocks/control_unit/*.v
vvp control_unit_tb.vvp
gtkwave control_unit_tb.vcd