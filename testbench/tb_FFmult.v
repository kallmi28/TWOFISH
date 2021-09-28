`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/24/2019 01:14:27 AM
// Design Name: 
// Module Name: tb_FFmult
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


module tb_FFmult(    );

reg [7:0] T_A, T_B;
wire [7:0] T_Y;
integer i;

FFmult dut (.a(T_A), .b(T_B), .y(T_Y));

initial 
begin

for(i = 0; i < 65636; i = i+1)
begin

T_A <= i;
T_B <= i >> 8;

#2;

end

$finish;
end



endmodule
