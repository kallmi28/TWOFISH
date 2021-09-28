----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/23/2019 09:27:54 PM
-- Design Name: 
-- Module Name: xtime - Behavioral
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

entity xtime is
    Port ( x : in std_logic_vector(7 downto 0);
           y : out std_logic_vector(7 downto 0));
end xtime;

architecture xtime_body of xtime is

signal shift : std_logic_vector(7 downto 0);
signal mask : std_logic_vector(7 downto 0);

begin

shift <= x(6 downto 0) & '0';
mask <= (6 => x(7), 3 downto 2 => x(7), 0 => x(7), others => '0');


y <= shift xor mask;


end xtime_body;
