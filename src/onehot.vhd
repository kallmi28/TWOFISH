----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/11/2019 07:20:21 PM
-- Design Name: 
-- Module Name: onehot - onehot
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

entity onehot is
    Port ( x : in STD_LOGIC_VECTOR (2 downto 0);
           y : out STD_LOGIC_VECTOR (7 downto 0));
end onehot;

architecture onehot of onehot is

begin


process (x)
begin
y <= (others => '0');

case x is
		when "000" => y <= x"01";
		when "001" => y <= x"02";
        when "010" => y <= x"04";
        when "011" => y <= x"08";
        when "100" => y <= x"10";
        when "101" => y <= x"20";
        when "110" => y <= x"40";
        when "111" => y <= x"80";
        when others => y <= x"00";
end case;
end process;

end onehot;
