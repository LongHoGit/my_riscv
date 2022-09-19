module d_mem(	addr,write_data,memwrite, memread,
				read_data);

input wire [9:0] addr;// memry Address
input wire [31:0] write_data;// memory Address Contents
input wire memwrite, memread;// Enable read, write

output reg [31:0] read_data;// Output of memory Address Contents
////////////////////////////////////////////////////////////
reg [31:0] mem[0:1000];
////////////////////////////////////////////////////////////

always @(addr or memwrite or memread) begin
  if (memwrite == 1'b1)
    mem[addr] <= write_data;
  // Use memread to indicate a valid address is on the line 
  // and read the memory into a register at that address when memread is asserted
  if (memread == 1'b1)
    read_data <= mem[addr];
end

endmodule