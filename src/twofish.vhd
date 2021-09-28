----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/03/2019 06:30:44 PM
-- Design Name: 
-- Module Name: twofish - twofish_body
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

entity twofish is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (127 downto 0);
           data_out : out STD_LOGIC_VECTOR (127 downto 0);
           button : in STD_LOGIC);
end twofish;

architecture twofish_body of twofish is

component f_func is
	Port ( x0, x1 : in std_logic_vector (31 downto 0);
		   keys0, keys1 : in std_logic_vector (31 downto 0);
		   keyk0, keyk1 : in std_logic_vector (31 downto 0);
		   y0, y1 : out std_logic_vector (31 downto 0)
		   );
end component f_func;

component keygen is
	Port (x : in std_logic_vector(4 downto 0);
		  keyM : in std_logic_vector(127 downto 0);	
		  k0, k1 : out std_logic_vector (31 downto 0));
end component keygen;

component skeygen is
    Port ( key : in STD_LOGIC_VECTOR (127 downto 0);
           keys0 : out STD_LOGIC_VECTOR (31 downto 0);
           keys1 : out STD_LOGIC_VECTOR (31 downto 0);
           clk : in STD_LOGIC;
           ce : in STD_LOGIC;
           reset : in STD_LOGIC;
           zero : out STD_LOGIC);
end component skeygen;

component counterKkey is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ce : in STD_LOGIC;
           zero : out STD_LOGIC;
           y : out STD_LOGIC_VECTOR (4 downto 0));
end component counterKkey;

component controller is
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
end component  controller;

component d_flip_flop is
generic (width: integer );
 port(  clk : in std_logic;
        rst : in std_logic;     
        ce : in std_logic;     
        d : in std_logic_vector (width - 1 downto 0);
        q : out std_logic_vector (width - 1 downto 0));
end component d_flip_flop;

component dmx2 is
    Port ( a : in STD_LOGIC_VECTOR (31 downto 0);
           y0 : out STD_LOGIC_VECTOR (31 downto 0);
           y1 : out STD_LOGIC_VECTOR (31 downto 0);
           sel : in STD_LOGIC);
end component dmx2;

component control_d is
    Port ( x : in std_logic_vector (4 downto 0);
           IW0, IW1, OW0, OW1, M, DM : out std_logic);
end component control_d;


signal C_SZERO, C_KZERO     : std_logic;
signal C_SCE, C_KCE         : std_logic;
signal C_SRST, C_KRST       : std_logic;
signal C_IL, C_PD : std_logic;
signal C_KEYGENX : std_logic_vector (4 downto 0);
constant C_KEY : std_logic_vector (127 downto 0) := x"65b4f6a498fb49efbd68df6b48d28967"; 
signal C_WORKING_KEY : std_logic_vector (127 downto 0);
signal C_KS0, C_KS1 : std_logic_vector (31 downto 0);
signal C_KK0, C_KK1 : std_logic_vector (31 downto 0);

signal data : std_logic_vector (127 downto 0);

type bus_4x32 is array (0 to 3) of std_logic_vector (31 downto 0);

signal C_INPUTW, C_OUTPUTW : bus_4x32;
signal C_DATA_TO_OW : bus_4x32;
signal MUX_OUTPUT : bus_4x32;


signal D_OUTPUT : bus_4x32;
signal F_INPUT0, F_INPUT1 : std_logic_vector (31 downto 0);
signal C_X0_NEW, C_X1_NEW : std_logic_vector (31 downto 0);

signal f_out0, f_out1 : std_logic_vector (31 downto 0);
signal d_r_out0, d_r_out1 : std_logic_vector (31 downto 0);


signal D_IW0, D_IW1, D_OW0, D_OW1 : std_logic;
signal D_M, D_DM : std_logic;
signal D_ALMOST_OUT : std_logic_vector (127 downto 0);

begin

