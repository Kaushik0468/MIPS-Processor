`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2023 11:08:17
// Design Name: 
// Module Name: Control
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


module Control(Func_Code,RegDst,MemRead,MemtoReg,ALUOp1,ALUOp0,MemWrite,ALUSource,RegWrite,Branch,Branch1,Jump,AL);

input [5:0] Func_Code;
output wire RegDst,MemRead,MemtoReg,ALUOp1,ALUOp0,MemWrite,ALUSource,RegWrite,Branch,Branch1,Jump,AL;
reg [11:0] out;
wire [5:0] r=0;   //000000
wire [5:0] lw=6'b100011; //100011 23 
wire [5:0] sw=6'b101011; //101011
wire [5:0] beq=6'b000100; //000100
wire [5:0] bne=5; //000101
wire [5:0] j=2;   //000010  
wire [5:0] jal=3; //000011
always @(Func_Code)
begin
    case(Func_Code)
        r : out=12'b100100001000;
        lw: out=12'b011110000000;
        sw: out=12'bx1x001000000;
        beq:out=12'bx0x000100100;
        bne:out=12'bx0x000010100;
        j:  out=12'bxxx000xxxx10;
        jal:out=12'bxxx100xxxx11;// 11111 in write register, PC value in write data (32 bit)
        
    endcase
end
assign {RegDst,ALUSource,MemtoReg,RegWrite,MemRead,MemWrite,Branch,Branch1,ALUOp1,ALUOp0,Jump,AL} = out;
endmodule
