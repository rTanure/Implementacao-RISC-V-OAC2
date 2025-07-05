`timescale 1ps/1ps

module register_file_tb();
  reg clk = 0;
  always #5 clk = ~clk;

  reg rst = 1;
  reg reg_write = 0;
  reg [4:0] read_address_a = 0;
  reg [4:0] read_address_b = 0;
  reg [4:0] write_address = 0;
  reg [31:0] write_data = 0;

  wire [31:0] read_data_a;
  wire [31:0] read_data_b;

  register_file uut (
    .clk(clk),
    .rst(rst),
    .reg_write(reg_write),
    .read_address_a(read_address_a),
    .read_address_b(read_address_b),
    .write_address(write_address),
    .write_data(write_data),
    .read_data_a(read_data_a),
    .read_data_b(read_data_b)
  );

  initial begin 
    $dumpfile("register_file_tb.vcd");
    $dumpvars(0, register_file_tb);

    // Finaliza o reset do banco de registradores
    #10
    rst = 0;

    // Escreve 123 no registrador 1
    #10
    write_address = 5'd1;
    write_data = 32'd123;
    reg_write = 1;
    #10
    reg_write = 0;

    // Lê o valor do registrador 1;
    read_address_a = 5'd1;
    #5;
    $display("Esperado: 123, Lido: %d", read_data_a);

    // Tenta escrever 99 no registrador 0
    write_address = 5'd0;
    write_data = 32'd99;
    reg_write = 1;
    #10
    reg_write = 0;

    #10
    read_address_a = 5'd0;
    #5
    $display("Esperado: 0, Lido: %d", read_data_a);

    // Escrever 736 no registrador 2
    write_address = 5'd2;
    write_data = 32'd736;
    reg_write = 1;
    #10;
    reg_write = 0;

    // Ler registradores 1 e 2 simultaneamente
    read_address_a = 5'd1;
    read_address_b = 5'd2;
    #5;
    $display("Lido A: %d (esperado 123), Lido B: %d (esperado 736)", read_data_a, read_data_b);

    #20 $finish;
  end

endmodule