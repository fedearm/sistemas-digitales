library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.all;
use IEEE.std_logic_textio.all;

entity test_counter_4dig is
end test_counter_4dig;

architecture Beh of test_counter_4dig is
	signal enable : std_logic:= '0';
   	signal clk : std_logic:= '0';
	signal reset : std_logic:= '0';
	signal output0,output1,output2,output3 : std_logic_vector(3 downto 0) := "0000";

begin
	uut: entity work.contador_4dig(Behavioral)
		--generic map(N=>4)
		port map(en=>enable, rst=>reset, clk=>clk,
			out0=>output0,out1=>output1,out2=>output2,out3=>output3);

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

