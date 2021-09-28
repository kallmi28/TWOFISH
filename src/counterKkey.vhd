----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/03/2019 04:07:15 PM
-- Design Name: 
-- Module Name: counterKkey - counterKkey_body
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

entity counterKkey is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ce : in STD_LOGIC;
           zero : out STD_LOGIC;
           y : out STD_LOGIC_VECTOR (4 downto 0));
end counterKkey;

architecture counterKkey_body of counterKkey is

type box is array (integer range <>) of std_logic_vector(4 downto 0);

constant decode : box (0 to 19) := ("00000", "00001", "00100", "00101", "00110", 
                                    "00111", "01000", "01001", "01010", "01011", 
                                    "01100", "01101", "01110", "01111", "10000",
                                    "10001", "10010", "10011", "00010", "00011");

signal counter : std_logic_vector (4 downto 0);

begin

process(clk, rst)
begin
if(rst = '0') then
    if(ce = '1') then 
        if(clk = '1' and clk'event) then
            if(counter + 1 = "10100") then
               counter <= (others => '0');
            else
               counter <= counter + 1;
            end if;
        end if;
    end if;
else
    counter <= (others => '0');
end if;
end process;

zero <= '1' when counter = 19 else '0';
y <= decode(conv_integer(counter));

end counterKkey_body;
