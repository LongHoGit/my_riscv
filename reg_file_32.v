module reg_file_32 (clk, addr_read1, addr_read2, addr_write, data_in, regwrite,
					data_out1, data_out2);
//
input clk;
input [4:0] addr_read1, addr_read2;//alternatively connected to rs1 and rs2

input [4:0] addr_write;//the register selected to write from data_in
input [31:0] data_in;//write back from WB stage

input regwrite;//write=1

output reg [31:0] data_out1, data_out2; //data in register corresponding to rs1 and rs2
/////////////////////////////////////////////////////
reg [31:0] r[31:0]; //32 registers
/////////////////////////////////////////////////////
always @(addr_read1 or addr_read2) 
	begin 
		data_out1 = r[addr_read1];
		data_out2 = r[addr_read2];
	end		
			
always @(negedge clk)
	begin
		if (regwrite)
			r[addr_write]=data_in;
	end		
		
endmodule