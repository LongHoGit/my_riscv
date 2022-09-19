module memory ( result_alu, data_rs2_to_d_mem,
				memwrite, memread,
				read_data, result_alu_to_mux);
				
input [9:0] result_alu;
input [31:0] data_rs2_to_d_mem;
input memwrite, memread;

output [31:0] read_data;
output [31:0] result_alu_to_mux;

///////////////////
assign result_alu_to_mux = result_alu;
///////////////////

d_mem d_mem_u
(
.addr(result_alu),
.write_data(data_rs2_to_d_mem),
.memwrite(memwrite), //connect to controller
.memread(memread), //connect to controller

.read_data(read_data) //connect to writeback
);

endmodule