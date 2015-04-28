library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tp is
	port( clk:  in  std_logic := '0';
	      rst:  in std_logic:= '1';
	      an:   out  std_logic_vector(3 downto 0);
	      seg7: out std_logic_vector(7 downto 0) );
end tp;

architecture Behavioral of tp is
	signal bcd0, bcd1, bcd2, bcd3: std_logic_vector(3 downto 0) := "0000";
	signal en: std_logic;
begin
	ctrl_disp: entity work.disp_ctrl(Behavioral)
		port map(clk=>clk, rst=>'0', anodos=>an, seg7=>seg7, bcd0=>bcd0, bcd1=>bcd1, bcd2=>bcd2, bcd3=>bcd3);
		
	generator_unit: entity work.generador(Beh)
		generic map(N=>50)
		--generic map(N=>32)
		port map(clock=>clk, over=>en);
		
	cont_bcd: entity work.cont_bcd(Behavioral)
		port map(en=>en, rst=>rst, clk=>clk,
			out_4=>bcd0, out_5=>bcd1, out_6=>bcd2, out_7=>bcd3);



end Behavioral;

