library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.all;
use IEEE.std_logic_textio.all;
use work.my_types_pkg.all;

entity test_counter_4dig is
end test_counter_4dig;

architecture Beh of test_counter_4dig is
	constant M: integer := 8;

	signal enable : std_logic:= '0';
   	signal clk :    std_logic:= '0';
	signal reset :  std_logic:= '0';
	signal out_0,out_1,out_2,out_3,out_4,out_5,out_6,out_7 : std_logic_vector(3 downto 0) := "0000";

begin
	uut: entity work.cont_bcd(Behavioral)
		port map(en=>enable, rst=>reset, clk=>clk, 
			out_0=>out_0, out_1=>out_1, out_2=>out_2, out_3=>out_3,
			out_4=>out_4, out_5=>out_5, out_6=>out_6, out_7=>out_7
		);

	clk <= not clk after 10 ns;
  
	StimuliProcess : process
	begin
		enable <= '0';
		reset  <= '1';
		REPORT "DFF : GOOD SCENARIO :";
		REPORT "===================";
		wait until rising_edge(clk);
		reset  <= '0';
		wait until rising_edge(clk);
		enable <= '1';
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		wait for 8 ns;
		reset <= '1';
		wait until rising_edge(clk);
		wait for 2 ns;
		reset <= '0';
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		wait for 1 ns;
		enable <= '0';
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		wait for 1 ns;
		enable <= '1';
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		wait for 1 ns;
		wait;
   end process StimuliProcess;

end Beh;

