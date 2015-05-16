library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_vga is
end test_vga;
		
architecture Beh of test_vga is
	signal clk:  std_logic := '0';
	signal hs:  std_logic;
	signal vs:  std_logic;
	signal red_o:  std_logic_vector(2 downto 0);
	signal grn_o:  std_logic_vector(2 downto 0);
	signal blu_o:  std_logic_vector(1 downto 0);
	signal pixel_row:  std_logic_vector(9 downto 0);
	signal pixel_col:  std_logic_vector(9 downto 0);

begin
	uut: entity work.vga_ctrl(vga_ctrl_arq)
		port map(mclk=>clk, hs=>hs, vs=>vs, red_o=>red_o, grn_o=>grn_o, blu_o=>blu_o,
			 pixel_row=>pixel_row, pixel_col=>pixel_col );

	clk <= not clk after 10 ns;
  
	StimuliProcess : process
	begin
		wait for 1000000 ns;
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

