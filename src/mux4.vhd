----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/02/2019 09:02:33 PM
-- Design Name: 
-- Module Name: mux4 - mux4_body
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

entity mux4 is
    Port ( a, b, c, d   : in std_logic_vector (7 downto 0);
           sel          : in std_logic_vector (1 downto 0);
           y            : out std_logic_vector(7 downto 0));
end mux4;

architecture mux4_body of mux4 is

begin

process(a, b, c, d, sel)
begin

case sel is
    when "00" => y <= a;
    when "01" => y <= b;
    when "10" => y <= c;
    when "11" => y <= d;
    when others => NULL;
end case;

end process;


end mux4_body;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2 is
    Port ( a, b         : in std_logic_vector (7 downto 0);
           sel          : in std_logic;
           y            : out std_logic_vector(7 downto 0));
end mux2;

architecture mux2_body of mux2 is

begin

process(a, b, sel)
begin

case sel is
    when '0' => y <= a;
    when '1' => y <= b;
    when others => NULL;
end case;

end process;


end mux2_body;
