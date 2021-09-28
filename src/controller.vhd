----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/03/2019 03:28:40 PM
-- Design Name: 
-- Module Name: controller - controller_body
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

entity controller is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           button : in STD_LOGIC;
           szero : in STD_LOGIC;
           kzero : in STD_LOGIC;
           sce : out STD_LOGIC;
           kce : out STD_LOGIC;
           srst : out STD_LOGIC;
           krst : out STD_LOGIC;
           present_data : out STD_LOGIC;
           input_load : out STD_LOGIC);
end controller;

architecture controller_body of controller is

type fsm_state is (A, B, C, D, E);
signal state, nextstate : fsm_state; 

begin

CLOCK: process(clk)
begin
	if rising_edge(clk) then
		if reset='1' then 
			state <= A;
		else 
			state <= nextstate;
		end if;
	end if;
end process;

TRANSITION : process (state, button,szero, kzero)
begin
	nextstate <= state;
	case state is
		when A => 
		  nextstate <= B;
		when B => 
		  if(szero = '1') then
		      nextstate <= C;
		  end if;
	   when C =>
	       if(button = '1') then
	           nextstate <= D;
	       end if;
	   when D =>
	       if(kzero = '1') then
	           nextstate <= E;
	       end if;
	   when E =>
	       if(button = '0') then
	           nextstate <= C;
	       end if;
	end case;
end process;

OUTPUT : process (state, button,szero, kzero)
begin
sce <= '0';
kce <= '0';
srst <= '0';
krst <= '0';
input_load <= '0';
present_data <= '0';

case state is
    when A =>
        srst <= '1';
    when B =>
        sce <= '1';
    when C =>
        if(button = '1') then
            krst <= '1';
            input_load <= '1';
        end if;
    when D =>
        kce <= '1';
    when E => 
        present_data <= '1';
end case;
end process;


end controller_body;
