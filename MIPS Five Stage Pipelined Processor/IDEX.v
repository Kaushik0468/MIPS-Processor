`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2023 12:01:22
// Design Name: 
// Module Name: IDEX
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


module IDEX(ID_Rs,ID_Rt,ID_Rd,ID_sign_extend,ID_Read_Data_1,ID_Read_Data_2,ID_PCinc,ID_PC_MSBs,
          EX_Rs,EX_Rt,EX_Rd,EX_sign_extend,EX_Read_Data_1,EX_Read_Data_2,EX_PCinc,EX_PC_MSBs,
          IDEX_RegDst,IDEX_MemRead,IDEX_MemtoReg,IDEX_ALUOp1,IDEX_ALUOp0,IDEX_MemWrite,IDEX_ALUSource,IDEX_RegWrite,IDEX_Branch,IDEX_Branch1,IDEX_Jump,
          EX_RegDst,EX_MemRead,EX_MemtoReg,EX_ALUOp,EX_MemWrite,EX_ALUSource,EX_RegWrite,EX_Branch,EX_Branch1,EX_Jump,
          clk,reset,FLUSH);
          
input [4:0] ID_Rs,ID_Rt,ID_Rd;
input [31:0] ID_sign_extend,ID_Read_Data_1,ID_Read_Data_2,ID_PCinc;
output reg [4:0] EX_Rs,EX_Rt,EX_Rd;
output reg [31:0] EX_sign_extend,EX_Read_Data_1,EX_Read_Data_2,EX_PCinc;
input [3:0] ID_PC_MSBs;
output reg [3:0] EX_PC_MSBs;
input IDEX_RegDst,IDEX_MemRead,IDEX_MemtoReg,IDEX_ALUOp1,IDEX_ALUOp0,IDEX_MemWrite,IDEX_ALUSource,IDEX_RegWrite,IDEX_Branch,IDEX_Branch1,IDEX_Jump;
output reg EX_RegDst,EX_MemRead,EX_MemtoReg,EX_MemWrite,EX_ALUSource,EX_RegWrite,EX_Branch,EX_Branch1,EX_Jump;
output reg [1:0] EX_ALUOp;
input clk,reset,FLUSH;

always @(FLUSH,posedge clk, negedge reset)
        begin
        if((reset==0)||(FLUSH==1))
            begin
            EX_Rs <= 0;
            EX_Rt <= 0;
            EX_Rd <= 0;
            EX_sign_extend <= 0;
            EX_Read_Data_1 <= 0;
            EX_Read_Data_2 <= 0;
            EX_PCinc <= 0;
            EX_RegDst <= 0;
            EX_MemRead <= 0;
            EX_MemtoReg  <= 0;
            EX_MemWrite <= 0;
            EX_ALUSource <= 0;
            EX_RegWrite <= 0;
            EX_Branch <= 0;
            EX_Branch1 <= 0;
            EX_ALUOp <= 0;
            EX_Jump <= 0;
            EX_PC_MSBs <= 0;
            end
        else
            begin
            EX_Rs <= ID_Rs;
            EX_Rt <= ID_Rt;
            EX_Rd <= ID_Rd;
            EX_sign_extend <= ID_sign_extend;
            EX_Read_Data_1 <= ID_Read_Data_1;
            EX_Read_Data_2 <= ID_Read_Data_2;
            EX_PCinc <= ID_PCinc;
            EX_RegDst <= IDEX_RegDst;
            EX_MemRead <= IDEX_MemRead;
            EX_MemtoReg  <= IDEX_MemtoReg;
            EX_MemWrite <= IDEX_MemWrite;
            EX_ALUSource <= IDEX_ALUSource;
            EX_RegWrite <= IDEX_RegWrite;
            EX_Branch <= IDEX_Branch;
            EX_Branch1 <= IDEX_Branch1;
            EX_ALUOp <= {IDEX_ALUOp1,IDEX_ALUOp0};
            EX_Jump <= IDEX_Jump;
            EX_PC_MSBs <= ID_PC_MSBs;
            end
        end
          
endmodule
