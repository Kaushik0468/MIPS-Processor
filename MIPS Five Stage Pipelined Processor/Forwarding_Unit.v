`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2023 14:22:05
// Design Name: 
// Module Name: Forwarding_Unit
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


module Forwarding_Unit(
    input [4:0] MEMRegisterRd,
    input [4:0] WBRegisterRd,
    input [4:0] EXRegisterRs,
    input [4:0] EXRegisterRt,
    input WB_RegWrite,
    input MEM_RegWrite,
    output reg [1:0] ForwardA,
    output reg [1:0] ForwardB
    );
// we are not using 0th register as zero register. So we are not checking for (MEMWBRegisterRd == 0) and (EXMEMRegisterRd == 0)      
    
always@(*)
begin
if (MEM_RegWrite) 
    begin
    if(MEMRegisterRd == EXRegisterRs) ForwardA = 2'b10; //Forward data from EXMEM
    end
else if (WB_RegWrite == 1'b1 && MEM_RegWrite!=1'b1)
    begin
    if((WBRegisterRd == EXRegisterRs && MEMRegisterRd != EXRegisterRs))ForwardA = 2'b01; //Forward data from MEMWB
    end
else 
    begin
    ForwardA = 2'b00;
    end 
end
always@(*)
begin
if (MEM_RegWrite) 
    begin
    if(MEMRegisterRd == EXRegisterRt) ForwardB = 2'b10; //Forward data from EXMEM
    end
else if (WB_RegWrite == 1'b1 && MEM_RegWrite!=1'b1)
    begin
    if((WBRegisterRd == EXRegisterRt && MEMRegisterRd != EXRegisterRt))ForwardB = 2'b01; //Forward data from MEMWB
    end
else 
    begin
    ForwardB = 2'b00;
    end 
end


endmodule