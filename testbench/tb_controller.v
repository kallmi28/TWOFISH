`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2019 03:51:57 PM
// Design Name: 
// Module Name: tb_controller
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


module tb_controller(    );
reg T_CLK, T_RST, T_BTN, T_SZ, T_KZ;

wire T_SCE, T_KCE, T_SRST, T_KRST, T_IL;

controller dut_controller (.clk(T_CLK), .reset(T_RST), .button(T_BTN), .szero(T_SZ), .kzero(T_KZ), .sce(T_SCE), .kce(T_KCE), .srst(T_SRST), .krst(T_KRST), .input_load(T_IL));

always
begin
#25; T_CLK <= ~T_CLK;
end;


initial
begin
T_CLK = 0;

#30;

T_RST <= 1'b1;

#100;

T_RST <= 1'b0;
T_SZ <= 1'b1;

#100;
T_SZ <= 1'b0;
T_BTN <= 1'b1;

#100;
T_KZ <= 1'b1;

#200;

T_BTN <= 1'b0;

#100;


$finish;

end;


endmodule
