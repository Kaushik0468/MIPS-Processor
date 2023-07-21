`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2023 01:00:19
// Design Name: 
// Module Name: Hazard_Detection_Unit
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


module Hazard_Detection_Unit(
input ID_EX_MemRead,ID_EX_Jump,
input [4:0] ID_EX_Rt, IF_ID_Rt,IF_ID_Rs,
output reg IF_ID_Write,PCWrite,Control_zero
    );
    
    always@(*) begin
    if( ID_EX_MemRead && ((ID_EX_Rt==IF_ID_Rt)||(ID_EX_Rt==IF_ID_Rs)) )
    begin
    IF_ID_Write = 1;
    PCWrite = 1;
    Control_zero = 1;
    end
    else if(ID_EX_Jump)
        begin
            IF_ID_Write = 1;
            PCWrite = 0;
            Control_zero = 1;
        end                            
    else
        begin
            IF_ID_Write = 0;
            PCWrite = 0;
            Control_zero = 0;
        end                            
    end
    
endmodule
