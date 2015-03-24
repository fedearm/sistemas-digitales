library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.all;
use IEEE.std_logic_textio.all;

entity test_gen_1s is
end test_gen_1s;

architecture Beh of test_gen_1s is
   	signal clk : std_logic:= '0';
	signal oflow:  std_logic;
begin
	uut: entity work.generador(Beh)
		port map(clock=>clk, over=>oflow);

  
	Reloj: process
	begin
	  for contador in 1 to 50000010 loop
		clk <= '0';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
	  end loop;
	end process Reloj;

end Beh;

