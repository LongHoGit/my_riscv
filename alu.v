`define ADD_32 			4'h00
`define SUB_32 			4'h01
`define XOR_32 			4'h02
`define OR_32 			4'h03
`define AND_32 			4'h04
`define SHIFTL_32 		4'h05
`define SHIFTR_32 		4'h06
`define SHIFTR_32_ARITH	4'h07
`define LESS_THAN_32 		4'h08
`define LESS_THAN_32_SIGNED 4'h09

module alu(	alu_ctrl,
			alu_in1,alu_in2,
			result_o);

input [3:0] alu_ctrl;
input [31:0] alu_in1,alu_in2;

output [31:0] result_o;

//////////////////////////////////////////////////////
reg [31:0] reg_result;// register for output

reg [31:0] reg_shift_left_1;
reg [31:0] reg_shift_left_2;
reg [31:0] reg_shift_left_4;
reg [31:0] reg_shift_left_8;

reg [31:16] reg_shift_right_fill;
reg [31:0] reg_shift_right_1;
reg [31:0] reg_shift_right_2;
reg [31:0] reg_shift_right_4;
reg [31:0] reg_shift_right_8;

wire [31:0] wire_result_add;
wire [31:0] wire_result_sub;
wire carry_bit;
//////////////////////////////////////////////////////
add_sub_32bit as0(1'b0,alu_in1,alu_in2,,wire_result_add);//ADD_32
add_sub_32bit as1(1'b1,alu_in1,alu_in2,carry_bit,wire_result_sub);//SUB_32
/////////////////////////////////////////////////////
always @(alu_ctrl or alu_in1 or alu_in2) 
begin
	case(alu_ctrl)
		
	//Arithmetic
	//===============
	`ADD_32: reg_result = wire_result_add;
		
	`SUB_32: reg_result = wire_result_sub;

	//Logical
	//===============
	`XOR_32:	reg_result = alu_in1 ^ alu_in2;

	`OR_32:		reg_result = alu_in1 || alu_in2;

	`AND_32:	reg_result = alu_in1 && alu_in2;

	//Shift left
	//===============
	`SHIFTL_32:
			begin
				
				if (alu_in2[0] == 1'b1)
					reg_shift_left_1 = {alu_in1[30:0],1'b0};
				else
					reg_shift_left_1 = alu_in1;
				
				if (alu_in2[1] == 1'b1)
					reg_shift_left_2 = {reg_shift_left_1[29:0],2'b00};
				else
					reg_shift_left_2 = reg_shift_left_1;
				
				if (alu_in2[2] == 1'b1)
					reg_shift_left_4 = {reg_shift_left_2[27:0],4'b0000};
				else
					reg_shift_left_4 = reg_shift_left_2;
				
				if (alu_in2[3] == 1'b1)
					reg_shift_left_8 = {reg_shift_left_4[23:0],8'b00000000};
				else
					reg_shift_left_8 = reg_shift_left_4;
				
				if (alu_in2[4] == 1'b1)
					reg_result = {reg_shift_left_8[15:0],16'b0000000000000000};
				else
					reg_result = reg_shift_left_8;
			end
			
	//Shift right
	//===============
	`SHIFTR_32, `SHIFTR_32_ARITH:
		begin
				// Arithmetic shift? Fill with 1's if MSB set
				if (alu_in1[31] == 1'b1 && alu_ctrl == `SHIFTR_32_ARITH)
					reg_shift_right_fill = 16'b1111111111111111;
				else
					reg_shift_right_fill = 16'b0000000000000000;

				if (alu_in2[0] == 1'b1)
					reg_shift_right_1 = {reg_shift_right_fill[31], alu_in1[31:1]};
				else
					reg_shift_right_1 = alu_in1;

				if (alu_in2[1] == 1'b1)
					reg_shift_right_2 = {reg_shift_right_fill[31:30], reg_shift_right_1[31:2]};
				else
					reg_shift_right_2 = reg_shift_right_1;

				if (alu_in2[2] == 1'b1)
					reg_shift_right_4 = {reg_shift_right_fill[31:28], reg_shift_right_2[31:4]};
				else
					reg_shift_right_4 = reg_shift_right_2;

				if (alu_in2[3] == 1'b1)
					reg_shift_right_8 = {reg_shift_right_fill[31:24], reg_shift_right_4[31:8]};
				else
					reg_shift_right_8 = reg_shift_right_4;

				if (alu_in2[4] == 1'b1)
					reg_result = {reg_shift_right_fill[31:16], reg_shift_right_8[31:16]};
				else
					reg_result = reg_shift_right_8;
		end

	`LESS_THAN_32: reg_result = (carry_bit) ? 32'h1 : 32'h0;
		
	`LESS_THAN_32_SIGNED:
		begin
			if (alu_in1[31] != alu_in2[31])
				reg_result = alu_in1[31] ? 32'h1 : 32'h0;
			else
				reg_result = wire_result_sub[31] ? 32'h1 : 32'h0;         
		end
	endcase
end
		
//=====================================		
assign result_o = reg_result;
//=====================================

endmodule