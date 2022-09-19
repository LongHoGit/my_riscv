module i_mem(addr, instruction);

input [9:0] addr;//connect to pc

output reg [31:0] instruction;//connect to regfile or decoder

reg [31:0] mem[0:1000];

initial
	$readmemb("memfile.txt",mem);

always @(addr)
	instruction <= mem[addr] ;

endmodule