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
	signal rst_per: std_logic;
	signal ena_cont: std_logic;
	signal ena_medido: std_logic;
	signal shft_reg: std_logic;
	signal fin_per: std_logic;
	
	signal od0,od1,od2,od3,od4,od5,od6: std_logic_vector(3 downto 0);
	signal op0,op1,op2,op3,op4,op5,op6: std_logic_vector(3 downto 0);
	signal ot0,ot1,ot2,ot3,ot4,ot5,ot6: std_logic_vector(3 downto 0);
	
begin
	--generator_unit: entity work.generador(Beh)
	--	generic map(N=>2)
	--	port map(clock=>clk, over=>ena_cont);

	dff_unit: entity work.dff(Behavioral)
		port map(clk=>clk, rst=>rst, ce=>'1', d=>an_in, q=>q, nq=>not_q);

	cont_sigma_unit: entity work.cont_bcd(Behavioral)
		port map(en=>ena_medido, clk=>clk, rst=>rst_medido, over=>ov_medido, 
				out_0=>od0,out_1=>od1,out_2=>od2,out_3=>od3,
				out_4=>od4,out_5=>od5,out_6=>od6);

	cont_per_unit: entity work.cont_bcd(Behavioral)
		port map(en=>ena_cont, clk=>clk, rst=>rst_per, over=>ov_periodo,
				out_0=>op0,out_1=>op1,out_2=>op2,out_3=>op3,
				out_4=>op4,out_5=>op5,out_6=>op6);
					
	reg0_unit: entity work.reg4(Behavioral)
		port map(clk=>clk, rst=>rst, en=>shft_reg, q_in=>od3, q_out=>ot3 );
	reg1_unit: entity work.reg4(Behavioral)
		port map(clk=>clk, rst=>rst, en=>shft_reg, q_in=>od4, q_out=>ot4 );
	reg2_unit: entity work.reg4(Behavioral)
		port map(clk=>clk, rst=>rst, en=>shft_reg, q_in=>od5, q_out=>ot5 );
	reg3_unit: entity work.reg4(Behavioral)
		port map(clk=>clk, rst=>rst, en=>shft_reg, q_in=>od6, q_out=>ot6 );
		
	an_in <= analog_in;			
	nq <= not_q;
	
	ena_cont <= '1';
	
	ena_medido <= q and ( not fin_per);  
	shft_reg <= fin_per;
			
	out_0<=ot3;
	out_1<=ot4;
	out_2<=ot5;
	out_3<=ot6;
	
   process(clk)
	begin
		if rising_edge(clk) then
			fin_per <= '0';
			rst_medido <= '0';
			rst_per <= '0';
			
			--bcd periodo = 3.299.999
			if op6="0011" and op5="0011" and op4="0000" and op3="0000" and op2="0000" and op1="0000" and op0="0000" then			 
				fin_per <= '1';
			end if;
			if op6="0011" and op5="0011" and op0="0001" then
				rst_medido <= '1';
				rst_per <= '1';
			end if;
		end if;
	end process;

end Behavioral;

