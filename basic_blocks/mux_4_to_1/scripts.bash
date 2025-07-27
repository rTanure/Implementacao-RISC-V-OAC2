iverilog -Wall -o mux_4_to_1_tb.vvp ./basic_blocks/mux_4_to_1/*.vvp
vvp mux_4_to_1_tb.vvp
gtkwave mux_4_to_1_tb.vcd