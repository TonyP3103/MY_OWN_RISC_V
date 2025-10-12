module BRC ( i_rs1_data,  i_rs2_data,  i_br_un,  o_br_less,o_br_equal);

input logic [31:0] i_rs1_data, i_rs2_data;
input logic i_br_un;        // 0 for unsigned, 1 for signed
output logic o_br_less,o_br_equal;

logic cout;
logic [31:0] sum;

adder_32_bit adder_32_bit_BRC (	.a(i_rs1_data),
                                    .b(~i_rs2_data),
                                    .cin(1'b1),
                                    .sum(sum),
                                    .G(),
                                    .P(),
                                    .cout(cout),
                                    .overflow()
                                    );


assign  o_br_equal = sum ? 1'b0 : 1'b1;

    assign o_br_less  = i_br_un ? ((i_rs1_data[31] ^ i_rs2_data[31]) ? i_rs1_data[31] : sum[31]) : ~cout;
endmodule 
