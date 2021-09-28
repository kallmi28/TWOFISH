----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/23/2019 04:56:57 PM
-- Design Name: 
-- Module Name: mds - mds_body
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
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mds is
    Port ( x : in std_logic_vector(31 downto 0);
           z : out std_logic_vector(31 downto 0));
end mds;

architecture mds_body of mds is

component multEF is
    Port ( x : in std_logic_vector(7 downto 0);
           y : out std_logic_vector(7 downto 0));
end component multEF;

component mult5B is
    Port ( x : in std_logic_vector(7 downto 0);
           y : out std_logic_vector(7 downto 0));
end component mult5B;

signal y05B, y15B, y25B, y35B   : std_logic_vector (7 downto 0);
signal y0EF, y1EF, y2EF, y3EF   : std_logic_vector (7 downto 0);
signal y001, y101, y201, y301   : std_logic_vector (7 downto 0);
signal z0, z1, z2, z3           : std_logic_vector (7 downto 0);
begin
mult5By0 : mult5B port map (x => x(7 downto 0), y => y05B);
mult5By1 : mult5B port map (x => x(15 downto 8), y => y15B);
mult5By2 : mult5B port map (x => x(23 downto 16), y => y25B);
mult5By3 : mult5B port map (x => x(31 downto 24), y => y35B);

multEFy0 : multEF port map (x => x(7 downto 0), y => y0EF);
multEFy1 : multEF port map (x => x(15 downto 8), y => y1EF);
multEFy2 : multEF port map (x => x(23 downto 16), y => y2EF);
multEFy3 : multEF port map (x => x(31 downto 24), y => y3EF);

y001 <= x(7 downto 0);
y101 <= x(15 downto 8);
y201 <= x(23 downto 16);
y301 <= x(31 downto 24);

z0 <= y001 xor y1EF xor y25B xor y35B;
z1 <= y05B xor y1EF xor y2EF xor y301;
z2 <= y0EF xor y15B xor y201 xor y3EF;
z3 <= y0EF xor y101 xor y2EF xor y35B;

z <= z3 & z2 & z1 & z0;

end mds_body;
