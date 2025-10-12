module Decoder ( i_ls_address, store_enable, i_data, o_data_wren, o_data_mem, o_io_wren, o_data_io,   data_enable,io_enable);

input logic [1:0] i_ls_address;                //load-store address                                                            
input logic store_enable;
input logic [31:0] i_data;                      //data to be stored

//output logic o_instr_wren;             
//output logic [31:0] o_data_instr;

output logic o_data_wren;                  
output logic [31:0] o_data_mem;                   

output logic o_io_wren;                     
output logic [31:0] o_data_io;


output logic data_enable;
output logic io_enable;



    assign data_enable = ~i_ls_address[1] & i_ls_address[0]; // 0x100 – 0x1FF
    assign io_enable   =  i_ls_address[1] & ~i_ls_address[0]; // 0x200 – 0x2FF

    // Write enables
    assign o_data_wren = data_enable & store_enable;
    assign o_io_wren   = io_enable   & store_enable;

    // Always forward data, enables control actual writes
    assign o_data_mem = i_data;
    assign o_data_io  = i_data;
endmodule 