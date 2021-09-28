----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/16/2019 02:14:10 PM
-- Design Name: 
-- Module Name: twofish_final - twofish_final_body
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

entity twofish_final is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           button_l : in STD_LOGIC;
           button_c : in STD_LOGIC;
           button_r : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (15 downto 0);
           data_out : out STD_LOGIC_VECTOR (6 downto 0);
           an_out : out STD_LOGIC_VECTOR (3 downto 0);
           out_counter : out std_logic_vector (2 downto 0));
end twofish_final;

architecture twofish_final_body of twofish_final is

component clk_wiz_0
port
 (-- Clock in ports
  -- Clock out ports
  clk_out1          : out    std_logic;
  -- Status and control signals
  reset             : in     std_logic;
  clk_in1           : in     std_logic
 );
end component;


component je_to_na_hovno is
port
 (-- Clock in ports
  -- Clock out ports
  clk_out1          : out    std_logic;
  -- Status and control signals
  reset             : in     std_logic;
  clk_in1           : in     std_logic
 );
end component je_to_na_hovno;


component twofish is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (127 downto 0);
           data_out : out STD_LOGIC_VECTOR (127 downto 0);
           button : in STD_LOGIC);
end component twofish;

component sevenseg is
   port (
      DATA    : in   STD_LOGIC_VECTOR (15 downto 0);  
      CLK     : in   STD_LOGIC;
      ANODE   : out  STD_LOGIC_VECTOR (3 downto 0);
      SEGMENT : out  STD_LOGIC_VECTOR (6 downto 0)
	);
end component sevenseg;

component top_controller is
    Port (  clk, reset : in std_logic;
            button : in std_logic;
            load, start : out std_logic;
            counter_o : out std_logic_vector(2 downto 0));
end component top_controller;

component top_controller_out is
    Port ( clk, reset : in std_logic;
           button_r, button_l : in std_logic;
           counter : out std_logic_vector (2 downto 0) );
end component top_controller_out;

signal t_data_in, t_data_out : std_logic_vector (127 downto 0);
signal t_start, t_load : std_logic;
signal t_counter_l : std_logic_vector(2 downto 0);
signal t_counter_o : std_logic_vector(2 downto 0);
signal t_clk_twofish : std_logic;

signal t_out_to_7seg : std_logic_vector(15 downto 0);

begin
--my_instance_name : clk_wiz_0 port map ( clk_out1 => t_clk_twofish, reset => reset, clk_in1 => clk);
my_instance_name : je_to_na_hovno port map ( clk_out1 => t_clk_twofish, reset => reset, clk_in1 => clk);
i_twofish : twofish port map (clk => t_clk_twofish, reset => reset, data_in => t_data_in, data_out => t_data_out, button => t_start);
i_controller_in : top_controller port map (clk => t_clk_twofish, reset => reset, button => button_c, load => t_load, start => t_start, counter_o => t_counter_l);
i_controller_out : top_controller_out port map (clk => t_clk_twofish, reset => reset, button_r => button_r, button_l => button_l, counter => t_counter_o);
i_7seg : sevenseg port map (DATA => t_out_to_7seg, CLK => t_clk_twofish, ANODE => an_out, SEGMENT => data_out);

out_counter <= t_counter_l;

process (t_clk_twofish)
begin
if(t_clk_twofish'event and t_clk_twofish = '1') then
    if(t_load = '1') then
        t_data_in <= t_data_in(111 downto 0) & data_in;
    end if;
end if;
end process;

process (t_clk_twofish)
begin

if(t_clk_twofish'event and t_clk_twofish = '1') then
    t_out_to_7seg <= t_data_out(conv_integer(t_counter_o) * 16 + 15 downto conv_integer(t_counter_o) * 16);
end if;

end process;

end twofish_final_body;
