`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2023 14:48:29
// Design Name: 
// Module Name: mux32bit
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


//32 bit mux

module mux32bit(
    input [31:0] I0,
    input [31:0] I1,
    input [31:0] I2,
    input [1:0] S,
    output reg [31:0] out
    );
   
   
   always@(S,I0,I1,I2)
       begin 
       case(S)
       0:out = I0;
       1:out = I1;
       2:out = I2;
       default: out =I0;
       endcase
   end
   
endmodule
