iverilog -Wall -o mux_2_to_1_tb.vvp ./basic_blocks/mux_2_to_1/*.v
vvp mux_2_to_1_tb.vvp
gtkwave mux_2_to_1_tb.vcd