----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/23/2019 05:26:03 PM
-- Design Name: 
-- Module Name: q0 - q0_body
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

entity q0 is
    Port ( x : in std_logic_vector(7 downto 0);
           y : out std_logic_vector(7 downto 0));
end q0;

architecture q0_body of q0 is

signal a1, b1 : std_logic_vector (3 downto 0);
signal a2, b2 : std_logic_vector (3 downto 0);
signal a3, b3 : std_logic_vector (3 downto 0);
signal ws1, ws2 : std_logic_vector (3 downto 0);




type box is array (integer range <>) of std_logic_vector(3 downto 0);

constant t0 : box (0 to 15) := (X"8", X"1", X"7", X"D", X"6", X"F", X"3", X"2", X"0", X"B", X"5", X"9", X"E", X"C", X"A", X"4");
constant t1 : box (0 to 15) := (X"E", X"C", X"B", X"8", X"1", X"2", X"3", X"5", X"F", X"4", X"A", X"6", X"7", X"0", X"9", X"D");
constant t2 : box (0 to 15) := (X"B", X"A", X"5", X"E", X"6", X"D", X"9", X"0", X"C", X"8", X"F", X"3", X"2", X"4", X"7", X"1");
constant t3 : box (0 to 15) := (X"D", X"7", X"F", X"4", X"1", X"2", X"6", X"E", X"9", X"B", X"3", X"0", X"8", X"5", X"C", X"A");
  
begin

ws1 <= x(4) & "000";

a1 <= x(7 downto 4) xor x(3 downto 0);
b1 <= x(7 downto 4) xor (x(0) & x(3 downto 1)) xor ws1;

a2 <= t0(conv_integer(a1));
b2 <= t1(conv_integer(b1));

ws2 <= a2(0) & "000";

a3 <= a2 xor b2;
b3 <= a2 xor (b2(0) & b2(3 downto 1)) xor ws2;

y <= (t3(conv_integer(b3))&t2(conv_integer(a3)));



end q0_body;
