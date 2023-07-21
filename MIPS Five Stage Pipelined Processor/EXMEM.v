`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2023 15:01:43
// Design Name: 
// Module Name: EXMEM
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



module EXMEM(EXMEM_Rd ,B, EX_ALUOut,EX_Zero,EX_Add_Result,EX_Branch,EX_Branch1,EX_MemWrite,EX_MemRead,EX_MemtoReg,EX_RegWrite,
             MEM_Rd ,MEM_B, MEM_ALUOut,MEM_Zero,MEM_Add_Result,MEM_Branch,MEM_Branch1,MEM_MemWrite,MEM_MemRead,MEM_MemtoReg,MEM_RegWrite,
             clk,reset);

input [4:0] EXMEM_Rd ;
input [31:0] B, EX_ALUOut,EX_Add_Result;
input EX_Zero,EX_Branch,EX_Branch1,EX_MemWrite,EX_MemRead,EX_MemtoReg,EX_RegWrite;
output reg [4:0] MEM_Rd;
output reg [31:0] MEM_ALUOut,MEM_Add_Result,MEM_B;
output reg MEM_Zero,MEM_Branch,MEM_Branch1,MEM_MemWrite,MEM_MemRead,MEM_MemtoReg,MEM_RegWrite;
input wire clk,reset;

always @(posedge clk, negedge reset)
        begin
        
        if(reset==0)
        begin
        MEM_Rd			<= 0; 
        MEM_B           <= 0;
        MEM_ALUOut      <= 0;
        MEM_Zero        <= 0;
        MEM_Add_Result  <= 0;
        MEM_Branch      <= 0;
        MEM_Branch1     <= 0;
        MEM_MemWrite    <= 0;
        MEM_MemRead     <= 0;
        MEM_MemtoReg    <= 0;
        MEM_RegWrite    <= 0;
        end
        
        else
        begin
        MEM_Rd			<= EXMEM_Rd;
        MEM_B           <= B;
        MEM_ALUOut      <= EX_ALUOut;
        MEM_Zero        <= EX_Zero;
        MEM_Add_Result  <= EX_Add_Result;
        MEM_Branch      <= EX_Branch;
        MEM_Branch1     <= EX_Branch1;
        MEM_MemWrite    <= EX_MemWrite;
        MEM_MemRead     <= EX_MemRead;
        MEM_MemtoReg    <= EX_MemtoReg;
        MEM_RegWrite    <= EX_RegWrite;
        end
    end
    
endmodule
