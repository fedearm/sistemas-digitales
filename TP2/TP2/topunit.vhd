library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tp is
	port( clk:   in std_logic;
	      rst:   in std_logic;
			rst_sd:in std_logic;
			an_in: in std_logic;
			nq_out:out std_logic;
	      an:    out std_logic_vector(3 downto 0);
	      seg7:  out std_logic_vector(7 downto 0);

			hs: out std_logic;
			vs: out std_logic;
			red_o: out std_logic_vector(2 downto 0);
			grn_o: out std_logic_vector(2 downto 0);
			blu_o: out std_logic_vector(1 downto 0)
			);
end tp;

architecture Behavioral of tp is
	signal bcd0, bcd1, bcd2, bcd3: std_logic_vector(3 downto 0) := "0000";
	signal en: std_logic;
	signal nq: std_logic;
	signal s_red,s_grn,s_blu: std_logic;
begin
	ctrl_disp: entity work.disp_ctrl(Behavioral)
		port map(clk=>clk, rst=>'0', anodos=>an, seg7=>seg7, bcd0=>bcd0, bcd1=>bcd1, bcd2=>bcd2, bcd3=>bcd3);
		
	sigma_unit: entity work.sigma(Behavioral)
		port map(rst=>rst_sd, clk=>clk, nq=>nq, analog_in=>an_in,
			out_0=>bcd0, out_1=>bcd1, out_2=>bcd2, out_3=>bcd3);

	vga_unit: entity work.vga_ctrl(vga_ctrl_arq)
		port map ( mclk=>clk, red_i=>s_red, grn_i=>s_grn, blu_i=>s_blu,
		hs=>hs, vs=>vs, red_o=>red_o, grn_o=>grn_o, blu_o=>blu_o,
		bcd0=>bcd0, bcd1=>bcd1, bcd2=>bcd2, bcd3=>bcd3
		);

	--cont_bcd: entity work.cont_bcd(Behavioral)
	--	port map(en=>en, rst=>rst, clk=>clk,
	--		out_4=>bcd0, out_5=>bcd1, out_6=>bcd2, out_7=>bcd3);
	nq_out <= nq;
	s_red<=bcd3(3);
	s_grn<=bcd2(3);
	s_blu<=bcd1(3);


end Behavioral;

