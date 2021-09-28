----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/16/2019 03:18:18 PM
-- Design Name: 
-- Module Name: top_controller - top_controller_body
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

entity top_controller is
    Port (  clk, reset : in std_logic;
            button : in std_logic;
            load, start : out std_logic;
            counter_o : out std_logic_vector(2 downto 0)
            );
end top_controller;

architecture top_controller_body of top_controller is

type fsm_state is (X, A, B, C, D, E);
signal state, nextstate : fsm_state;

signal counter : std_logic_vector (2 downto 0);
signal zero : std_logic;

begin

zero <= '1' when (counter = 0) else '0';
counter_o <= counter;

process(clk)
begin
if rising_edge(clk) then
    if(reset = '1') then
        counter <= (others => '1');
    elsif (state = A and button = '1') then
        counter <= counter - 1;    
    end if;
end if;
end process;




CLOCK: process(clk)
begin
	if rising_edge(clk) then
		if reset='1' then 
			state <= X;
			--counter <= (others => '1');
		else 
			state <= nextstate;
		end if;
	end if;
end process;

TRANSITION : process(state, button, zero)
begin
nextstate <= state;
case state is
		when A =>
		  if(button = '1') then
		      nextstate <= B;
		  elsif (zero = '1') then
                  nextstate <= C;
          end if;
		when B => 
		  if(button = '0') then
		      nextstate <= A;
          end if;
		when C => 
		  nextstate <= D;
		when D => 
		  if(button = '1') then
		      nextstate <= E;
		  end if;
		when E => 
		  if(button = '0') then
		      nextstate <= X;
		  end if;
        when X =>
          if(button = '1') then
              nextstate <= B;
          end if;
end case;
end process;


OUTPUT : process(state, button, zero)
begin
start <= '0';
load <= '0';
case state is
    when A =>
        if(button = '1') then
            load <= '1';
        end if;

    when C =>
        start <= '1';
    when X =>
        if(button = '1') then
            load <= '1';
        end if;
    when others => NULL;
end case;
end process;


end top_controller_body;
