----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/17/2019 10:31:08 PM
-- Design Name: 
-- Module Name: je_to_na_hovno - je_to_na_hovno_body
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

entity je_to_na_hovno is
port
 (-- Clock in ports
  -- Clock out ports
  clk_out1          : out    std_logic;
  -- Status and control signals
  reset             : in     std_logic;
  clk_in1           : in     std_logic
 );
end je_to_na_hovno;

architecture je_to_na_hovno_body of je_to_na_hovno is
signal counter : std_logic_vector(2 downto 0) := "000";

begin

process (clk_in1)
begin

if(clk_in1'event and clk_in1 = '1') then
    counter <= counter + 1;
end if;
end process;

clk_out1 <= counter(2);


end je_to_na_hovno_body;
