library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;



entity f_func is
	Port ( x0, x1 : in std_logic_vector (31 downto 0);
		   keys0, keys1 : in std_logic_vector (31 downto 0);
		   keyk0, keyk1 : in std_logic_vector (31 downto 0);
		   y0, y1 : out std_logic_vector (31 downto 0)
		   );
end f_func;

architecture f_func_body of f_func is

component g_func is
	Port (x : in std_logic_vector(31 downto 0);
		  keys0, keys1 : in std_logic_vector (31 downto 0);
		  y : out std_logic_vector (31 downto 0));
end component g_func;

component pht is
    Port ( x1, x2 : in std_logic_vector(31 downto 0);
           y1, y2 : out std_logic_vector(31 downto 0));
end component pht;

signal x1_rol8 : std_logic_vector (31 downto 0);
signal g0_out, g1_out : std_logic_vector (31 downto 0);
signal pht_out0, pht_out1 : std_logic_vector (31 downto 0);

begin

x1_rol8 <= x1(23 downto 0) & x1(31 downto 24);

g_0 	: g_func 	port map (x => x0, keys0 => keys0, keys1 => keys1, y => g0_out);
g_1 	: g_func 	port map (x => x1_rol8, keys0 => keys0, keys1 => keys1, y => g1_out);
pht_0 	: pht 		port map (x1 => g0_out, x2 => g1_out, y1 => pht_out0, y2 => pht_out1);


y0 <= pht_out0 + keyk0;
y1 <= pht_out1 + keyk1;

 
end f_func_body;
