`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.03.2023 23:22:22
// Design Name: 
// Module Name: tb
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


module tb();
reg clk, reset;
SCDataPath uut(clk, reset);

initial begin
clk = 0;
repeat(30)
#5 clk = ~clk;
$finish;
end

initial begin
reset = 1;
#2 reset = 0;
#2 reset = 1;
end

endmodule
