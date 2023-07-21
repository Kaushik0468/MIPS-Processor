`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2023 01:25:18
// Design Name: 
// Module Name: IFID
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


module IFID(clk,reset,IF_Instruction_Code,IF_PCinc,ID_Instruction_Code,ID_PCinc,IFIDWrite,FLUSH);
    
input clk,reset,IFIDWrite,FLUSH;
input [31:0] IF_Instruction_Code,IF_PCinc;
output reg [31:0] ID_Instruction_Code,ID_PCinc;    
    
always @(FLUSH, posedge clk, negedge reset)
        begin
        if((reset==0)||(FLUSH==1))
            begin
            ID_Instruction_Code [31:0]<=0;
            ID_PCinc [31:0]<=0;
            end
        else if (IFIDWrite)
            begin
            ID_Instruction_Code [31:0] <= ID_Instruction_Code [31:0];
            ID_PCinc[31:0] <= ID_PCinc [31:0];
            end
        else
            begin
            ID_Instruction_Code [31:0] <= IF_Instruction_Code [31:0];
            ID_PCinc[31:0] <= IF_PCinc [31:0];
            end
        end
      
endmodule
