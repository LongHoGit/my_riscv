module pc(	clk,reset,
			count_out);
  
input clk,reset;

output reg [31:0] count_out;
//////////////////////////
reg  [31:0] reg_count;	
wire [31:0] temp_count;
add_sub_32bit c0(1'b0,reg_count,32'h00000004,,temp_count);
//////////////////////////
    always@(posedge clk or posedge reset)
    begin
        if(reset)
            count_out = 32'h00000000;
		else 
			begin
			reg_count = temp_count;
			count_out = temp_count;
			end
    end

endmodule