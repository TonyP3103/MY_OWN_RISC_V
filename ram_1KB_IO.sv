module ram_1KB_IO #(  parameter MEM_FILE   = "mem_init_zeros.hex") 
(i_clk, i_rst, i_wren, i_address, i_data, o_data, i_io_sw, i_io_btn, o_io_ledr, o_io_ledg, o_io_lcd, o_io_hex0, o_io_hex1, o_io_hex2, o_io_hex3,            mem_output_buffer);
                                                                                                                  

input logic i_clk;
input logic i_rst;
input logic i_wren;
input logic  [2:0]  i_address;                   // [7:0] i_address;
input logic [31:0] i_data;
input logic [31:0] i_io_sw;
input logic [31:0] i_io_btn;

output logic [31:0] o_data;
output logic [31:0]  o_io_ledr, o_io_ledg, o_io_lcd;
output logic [6:0] o_io_hex0, o_io_hex1, o_io_hex2, o_io_hex3;
output logic [31:0] mem_output_buffer [0:3]; 
logic [31:0] mem_input_buffer [0:3];

always_ff @(posedge i_clk or negedge i_rst) begin
    if (!i_rst) begin
         mem_output_buffer[0] <= 32'b0;
         mem_output_buffer[1] <= 32'b0;
         mem_output_buffer[2] <= 32'b0;
         mem_output_buffer[3] <= 32'b0;
    end else if (i_wren) begin
        mem_output_buffer[i_address[1:0]] <= i_data;
    end else begin
	 
	 end 
end 


assign mem_input_buffer[3] = i_io_btn;
assign mem_input_buffer[2] = i_io_sw;
assign mem_input_buffer[1] = 32'd32;
assign mem_input_buffer[0] = 32'd31;

assign o_io_ledr =  mem_output_buffer[0];
assign o_io_ledg =  mem_output_buffer[1];
assign o_io_hex0 =  mem_output_buffer[2][6:0];
assign o_io_hex1 =  mem_output_buffer[2][14:8];
assign o_io_hex2 =  mem_output_buffer[2][22:16];
assign o_io_hex3 =  mem_output_buffer[2][30:24];
assign o_io_lcd  =  mem_output_buffer[3];

assign o_data = (i_address[2]) ? mem_input_buffer[i_address[1:0]] : mem_output_buffer[i_address[1:0]];

initial begin
 $readmemh(MEM_FILE, mem_output_buffer);
  $readmemh(MEM_FILE, mem_input_buffer);
    end 

endmodule         
