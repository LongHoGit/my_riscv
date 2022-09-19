module riscv
(
clk ,reset,
data_rs1, data_rs2
);

input clk, reset;

output [31:0] data_rs1, data_rs2;

///////////////////////////
wire [31:0] instruction;
wire regwrite, memread, memwrite, alu_src, mem_to_reg;
wire [31:0] data_rs1, data_rs2;
wire [31:0] imm;
wire [3:0] alu_ctrl;
wire [31:0] result_alu, result_alu_to_mux;
wire [31:0] data_rs2_to_d_mem;
wire [31:0] read_data;
wire [31:0] mux_to_regfile;
///////////////////////////

//CONTROLLER
controller controller_u
(
.clk(clk), 
.opcode(instruction[6:2]),

.regwrite(regwrite),
/*.branch(),*/ 
.memread(memread), 
.memwrite(memwrite), 
.alu_src(alu_src), 
.mem_to_reg(mem_to_reg)
);

//INSTRUCTION FETCH
fetch fetch_u
(
.clk(clk),
.reset(reset),

.instruction(instruction)
);

//INSTRUCTION DECODE
decode decode_u
(
.clk(clk), 
.instruction(instruction), 
.wb_data(mux_to_regfile), 
.regwrite(regwrite),

.data_rs1(data_rs1), 
.data_rs2(data_rs2), 
.imm(imm),
.alu_ctrl(alu_ctrl)
);

//EXECUTE ADDRESS
execute execute_u
(
.data_rs1(data_rs1), 
.data_rs2(data_rs2), 
.imm(imm),
.alu_src(alu_src),
.alu_ctrl(alu_ctrl),

.result_o(result_alu), 
.data_rs2_to_d_mem(data_rs2_to_d_mem)
);

//MEMORY ACCESS
memory memory_u
(
.result_alu(result_alu[9:0]), 
.data_rs2_to_d_mem(data_rs2_to_d_mem),
.memwrite(memwrite), 
.memread(memread),

.read_data(read_data),
.result_alu_to_mux(result_alu_to_mux)
);

//WRITE BACK
writeback writeback_u
(
.result_alu(result_alu_to_mux), 
.read_data(read_data),
.mem_to_reg(mem_to_reg),

.mux_to_regfile(mux_to_regfile)
);

endmodule