`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2023 13:26:45
// Design Name: 
// Module Name: Instruction_Fetch
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


module Instruction_Fetch( 
	input clk,
	input reset,
	output [31:0] Instruction_Code,
	input PC_con,
	input Jump,
	input [31:0] extend,
	//output reg [31:0] PC,
	output [31:0] Add_Source_1);
	 
	 reg [31:0] PC;
	 
	 wire [31:0] out_1,ALU_out,out,PC_jump;
	 wire [31:0] Add_Source_2; //Add_Source_1 = PC +4;
	 wire [27:0] Ins_part = Instruction_Code [25:0] <<<2;
	 
	 assign PC_jump = {Add_Source_1[31:28],Ins_part};
	 assign Add_Source_2 = extend<<<2; // arithmetic left shift 
	 assign Add_Source_1= PC +4;
	 assign ALU_out = Add_Source_2 + Add_Source_1;
	 assign out_1 = PC_con ? ALU_out : Add_Source_1;
	 assign out = Jump ? PC_jump : out_1;    
	
	 Instruction_Memory a1(PC,reset,Instruction_Code);
	 
	 always @(posedge clk, negedge reset)
	 
	 begin
	 
	 if (reset==0)
	 PC <=0;
	 
	 else
	 PC<= out;
	 
	 end
	 
endmodule
