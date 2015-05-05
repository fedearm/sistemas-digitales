library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg4 is
	generic ( N : integer := 4);
	port(clk, en, rst: in std_logic;
		  q_in:   in std_logic_vector(N-1 downto 0);
        q_out: out std_logic_vector(N-1 downto 0)
       );
end reg4;

architecture Behavioral of reg4 is
begin

  process(clk, rst)
  begin
    if rst = '1' then
      q_out <= ( others => '0' );
    elsif rising_edge(clk) then
			if en='1' then
				q_out <= q_in;
			end if;
    end if; 
  end process;
end Behavioral;