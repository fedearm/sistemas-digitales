library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dff is
    Port ( clk : in  std_logic;
           rst : in  std_logic;
           ce  : in  std_logic;
           d   : in  std_logic;
           q   : out std_logic;
			  nq  : out std_logic);
end dff;

architecture Behavioral of dff is
begin
	--nq <= not q;

   process (clk,rst,ce) is
   begin
      if rising_edge(clk) then  
         if (rst='1') then   
            q <= '0';
				nq <= '1';
         elsif (ce='1') then
            q <= d;
				nq <= not d;
         end if;
      end if;
   end process;

end architecture Behavioral;
