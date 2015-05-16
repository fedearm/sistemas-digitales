library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity test_rom is
end test_rom;

architecture Beh of test_rom is
	signal clk:  std_logic := '0';
	signal addr: std_logic_vector(5 downto 0);
	signal f_row,f_col: std_logic_vector(2 downto 0);
	signal salida: std_logic;	

begin
	uut: entity work.Char_ROM(p)
		port map(clk=>clk,char_address=>addr, rom_out=>salida,
			 font_row=>f_row, font_col=>f_col);

	clk <= not clk after 10 ns;
  
	StimuliProcess : process
	begin
		wait until rising_edge(clk);
		addr <= "000000";
		f_row <="000";
		f_col <="000";
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		f_col <="001";
		wait until rising_edge(clk);
		f_col <="010";
		wait until rising_edge(clk);
		f_col <="011";
		wait until rising_edge(clk);
		f_col <="100";
		wait until rising_edge(clk);
		f_col <="101";
		wait until rising_edge(clk);
		f_col <="110";
		wait until rising_edge(clk);
		f_col <="111";
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		f_row <="001";
		f_col <="000";
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		f_col <="001";
		wait until rising_edge(clk);
		f_col <="010";
		wait until rising_edge(clk);
		f_col <="011";
		wait until rising_edge(clk);
		f_col <="100";
		wait until rising_edge(clk);
		f_col <="101";
		wait until rising_edge(clk);
		f_col <="110";
		wait until rising_edge(clk);
		f_col <="111";
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		wait until rising_edge(clk);
	end process StimuliProcess;

end Beh;

