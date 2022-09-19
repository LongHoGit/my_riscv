module execute (data_rs1, data_rs2, imm,
				alu_src,
				alu_ctrl,
				result_o, data_rs2_to_d_mem);

input [31:0] data_rs1, data_rs2;
input [31:0] imm;
input 		 alu_src;
input [3:0]  alu_ctrl;

output [31:0] result_o;
output [31:0] data_rs2_to_d_mem;

//////////////////
wire [31:0] wire_to_alu_in2;
assign data_rs2_to_d_mem = data_rs2;
//////////////////

mux_32x2to1 mux_u
(
.d0(data_rs2),
.d1(imm),
.sel(alu_src), //signal from control unit

.out(wire_to_alu_in2)
);

alu alu_u
(
.alu_ctrl(alu_ctrl),
.alu_in1(data_rs1),
.alu_in2(wire_to_alu_in2),

.result_o(result_o)
);

endmodule