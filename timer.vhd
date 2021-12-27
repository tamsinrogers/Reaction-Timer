-- Quartus II VHDL Template
-- Four-State Moore State Machine

-- A Moore machine's outputs are dependent only on the current state.
-- The output is written only when the state changes.  (State
-- transitions are synchronous.)

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity timer is

	port(
		clk				: in	std_logic;									-- clock
		start	 			: in	std_logic;									-- start input
		react	 			: in	std_logic;									-- react input
		reset	 			: in	std_logic;									-- react input
		mstime			: out	std_logic_vector(7 downto 0);			-- sends time in ms (number of seconds waited)
		rLED 				: out std_logic;									-- red LED
		gLED 				: out std_logic									-- green LED
	);

end entity;

architecture rtl of timer is

	-- Build an enumerated type for the state machine
	type state_type is (sIdle, sWait, sCount);

	-- Register to hold the current state
	signal state   : state_type;
	signal count 	: unsigned(27 downto 0);							-- internal counter, controls the wait time

begin

	-- Logic to advance to the next state
	process (clk, reset)
	begin
		
		if reset = '0' then													-- reset condition activates on a 0
			state <= sIdle;													-- begin in the idle state
			count <= (others=>'0');											-- set the count to all zeros
				
		elsif (rising_edge(clk)) then
			case state is
			
				when sIdle=>													-- IDLE STATE
					if start = '0' then										-- when the user hits the start button
						count <= "1111111111111111111111111111";	
						state <= sWait;										-- move to the sWait state
					else
						state <= sIdle;
					end if;
					
				when sCount=>													-- COUNT STATE		
					if react = '0' then										-- when the user hits the react button
						state <= sIdle;										-- move back to the sIdle state
					else
						state <= sCount;
						count <= count+1;
					end if;
					
				when sWait=>													-- WAIT STATE
					if react = '0' then										-- when the user hits the react button
						state <= sIdle;										-- go back to the sIdle state	
						count <= (others=>'1');		
					elsif count = ("0000000000000000000000000000") then	
						state <= sCount;
					else
						state <= sWait;
						count <= count-1;										-- wait a while
					end if;
						
			end case;
		end if;
	end process;

	-- Output depends solely on the current state
	
		gLED <= '1' when state = sCount else '0';
		rLED <= '1' when state = sWait else '0';
		mstime <= "00000000" when state = sWait else std_logic_vector(count(22 downto 15));	-- assign a string of 8 zeros to mstime
																															-- else assign mstime bits 22-15 of the internal counter, cast to a std_logic_vector

end rtl;
