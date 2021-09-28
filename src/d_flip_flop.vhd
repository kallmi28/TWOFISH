library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity d_flip_flop is
generic (width: integer);
 port(  clk : in std_logic;
        rst : in std_logic;     
        ce : in std_logic;     
        d : in std_logic_vector (width - 1 downto 0);
        q : out std_logic_vector (width - 1 downto 0));
end d_flip_flop;

architecture d_flip_flop_body of d_flip_flop is

begin

process (clk)
   begin
      if rising_edge(clk) then  
         if (rst='1') then   
             q <= (others => '0');
         elsif (ce = '1') then
             q <= d;
         end if;
      end if;
   end process;

end d_flip_flop_body;
