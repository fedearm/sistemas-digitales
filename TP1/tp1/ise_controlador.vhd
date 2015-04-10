library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity disp_ctrl is
	port( bcd0,bcd1,bcd2,bcd3:  in  std_logic_vector(3 downto 0);
	      clk: in  std_logic := '0';
	      rst: in std_logic:= '1';
	      anodos: out  std_logic_vector(3 downto 0);
	      --a_mux: out std_logic_vector(1 downto 0);
	      seg7: out std_logic_vector(7 downto 0) );
end disp_ctrl;

architecture Behavioral of disp_ctrl is
	--signal enable: std_logic;
	--signal reset: std_logic;
	signal enable:  std_logic := '0';
	signal sel_mux: std_logic_vector(1 downto 0);
	signal out_mux: std_logic_vector(3 downto 0);
begin
	cont_2b_unit: entity work.counter(Behavioral)
		generic map(N=>2)
		port map(en=>enable, rst=>rst, clock=>clk, OV=>"11", outp=>sel_mux);

	ctrl_ano_unit: entity work.bits_to_an(Behavioral)
		port map(sel=>sel_mux, anodos=>anodos);

	mux_unit: entity work.mux2(Behavioral)
		port map(a=>bcd0,b=>bcd1,c=>bcd2,d=>bcd3, sel=>sel_mux, output=>out_mux );

	bcd_to_seg7_unit: entity work.bcd_to_7seg(Behavioral)
		port map(bcd=>out_mux, seg7=>seg7 );

	generator_unit: entity work.generador(Beh)
		generic map(N=>50000)
		--generic map(N=>4)
		port map(clock=>clk, over=>enable);

	--a_mux<=sel_mux;
end Behavioral;

