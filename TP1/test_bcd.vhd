library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.all;
use IEEE.std_logic_textio.all;
use IEEE.STD_LOGIC_ARITH.ALL;

entity test_bcd is
end test_bcd;

architecture Beh of test_bcd is
	signal input :  std_logic_vector(3 downto 0);
	signal output : std_logic_vector(7 downto 0);

begin
	uut: entity work.bcd_to_7seg(Behavioral)
		--generic map(N=>4)
		port map(bcd=>input, seg7=>output);

	StimuliProcess : process
	begin
		for i in 0 to 20 loop
			input <= conv_std_logic_vector(i,4);
			wait for 10 ns;
		end loop;
   	end process StimuliProcess;

end Beh;

