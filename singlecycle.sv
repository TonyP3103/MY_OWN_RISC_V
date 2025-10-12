module singlecycle (i_clk, i_rst_n, o_pc_debug, o_insn_vld, o_io_ledr, o_io_ledg, o_io_hex0, o_io_hex1, o_io_hex2    ,o_pc,instr_data,reg_array,mux_out,i_operand_a, i_operand_b,o_wback_data,o_br_less, o_br_equal,o_rs1_data, o_rs2_data,PCsel,mem_output_buffer,mem,immediate, ld_data,wback_data,data_data, io_data,o_data_wren, o_io_wren,MemRW,data_enable, io_enable,
o_io_hex3, o_io_hex4, o_io_hex5, o_io_hex6, o_io_hex7, o_io_lcd, i_io_sw, i_io_btn);



input logic i_clk, i_rst_n;
input logic [31:0] i_io_sw;
input logic [3:0] i_io_btn;

output logic o_insn_vld;
output logic [6:0] o_io_hex0, o_io_hex1, o_io_hex2, o_io_hex3, o_io_hex4, o_io_hex5, o_io_hex6, o_io_hex7;
output logic [31:0] o_pc_debug, o_io_ledr, o_io_ledg, o_io_lcd;

output logic [31:0] reg_array [31:0];
output logic [31:0] o_pc;
output logic [31:0] instr_data;
output logic [31:0] mux_out;
output logic [31:0]  i_operand_a, i_operand_b;
output logic [31:0] o_wback_data;
output logic PCsel;
output logic [31:0] mem_output_buffer [0:3]; 
output logic [31:0] mem [0:255]; 

logic Asel, Bsel, RegWen;
logic [1:0] wb_select;
logic  i_br_un;
output logic o_br_less, o_br_equal;
logic [31:0] o_pc_plus4;
output logic [31:0] immediate, ld_data,wback_data;
output logic [31:0] o_rs1_data, o_rs2_data;
logic [3:0] ALU_sel;
output logic MemRW;
output logic [31:0] data_data, io_data;
output logic o_data_wren, o_io_wren;
output logic data_enable, io_enable;


//assign i_pc = (PCsel) ? mux_out : o_pc_plus4;
PC PC_inst (.i_clk(i_clk),
            //.i_pc (i_pc),
            .mux_out(mux_out),
				.PCsel(PCsel),
            .i_rst(i_rst_n),
            .o_pc_plus4(o_pc_plus4),
            .o_pc(o_pc)
            );



ram_1KB_instruction #(.MEM_FILE("mem_init.hex")) 
         ram_instr (.i_clk(i_clk),                                                       // never reset instruction memory
                    .i_rst(1'b1), 
                    .i_address(o_pc[9:2]),
                    .o_data(instr_data)
                           
                    );

regfile regfile_ints (  .i_clk(i_clk), 
                        .i_rst(i_rst_n), 
                        .i_rs1_addr(instr_data[19:15]), 
                        .i_rs2_addr(instr_data[24:20]),  
                        .o_rs1_data(o_rs1_data), 
                        .o_rs2_data(o_rs2_data), 
                        .i_rd_addr(instr_data[11:7]), 
                        .i_rd_data(o_wback_data), 
                        .i_rd_wren(RegWen),                        //signal from control unit
								.reg_array(reg_array)
                        );

imm_gen imm_gen_inst(.i_imm(instr_data[31:7]), 
                     .i_sel(instr_data[6:0]), // Select signal for immediate generation
                     .o_imm(immediate)
                     );

assign i_operand_a = (Asel) ? o_pc : o_rs1_data;
assign i_operand_b = (Bsel) ? immediate : o_rs2_data;

ALU  ALU_inst( .i_operand_a(i_operand_a), 
                .i_operand_b(i_operand_b), 
                .i_alu_op(ALU_sel),                
                .mux_out(mux_out)
                );


LSU  LSU_inst ( .i_clk(i_clk), 
                .i_rst(i_rst_n),
                .i_lsu_data(o_rs2_data), 
                .i_lsu_addr(mux_out),               //mux_out comes from ALU
                .i_lsu_wren(MemRW),                      //////////////////////
                .i_io_sw(i_io_sw), 
                .i_io_btn(i_io_btn), 
                .o_io_ledr(o_io_ledr), 
                .o_io_ledg(o_io_ledg), 
                .o_io_lcd(o_io_lcd), 
                .o_io_hex0(o_io_hex0), 
                .o_io_hex1(o_io_hex1), 
                .o_io_hex2(o_io_hex2), 
                .o_io_hex3(o_io_hex3), 
                .o_ld_data(ld_data),
					 .funct3(instr_data[14:12]),

                .mem_output_buffer(mem_output_buffer),
                .mem(mem),
                .data_data(data_data), 
                .io_data(io_data),
                .o_data_wren(o_data_wren), 
                .o_io_wren(o_io_wren),
                .data_enable(data_enable), 
                .io_enable(io_enable)

                );



always_comb begin
    case (wb_select)
        2'b00: wback_data = ld_data; // From Load Data
        2'b01: wback_data = mux_out;  // From ALU
        2'b10: wback_data = o_pc_plus4; // From PC + 4 (for JAL, JALR)
        2'b11: wback_data = i_operand_b;    // B
        endcase 
end

controller_unit controller (.instr_data(instr_data), 
                                 .o_br_less(o_br_less), 
                                 .o_br_equal(o_br_equal), 
                                 .PCsel(PCsel), 
                                 .RegWen(RegWen), 
                                 .Asel(Asel), 
                                 .Bsel(Bsel), 
                                 .ALU_sel(ALU_sel), 
                                 .MemRW(MemRW), 
                                 .wb_select(wb_select)
                                 );

load_logic loadlogic (.funct3(instr_data[14:12]), 
                .opcode(instr_data[6:0]),                                    
				.i_wback_data(wback_data), 
				.o_wback_data(o_wback_data)
				);

BRC BRC_int (.i_rs1_data(o_rs1_data),  
             .i_rs2_data(o_rs2_data),  
             .i_br_un(i_br_un),             // from control unit  
             .o_br_less(o_br_less),
             .o_br_equal(o_br_equal)
             );


branch_encoder branch_encode (.i_funct3(),
                              .o_br_less(), 
                              .o_br_equal(), 
                              .o_pc_sel(), 
                              .i_br_un(i_br_un)
                              );
endmodule