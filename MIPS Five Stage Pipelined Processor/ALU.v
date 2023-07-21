`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2023 14:41:42
// Design Name: 
// Module Name: ALU
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


module ALU(ALUCtl, A,B, ALUOut, Zero);

	input [3:0] ALUCtl;
	input [31:0] A,B;
	output reg [31:0] ALUOut;
	output  Zero;
	
	assign Zero= ~(|ALUOut); // Zero is true if ALUOUT is 0
	
	always@(ALUCtl,A,B) begin //reevaluate if these change
		case (ALUCtl)
			0: ALUOut = A&B;
			1: ALUOut = A|B;
			2: ALUOut = A+B;
			6: ALUOut = A-B;
			7: ALUOut = A<B; 
			8: ALUOut = A^B;
            9: ALUOut = ~(A|B);
            default: ALUOut = 0;
		endcase
	end
	
endmodule
