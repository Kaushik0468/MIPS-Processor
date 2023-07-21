`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2023 14:38:19
// Design Name: 
// Module Name: ALU_Control
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


module ALU_Control(ALUOp, FuncCode, ALUCtl);

input [1:0] ALUOp;
input [5:0] FuncCode;
output reg [3:0] ALUCtl;

wire [7:0] In= {ALUOp, FuncCode}; 
	
always @(*)
begin
casex(In)
	8'b00xxxxxx : ALUCtl <= 4'b0010; //add
	8'bx1xxxxxx : ALUCtl <= 4'b0110; //sub  
	8'b1xxx0000 : ALUCtl <= 4'b0010; //add //100000 
	8'b1xxx0010 : ALUCtl <= 4'b0110; //sub //100010
	8'b1xxx0100 : ALUCtl <= 4'b0000; //and //100100
	8'b1xxx0101 : ALUCtl <= 4'b0001; //or  //100101
	8'b1xxx1010 : ALUCtl <= 4'b0111; //slt //101010 
	8'b1xxx0110 : ALUCtl <= 4'b1000; //xor //100110
	8'b1xxx0111 : ALUCtl <= 4'b1001; //nor //100111    
	default: ALUCtl <= 4'b1001; //nor
endcase	
end
endmodule
