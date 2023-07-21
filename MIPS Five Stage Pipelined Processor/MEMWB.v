`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2023 16:00:27
// Design Name: 
// Module Name: MEMWB
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


module MEMWB(MEM_Rd,MEM_ALUOut,MEM_Read_Data,MEM_MemtoReg,MEM_RegWrite,
              WB_Rd,WB_ALUOut,WB_Read_Data,WB_MemtoReg,WB_RegWrite,
              clk,reset);

              
input wire [4:0] MEM_Rd;
input wire [31:0] MEM_ALUOut,MEM_Read_Data;
input wire MEM_MemtoReg,MEM_RegWrite;
output reg [4:0] WB_Rd;
output reg [31:0] WB_ALUOut ,WB_Read_Data;
output reg WB_MemtoReg,WB_RegWrite;
input wire clk,reset;

always @(posedge clk, negedge reset)
        begin
        
        if(reset==0)
        begin
        WB_Rd [4:0] <= 0;
        WB_ALUOut [31:0] <= 0;
        WB_Read_Data [31:0] <= 0;
        WB_MemtoReg <= 0;
        WB_RegWrite <= 0;
        end
        
        else
        begin
        WB_Rd [4:0] <= MEM_Rd [4:0];
        WB_ALUOut [31:0] <= MEM_ALUOut [31:0]; 
        WB_Read_Data [31:0] <= MEM_Read_Data [31:0];
        WB_MemtoReg <= MEM_MemtoReg;
        WB_RegWrite <= MEM_RegWrite;
        end
        end
              
endmodule
