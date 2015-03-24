library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.textio.all;
use IEEE.std_logic_textio.all;

entity test_counter is
end test_counter;

architecture Beh of test_counter is
	signal enable : std_logic:= '0';
   	signal clk : std_logic:= '0';
	signal reset : std_logic:= '0';
	signal oflow:  std_logic;
	--signal output : std_logic_vector(3 downto 0) := "0000";
	signal output : std_logic_vector(1 downto 0) := "00";

begin
	uut: entity work.counter(Behavioral)
		--generic map(N=>4)
		--port map(en=>enable, rst=>reset, OV=>"1001", clock=>clk, over=>oflow, outp=>output);
		generic map(N=>2)
		port map(en=>enable, rst=>reset, OV=>"11", clock=>clk, over=>oflow, outp=>output);

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

