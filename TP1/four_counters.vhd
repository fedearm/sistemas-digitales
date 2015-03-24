library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity contador_4dig is
    generic ( N : integer := 4);
    Port ( clk : in  std_logic;
           rst : in  std_logic;
	   en  : in  std_logic;
           out0 : out  std_logic_vector (N-1 downto 0);
           out1 : out  std_logic_vector (N-1 downto 0);
           out2 : out  std_logic_vector (N-1 downto 0);
           out3 : out  std_logic_vector (N-1 downto 0) );
end contador_4dig;

architecture Behavioral of contador_4dig is
 	signal en1,en2,en3:  std_logic;
begin
	u_c0: entity work.counter(Behavioral)
		port map (clock=>clk, en=>en, rst=>rst, OV=>"1010", over=>en1, outp=>out0 );
	u_c1: entity work.counter(Behavioral)
		port map (clock=>clk, en=>en1,rst=>rst, OV=>"1010", over=>en2, outp=>out1);
	u_c2: entity work.counter(Behavioral)
		port map (clock=>clk, en=>en2,rst=>rst, OV=>"1010", over=>en3, outp=>out2);
	u_c3: entity work.counter(Behavioral)
		port map (clock=>clk, en=>en3,rst=>rst, OV=>"1010", outp=>out3);

end Behavioral;

