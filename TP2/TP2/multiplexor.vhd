library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all; 
use IEEE.NUMERIC_STD.ALL;

entity mux2 is
	port( a,b,c,d:  in  std_logic_vector(3 downto 0);
	      sel: in  std_logic_vector(1 downto 0);
	      output: out std_logic_vector(3 downto 0) );
end mux2;

architecture Behavioral of mux2 is
begin
	process (a,b,c,d,sel)
	begin
		case  sel is
		when "00"=> output <= a;
		when "01"=> output <= b;
		when "10"=> output <= c;
		when "11"=> output <= d; 
		when others=> output <="0000"; 
		end case;
	end process;
end Behavioral;
