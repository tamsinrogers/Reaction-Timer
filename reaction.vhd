-- Tamsin Rogers
-- 9/28/20
-- CS232 Project3
-- reaction.vhd

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY reaction IS 

	PORT
	(
		clock :  IN  STD_LOGIC;
		reset :  IN  STD_LOGIC;
		start :  IN  STD_LOGIC;
		react :  IN  STD_LOGIC;
		HEX0_0 :  OUT  STD_LOGIC;
		HEX0_1 :  OUT  STD_LOGIC;
		HEX0_2 :  OUT  STD_LOGIC;
		HEX0_3 :  OUT  STD_LOGIC;
		HEX0_4 :  OUT  STD_LOGIC;
		HEX0_5 :  OUT  STD_LOGIC;
		HEX0_6 :  OUT  STD_LOGIC;
		HEX1_0 :  OUT  STD_LOGIC;
		HEX1_1 :  OUT  STD_LOGIC;
		HEX1_2 :  OUT  STD_LOGIC;
		HEX1_3 :  OUT  STD_LOGIC;
		HEX1_4 :  OUT  STD_LOGIC;
		HEX1_5 :  OUT  STD_LOGIC;
		HEX1_6 :  OUT  STD_LOGIC;
		rLED :  OUT  STD_LOGIC;
		gLED :  OUT  STD_LOGIC
	);
	
END reaction;

ARCHITECTURE bdf_type OF reaction IS 

COMPONENT hexdisplay

	PORT
	(
		a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		result : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
		
END COMPONENT;

COMPONENT timer

	PORT
	(
		clk : IN STD_LOGIC;
		start : IN STD_LOGIC;
		react : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		rLED : OUT STD_LOGIC;
		gLED : OUT STD_LOGIC;
		mstime : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
	
END COMPONENT;

SIGNAL	mstime : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	result0 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL	result1 : STD_LOGIC_VECTOR(6 DOWNTO 0);

BEGIN 

b2v_inst : hexdisplay
PORT MAP
(
	a => mstime(3 DOWNTO 0),
	result => result0
);


b2v_inst1 : hexdisplay
PORT MAP
(
	a => mstime(7 DOWNTO 4),
	result => result1
);


b2v_inst2 : timer
PORT MAP
(		
	clk => clock,
	 start => start,
	 react => react,
	 reset => reset,
	 rLED => rLED,
	 gLED => gLED,
	 mstime => mstime
);

HEX0_0 <= result0(0);
HEX0_1 <= result0(1);
HEX0_2 <= result0(2);
HEX0_3 <= result0(3);
HEX0_4 <= result0(4);
HEX0_5 <= result0(5);
HEX0_6 <= result0(6);
HEX1_0 <= result1(0);
HEX1_1 <= result1(1);
HEX1_2 <= result1(2);
HEX1_3 <= result1(3);
HEX1_4 <= result1(4);
HEX1_5 <= result1(5);
HEX1_6 <= result1(6);

END bdf_type;