data <= data_in when (clk = '1' and clk'event and C_IL = '1');

I_CONTROLLER : controller port map ( clk => clk, reset => reset, button => button, 
                                    szero => C_SZERO, kzero => C_KZERO, sce => C_SCE, 
                                    kce => C_KCE, srst => C_SRST, krst => C_KRST, present_data => C_PD,
                                    input_load => C_IL);

I_COUNTERKKEY : counterKkey port map (clk => clk, rst => C_KRST, ce => C_KCE, zero => C_KZERO, y => C_KEYGENX);

I_SKEYGEN : skeygen port map (key => C_WORKING_KEY, keys0 => C_KS0 , keys1 => C_KS1, clk => clk, ce => C_SCE, reset => C_SRST, zero => C_SZERO);

I_KEYGEN : keygen port map (x => C_KEYGENX, keyM => C_WORKING_KEY, k0 => C_KK0 , k1=> C_KK1);

I_CD : control_d port map (x => C_KEYGENX, IW0 => D_IW0, IW1 => D_IW1, OW0 => D_OW0, OW1 => D_OW1, M => D_M, DM => D_DM );


----------------------------------------------------------------------------------------------------------------------------------------------

KEY : for I in 0 to 15 generate
    C_WORKING_KEY(I * 8 + 7 downto I * 8) <= C_KEY((15 - I) * 8 + 7 downto (15 - I) * 8);
end GENERATE;



C_INPUTW(3) <= (data (7 downto 0) & data (15 downto 8) & data (23 downto 16) & data (31 downto 24)) xor C_KK1;
C_INPUTW(2) <= (data (39 downto 32) & data (47 downto 40) & data (55 downto 48) & data (63 downto 56)) xor C_KK0;
C_INPUTW(1) <= (data (71 downto 64) & data (79 downto 72) & data (87 downto 80) & data (95 downto 88)) xor C_KK1;
C_INPUTW(0) <= (data (103 downto 96) & data (111 downto 104) & data (119 downto 112) & data (127 downto 120))xor C_KK0;

----------------------------------------------------------------------------------------------------------------------------------------------
 C_OUTPUTW(0) <= C_DATA_TO_OW(2) xor C_KK0; 
 C_OUTPUTW(1) <= C_DATA_TO_OW(3) xor C_KK1; 
 C_OUTPUTW(2) <= C_DATA_TO_OW(0) xor C_KK0; 
 C_OUTPUTW(3) <= C_DATA_TO_OW(1) xor C_KK1; 



I_F : f_func port map (x0 =>D_OUTPUT(0), x1 => D_OUTPUT(1), keys0 => C_KS0, keys1 => C_KS1, keyk0 => C_KK0, keyk1 => C_KK1, y0 => f_out0, y1 => f_out1);

--f_out0_xor <= (f_out0(0) & f_out0(31 downto 1)) xor (D_OUTPUT(2)(0) & D_OUTPUT(2)(31 downto 1));
--f_out1_xor <= f_out1 xor (D_OUTPUT(3)(30 downto 0) & D_OUTPUT(3)(31));

C_X0_NEW <= (f_out0(0) & f_out0(31 downto 1)) xor (d_r_out0(0) & d_r_out0(31 downto 1));
C_X1_NEW <= f_out1 xor (d_r_out1(30 downto 0) & d_r_out1(31));

----------------------------------------------------------------------------------------------------------------------------------------------

MUX_OUTPUT(0) <= C_INPUTW(0) when (D_M = '1') else C_X0_NEW;
MUX_OUTPUT(1) <= C_INPUTW(1) when (D_M = '1') else C_X1_NEW;
MUX_OUTPUT(2) <= C_INPUTW(2) when (D_M = '1') else D_OUTPUT(0);
MUX_OUTPUT(3) <= C_INPUTW(3) when (D_M = '1') else D_OUTPUT(1);

----------------------------------------------------------------------------------------------------------------------------------------------

I_DMX2_0 : dmx2 port map (a => D_OUTPUT(0), y0 =>F_INPUT0, y1=> C_DATA_TO_OW(0), sel => D_DM);
I_DMX2_1 : dmx2 port map (a => D_OUTPUT(1), y0 =>F_INPUT1, y1=> C_DATA_TO_OW(1), sel => D_DM);
--I_DMX2_2 : dmx2 port map (a => f_out0_xor, y0 =>C_X0_NEW, y1=> C_DATA_TO_OW(2), sel => D_DM);
--I_DMX2_3 : dmx2 port map (a => f_out1_xor, y0 =>C_X1_NEW, y1=> C_DATA_TO_OW(3), sel => D_DM);
I_DMX2_2 : dmx2 port map (a => D_OUTPUT(2), y0 =>d_r_out0, y1=> C_DATA_TO_OW(2), sel => D_DM);
I_DMX2_3 : dmx2 port map (a => D_OUTPUT(3), y0 =>d_r_out1, y1=> C_DATA_TO_OW(3), sel => D_DM);

----------------------------------------------------------------------------------------------------------------------------------------------


    DI0 : d_flip_flop   generic map (width => 32)
                      port map (clk => clk, rst => reset, ce => D_IW0, d => MUX_OUTPUT(0), q => D_OUTPUT(0));

    DI1 : d_flip_flop   generic map (width => 32)
                      port map (clk => clk, rst => reset, ce => D_IW0, d => MUX_OUTPUT(1), q => D_OUTPUT(1));

    DI2 : d_flip_flop   generic map (width => 32)
                      port map (clk => clk, rst => reset, ce => D_IW1, d => MUX_OUTPUT(2), q => D_OUTPUT(2));

    DI3 : d_flip_flop   generic map (width => 32)
                      port map (clk => clk, rst => reset, ce => D_IW1, d => MUX_OUTPUT(3), q => D_OUTPUT(3));
                      
                      
    DO0 : d_flip_flop   generic map (width => 32)
                    port map (clk => clk, rst => reset, ce => D_OW0, d => C_OUTPUTW(0), q => D_ALMOST_OUT(127 downto 96));
    
    DO1 : d_flip_flop   generic map (width => 32)
                    port map (clk => clk, rst => reset, ce => D_OW0, d => C_OUTPUTW(1), q => D_ALMOST_OUT(95 downto 64));
    
    DO2 : d_flip_flop   generic map (width => 32)
                    port map (clk => clk, rst => reset, ce => D_OW1, d => C_OUTPUTW(2), q => D_ALMOST_OUT(63 downto 32));
    
    DO3 : d_flip_flop   generic map (width => 32)
                    port map (clk => clk, rst => reset, ce => D_OW1, d => C_OUTPUTW(3), q => D_ALMOST_OUT(31 downto 0));                  
                      
----------------------------------------------------------------------------------------------------------------------------------------------

data_out <= (D_ALMOST_OUT (103 downto 96) & D_ALMOST_OUT (111 downto 104) & D_ALMOST_OUT (119 downto 112) & D_ALMOST_OUT (127 downto 120)) & 
            (D_ALMOST_OUT (71 downto 64) & D_ALMOST_OUT (79 downto 72) & D_ALMOST_OUT (87 downto 80) & D_ALMOST_OUT (95 downto 88))&
            (D_ALMOST_OUT (39 downto 32) & D_ALMOST_OUT (47 downto 40) & D_ALMOST_OUT (55 downto 48) & D_ALMOST_OUT (63 downto 56))&
            (D_ALMOST_OUT (7 downto 0) & D_ALMOST_OUT (15 downto 8) & D_ALMOST_OUT (23 downto 16) & D_ALMOST_OUT (31 downto 24)) ;




end twofish_body;
