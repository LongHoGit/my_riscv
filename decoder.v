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

module decoder	(	instruction, 
					rs1, rs2, imm, rd, alu_ctrl);

//input clk;
input [31:0] instruction;

output reg [4:0]  rs1;
output reg [4:0]  rs2;
output reg [31:0] imm;
output reg [4:0]  rd;
output reg [3:0]  alu_ctrl;

////////////////////////////////////////////
reg  [4:0] reg_opcode;
reg  [2:0] funct3;
reg  [6:0] funct7_or_imm;
///////////////////////////////////////////

always @(instruction) 
begin
//////////////////////////////////////////////////////////////////
	reg_opcode = instruction[6:2];
	funct3 = instruction[14:12];
	funct7_or_imm = instruction[31:25];

	rs1 = instruction[19:15];
	rs2 = instruction[24:20];
	
	if (instruction[31] == 0)
		imm = {20'b0000000000000000000,instruction[31:20]};
	else 
		imm = {20'b1111111111111111111,instruction[31:20]};

	rd = instruction[11:7];
//////////////////////////////////////////////////////////////////
	case(reg_opcode)
		
		`R_OP, `IMM_OP:
		begin
			if (reg_opcode == `R_OP && {funct3, funct7_or_imm} == 10'b000_0100000)
				alu_ctrl = 1; //sub
		
			case({funct3,funct7_or_imm})
				10'b000_0000000:alu_ctrl = 0; //add
				10'b100_0000000:alu_ctrl = 2; //xor
				10'b110_0000000:alu_ctrl = 3; //or
				10'b111_0000000:alu_ctrl = 4; //and
				10'b001_0000000:alu_ctrl = 5; //sll
				10'b101_0000000:alu_ctrl = 6; //srl
				10'b101_0100000:alu_ctrl = 7; //sra
				10'b010_0000000:alu_ctrl = 8; //slt
				10'b011_0000000:alu_ctrl = 9; //sltu		
			endcase
		end
		
		`LOAD_OP: 
		begin
			case(funct3)
				3'b000:alu_ctrl = 0; //lb
				3'b001:alu_ctrl = 0; //lh
				3'b010:alu_ctrl = 0; //lw
				3'b100:alu_ctrl = 0; //lbu
				3'b101:alu_ctrl = 0; //lhu
			endcase
		end
		
		`STORE_OP:
		begin
			case(funct3)
				3'b000:alu_ctrl = 0; //sb
				3'b001:alu_ctrl = 0; //sh
				3'b010:alu_ctrl = 0; //sw
			endcase
		end
		
	endcase
	
end //always


endmodule
////////////////////////////////////////////
/*case(reg_opcode)
		//I-type
		5'b00000: begin
			case(funct3)
			3'b000://lb
			3'b001://lh
			3'b010://lw
			3'b100://lbu
			3'b101://lhu
		end
		
		//I-type
		5'b00100: begin
			case(funct3)
			3'b000://addi
			3'b001:begin
				if(funct7_or_imm==0)
					//slli
				else //error
			end
			3'b010:slti
			3'b011:sltiu
			3'b100:xori
			3'b101:begin
				if(funct7_or_imm==0)
					//srli
				else if(funct7_or_imm==7'b0100000)
					//srai
				else //error
			end
			3'b110://ori
			3'b111://andi			
		end
		
		//U-type
		5'b00101://auipc
		
		//S-type
		5'b01000:begin
			case(funct3)
			3'b000://sb
			3'b001://sh
			3'b010://sw
		end
		
		//R-type
		5'b01100:begin
			case({funct3, funct7_or_imm})
			10'b000_0000000:add_ctrl //add
			10'b000_0100000:sub_ctrl //sub
			10'b001_0000000:sh_leftlogic_ctrl //sll
			10'b010_0000000:sh_lessthan_ctrl //slt
			10'b011_0000000:sh_lessthan_u_ctrl //sltu
			10'b100_0000000:xor_ctrl //xor
			10'b101_0000000:sh_rightlogic_ctrl //srl
			10'b101_0100000:sh_rightarith_ctrl //sra
			10'b110_0000000:or_ctrl //or
			10'b111_0000000:and_ctrl //and
		end
		
		//U-type
		5'b01101://lui
		
		//SB-type
		5'b11000:begin
			case(funct3)
			3'b000://beq
			3'b001://bne
			3'b100://blt
			3'b101://bge
			3'b110://bltu
			3'b111://bgeu
		end
		
		//I-type
		5'b11001:
		if(funct3==3'b000)
			//jalr
		
		//UJ-type
		5'b11011://jal
		
	endcase
end*/