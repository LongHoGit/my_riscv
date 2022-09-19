module decode ( clk, instruction, wb_data, regwrite,
				data_rs1, data_rs2, imm,
				alu_ctrl);

input clk;				
input [31:0] instruction;
input [31:0] wb_data;
input regwrite;

output [31:0] data_rs1, data_rs2;
output [31:0] imm;
output [3:0] alu_ctrl;

////////////////////
wire [4:0]  wire_rs1;
wire [4:0]  wire_rs2;
wire [4:0]  wire_rd;
////////////////////

decoder decoder_u
(
.instruction(instruction),
 
.rs1(wire_rs1), 
.rs2(wire_rs2), 
.imm(imm), 
.rd(wire_rd), 
.alu_ctrl(alu_ctrl)
);

reg_file_32 regfile_u
(
.clk(clk),
.addr_read1(wire_rs1), 
.addr_read2(wire_rs2), 
.addr_write(wire_rd),
.data_in(wb_data), 
.regwrite(/*connect to controller */ regwrite),

.data_out1(data_rs1),
.data_out2(data_rs2)
);

endmodule