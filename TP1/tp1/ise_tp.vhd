library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tp is
	port( clk:  in  std_logic := '0';
	      rst:  in std_logic:= '1';
	      an:   out  std_logic_vector(3 downto 0);
	      seg7: out std_logic_vector(7 downto 0) );
			
	---attribute loc: string;
	
	--attribute loc of clk:	signal is "T9";
	--attribute loc of rst:	signal is "G18";
	--attribute loc of an:		signal is "F15 C18 H17 F17 ";
	--attribute loc of seg7:	signal is "C17 H14 J17 G14 D16 D17 F18 L18";
			
end tp;



architecture Behavioral of tp is
	signal bcd0, bcd1, bcd2, bcd3: std_logic_vector(3 downto 0) := "0000";
	signal en: std_logic;
begin
	ctrl_disp: entity work.disp_ctrl(Behavioral)
		port map(clk=>clk, rst=>rst, anodos=>an, seg7=>seg7, bcd0=>bcd0, bcd1=>bcd1, bcd2=>bcd2, bcd3=>bcd3);

	generator_unit: entity work.generador(Beh)
		generic map(N=>50000000)
		--generic map(N=>32)
		port map(clock=>clk, over=>en);

	contadores: entity work.contador_4dig(Behavioral)
		port map(en=>en, rst=>rst, clk=>clk,
			out0=>bcd0, out1=>bcd1, out2=>bcd2, out3=>bcd3);



end Behavioral;

