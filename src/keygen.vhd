library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity keygen is
	Port (x : in std_logic_vector(4 downto 0);
		  keys0, keys1 : in std_logic_vector (31 downto 0);
		  keyM : in std_logic_vector(127 downto 0);	
		  k0, k1 : out std_logic_vector (31 downto 0));
end keygen;

architecture keygen_body of kyegen is


component g_func is
	Port (x : in std_logic_vector(31 downto 0);
		  keys0, keys1 : in std_logic_vector (31 downto 0);
		  y : out std_logic_vector (31 downto 0));
end component g_func;


component pht is
    Port ( x1, x2 : in std_logic_vector(31 downto 0);
           y1, y2 : out std_logic_vector(31 downto 0));
end component pht;

signal g0_out, g1_out : std_logic_vector (31 downto 0);
signal pht_out0, pht_out1 : std_logic_vector (31 downto 0);

signal g0_in, g1_in : std_logic_vector (31 downto 0);

begin

g0_in <= ("00" & x & '0') & ("00" & x & '0') & ("00" & x & '0') & ("00" & x & '0');
g1_in <= ("00" & x & '1') & ("00" & x & '1') & ("00" & x & '1') & ("00" & x & '1');

g_0 	: g_func 	port map (x => g0_in, keys0 => keyM(95 downto 64), keys1 => keyM(31 downto 0), y => g0_out);
g_1 	: g_func 	port map (x => g1_in, keys0 => keyM(127 downto 96), keys1 => keyM(63 downto 32), y => g1_out);
pht_0 	: pht 		port map (x1 => g0_out, x2 => (g1_out(23 downto 0) & g1_out(31 downto 24)), y1 => pht_out0, y2 => pht_out1);

k0 <= pht_out0;

k1 <= pht_out1(22 downto 0) & pht_out1(31 downto 23);

 
end keygen_body;
