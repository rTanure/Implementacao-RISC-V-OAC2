iverilog -Wall -o cpu_com_pipeline_tb.vvp ./cpu_com_pipeline/*.v
vvp cpu_com_pipeline_tb.vvp


iverilog -Wall -DDEBUG -o cpu_com_pipeline_tb.vvp ./cpu_com_pipeline/*.v
vvp cpu_com_pipeline_tb.vvp
gtkwave cpu_com_pipeline_tb.vcd