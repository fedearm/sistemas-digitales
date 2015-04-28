library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cont_bcd is
	generic ( M: integer := 8 );

	port ( clk, rst, en : in  std_logic;
		over: out  std_logic;
		out_0,out_1,out_2,out_3,out_4,out_5,out_6,out_7: out std_logic_vector(3 downto 0) := "0000"
	);
end cont_bcd;

architecture Behavioral of cont_bcd is
	constant MAX: std_logic_vector(3 downto 0) := "1001";

	signal en_x:  std_logic_vector(0 to M-1);
	signal reset: std_logic;
	signal ov: std_logic;
	signal o_0,o_1,o_2,o_3,o_4,o_5,o_6,o_7: std_logic_vector(3 downto 0);
begin
	u_c0: entity work.counter(Behavioral)
		port map (clock=>clk, en=>en,      rst=>reset, OV=>MAX, over=>en_x(0), outp=>o_0 );
	u_c1: entity work.counter(Behavioral)
		port map (clock=>clk, en=>en_x(0), rst=>reset, OV=>MAX, over=>en_x(1), outp=>o_1 );
	u_c2: entity work.counter(Behavioral)
		port map (clock=>clk, en=>en_x(1), rst=>reset, OV=>MAX, over=>en_x(2), outp=>o_2 );
	u_c3: entity work.counter(Behavioral)
		port map (clock=>clk, en=>en_x(2), rst=>reset, OV=>MAX, over=>en_x(3), outp=>o_3 );
	u_c4: entity work.counter(Behavioral)
		port map (clock=>clk, en=>en_x(3), rst=>reset, OV=>MAX, over=>en_x(4), outp=>o_4 );
	u_c5: entity work.counter(Behavioral)
		port map (clock=>clk, en=>en_x(4), rst=>reset, OV=>MAX, over=>en_x(5), outp=>o_5 );
	u_c6: entity work.counter(Behavioral)
		port map (clock=>clk, en=>en_x(5), rst=>reset, OV=>MAX, over=>en_x(6), outp=>o_6 );
	u_c7: entity work.counter(Behavioral)
		port map (clock=>clk, en=>en_x(6), rst=>reset, OV=>MAX, over=>en_x(7), outp=>o_7 );

	out_0 <= o_0;
	out_1 <= o_1;
	out_2 <= o_2;
	out_3 <= o_3;
	out_4 <= o_4;
	out_5 <= o_5;
	out_6 <= o_6;
	out_7 <= o_7;

	reset <= ov or rst;
	over <= ov;
	ov <= '1' when o_0=MAX and o_1=MAX and o_2=MAX and o_3=MAX and o_4=MAX and o_5=MAX and o_6=MAX and o_7=MAX else '0';

	
end Behavioral;

