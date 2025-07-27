iverilog -Wall -o data_memory_tb.vvp ./risc_v_blocks/data_memory/*.v
vvp data_memory_tb.vvp
gtkwave data_memory_tb.vcd