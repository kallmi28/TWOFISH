----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/02/2019 09:02:33 PM
-- Design Name: 
-- Module Name: dmx16 - dmx16_body
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

entity dmx8 is
    Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
           sel : in STD_LOGIC_VECTOR (2 downto 0);
           y0, y1, y2, y3, y4, y5, y6, y7 : out STD_LOGIC_VECTOR (7 downto 0));
end dmx8;

architecture dmx8_body of dmx8 is

begin

process(a, sel)
begin
    y0 <= (others => '0');
    y1 <= (others => '0');
    y2 <= (others => '0');
    y3 <= (others => '0');
    y4 <= (others => '0');
    y5 <= (others => '0');
    y6 <= (others => '0');
    y7 <= (others => '0');

    case sel is
        when "000" => y0 <= a;
        when "001" => y1 <= a;
        when "010" => y2 <= a;
        when "011" => y3 <= a;
        when "100" => y4 <= a;
        when "101" => y5 <= a;
        when "110" => y6 <= a;
        when "111" => y7 <= a;
        when others => NULL;
    end case;

end process;    
end dmx8_body;
