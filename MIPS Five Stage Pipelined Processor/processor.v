`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2023 00:46:30
// Design Name: 
// Module Name: processor
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


module processor (clk,reset);

input clk,reset;

reg [31:0] PC;

//wires used in IF stage
wire [31:0] IF_PCinc,PCin,IF_Instruction_Code,PCin1,PCjump;
wire FLUSH;

//wires used in ID stage
wire [4:0] ID_Rt,ID_Rs,ID_Rd;
wire IF_ID_Write,PCWrite,Control_zero; //HDU
wire [31:0] ID_PCinc,ID_Instruction_Code,ID_sign_extend,ID_Read_Data_1,ID_Read_Data_2;
wire [5:0] ID_Func_Code; 
wire ID_RegDst,ID_MemRead,ID_MemtoReg,ID_ALUOp1,ID_ALUOp0,ID_MemWrite,ID_ALUSource,ID_RegWrite,ID_Branch,ID_Branch1,ID_Jump;
wire IDEX_RegDst,IDEX_MemRead,IDEX_MemtoReg,IDEX_ALUOp1,IDEX_ALUOp0,IDEX_MemWrite,IDEX_ALUSource,IDEX_RegWrite,IDEX_Branch,IDEX_Branch1,IDEX_Jump;
wire [3:0] ID_PC_MSBs;
//wires used in EX stage
wire [4:0] EX_Rs,EX_Rt,EX_Rd,EXMEM_Rd;
wire EX_RegDst,EX_MemRead,EX_MemtoReg,EX_MemWrite,EX_ALUSource,EX_RegWrite,EX_Branch,EX_Branch1,EX_Jump;
wire [1:0] EX_ALUOp;
wire [31:0] EX_sign_extend,EX_Read_Data_1,EX_Read_Data_2,EX_PCinc,EX_A,EX_B,B,EX_ALUOut,EX_Add_Result,Shifted_EX_sign_extended;
wire [1:0] ForwardA,ForwardB;
wire [3:0] EX_ALUCtl,EX_PC_MSBs;
wire EX_Zero;

//wires used in MEM stage
wire MEM_PCSrc;
wire MEM_RegWrite,MEM_Zero,MEM_Branch,MEM_Branch1,MEM_MemWrite,MEM_MemRead,MEM_MemtoReg;
wire [4:0] MEM_Rd;
wire [31:0] MEM_Write_Data, MEM_ALUOut,MEM_Add_Result,MEM_Read_Data;
      
//wires used in WB stage
wire [4:0] WB_Rd;
wire WB_RegWrite,WB_MemtoReg;
wire [31:0] WB_ALUOut,WB_Read_Data,WB_Write_Data;

//dummy signals
wire ID_AL;


//IF stage
assign IF_PCinc= PC+4;

assign PCjump = {EX_PC_MSBs,Shifted_EX_sign_extended[27:0]};

assign PCin1= EX_Jump? PCjump:PCin;

assign PCin = MEM_PCSrc ? MEM_Add_Result : IF_PCinc;

always@(posedge clk,negedge reset) 
begin
    if(reset==0)
        PC<=0;
    else if(PCWrite)
        PC<=PC;
    else
        PC<=PCin1;        
end

Instruction_Memory Instruction_Memory(PC,reset,IF_Instruction_Code);

// IFID pipeline register
assign FLUSH = MEM_PCSrc;
IFID IFID(clk,reset,IF_Instruction_Code,IF_PCinc,ID_Instruction_Code,ID_PCinc,IF_ID_Write,FLUSH);

//ID stage
assign  {ID_Rs,ID_Rt,ID_Rd} = ID_Instruction_Code [25:11];
assign ID_Func_Code = ID_Instruction_Code [31:26];

Control Control(ID_Func_Code,ID_RegDst,ID_MemRead,ID_MemtoReg,ID_ALUOp1,ID_ALUOp0,ID_MemWrite,ID_ALUSource,ID_RegWrite,ID_Branch,ID_Branch1,ID_Jump,ID_AL);

Hazard_Detection_Unit HDU(EX_MemRead,EX_Jump,EX_Rt, ID_Rt,ID_Rs,IF_ID_Write,PCWrite,Control_zero);// Hazard_Detection_Unit

sign_extend sign_extend(ID_Instruction_Code [15:0],ID_sign_extend);

register_file registers(ID_Rs,ID_Rt,WB_Rd,WB_Write_Data,ID_Read_Data_1,ID_Read_Data_2,WB_RegWrite,clk,reset);

assign {IDEX_RegDst,IDEX_MemRead,IDEX_MemtoReg,IDEX_ALUOp1,IDEX_ALUOp0,IDEX_MemWrite,IDEX_ALUSource,IDEX_RegWrite,IDEX_Branch,IDEX_Branch1,IDEX_Jump} = 
Control_zero? 11'b00000000000: {ID_RegDst,ID_MemRead,ID_MemtoReg,ID_ALUOp1,ID_ALUOp0,ID_MemWrite,ID_ALUSource,ID_RegWrite,ID_Branch,ID_Branch1,ID_Jump};
//11'bx0xxx0x0000 11'b00000000000

//IDEX pipeline register

//wire [1:0] EX_ALUOp = {EX_ALUOp1,EX_ALUOp0};
//wire [1:0] IDEX_ALUOp = {IDEX_ALUOp1,IDEX_ALUOp0};
assign ID_PC_MSBs = ID_Instruction_Code [31:28];

IDEX IDEX(ID_Rs,ID_Rt,ID_Rd,ID_sign_extend,ID_Read_Data_1,ID_Read_Data_2,ID_PCinc,ID_PC_MSBs,
          EX_Rs,EX_Rt,EX_Rd,EX_sign_extend,EX_Read_Data_1,EX_Read_Data_2,EX_PCinc,EX_PC_MSBs,
          IDEX_RegDst,IDEX_MemRead,IDEX_MemtoReg,IDEX_ALUOp1,IDEX_ALUOp0,IDEX_MemWrite,IDEX_ALUSource,IDEX_RegWrite,IDEX_Branch,IDEX_Branch1,IDEX_Jump,
          EX_RegDst,EX_MemRead,EX_MemtoReg,EX_ALUOp,EX_MemWrite,EX_ALUSource,EX_RegWrite,EX_Branch,EX_Branch1,EX_Jump,
          clk,reset,FLUSH);  
//EX stage

Forwarding_Unit Forwarding_Unit(MEM_Rd,WB_Rd,EX_Rs,EX_Rt,WB_RegWrite,MEM_RegWrite,ForwardA,ForwardB);

ALU_Control ALU_Control(EX_ALUOp, EX_sign_extend [5:0], EX_ALUCtl);

ALU ALU(EX_ALUCtl, EX_A,EX_B, EX_ALUOut, EX_Zero);

mux32bit Source1(EX_Read_Data_1,WB_Write_Data,MEM_ALUOut,ForwardA,EX_A);
mux32bit Source2(EX_Read_Data_2,WB_Write_Data,MEM_ALUOut,ForwardB,B);

assign EX_B = EX_ALUSource? EX_sign_extend : B;

assign EXMEM_Rd = EX_RegDst? EX_Rd:EX_Rt;

assign Shifted_EX_sign_extended = {EX_sign_extend[29:0],2'b00};

assign EX_Add_Result = EX_PCinc + Shifted_EX_sign_extended;

//EXMEM pipeline register
EXMEM EXMEM(EXMEM_Rd ,B, EX_ALUOut,EX_Zero,EX_Add_Result,EX_Branch,EX_Branch1,EX_MemWrite,EX_MemRead,EX_MemtoReg,EX_RegWrite,
      MEM_Rd ,MEM_Write_Data, MEM_ALUOut,MEM_Zero,MEM_Add_Result,MEM_Branch,MEM_Branch1,MEM_MemWrite,MEM_MemRead,MEM_MemtoReg,MEM_RegWrite,
      clk,reset);

// MEM stage

Data_Memory Data_Memory(MEM_ALUOut,MEM_Write_Data,MEM_MemWrite,MEM_MemRead,MEM_Read_Data,clk,reset);

assign MEM_PCSrc = (MEM_Zero & MEM_Branch) | ((~MEM_Zero) & MEM_Branch1);

//MEMWB pipeline register
MEMWB MEMWB(MEM_Rd,MEM_ALUOut,MEM_Read_Data,MEM_MemtoReg,MEM_RegWrite,
              WB_Rd,WB_ALUOut,WB_Read_Data,WB_MemtoReg,WB_RegWrite,
              clk,reset);
//WB stage
assign WB_Write_Data = WB_MemtoReg ? WB_Read_Data : WB_ALUOut; 

endmodule
