`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2019 06:49:31 PM
// Design Name: 
// Module Name: tb_twofish
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


module tb_twofish(    );
reg T_CLK, T_BTN, T_RST;
reg [127:0] T_DATAIN;

wire [127:0] T_DATAOUT;
twofish dut (.clk(T_CLK), .reset(T_RST), .data_in(T_DATAIN), .data_out(T_DATAOUT), .button(T_BTN));

wire [31:0] T_DATAOUT0, T_DATAOUT1, T_DATAOUT2, T_DATAOUT3;

assign T_DATAOUT0 = T_DATAOUT[31:0];
assign T_DATAOUT1 = T_DATAOUT[63:32];
assign T_DATAOUT2 = T_DATAOUT[95:64];
assign T_DATAOUT3 = T_DATAOUT[127:96];

always
begin
#25; T_CLK <= ~T_CLK;
end;
///* //test of controller and keygens
    initial
    begin
    
    T_CLK = 0;
    
    T_RST <= 1'b1;
    
    #100;
    
    T_RST <= 1'b0;
    T_DATAIN <= 128'h456efc645fec56fe4c56fec74879f4ec;
    
    #400;
    
    T_BTN <= 1'b1;

    
    #1500;
    
    $finish;
    
    
    
    end
//*/


endmodule
