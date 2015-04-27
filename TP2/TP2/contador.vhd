library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all; 
use IEEE.NUMERIC_STD.ALL;

entity counter is
	generic ( N : integer := 4 );
	port( en:   in  std_logic;
    	      clock:in  std_logic;
	      rst:  in  std_logic := '0';
	      OV:   in  std_logic_vector(N-1 downto 0);	

              over: out std_logic;
	      outp: out std_logic_vector(N-1 downto 0));
end counter;

architecture Behavioral of counter is
	signal salida: std_logic_vector(N-1 downto 0);
begin
   process(clock,rst,en)
   begin
	if rst='1' then
	        salida <= ( others => '0' );
		over <= '0';
	elsif rising_edge(clock) then
		over <= '0';
		if en='1' or rising_edge(en) then
			if salida = OV then
				salida <= ( others => '0');
				over <= '1';
			else
				salida <= salida + 1;
			end if;
		end if;
	end if;
   end process;
   outp <= salida;
	
end Behavioral;

