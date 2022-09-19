module fa_1bit(in0, in1, in2, c, s);

input in0, in1, in2;

output c,s;

	assign	c=(in0&in1)|(in1&in2)|(in2&in0);
	assign	s=in0^in1^in2;

endmodule