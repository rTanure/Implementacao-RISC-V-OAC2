module imm_gen_tb ();

  reg [31:0] instruction;
  wire [31:0] immediate;

  imm_gen uut (
    .instruction(instruction),
    .immediate(immediate)
  );

  initial begin
    $dumpfile("imm_gen_tb.vcd");
    $dumpvars(0, imm_gen_tb);

    instruction = 32'b10111111110100000000000000000000; 
    #5 $display("%b", immediate);
    #10;

    instruction = 32'b00111111111100000000000000000000; 
    #5 $display("%b", immediate);
    #10;

    instruction = 32'b00111111111000000000000000000000; 
    #5 $display("%b", immediate);
    #10;

    $finish;
  end

endmodule