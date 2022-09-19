module add_sub_32bit(	sel_add_sub,
						in0, in1,
						c_out, s);
///////////////////////////////////
input sel_add_sub;//add: sel_add_sub=0, sub: in0 - in1
input [31:0] in0, in1;

output [31:0] s;
output c_out;
//////////////////////////////////
wire c_in;
wire [30:0] c_temp;
wire [31:0] in1_temp;
//////////////////////////////////
assign c_in=sel_add_sub;

assign in1_temp[0]=in1[0]^sel_add_sub;
assign in1_temp[1]=in1[1]^sel_add_sub;
assign in1_temp[2]=in1[2]^sel_add_sub;
assign in1_temp[3]=in1[3]^sel_add_sub;
assign in1_temp[4]=in1[4]^sel_add_sub;
assign in1_temp[5]=in1[5]^sel_add_sub;
assign in1_temp[6]=in1[6]^sel_add_sub;
assign in1_temp[7]=in1[7]^sel_add_sub;
assign in1_temp[8]=in1[8]^sel_add_sub;
assign in1_temp[9]=in1[9]^sel_add_sub;

assign in1_temp[10]=in1[10]^sel_add_sub;
assign in1_temp[11]=in1[11]^sel_add_sub;
assign in1_temp[12]=in1[12]^sel_add_sub;
assign in1_temp[13]=in1[13]^sel_add_sub;
assign in1_temp[14]=in1[14]^sel_add_sub;
assign in1_temp[15]=in1[15]^sel_add_sub;
assign in1_temp[16]=in1[16]^sel_add_sub;
assign in1_temp[17]=in1[17]^sel_add_sub;
assign in1_temp[18]=in1[18]^sel_add_sub;
assign in1_temp[19]=in1[19]^sel_add_sub;

assign in1_temp[20]=in1[20]^sel_add_sub;
assign in1_temp[21]=in1[21]^sel_add_sub;
assign in1_temp[22]=in1[22]^sel_add_sub;
assign in1_temp[23]=in1[23]^sel_add_sub;
assign in1_temp[24]=in1[24]^sel_add_sub;
assign in1_temp[25]=in1[25]^sel_add_sub;
assign in1_temp[26]=in1[26]^sel_add_sub;
assign in1_temp[27]=in1[27]^sel_add_sub;
assign in1_temp[28]=in1[28]^sel_add_sub;
assign in1_temp[29]=in1[29]^sel_add_sub;

assign in1_temp[30]=in1[30]^sel_add_sub;
assign in1_temp[31]=in1[31]^sel_add_sub;

fa_1bit fa0	(in0[0], 	in1_temp[0], 	c_in,			c_temp[0], 	s[0]);
fa_1bit fa1	(in0[1], 	in1_temp[1], 	c_temp[0], 		c_temp[1], 	s[1]);
fa_1bit fa2	(in0[2], 	in1_temp[2], 	c_temp[1], 		c_temp[2], 	s[2]);
fa_1bit fa3	(in0[3], 	in1_temp[3], 	c_temp[2], 		c_temp[3], 	s[3]);
fa_1bit fa4	(in0[4], 	in1_temp[4], 	c_temp[3], 		c_temp[4], 	s[4]);
fa_1bit fa5	(in0[5], 	in1_temp[5], 	c_temp[4], 		c_temp[5], 	s[5]);
fa_1bit fa6	(in0[6], 	in1_temp[6], 	c_temp[5], 		c_temp[6], 	s[6]);
fa_1bit fa7	(in0[7], 	in1_temp[7], 	c_temp[6], 		c_temp[7], 	s[7]);
fa_1bit fa8	(in0[8], 	in1_temp[8], 	c_temp[7], 		c_temp[8], 	s[8]);
fa_1bit fa9	(in0[9], 	in1_temp[9], 	c_temp[8], 		c_temp[9], 	s[9]);

fa_1bit fa10(in0[10], 	in1_temp[10], 	c_temp[9], 		c_temp[10], s[10]);
fa_1bit fa11(in0[11], 	in1_temp[11], 	c_temp[10], 	c_temp[11], s[11]);
fa_1bit fa12(in0[12], 	in1_temp[12], 	c_temp[11], 	c_temp[12], s[12]);
fa_1bit fa13(in0[13], 	in1_temp[13], 	c_temp[12], 	c_temp[13], s[13]);
fa_1bit fa14(in0[14], 	in1_temp[14], 	c_temp[13], 	c_temp[14], s[14]);
fa_1bit fa15(in0[15], 	in1_temp[15], 	c_temp[14], 	c_temp[15], s[15]);
fa_1bit fa16(in0[16], 	in1_temp[16], 	c_temp[15], 	c_temp[16], s[16]);
fa_1bit fa17(in0[17], 	in1_temp[17], 	c_temp[16], 	c_temp[17], s[17]);
fa_1bit fa18(in0[18], 	in1_temp[18], 	c_temp[17], 	c_temp[18], s[18]);
fa_1bit fa19(in0[19], 	in1_temp[19], 	c_temp[18], 	c_temp[19], s[19]);

fa_1bit fa20(in0[20], 	in1_temp[20], 	c_temp[19], 	c_temp[20], s[20]);
fa_1bit fa21(in0[21], 	in1_temp[21], 	c_temp[20], 	c_temp[21], s[21]);
fa_1bit fa22(in0[22], 	in1_temp[22], 	c_temp[21], 	c_temp[22], s[22]);
fa_1bit fa23(in0[23], 	in1_temp[23], 	c_temp[22], 	c_temp[23], s[23]);
fa_1bit fa24(in0[24], 	in1_temp[24], 	c_temp[23], 	c_temp[24], s[24]);
fa_1bit fa25(in0[25], 	in1_temp[25], 	c_temp[24], 	c_temp[25], s[25]);
fa_1bit fa26(in0[26], 	in1_temp[26], 	c_temp[25], 	c_temp[26], s[26]);
fa_1bit fa27(in0[27], 	in1_temp[27], 	c_temp[26], 	c_temp[27], s[27]);
fa_1bit fa28(in0[28], 	in1_temp[28], 	c_temp[27], 	c_temp[28], s[28]);
fa_1bit fa29(in0[29], 	in1_temp[29], 	c_temp[28], 	c_temp[29], s[29]);

fa_1bit fa30(in0[30], 	in1_temp[30], 	c_temp[29], 	c_temp[30], s[30]);
fa_1bit fa31(in0[31], 	in1_temp[31], 	c_temp[30], 	c_out, 		s[31]);

endmodule