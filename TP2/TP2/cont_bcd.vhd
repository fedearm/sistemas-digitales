library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package my_types_pkg is
	type salidas_bcd is array(7 downto 0) of std_logic_vector(3 downto 0);
end package;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my_types_pkg.all;

entity cont_bcd is
	generic ( M: integer := 8 );

	port ( clk, rst, en : in  std_logic;
		over: out  std_logic;
		out_x : out salidas_bcd := (M-1 downto 0 => "0000") );
end cont_bcd;

architecture Behavioral of cont_bcd is
	constant MAX: std_logic_vector(3 downto 0) := "1001";
	constant MAX_TOT: salidas_bcd := ( M-1 downto 0 => MAX );

	signal en_x:  std_logic_vector(0 to M-1);
	signal reset: std_logic;
	signal ov: std_logic;
	signal o_x: salidas_bcd;
begin
	u_c0: entity work.counter(Behavioral)
		port map (clock=>clk, en=>en,      rst=>reset, OV=>MAX, over=>en_x(0), outp=>o_x(0) );
	u_c1: entity work.counter(Behavioral)
		port map (clock=>clk, en=>en_x(0), rst=>reset, OV=>MAX, over=>en_x(1), outp=>o_x(1) );
	u_c2: entity work.counter(Behavioral)
		port map (clock=>clk, en=>en_x(1), rst=>reset, OV=>MAX, over=>en_x(2), outp=>o_x(2) );
	u_c3: entity work.counter(Behavioral)
		port map (clock=>clk, en=>en_x(2), rst=>reset, OV=>MAX, over=>en_x(3), outp=>o_x(3) );
	u_c4: entity work.counter(Behavioral)
		port map (clock=>clk, en=>en_x(3), rst=>reset, OV=>MAX, over=>en_x(4), outp=>o_x(4) );
	u_c5: entity work.counter(Behavioral)
		port map (clock=>clk, en=>en_x(4), rst=>reset, OV=>MAX, over=>en_x(5), outp=>o_x(5) );
	u_c6: entity work.counter(Behavioral)
		port map (clock=>clk, en=>en_x(5), rst=>reset, OV=>MAX, over=>en_x(6), outp=>o_x(6) );
	u_c7: entity work.counter(Behavioral)
		port map (clock=>clk, en=>en_x(6), rst=>reset, OV=>MAX, over=>en_x(7), outp=>o_x(7) );


	reset <= ov or rst;
	out_x <= o_x;
	ov <= '1' when ( o_x = ( M-1 downto 0 =>MAX )) else '0';
	over <= ov;
	
end Behavioral;

