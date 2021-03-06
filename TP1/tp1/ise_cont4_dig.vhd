library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity contador_4dig is
    --constant M: integer := 4;
    port ( clk, rst, en : in  std_logic;
           out0,out1,out2,out3 : out  std_logic_vector(3 downto 0) := "0000" );
end contador_4dig;

architecture Behavioral of contador_4dig is
	constant MAX: std_logic_vector(3 downto 0) := "1001";
 	signal en1,en2,en3:  std_logic;
	signal reset: std_logic;
	signal ov: std_logic;
	signal o0,o1,o2,o3: std_logic_vector(3 downto 0);
begin
	u_c0: entity work.counter(Behavioral)
		port map (clock=>clk, en=>en, rst=>reset, OV=>MAX, over=>en1, outp=>o0 );
	u_c1: entity work.counter(Behavioral)
		port map (clock=>clk, en=>en1,rst=>reset, OV=>MAX, over=>en2, outp=>o1);
	u_c2: entity work.counter(Behavioral)
		port map (clock=>clk, en=>en2,rst=>reset, OV=>MAX, over=>en3, outp=>o2);
	u_c3: entity work.counter(Behavioral)
		port map (clock=>clk, en=>en3,rst=>reset, OV=>MAX, outp=>o3);


	reset <= ov or rst;
	out0 <= o0;
	out1 <= o1;
	out2 <= o2;
	out3 <= o3;

   process(clk,rst)
   begin
	if rising_edge(clk) then
		if ( o0=MAX and o1=MAX and o2=MAX and o3=MAX ) then
	        ov <= '1';
		else
			  ov <= '0';
		end if;
	end if;
   end process;
end Behavioral;

