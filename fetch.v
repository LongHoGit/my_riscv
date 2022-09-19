module fetch (	clk, reset,
				instruction);

input clk, reset;

output [31:0] instruction;

///////////////////
wire [31:0] pc_to_i_mem;
///////////////////

pc pc_u 
(
.clk(clk),
.reset(reset),
.count_out(pc_to_i_mem)
);
		
i_mem i_mem_u 
(
.addr(pc_to_i_mem), 
.instruction(instruction),
);

endmodule