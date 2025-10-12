`timescale 1us/1us
module tb();

logic clk;
//logic clk_2;
 logic  i_rst_n;
  logic [31:0] reg_array [31:0];

 /* 
  logic [31:0] reg_x12;
  assign reg_x12 = reg_array[12];*/

initial begin
	clk = 0;
	i_rst_n = 1'b0;
	#1 i_rst_n = 1'b1;
	forever #5 clk = !clk;
end

/*
initial begin
	clk_2 = 0;
	forever #10 clk_2 = !clk_2;
end 
*/


logic [31:0] i_io_sw;
logic [3:0] i_io_btn;
logic o_insn_vld;
logic [6:0] o_io_hex0, o_io_hex1, o_io_hex2, o_io_hex3;
logic [31:0] o_io_ledr, o_io_ledg, o_io_lcd;

logic [31:0] o_pc;	 
logic [31:0] instr_data,mux_out;
logic [31:0]  i_operand_a, i_operand_b;
logic [31:0] o_wback_data;
logic o_br_less, o_br_equal;
logic [31:0] o_rs1_data, o_rs2_data;
logic PCsel;
logic [31:0] mem_output_buffer [0:3]; 
logic [31:0] mem [0:255]; 
logic [31:0] immediate, ld_data,wback_data;
logic [31:0] data_data, io_data;
logic o_data_wren, o_io_wren;
logic MemRW;
logic data_enable, io_enable;


singlecycle DUT (.i_clk(clk), 
				 .i_rst_n(i_rst_n), 
				 .o_pc_debug(), 
				 .o_insn_vld(o_insn_vld), 
				 .o_io_ledr(o_io_ledr), 
				 .o_io_ledg(o_io_ledg), 
				 .o_io_hex0(o_io_hex0), 
				 .o_io_hex1(o_io_hex1), 
				 .o_io_hex2(o_io_hex2),
				 .o_io_hex3(o_io_hex3), 
				 .o_io_hex4(), 
				 .o_io_hex5(), 
				 .o_io_hex6(), 
				 .o_io_hex7(), 
				 .o_io_lcd(o_io_lcd), 
				 .i_io_sw(i_io_sw), 
				 .i_io_btn(i_io_btn),

				 .reg_array(reg_array),
				 .o_pc(o_pc),
				 .instr_data(instr_data),
				 .mux_out(mux_out),
				 .i_operand_a(i_operand_a),
				 .i_operand_b(i_operand_b),
				 .o_wback_data(o_wback_data),
				 .o_br_less(o_br_less), 
				 .o_br_equal(o_br_equal),
				 .o_rs1_data(o_rs1_data), 
				 .o_rs2_data(o_rs2_data),
				 .PCsel(PCsel),
				 .mem_output_buffer(mem_output_buffer),
				 .mem(mem),
				 .immediate(immediate),
				 .ld_data(ld_data),
				 .wback_data(wback_data),
				 .data_data(data_data),
				 .io_data(io_data),
				 .o_data_wren(o_data_wren), 
				 .o_io_wren(o_io_wren),
				 .MemRW(MemRW),
				 .data_enable(data_enable), 
				 .io_enable(io_enable)

				 );

/*
logic [2:0] funct3;
logic [31:0] i_wback_data;
logic [31:0] o_wback_data;

load_logic DUT (.funct3(funct3),
				.i_wback_data(i_wback_data), 
				.o_wback_data(o_wback_data)
				);

initial begin
for (int i = 0; i < 20; i++) begin
	@(posedge clk);
	funct3 = $urandom_range(0,3'b111);
	i_wback_data = $urandom_range(0,32'hFFFFFFFF);
end
end
*/
/*	/////////////////////////////////////////////LSU/////////////////////////////////////////////
logic i_lsu_wren;
logic [31:0] i_lsu_data;                                                                                                                                       
logic [31:0] i_lsu_addr;
logic [31:0] i_io_sw;
logic [31:0] i_io_btn;
logic [31:0] o_ld_data;
logic [31:0]  o_io_ledr, o_io_ledg, o_io_lcd;
logic [6:0] o_io_hex0, o_io_hex1, o_io_hex2, o_io_hex3;


LSU  LSU_DUT (	.i_clk(clk), 
				.i_rst(1'b1), 
				.i_lsu_data(i_lsu_data), 
				.i_lsu_addr(i_lsu_addr), 
				.i_lsu_wren(i_lsu_wren), 
				.i_io_sw(i_io_sw), 
				.i_io_btn(i_io_btn), 
				.o_io_ledr(o_io_ledr), 
				.o_io_ledg(o_io_ledg), 
				.o_io_lcd(o_io_lcd), 
				.o_io_hex0(o_io_hex0), 
				.o_io_hex1(o_io_hex1), 
				.o_io_hex2(o_io_hex2), 
				.o_io_hex3(o_io_hex3),
				.o_ld_data(o_ld_data)
				);
 
initial begin
i_lsu_addr = 32'h200;
i_lsu_data = 32'hA5A5A5A5;
i_lsu_wren = 1'b1;
end */
/*/////////////////////////////////////////////RAM_1KB_IO TESTBENCH//////////////////////////////////////////////
logic [2:0] i_address;                   // [7:0] i_address;
logic [31:0] i_data;
logic [31:0] o_data;	
logic [31:0] i_io_sw;
logic [31:0] i_io_btn;
logic i_wren;

logic [31:0] o_io_ledr, o_io_ledg, o_io_lcd;
logic [6:0] o_io_hex0, o_io_hex1, o_io_hex2, o_io_hex3;


ram_1KB_IO ram_1KB_IO_DUT (	.i_clk(clk), 
							.i_rst(1'b1),
							.i_wren(i_wren), 
							.i_address(i_address), 
							.i_data(i_data), 
							.o_data(o_data), 
							.i_io_sw(i_io_sw), 
							.i_io_btn(i_io_btn), 
							.o_io_ledr(o_io_ledr), 
							.o_io_ledg(o_io_ledg), 
							.o_io_lcd(o_io_lcd), 
							.o_io_hex0(o_io_hex0), 
							.o_io_hex1(o_io_hex1), 
							.o_io_hex2(o_io_hex2), 
							.o_io_hex3(o_io_hex3)
							);

initial begin
	i_io_sw = 32'hA5A5A5A5;
	i_io_btn = 32'h5A5A5A5A;
	i_wren = 1'b1;
	i_address = 3'b000;
	i_data = 32'hFFFFFFFF;
	#10;
	i_address = 3'b001;
	i_data = 32'h12345678;
	#10;
	i_address = 3'b010;
	i_data = 32'h12344321;
	#10;
	i_address = 3'b011;
	i_data = 32'h87654321;
	#10;
	i_wren = 1'b0;
	for (int i = 0; i < 8; i++) begin
		@(posedge clk);
		i_address = $urandom_range(0,3'b111);
	end
end
*/
/*
///////////////////////////////Decoder TB//////////////////////////////////////////////
logic [31:0] i_ls_address;				
logic store_enable;
logic [31:0] i_data;
logic o_instr_wren;
logic [31:0] o_data_instr;
logic o_data_wren;
logic [31:0] o_data_mem;
logic o_io_wren;
logic [31:0] o_data_io;

Decoder  decoder_tb( .i_ls_address(i_ls_address),
 					 .store_enable(store_enable), 
					 .i_data(i_data), 
					 .o_instr_wren(o_instr_wren), 
					 .o_data_instr(o_data_instr), 
					 .o_data_wren(o_data_wren), 
					 .o_data_mem(o_data_mem), 
					 .o_io_wren(o_io_wren), 
					 .o_data_io(o_data_io));


initial begin
	for (int i = 0; i < 20; i++) begin
		@(posedge clk);
		i_ls_address = $urandom_range(0,10'b1111111111);
		store_enable = $urandom_range(0,1);
		i_data = $urandom_range(0,32'hFFFFFFFF);
	end
end
*/



/*/////////////////////////////////////////////PC TB//////////////////////////////////////////////
logic [15:0] o_pc;

logic i_rst;
initial begin
	i_rst = 0;
	#5;
	i_rst = 1;
end

PC PC_DUT (	.i_clk(clk),
			 .i_rst(i_rst),
			 .o_pc(o_pc)
				);
*/////////////////////////////////////////////////////////////////////////////

/*				//RAM TESTBENCH 
logic i_wren;
logic [7:0] i_address;
logic [31:0] i_data;
logic [31:0] o_data;	

ram_1KB ram_1KB_DUT (	.i_clk(clk), 
						.i_rst(1'b1),
						.i_wren(i_wren), 
						.i_address(i_address),
						.i_data(i_data),
						.o_data(o_data)
						);



initial begin
	for (int j = 0; j < 256; j++) begin
		@(posedge clk);
		i_wren = 0;
		i_address = j;
		i_data = j;// $urandom_range(0,32'hFFFFFFFF);
	end
	#100;
for (int i = 0; i < 20; i++) begin
	@(posedge clk_2);
	i_wren = 0;
	i_address = $urandom_range(0,8'b11111111);
	i_data = $urandom_range(0,32'hFFFFFFFF);
end 
end
*/

/*
/////////////////////////////////////////////SHIFTER TB//////////////////////////////////////////////
logic [31:0] i_data;
logic [4:0] i_shamt;
logic [1:0] i_type; //00 logical left, 01 logical right, 10 arithmetic right
logic [31:0] o_result;
logic [31:0] expected_result;

shifter shifter_DUT (	.i_data(i_data),
						.i_shamt(i_shamt),
						.i_type(i_type),
						.o_result(o_result)
						);


initial begin
for (int i = 0; i < 20; i++) begin
	@(posedge clk);
	i_data = $urandom_range (0, 32'hFFFFFFFF);
	i_shamt = $urandom_range (0, 5'b11111);
	i_type = $urandom_range (0, 2'b11);
	if (i_type == 2'b00) begin
		expected_result = i_data << i_shamt;
	end else if (i_type == 2'b01) begin
		expected_result = i_data >> i_shamt;
	end else begin
		expected_result = $signed(i_data) >>> i_shamt;
	end
end 
end 
*/

/*
/////////////////////////////////////////////////REGFILE TESTBENCH///////////////////////////////////////////
logic [4:0] i_rs1_addr, i_rs2_addr;
logic [31:0] o_rs1_data, o_rs2_data;
logic [4:0] i_rd_addr;
logic [31:0] i_rd_data;
logic i_rd_wren;
logic i_rst;
initial begin
i_rst = 0;
#5;
i_rst = 1;
for (int i = 0; i < 32; i++) begin
	@(posedge clk);
	i_rd_wren = $urandom_range(0,1);
	i_rs1_addr = $urandom_range(0,5'b1111);
	i_rs2_addr = $urandom_range(0,5'b1111);
	i_rd_addr = $urandom_range(0,5'b1111);
	i_rd_data = $urandom_range(0,32'hFFFF);
end

end

regfile regfile_DUT (	.i_clk(clk),
						.i_rst(i_rst),
						.i_rs1_addr(i_rs1_addr),
						.i_rs2_addr(i_rs2_addr),
						.o_rs1_data(o_rs1_data),
						.o_rs2_data(o_rs2_data),
						.i_rd_addr(i_rd_addr),
						.i_rd_data(i_rd_data),
						.i_rd_wren(i_rd_wren)
						);
*/
/*
/////////////////////////////////////////////////BRC TESTBENCH////////////////////////////////////////////////
logic [31:0] i_rs1_data, i_rs2_data;
logic i_br_un;
logic o_br_less,o_br_equal;


BRC BRC_DUT (	.i_rs1_data(i_rs1_data),
				.i_rs2_data(i_rs2_data),
				.i_br_un(i_br_un),
				.o_br_less(o_br_less),
				.o_br_equal(o_br_equal)
				);

initial begin
for (int i = 0; i < 20; i++) begin	
	@(posedge clk);
	i_rs1_data = $urandom_range (0, 32'hFFFFFFFF);//32'hFFFFFABC;
	i_rs2_data = $urandom_range (0, 32'hFFFFFFFF);
	i_br_un = 0; //$urandom_range (0, 1);
end
end

*/
/*
/////////////////////////////////////////////////ALU TESTBENCH////////////////////////////////////////////////
logic [31:0] operand_a, operand_b;
logic [3:0] alu_op;
logic [31:0] alu_data;

logic [31:0] expected_alu_data;

singlecycle DUT (	.operand_a(operand_a),
			.operand_b(operand_b),
			.alu_op(alu_op),
			.alu_data(alu_data)
			);


initial begin
for (int i = 0; i < 20; i++) begin
@(posedge clk);
operand_a = $urandom_range (0, 32'hFFFFFFFF);
operand_b = $urandom_range (0, 32'hFFFFFFFF);
alu_op = 4'b0000; // ADD
expected_alu_data = operand_a + operand_b;
#10;
alu_op = 4'b0001; // SUB
expected_alu_data = operand_a - operand_b;
#10;
alu_op = 4'b0011; // SLT
expected_alu_data = ($signed(operand_a) < $signed(operand_b)) ? 32'b1 : 32'b0;
#10;
alu_op = 4'b0010; // SLTU
expected_alu_data = (operand_a < operand_b) ? 32'b1 : 32'b0;
#10;
alu_op = 4'b1010; // XOR
expected_alu_data = operand_a ^ operand_b;
#10;
alu_op = 4'b1001; // OR
expected_alu_data = operand_a | operand_b;
#10;
alu_op = 4'b1000; // AND
expected_alu_data = operand_a & operand_b;
#10;
alu_op = 4'b0100; // SLL
expected_alu_data = operand_a << operand_b[4:0];
#10;
alu_op = 4'b0101; // SRL
expected_alu_data = operand_a >> operand_b[4:0];
#10;
alu_op = 4'b0110; // SRA
expected_alu_data = $signed(operand_a) >>> operand_b[4:0];
end
end 
*/
/*
/////////////////////////////////////////////////////CLA TEST BENCH//////////////////////////////////////

logic [31:0] a, b, sum,sub;

logic overflow_add, overflow_sub;


logic [31:0] expected_sum;
logic [31:0] expected_subtract;

assign expected_sum = a + b;
assign expected_subtract = a - b;


adder_32_bit adder32bit_DUT_add (	.a(a),
										.b(b),
										.cin(1'b0),
										.sum(sum),
										.G(),
										.P(),
										.overflow(overflow_add)
										);

										
adder_32_bit adder32bit_DUT_sub (	.a(a),
										.b(b ^ 32'hFFFFFFFF),
										.cin(1'b1),
										.sum(sub),
										.G(),
										.P(),
										.overflow(overflow_sub)
										);										
initial begin
for (int i = 0; i < 100; i++) begin
	@(posedge clk);
	a = $urandom_range (0, 32'd100);
	b = $urandom_range (0, 32'd100);
end
end
*/

initial begin
#10000 $stop;
end
endmodule 