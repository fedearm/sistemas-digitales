----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:11:41 03/16/2015 
-- Design Name: 
-- Module Name:    dff - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dff is
    Port ( clk : in  std_logic;
           rst : in  std_logic;
           ce  : in  std_logic;
           d   : in  std_logic;
           q   : out std_logic);
end dff;

architecture Behavioral of dff is
begin
   process (clk,rst,ce,d) is
   begin
      if rising_edge(clk) then  
         if (rst='1') then   
            q <= '0';
         elsif (ce='1') then
            q <= d;
         end if;
      end if;
   end process;

end architecture Behavioral;

