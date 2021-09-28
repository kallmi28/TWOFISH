`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/23/2019 09:35:23 PM
// Design Name: 
// Module Name: tb_xtime
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


module tb_xtime(    );

reg [7:0] T_X;
wire [7:0] T_Y;

integer i;

xtime dut (.x(T_X), .y(T_Y));

initial
begin
for(i=0; i < 256; i = i + 1)
    #5 T_X = i;
    
$finish;
end


endmodule
