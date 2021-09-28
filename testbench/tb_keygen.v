`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2019 09:58:02 PM
// Design Name: 
// Module Name: tb_keygen
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


module tb_keygen(    );


reg [4:0] T_X;
reg [127:0] T_keyM;
wire [31:0] T_K0, T_K1;
integer i;

keygen dut_keygen (.x(T_X), .keyM(T_keyM), .k0(T_K0), .k1(T_K1));


initial
begin
T_keyM <= 0;
T_X <= 0;


for(i = 0; i < 20; i = i + 1)
begin
#5 T_X = i;

end

#5;
$finish;


end
endmodule
