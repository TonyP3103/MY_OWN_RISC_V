module PC (i_clk, i_rst, o_pc, o_pc_plus4, PCsel, mux_out);
input logic i_clk, i_rst, PCsel;
input logic [31:0]  mux_out;
output logic [31:0] o_pc;
output logic [31:0] o_pc_plus4;

logic [31:0] i_pc;

assign i_pc = (PCsel) ? mux_out : o_pc_plus4;

always_ff @(posedge i_clk or negedge i_rst) begin
    if (!i_rst) begin
        o_pc <= 32'b0;
    end else begin
        o_pc <= i_pc;
    end
end

adder_32_bit adder_32bit_inst   (  .a(o_pc),
                                    .b(32'd4),
                                    .cin(1'b0),
                                    .sum(o_pc_plus4),
                                    .G(),
                                    .P(),
                                    .cout(),
                                    .overflow());

endmodule 