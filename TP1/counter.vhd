----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:14:03 03/21/2015 
-- Design Name: 
-- Module Name:    counter - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.NUMERIC_STD.ALL;

entity counter is
	generic ( N : integer := 4);
	port( en: in  std_logic;
    	      clock:    in  std_logic;
	      rst:  in  std_logic;
	      outp: out std_logic_vector(N-1 downto 0));
end counter;

architecture Behavioral of counter is
	constant OV : std_logic_vector(N-1 downto 0) := "1010";	
	signal salida: std_logic_vector(N-1 downto 0);
begin
   process(clock,rst)
   begin
	if rst='1' then
	        salida <= ( others => '0' );
	elsif rising_edge(clock) then
		
		if en='0' then
			if salida = OV then
				salida <= ( others => '0');
			else
				--salida <= salida + 1;
				salida <= std_logic_vector(to_unsigned(to_integer(unsigned( salida )) + 1, N));
			end if;
		end if;
	end if;
   end process;
   outp <= salida;
	
end Behavioral;
