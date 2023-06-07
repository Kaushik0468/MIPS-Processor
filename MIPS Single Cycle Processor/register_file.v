`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2023 13:35:10
// Design Name: 
// Module Name: register_file
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


module register_file(
    input [4:0] Read_Reg_Num_1,
	 input [4:0] Read_Reg_Num_2,
	 input [4:0] Write_Reg_Num,
	 input [31:0] Write_Data,
	 output [31:0] Read_Data_1,
	 output [31:0] Read_Data_2,
	 input RegWrite,
	 input clk,
	 input reset
	 );

reg [31:0] RegMemory [31:0];

integer i;

assign Read_Data_1 = RegMemory[Read_Reg_Num_1];
assign Read_Data_2 = RegMemory[Read_Reg_Num_2];

always @(posedge clk or negedge reset)
begin
if (reset==0) // if reset is equal to 1 then register file will be refreshed
begin
	for(i=0; i<30; i=i+1)
	RegMemory[i] = 10*i+1;
	RegMemory[30] = 10;
	RegMemory[31] = 10;
end
end
always @(Write_Data)
begin
if (RegWrite ==1)
	RegMemory[Write_Reg_Num] = Write_Data;
end
endmodule

