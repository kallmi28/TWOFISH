`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2019 04:15:31 PM
// Design Name: 
// Module Name: tb_counterKkey
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


module tb_counterKkey(    );

reg T_CLK, T_RST, T_CE;

wire T_Z;
wire [4:0] T_Y;

counterKkey _dut (.clk(T_CLK), .rst(T_RST), .ce(T_CE), .zero(T_Z), .y(T_Y));

always
begin
#25; T_CLK <= ~T_CLK;
end;

initial
begin

T_CLK = 0;

T_RST <= 1'b1;
#40;

T_CE  <= 1'b1;

#63;

T_RST <= 1'b0;


#6320;

T_CE <= 1'b0;

#123;

$finish;
end


endmodule
