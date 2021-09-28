----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/04/2019 07:29:47 PM
-- Design Name: 
-- Module Name: dmx2 - dmx2_body
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

entity dmx2 is
    Port ( a : in STD_LOGIC_VECTOR (31 downto 0);
           y0 : out STD_LOGIC_VECTOR (31 downto 0);
           y1 : out STD_LOGIC_VECTOR (31 downto 0);
           sel : in STD_LOGIC);
end dmx2;

architecture dmx2_body of dmx2 is

begin

process (a, sel)
begin

y0 <= (others => '0');
y1 <= (others => '0');

if(sel = '0') then
    y0 <= a;
else
    y1 <= a;
end if;

end process;


end dmx2_body;
