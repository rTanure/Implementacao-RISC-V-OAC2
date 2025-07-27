iverilog -Wall -o ./register_file_tb.vvp ./risc_v_blocks/register_file/*.v
vvp ./register_file_tb.vvp
gtkwave ./register_file_tb.vcd