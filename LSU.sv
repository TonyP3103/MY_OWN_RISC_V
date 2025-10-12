module LSU (i_clk, i_rst, i_lsu_data, i_lsu_addr, i_lsu_wren, i_io_sw, i_io_btn, o_io_ledr, o_io_ledg, o_io_lcd, o_io_hex0, o_io_hex1, o_io_hex2, o_io_hex3, o_ld_data,funct3,         mem, mem_output_buffer,data_data, io_data,o_data_wren, o_io_wren,data_enable, io_enable);
 
input logic i_clk, i_rst, i_lsu_wren;
input logic [2:0] funct3;
 
input logic [31:0] i_lsu_data;                                                                                                                                       
input logic [31:0] i_lsu_addr;
input logic [31:0] i_io_sw;
input logic [31:0] i_io_btn;

output logic [31:0]  o_io_ledr, o_io_ledg, o_io_lcd, o_ld_data;
output logic [6:0] o_io_hex0, o_io_hex1, o_io_hex2, o_io_hex3;


output logic [31:0] mem_output_buffer [0:3]; 

output logic [31:0] data_data, io_data;

logic data_mem_enable, io_mem_enable;
output logic o_data_wren, o_io_wren;
logic [31:0] o_data_mem, o_data_io;
output logic data_enable, io_enable;

output logic [31:0] mem [0:255]; 

Decoder  decoder_inst ( .i_ls_address(i_lsu_addr[9:8]),
                        .store_enable(i_lsu_wren), 
                        .i_data(i_lsu_data), 
                        .o_data_wren(o_data_wren), 
                        .o_data_mem(o_data_mem), 
                        .o_io_wren(o_io_wren), 
                        .o_data_io(o_data_io),
                        .data_enable(data_enable), 
                        .io_enable(io_enable)
);


// each ram only need to access last 8 bits of the address


ram_1KB #(.MEM_FILE("mem_init_zeros.hex")) 
         ram_data (.i_clk(i_clk),
                   .i_rst(1'b1),
                   .i_wren(o_data_wren),
                   .i_address(i_lsu_addr[7:0]),
                   .i_data(o_data_mem), 
                   .o_data(data_data),
                   .funct3(funct3),
						 
						 
                   .mem(mem)     
                        );

ram_1KB_IO ram_1KB_IO_DUT (	.i_clk(i_clk), 
                                .i_rst(1'b1),
                                .i_wren(o_io_wren), 
                                .i_address(i_lsu_addr[2:0]), // Only 3 bits used, 8 locations
                                .i_data(o_data_io), 
                                .o_data(io_data), 
                                .i_io_sw(i_io_sw), 
                                .i_io_btn(i_io_btn), 
                                .o_io_ledr(o_io_ledr), 
                                .o_io_ledg(o_io_ledg), 
                                .o_io_lcd(o_io_lcd), 
                                .o_io_hex0(o_io_hex0), 
                                .o_io_hex1(o_io_hex1), 
                                .o_io_hex2(o_io_hex2), 
                                .o_io_hex3(o_io_hex3),


                                .mem_output_buffer(mem_output_buffer)
                                );

logic  [1:0] lsu_sel;

assign lsu_sel = {io_enable, data_enable};

LSU_MUX LSU_MUX_inst (  .data_data(data_data), 
                        .io_data(io_data), 
                        .lsu_sel(lsu_sel), 
                        .lsu_data_out(o_ld_data)
                );

endmodule   