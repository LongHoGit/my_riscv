`define R_OP 		 5'b01100
`define IMM_OP		 5'b00100
`define LOAD_OP		 5'b00000
`define STORE_OP	 5'b01000
`define branch_OP	 5'b11000
`define JAL_OP		 5'b11011
`define JALR_OP		 5'b11001
`define LUI_OP		 5'b01101
`define AUIPC_OP	 5'b00101
`define ENVIR_OP	 5'b11100

module controller ( clk, opcode,
					regwrite, /*branch,*/ memread, memwrite, alu_src, mem_to_reg);

input clk;					
input [6:2] opcode;

output reg regwrite; //connect to reg_file_32
/*output branch;*/ //connect to ...
output reg memread, memwrite; // connect to d_mem
output reg alu_src, mem_to_reg; // connect to 2 multilexer

///////////////////////////////
reg temp;
///////////////////////////////

always @(posedge clk)
begin
	case(opcode)
		`R_OP:
		begin
			alu_src		= 1'b0; //src = rs2
			
			mem_to_reg	= 1'b0; //rd = alu result
		end
		
		`IMM_OP:
		begin
			alu_src		= 1'b1; //src = imm
			
			mem_to_reg	= 1'b0; //rd = alu result
		end
		
		`LOAD_OP:
		begin
			alu_src		= 1'b0; //src = rs2
			memread		= 1'b1; //read enable
			mem_to_reg	= 1'b1; //rd = M[]
		end
		
		`STORE_OP:
		begin
			alu_src		= 1'b0; //src = rs2
			memwrite	= 1'b1; //write enable
		end

	endcase
end

always @(negedge clk) regwrite	= 1'b1;

endmodule