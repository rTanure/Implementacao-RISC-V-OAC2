`include "./risc_v_blocks/instruction_memory/instruction_memory.v"

module cpu_sem_pipeline(
  input clk,
  input rst
);
  reg [31:0] pc;
  wire [31:0] instruction;

  instruction_memory i_mem (
    .read_address(pc),
    .instruction_data(instruction)
  );

  always @(posedge clk) begin
    if (rst)
      pc <= 0;
    else
      pc <= pc + 4;

    $display("PC = %0d | Instruction = %h", pc, instruction);
  end
endmodule