`timescale 1ns / 1ps

module cpu_sem_pipeline_tb;

  reg clk;
  reg rst;

  cpu_sem_pipeline uut (
    .clk(clk),
    .rst(rst)
  );

  always #5 clk = ~clk;

  initial begin
    $dumpfile("cpu_sem_pipeline_tb.vcd");
    $dumpvars(0, cpu_sem_pipeline_tb);

    clk = 0;
    rst = 1;

    #10 rst = 0;

    #200 $finish;
  end

endmodule
