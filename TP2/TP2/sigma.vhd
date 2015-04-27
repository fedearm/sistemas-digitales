library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
use work.my_types_pkg.all;

entity sigma is
	port( analog: in  std_logic;
			clk:    in  std_logic;
			rst:    in  std_logic;
			nq:     out std_logic;
	      out_delta: out salidas_bcd;
			out_total: out salidas_bcd
			);
end sigma;

architecture Behavioral of sigma is
	signal q:  std_logic;
	signal ena_reg: std_logic;
	signal ena_cont: std_logic;
	signal out_periodo: std_logic;
	signal ena_periodo: std_logic;
begin
	dff_unit: entity work.dff(Behavioral)
		port map(clk=>clk, rst=>rst, ce=>'1', d=>analog, q=>ena_cont, nq=>nq);

	--cont_periodo_unit: entity work.cont_bcd(Behavioral)
	--	port map(en=>'1', clk=>clk, rst=>rst, over=>out_periodo, out_x=>out_delta);

	cont_unit: entity work.cont_bcd(Behavioral)
	port map(en=>ena_cont, clk=>clk, rst=>rst, over=>ena_reg, out_x=>out_total);

end Behavioral;

