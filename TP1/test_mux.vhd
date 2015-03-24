library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.all;
use IEEE.std_logic_textio.all;
use IEEE.STD_LOGIC_ARITH.ALL;

entity test_mux is
end test_mux;

architecture Beh of test_mux is
	signal a,b,c,d :  std_logic_vector(3 downto 0);
	signal sel:  std_logic_vector(1 downto 0);
	signal output : std_logic_vector(3 downto 0);

begin
	uut: entity work.mux2(Behavioral)
		--generic map(N=>4)
		port map(a=>a,b=>b,c=>c,d=>d, sel=>sel, output=>output);

	StimuliProcess : process
	begin
		a <= "1010";
		b <= "0101";
		c <= "0110";
		d <= "1001";
		for i in 0 to 5 loop
			sel <= "00";
			wait for 10 ns;
			sel <= "01";
			wait for 10 ns;
			sel <= "10";
			wait for 10 ns;
			sel <= "11";
			wait for 10 ns;
		end loop;
   	end process StimuliProcess;

end Beh;

