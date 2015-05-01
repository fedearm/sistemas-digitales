library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
--use work.my_types_pkg.all;

entity sigma is
	port( analog_in: in  std_logic;
			clk:    in  std_logic;
			rst:    in  std_logic;
			nq:     out std_logic;
	      out_0,out_1,out_2,out_3: out std_logic_vector(3 downto 0)
			);
end sigma;

architecture Behavioral of sigma is
	signal q,not_q:  std_logic;
	signal an_in:  std_logic;
	signal ov_periodo, ov_medido: std_logic;
	signal rst_medido: std_logic;
	signal ena_cont: std_logic;
	signal ena_medido: std_logic;
	signal shft_reg: std_logic;
	signal od0,od1,od2,od3,od4,od5,od6,od7: std_logic_vector(3 downto 0);
	signal ot0,ot1,ot2,ot3,ot4,ot5,ot6,ot7: std_logic_vector(3 downto 0);
begin
	generator_unit: entity work.generador(Beh)
		generic map(N=>2)
		port map(clock=>clk, over=>ena_cont);

	dff_unit: entity work.dff(Behavioral)
		port map(clk=>clk, rst=>rst, ce=>'1', d=>an_in, q=>q, nq=>not_q);

	cont_sigma_unit: entity work.cont_bcd(Behavioral)
		port map(en=>ena_medido, clk=>clk, rst=>rst_medido, over=>ov_medido, 
				out_0=>od0,out_1=>od1,out_2=>od2,out_3=>od3,
				out_4=>od4,out_5=>od5,out_6=>od6,out_7=>od7);

	cont_per_unit: entity work.cont_bcd(Behavioral)
		port map(en=>ena_cont, clk=>clk, rst=>rst_medido, over=>ov_periodo );
	
	reg0_unit: entity work.reg4(Behavioral)
		--port map(clk=>clk, rst=>rst, en=>ov_periodo, q_in=>od4, q_out=>ot4 );
		port map(clk=>clk, rst=>rst, en=>'1', q_in=>od4, q_out=>ot4 );
	reg1_unit: entity work.reg4(Behavioral)
		--port map(clk=>clk, rst=>rst, en=>ov_periodo, q_in=>od5, q_out=>ot5 );
		port map(clk=>clk, rst=>rst, en=>'1', q_in=>od5, q_out=>ot5 );
	reg2_unit: entity work.reg4(Behavioral)
		--port map(clk=>clk, rst=>rst, en=>ov_periodo, q_in=>od6, q_out=>ot6 );
		port map(clk=>clk, rst=>rst, en=>'1', q_in=>od6, q_out=>ot6 );
	reg3_unit: entity work.reg4(Behavioral)
		--port map(clk=>clk, rst=>rst, en=>ov_periodo, q_in=>od7, q_out=>ot7 );
		port map(clk=>clk, rst=>rst, en=>'1', q_in=>od7, q_out=>ot7 );
		
	an_in <= analog_in;			
	nq <= not_q;
	rst_medido <= rst;
	ena_medido <= q and ( not ena_cont);  
	out_0<=ot4;
	out_1<=ot5;
	out_2<=ot6;
	out_3<=ot7;
	
end Behavioral;

