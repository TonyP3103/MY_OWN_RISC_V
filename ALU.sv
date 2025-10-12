module ALU (i_operand_a, i_operand_b, i_alu_op, mux_out);

input logic [31:0] i_operand_a, i_operand_b;
input logic [3:0] i_alu_op;
output logic [31:0] mux_out;
 
logic [31:0] ARTHIMETIC, SHIFT, LOGICAL;


ARITHMETIC ARITHMETIC_DUT (	.i_operand_a(i_operand_a),
                                        .i_operand_b(i_operand_b),
                                        .op(i_alu_op[1:0]),
                                        .ARITHMETIC_result(ARTHIMETIC)
                                        );
                                
LOGICAL LOGICAL_DUT (	.i_operand_a(i_operand_a),
                                        .i_operand_b(i_operand_b),  
                                        .i_alu_op(i_alu_op[1:0]),
                                        .o_result(LOGICAL)
                                        );


shifter shifter_DUT (	.i_data(i_operand_a),
                        .i_shamt(i_operand_b[4:0]),
                        .i_type(i_alu_op[1:0]),
                        .o_result(SHIFT)
                        );


ALU_MUX  MUX (  .ARTHIMETIC(ARTHIMETIC), 
                .SHIFT(SHIFT),  
                .LOGICAL(LOGICAL), 
                .sel(i_alu_op[3:2]), 
                .mux_out(mux_out));


/*
logic [31:0] cin_32bit;

logic signed_set;
logic cout;

logic [31:0] shifter_output_left, shifter_output_right;

always_comb begin
    cin_32bit = 32'h00000000;
    SHIFT     = 32'd0;
    LOGICAL   = 32'd0;
    SET       = 32'd0;

    if (i_alu_op[0]) begin
        cin_32bit = 32'hFFFFFFFF;      
        SHIFT     = shifter_output_right;
        LOGICAL   = i_operand_a | i_operand_b;

        if (i_alu_op[1]) 
            SET = {31'd0, signed_set};   
        else 
            SET = {31'd0, !cout};        
    end else begin
        cin_32bit = 32'h00000000;
        SHIFT     = shifter_output_left;

        if (i_alu_op[1])
            LOGICAL = i_operand_a ^ i_operand_b;
        else
            LOGICAL = i_operand_a & i_operand_b;

        SET = 32'd0; 
    end
end


///////////////////////////////////signed set to 1 according to Bolean function/////////////////////////////////////////////
assign signed_set = !i_operand_b[31] & ARTHIMETIC[31] | i_operand_a[31] & ARTHIMETIC[31] | i_operand_a[31] & !i_operand_b[31];



adder_32_bit adder32bit_DUT (	.a(i_operand_a),
                                        .b(i_operand_b ^ cin_32bit),
                                        .cin(i_alu_op[0]),
                                        .sum(ARTHIMETIC),
                                        .G(),
                                        .P(),
                                        .cout(cout),
                                        .overflow()
                                        );





shifter_32_bit_left shifter_32_bit_left_DUT (   .i_data(i_operand_a),
                        .i_shift_amt(i_operand_b[4:0]),
                        .o_data(shifter_output_left));


shifter_32_bit_right shifter_32_bit_right_DUT (  .i_data(i_operand_a),
                        .i_shift_amt(i_operand_b[4:0]),
                        .A_enable(i_alu_op[1]),
                        .o_data(shifter_output_right));



always_comb begin
        o_alu_data = 32'b00000000000000000000000000000000;
        A_enable = 1'b0;
        cin = 0;    
case (i_alu_op)
    4'b0000: begin // ADD
        cin = 1'b0;
        o_alu_data = adder_output;
    end

    4'b0001: begin // SUB
        cin = 1'b1;
        o_alu_data = adder_output;
    end

    4'b0010: begin // SLT
        cin= 1'b1;
        o_alu_data = {31'd0, signed_set};
    end

    4'b0011: begin // SLTU
        cin = 1'b1; 
        o_alu_data = {30'd0,!cout};
    end
    
    4'b0100: begin // XOR
        o_alu_data = i_operand_a ^ i_operand_b;
    end

    4'b0101: begin // OR
        o_alu_data = i_operand_a | i_operand_b;
    end

    4'b0110: begin // AND
        o_alu_data = i_operand_a & i_operand_b;
    end

    4'b0111: begin // SLL
        o_alu_data = shifter_output_left;
    end 

    4'b1000: begin // SRL
        o_alu_data = shifter_output_right;
    end  

    4'b1001: begin // SRA
        A_enable = 1'b1;
        o_alu_data = shifter_output_right;
    end

    default: begin
        o_alu_data = 32'b00000000000000000000000000000000;
        A_enable = 1'b0;
        cin = 0;    
    end 
endcase 
end
*/
endmodule 