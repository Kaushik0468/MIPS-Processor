`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2023 13:23:55
// Design Name: 
// Module Name: SCDataPath
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


module SCDataPath(clk,reset);

input clk, reset;

wire [31:0] ALU_output;
wire [31:0] Instruction_Code ;
wire [31:0] PCinc;
wire Jump,AL,PC_con_main,PC_con_beq,PC_con_bne;
wire [31:0] extend; 
wire RegDst,MemRead,MemtoReg,ALUOp1,ALUOp0,MemWrite,ALUSource,RegWrite,Branch,Branch1;
wire [4:0] Read_Reg_Num_1 =Instruction_Code[25:21];
wire [4:0] Read_Reg_Num_2 =Instruction_Code[20:16];
wire [31:0] Read_Data_1,Read_Data_2;
wire [31:0] Write_Data;
wire [4:0] Write_Reg_Num;
wire [5:0] alpha = Instruction_Code[5:0];
wire [1:0] ALUOp = {ALUOp1,ALUOp0};
wire [3:0] ALU_Ctl;
wire [31:0] In2;
wire [31:0] ALU_Result;
wire zero;
wire [31:0] Read_Data;

wire [31:0] Write_Data_normal , Write_Data_al;
wire [4:0] Write_Reg_Num_al , Write_Reg_Num_normal;

Instruction_Fetch Instruction_Fetch(clk,reset,Instruction_Code,PC_con_main,Jump,extend,PCinc);

Control Cont(Instruction_Code[31:26],RegDst,MemRead,MemtoReg,ALUOp1,ALUOp0,MemWrite,ALUSource,RegWrite,Branch,Branch1,Jump,AL);

assign Write_Reg_Num_normal = RegDst ? Instruction_Code[15:11] : Instruction_Code[20:16]; 
assign Write_Reg_Num_al = 5'b11111; // $31 

assign Write_Reg_Num = AL ? Write_Reg_Num_al : Write_Reg_Num_normal;

register_file registers(Read_Reg_Num_1,Read_Reg_Num_2,Write_Reg_Num,Write_Data,Read_Data_1,Read_Data_2,RegWrite,clk,reset); 

ALU_Control ALU_Control(ALUOp, alpha, ALU_Ctl);

wire [15:0] msb = {16{Instruction_Code[15]}}; 
assign extend = {msb,Instruction_Code[15:0]};
assign In2 = ALUSource ? extend : Read_Data_2; // 1:0

ALU ALU(ALU_Ctl,Read_Data_1,In2,ALU_Result,zero);
Data_Memory DataMemory(ALU_Result,Read_Data_2,MemWrite,MemRead,Read_Data,clk,reset);

assign Write_Data_normal = !MemtoReg ? ALU_Result : Read_Data; 
assign Write_Data_al = PCinc; 

assign Write_Data = AL ? Write_Data_al : Write_Data_normal; 


assign ALU_output= ALU_Result; 

assign PC_con_main = PC_con_beq | PC_con_bne;
assign PC_con_beq = Branch & zero;
assign PC_con_bne = Branch1 & (!zero);
endmodule
