library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bits_to_an is
	port( sel:    in  std_logic_vector(1 downto 0);
	      anodos: out std_logic_vector(3 downto 0) );
end bits_to_an;

architecture Behavioral of bits_to_an is
begin
	process (sel)
	begin
		case sel is
		when "00"=> anodos <="1110";
		when "01"=> anodos <="1101";
		when "10"=> anodos <="1011";
		when "11"=> anodos <="0111"; 
		when others => anodos <="1111";
		end case;
	end process;
end Behavioral;