`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2023 13:38:38
// Design Name: 
// Module Name: Data_Memory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Data_Memory(Address,Write_Data,MemWrite,MemRead,Read_Data,clk,reset);

input [31:0] Address;
input [31:0] Write_Data; //Data that is to be written into memory in case of store
input MemRead, MemWrite; // From control unit
output reg [31:0] Read_Data; // Data that is read and taken into register in case of load
input clk,reset;	

integer i;
	
reg [31:0] mem [127:0];

always @(*)
begin
begin
	for(i=0; i<128; i=i+1)
	mem[i] = i+10;
end


if (MemWrite==1'b1 && MemRead ==1'b0)
	mem[Address] = Write_Data;
else if(MemWrite==1'b0 && MemRead ==1'b1)	
	Read_Data = mem[Address];
end
	
endmodule
