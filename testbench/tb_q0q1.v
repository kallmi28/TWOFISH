`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/23/2019 06:05:56 PM
// Design Name: 
// Module Name: tb_q0q1
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


module tb_q0q1(    );

reg [7:0] T_X;
wire [7:0] T_Y0, T_Y1;
integer i;

q0 dut_q0 (.x(T_X), .y(T_Y0));
q1 dut_q1 (.x(T_X), .y(T_Y1));

initial
begin

for(i = 0; i < 256; i = i + 1)
begin
#5 T_X = i;
end

#5;
$finish;


end

endmodule
