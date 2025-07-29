iverilog -Wall -o cpu_sem_pipeline_tb.vvp ./cpu_sem_pipeline/*.v
vvp cpu_sem_pipeline_tb.vvp

iverilog -Wall -DDEBUG -o cpu_sem_pipeline_tb.vvp ./cpu_sem_pipeline/*.v
vvp cpu_sem_pipeline_tb.vvp
gtkwave cpu_sem_pipeline_tb.vcd