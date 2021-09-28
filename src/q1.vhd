----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/23/2019 05:26:03 PM
-- Design Name: 
-- Module Name: q1 - q1_body
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

entity q1 is
    Port ( x : in std_logic_vector(7 downto 0);
           y : out std_logic_vector(7 downto 0));
end q1;

architecture q1_body of q1 is
signal a1, b1 : std_logic_vector (3 downto 0);
signal a2, b2 : std_logic_vector (3 downto 0);
signal a3, b3 : std_logic_vector (3 downto 0);
signal ws1, ws2 : std_logic_vector (3 downto 0);

type box is array (integer range <>) of std_logic_vector(3 downto 0);

constant t0 : box (0 to 15) := (X"2", X"8", X"B", X"D", X"F", X"7", X"6", X"E", X"3", X"1", X"9", X"4", X"0", X"A", X"C", X"5");
constant t1 : box (0 to 15) := (X"1", X"E", X"2", X"B", X"4", X"C", X"3", X"7", X"6", X"D", X"A", X"5", X"F", X"9", X"0", X"8");
constant t2 : box (0 to 15) := (X"4", X"C", X"7", X"5", X"1", X"6", X"9", X"A", X"0", X"E", X"D", X"8", X"2", X"B", X"3", X"F");
constant t3 : box (0 to 15) := (X"B", X"9", X"5", X"1", X"C", X"3", X"D", X"E", X"6", X"4", X"7", X"F", X"2", X"0", X"8", X"A");
  
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


end q1_body;
