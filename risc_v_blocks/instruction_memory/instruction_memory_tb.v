`timescale 1ps / 1ps

module instruction_memory_tb;

  reg [31:0] addr;
  wire [31:0] instr;

  instruction_memory uut (
    .read_address(addr),
    .instruction_data(instr)
  );

  integer i;

  initial begin
    $dumpfile("instruction_memory_tb.vcd");
    $dumpvars(0, instruction_memory_tb);
    

    for (i = 0; i < 10; i = i + 1) begin
      addr = i * 4;
      #10;
      $display("Endereco: %d, Instrucao: %b", addr, instr);
    end
    
    #10 $finish;
  end

endmodule
