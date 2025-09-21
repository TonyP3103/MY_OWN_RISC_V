`timescale 1us/1us
module tb();

logic clk;


initial begin
clk = 0;
forever #5 clk = !clk;
end

/*
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