library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity g_func is
	Port (x : in std_logic_vector(31 downto 0);
		  keys0, keys1 : in std_logic_vector (31 downto 0);
		  y : out std_logic_vector (31 downto 0));
end g_func;

architecture g_func_body of g_func is

component sbox is
	Port (x : in std_logic_vector(31 downto 0);
		  keys0, keys1 : in std_logic_vector (31 downto 0);
		  y : out std_logic_vector (31 downto 0));
end component sbox;

component mds is
    Port ( x : in std_logic_vector(31 downto 0);
           z : out std_logic_vector(31 downto 0));
end component mds;

signal sbox_to_mds : std_logic_vector(31 downto 0);

begin

s1   : sbox port map (x => x, keys0 => keys0, keys1 => keys1, y =>sbox_to_mds);
mds1 : mds port map (x => sbox_to_mds, z => y);
 
end g_func_body;
