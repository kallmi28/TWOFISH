----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/08/2019 11:10:41 AM
-- Design Name: 
-- Module Name: control_d - control_d_body
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control_d is
    Port ( x : in std_logic_vector (4 downto 0);
           IW0, IW1, OW0, OW1, M, DM : out std_logic);
end control_d;

architecture control_d_body of control_d is

begin

IW0 <= (not x(4) and not x(3) and not x(2) and not x(1) and not x(0)) or x(2) or x(3) or x(4);
IW1 <= (not x(4) and not x(3) and not x(2) and not x(1) and x(0)) or x(2) or x(3) or x(4);

OW0 <= (not x(4) and not x(3) and not x(2) and x(1) and not x(0));
OW1 <= (not x(4) and not x(3) and not x(2) and x(1) and x(0));

M <=  (not x(4) and not x(3) and not x(2) and not x(1));
DM <=  (not x(4) and not x(3) and not x(2) and x(1));


end control_d_body;
