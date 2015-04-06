library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_tp is
end test_tp;

architecture Beh of test_tp is
	signal clk:  std_logic := '0';
	signal rst:  std_logic := '1';
	signal an:   std_logic_vector(3 downto 0);
	signal seg7: std_logic_vector(7 downto 0);	

begin
	uut: entity work.tp(Behavioral)
		port map(clk=>clk, rst=>rst, an=>an, seg7=>seg7);

	clk <= not clk after 10 ns;
  
	StimuliProcess : process
	begin
		wait until rising_edge(clk);
		rst <= '0';
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
	end process StimuliProcess;

end Beh;

