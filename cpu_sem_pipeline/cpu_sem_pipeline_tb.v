`timescale 1ps / 1ps

module cpu_sem_pipeline_tb;
  reg clk = 1;
  always #5 clk = ~clk;

  reg rst = 1;

  cpu_sem_pipeline uut (
    .clk(clk),
    .rst(rst)
  );

  initial begin
    $dumpfile("cpu_sem_pipeline_tb.vcd");
    $dumpvars(0, cpu_sem_pipeline_tb);
    #0 rst = 1;
    #10 rst = 0;

    #300 $finish;
  end

endmodule
