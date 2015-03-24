library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_ctrl_disp is
end test_ctrl_disp;

architecture Beh of test_ctrl_disp is
	signal bcd0: std_logic_vector(3 downto 0) := "1100";
	signal bcd1: std_logic_vector(3 downto 0) := "0011";
	signal bcd2: std_logic_vector(3 downto 0) := "0110";
	signal bcd3: std_logic_vector(3 downto 0) := "1001";
	signal clk:  std_logic := '0';
	signal rst:  std_logic := '1';
	signal an:   std_logic_vector(3 downto 0);
	signal seg7: std_logic_vector(7 downto 0);	

begin
	uut: entity work.disp_ctrl(Behavioral)
		port map(bcd0=>bcd0,bcd1=>bcd1,bcd2=>bcd2,bcd3=>bcd3,
			 clk=>clk, rst=>rst, anodos=>an, seg7=>seg7);

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

