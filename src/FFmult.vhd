----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/24/2019 12:16:24 AM
-- Design Name: 
-- Module Name: FFmult - FFmult_body
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FFmult is
    Port ( a, b : in std_logic_vector(7 downto 0);
           y    : out std_logic_vector(7 downto 0));
end FFmult;

architecture FFmult_body of FFmult is

component xtime is
    Port ( x : in std_logic_vector(7 downto 0);
           y : out std_logic_vector(7 downto 0));
end component xtime;

component and8 is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC_VECTOR (7 downto 0);
           y : out STD_LOGIC_VECTOR (7 downto 0));
end component and8;

type pp is array (integer range <>) of std_logic_vector (7 downto 0);

signal XT : pp (7 downto 0);
signal XAND : pp (7 downto 0);
signal XXOR : pp (5 downto 0);

begin

GEN_XTIME:    
for I in 0 to 7 generate
    FIRSTX : if I = 0 generate
        TIME1 : xtime port map (x => b, y => XT(0));
    end generate FIRSTX;
    
    OTHERX : if I > 0 generate
        TIMEX : xtime port map (x => XT(I-1), y => XT(I));
    end generate OTHERX;
end generate GEN_XTIME;


GEN_AND:    
for I in 0 to 7 generate
    FIRSTA : if I = 0 generate
        AND0 : and8 port map (a => a(0), b => b, y => XAND(0));
    end generate FIRSTA;
    
    OTHERA : if I > 0 generate
        ANDX : and8 port map (a => a (I), b => XT(I - 1), y => XAND(I));
    end generate OTHERA;
end generate GEN_AND; 


GEN_XOR:
for I in 0 to 6 generate
    FIRSTXOR : if I = 0 generate
        XOR0 : XXOR(0) <= XAND (0) xor XAND (1);
    end generate FIRSTXOR;
    
    LASTXOR : if I = 6 generate
        XOR5 : y <= XAND (7) xor XXOR (I - 1);
    end generate LASTXOR;
    
    OTHERXOR : if I > 0 and I < 6 generate
        XORX : XXOR (I) <= XXOR (I - 1) xor XAND (I + 1);
    end generate OTHERXOR;
end generate GEN_XOR;

end FFmult_body;
