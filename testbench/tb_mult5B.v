`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/23/2019 02:42:38 PM
// Design Name: 
// Module Name: tb_mult5B
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


module tb_mult5B(   );

reg [7:0] T_X;
wire [7:0] T_Y;
integer i, f;

mult5B dut (.x(T_X), .y(T_Y));

    
initial
begin

f = $fopen("output5B.txt", "w");
#10;

for(i=0; i < 256; i = i + 1)
begin

T_X <= i;
#5;

$fwrite(f, "%b\n", T_Y);

end

$fclose(f);
$finish;


end

endmodule
