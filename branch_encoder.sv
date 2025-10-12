module branch_encoder (i_funct3, o_br_less, o_br_equal, o_pc_sel,i_br_un);
input logic [2:0] i_funct3;
input logic o_br_less, o_br_equal;
output logic o_pc_sel, i_br_un;

always_comb begin
    case (i_funct3)
        3'b000: begin
             o_pc_sel = o_br_equal;       // BEQ
             i_br_un = 1'b1;  // signed
        end    

        3'b001: begin
             o_pc_sel = ~o_br_equal;      // BNE
             i_br_un = 1'b1;  // signed
        end 

        3'b100: begin
             o_pc_sel = o_br_less;        // BLT
             i_br_un = 1'b1;  // signed
        end

        3'b101: begin
             o_pc_sel = ~o_br_less;       // BGE
             i_br_un = 1'b1;  // signed
        end

        3'b110: begin
             o_pc_sel = o_br_less;        // BLTU
             i_br_un = 1'b0;  // unsigned
        end

        3'b111: begin
             o_pc_sel = ~o_br_less;       // BGEU
             i_br_un = 1'b0;  // unsigned
        end

        default:begin 
		  o_pc_sel = 1'b0;
        i_br_un = 1'b1;  // signed
		  end
    endcase
end 

endmodule 