library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all; 
use IEEE.NUMERIC_STD.ALL;

entity generador is
	generic ( N : integer := 50000000);
	port( clock:    in  std_logic;
	      over: out std_logic );
end generador;

architecture Beh of generador is
	signal salida : integer range 0 to N := 0;
begin
   	process(clock)
	begin
	if rising_edge(clock) then
		over <= '0';
		if salida = N then
			salida <= 0;
			over <= '1';
		else
			salida <= salida + 1;
		end if;
	end if;
	end process;
end Beh;

