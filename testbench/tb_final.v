`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/16/2019 05:32:30 PM
// Design Name: 
// Module Name: tb_final
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


module tb_final(   );

reg T_CLK, T_RST, T_BC, T_BL, T_BR;

reg [15:0] T_DIN;

wire [6:0] T_7SEG;
wire [3:0] T_AN;

integer i;

twofish_final _dut (.clk(T_CLK), .reset(T_RST), .button_l(T_BL), .button_c(T_BC), .button_r(T_BR), .data_in(T_DIN), .data_out(T_7SEG), .an_out(T_AN));

always
#5 T_CLK = ~T_CLK;


always

#300 T_BL = ~T_BL; 




initial
begin

T_CLK = 1'b0;
T_RST = 1'b1;
T_BC = 1'b0;
T_BL = 1'b0;
T_BR = 1'b0;

T_DIN = 16'h0000;

#230;
T_RST = 1'b0;

#1500;

for(i = 0; i < 8; i = i + 1)
begin
T_DIN <= {i[3:0], i[3:0], i[3:0], i[3:0]};

#120;

T_BC = 1'b1;

#340;

T_BC = 1'b0;

#250;

end

#100000;

$finish;

end


endmodule
