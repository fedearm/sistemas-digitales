library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all; 
use IEEE.NUMERIC_STD.ALL;

entity bcd_to_7seg is
	port( bcd:  in  std_logic_vector(3 downto 0);
	      seg7: out std_logic_vector(7 downto 0) );
end bcd_to_7seg;

architecture Behavioral of bcd_to_7seg is
begin
	process (bcd)
	begin
		case  bcd is
		when "0000"=> seg7 <="11000000";
		when "0001"=> seg7 <="11111001";
		when "0010"=> seg7 <="10100100";
		when "0011"=> seg7 <="10110000"; 
		when "0100"=> seg7 <="10011001"; 
		when "0101"=> seg7 <="10010010";
		when "0110"=> seg7 <="10000010";
		when "0111"=> seg7 <="11111000";
		when "1000"=> seg7 <="10000000";
		when "1001"=> seg7 <="10010000";
		when others=> seg7 <="11111111"; 
		end case;
	end process;
end Behavioral;

