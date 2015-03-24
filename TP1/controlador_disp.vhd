library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all; 
use IEEE.NUMERIC_STD.ALL;

entity disp_ctrl is
	port( bcd0,bcd1,bcd2,bcd3:  in  std_logic_vector(3 downto 0);
	      clk: in  std_logic;
	      anodos: out  std_logic_vector(3 downto 0);
	      seg7: out std_logic_vector(7 downto 0) );
end disp_ctrl;

architecture Behavioral of disp_ctrl is
begin
	cont_2b_unit: entity work.counter(Behavioral)
		generic map(N=>2)
		port map(en=>enable, rst=>reset, clk=>clk,
			out0=>output0,out1=>output1,out2=>output2,out3=>output3);

	process (clk,bcd0,bcd1,bcd2,bcd3)
	begin
		case  bcd is
		when "0000"=> seg7 <="10000001";
		when others=> seg7 <="11111111"; 
		end case;
	end process;
end Behavioral;

