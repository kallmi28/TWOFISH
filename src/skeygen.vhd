----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/02/2019 08:52:00 PM
-- Design Name: 
-- Module Name: skeygen - skeygen_body
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

entity skeygen is
    Port ( key : in STD_LOGIC_VECTOR (127 downto 0);
           keys0 : out STD_LOGIC_VECTOR (31 downto 0);
           keys1 : out STD_LOGIC_VECTOR (31 downto 0);
           clk : in STD_LOGIC;
           ce : in STD_LOGIC;
           reset : in STD_LOGIC;
           zero : out STD_LOGIC);
end skeygen;

architecture skeygen_body of skeygen is

component FFmult is
    Port ( a, b : in std_logic_vector(7 downto 0);
           y    : out std_logic_vector(7 downto 0));
end component FFmult;

component dmx8 is
    Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
           sel : in STD_LOGIC_VECTOR (2 downto 0);
           y0, y1, y2, y3, y4, y5, y6, y7 : out STD_LOGIC_VECTOR (7 downto 0));
end component dmx8;

component mux4 is
    Port ( a, b, c, d   : in std_logic_vector (7 downto 0);
           sel          : in std_logic_vector (1 downto 0);
           y            : out std_logic_vector(7 downto 0));
end component mux4;

component mux2 is
    Port ( a, b         : in std_logic_vector (7 downto 0);
           sel          : in std_logic;
           y            : out std_logic_vector(7 downto 0));
end component mux2;

component d_flip_flop is
generic (width: integer := 8);
 port(  clk : in std_logic;
        rst : in std_logic;     
        ce : in std_logic;     
        d : in std_logic_vector (width - 1 downto 0);
        q : out std_logic_vector (width - 1 downto 0));
end component d_flip_flop;

component onehot is
    Port ( x : in STD_LOGIC_VECTOR (2 downto 0);
           y : out STD_LOGIC_VECTOR (7 downto 0));
end component onehot;


type row is array (0 to 7) of std_logic_vector (7 downto 0);
type matrix is array (0 to 3) of row;

constant RSmat : matrix := ((x"01", x"a4",x"55",x"87",x"5a",x"58",x"db",x"9e"),
                           (x"a4", x"56",x"82",x"f3",x"1e",x"c6",x"68",x"e5"),
                           (x"02", x"a1",x"fc",x"c1",x"47",x"ae",x"3d",x"19"),
                           (x"a4", x"55",x"87",x"5a",x"58",x"db",x"9e",x"03")); 

type BUS_8x8 is array (0 to 7) of std_logic_vector (7 downto 0);

signal ff_out : BUS_8x8;
signal mux_2_out : BUS_8x8;
signal mux_4_out : BUS_8x8;
signal d_in : BUS_8x8;
signal d_out : BUS_8x8;

signal res : std_logic_vector(7 downto 0);

signal counter : std_logic_vector (2 downto 0);

signal S_onehot : std_logic_vector (7 downto 0);

begin

GEN_MUX : 
for I in 0 to 7 generate
    MUX_4 : mux4 port map (a => RSmat(0)(I), b => RSmat(1)(I), c => RSmat(2)(I), d => RSmat(3)(I), sel => counter(1 downto 0), y => mux_4_out(I));
    MUX_2 : mux2 port map (a => key(I * 8 + 7 downto I * 8), b =>key(I * 8 + 7 + 64 downto I * 8 + 64), sel => counter(2), y => mux_2_out(I));
end generate GEN_MUX;

GEN_MULT :
for I in 0 to 7 generate
    MULT : FFmult port map (a => mux_2_out(I), b => mux_4_out(I), y => ff_out(I));
end generate GEN_MULT;

GEN_D :
for I in 0 to 7 generate
    D : d_flip_flop generic map (width => 8)
                    port map (clk => clk, rst => reset, ce => S_onehot (I), d => d_in(I), q => d_out(I));
end generate GEN_D;

res <= ff_out(0) xor ff_out(1) xor ff_out(2) xor ff_out(3) xor ff_out(4) xor ff_out(5) xor ff_out(6) xor ff_out(7);  

DMX : dmx8 port map (a => res, sel => counter, y0 => d_in(0), y1 => d_in(1), y2 => d_in(2), y3 => d_in(3), y4 => d_in(4), y5 => d_in(5), y6 => d_in(6), y7 => d_in(7));


OH : onehot port map (x => counter, y => S_onehot);


process(clk, reset)
begin
    if(reset = '0') then
        if(ce = '1') then 
            if(clk = '1' and clk'event) then
                counter <= counter - 1;
            end if;
        end if;
    else
        counter <= (others => '1');
    end if;
end process;

zero <= '1' when counter = 0 else '0';

keys0 <= d_out(3) & d_out(2) & d_out(1) & d_out(0);
keys1 <= d_out(7) & d_out(6) & d_out(5) & d_out(4);


end skeygen_body;
