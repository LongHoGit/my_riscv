module mux_32x2to1(	d0,d1, 
					sel, out);

input [31:0] d0,d1;
input sel;

output reg [31:0] out;

always @(sel) begin
	case(sel)
		0:	out<=d0;
		1:	out<=d1;

	endcase
end

endmodule

