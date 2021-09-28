`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2019 11:19:16 AM
// Design Name: 
// Module Name: tb_control_d
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


module tb_control_d(    );

reg [4:0] T_CNT;

wire T_IW0, T_IW1, T_OW0, T_OW1, T_M, T_DM;

control_d _dut (.x(T_CNT), .IW0(T_IW0), .IW1(T_IW1), .OW0(T_OW0), .OW1(T_OW1), .M(T_M), .DM(T_DM));

integer i;

initial 
begin

T_CNT = 0;

for(i = 0; i < 20; i = i + 1)
begin

T_CNT = i;

#5;

end;

$finish;

end;
endmodule
