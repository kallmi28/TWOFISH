----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/23/2019 02:35:32 PM
-- Design Name: 
-- Module Name: mult5B - mult5B_body
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

entity mult5B is
    Port ( x : in std_logic_vector(7 downto 0);
           y : out std_logic_vector(7 downto 0));
end mult5B;

architecture mult5B_body of mult5B is

begin

y(7) <= x(7) xor x(1);
y(6) <= x(6) xor x(0);
y(5) <= x(7) xor x(5) xor x(1);
y(4) <= x(6) xor x(4) xor x(1) xor x(0); 
y(3) <= x(5) xor x(3) xor x(0);
y(2) <= x(4) xor x(2) xor x(1);
y(1) <= x(3) xor x(1) xor x(0);
y(0) <= x(2) xor x(0);

end mult5B_body;
