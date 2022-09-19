module writeback (result_alu, read_data,
				  mem_to_reg,
				  mux_to_regfile);
				 
input [31:0] result_alu, read_data;
input mem_to_reg;

output [31:0] mux_to_regfile;

/////////////////////////

/////////////////////////

mux_32x2to1 mux_u
(
.d0(result_alu),
.d1(read_data),
.sel(mem_to_reg), //signal from control unit

.out(mux_to_regfile)
);

endmodule