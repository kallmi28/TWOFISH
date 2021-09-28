`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2019 01:36:08 PM
// Design Name: 
// Module Name: tb_skeygen
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


module tb_skeygen(    );
reg [127:0] T_K;
reg T_CLK, T_RST, T_CE;

wire [31:0] T_KS0, T_KS1;
wire T_Z;
integer i;
skeygen _dut (.key(T_K), .keys0(T_KS0), .keys1(T_KS1), .clk(T_CLK), .ce(T_CE), .reset(T_RST), .zero(T_Z));

always
begin
#25; T_CLK <= ~T_CLK;
end;

initial
begin
T_CLK = 0;
T_CE <= 0;

T_K <= 128'h2b7e151628aed2a6abf7158809cf4f3d;

T_RST <= 1'b1;

#60;



T_RST <= 1'b0;

#100;

for(i = 0; i < 30; i = i + 1)
begin

#25 T_CE = ~ T_Z;
end

T_CE <= 1'b0;

#200;

$finish;

end;



endmodule
