library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity sbox is
	Port (x : in std_logic_vector(31 downto 0);
		  keys0, keys1 : in std_logic_vector (31 downto 0);
		  y : out std_logic_vector (31 downto 0));
end sbox;

architecture sbox_body of sbox is

component q1 is
    Port ( x : in std_logic_vector(7 downto 0);
           y : out std_logic_vector(7 downto 0));
end component q1;


component q0 is
    Port ( x : in std_logic_vector(7 downto 0);
           y : out std_logic_vector(7 downto 0));
end component q0;

type w8 is array (integer range <>) of std_logic_vector (7 downto 0);

signal s1i, s1o, s2i, s2o : w8 (0 to 3);

begin
A: for I in 0 to 3 generate
	S1_xor : s1o(I) <= s1i(I) xor keys0((((I + 1) * 8) - 1) downto I * 8);
end generate A;

B: for I in 0 to 3 generate
	S2_xor : s2o(I) <= s2i(I) xor keys1((((I + 1) * 8) - 1) downto I * 8);
end generate B;

Q0_0 : Q0 port map (x => x(7 downto 0), y => s1i(0));
Q1_0 : Q1 port map (x => x(15 downto 8), y => s1i(1));
Q0_1 : Q0 port map (x => x(23 downto 16), y => s1i(2));
Q1_1 : Q1 port map (x => x(31 downto 24), y => s1i(3));

Q0_2 : Q0 port map (x => s1o(0), y => s2i(0));
Q0_3 : Q0 port map (x => s1o(1), y => s2i(1));
Q1_2 : Q1 port map (x => s1o(2), y => s2i(2));
Q1_3 : Q1 port map (x => s1o(3), y => s2i(3));

Q1_4 : Q1 port map (x => s2o(0), y => y(7 downto 0));
Q0_4 : Q0 port map (x => s2o(1), y => y(15 downto 8));
Q1_5 : Q1 port map (x => s2o(2), y => y(23 downto 16));
Q0_5 : Q0 port map (x => s2o(3), y => y(31 downto 24));



end sbox_body;
