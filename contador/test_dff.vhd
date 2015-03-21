----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:15:54 03/16/2015 
-- Design Name: 
-- Module Name:    test_dff - Behavioral 
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

entity test_dff is
end test_dff;

architecture Behavioral of test_dff is
	signal test_d : std_logic:= '0';
   signal test_en : std_logic:= '0';
	signal test_rst : std_logic:= '0';
   signal clock  : std_logic := '0';
	signal test_out : std_logic;

begin
	uut: entity work.dff(Behavioral)
		port map(d=>test_d, ce=>test_en , rst=>test_rst, clk=>clock, q=>test_out);

	test_rst <= '0';
	test_en <= '1';
	test_d <= '0';

--	process
--	variable i : integer;
--	constant TEST_EN_TIME_ON : integer := 5;
--	begin
--	
--		for i in 0 to 20 loop
--			clock <= '0';
--			wait for 200 ns;
--			clock <= '1';
--			wait for 200 ns;
--			test_d <= '1';
--		end loop;
--	
--	assert false
--		report "Simulation Completed"
--		severity failure;
--	
--	end process;

  clock <= not clock after 5 ns;
  
	StimuliProcess : process
	begin
		test_d <='0';
		REPORT "DFF : GOOD SCENARIO :";
		REPORT "===================";
		wait until rising_edge(clock);
		wait until rising_edge(clock);
		wait until rising_edge(clock);
		wait until rising_edge(clock);
		wait until rising_edge(clock);
		wait for 8 ns;
		test_d <='1';
		wait until rising_edge(clock);
		wait for 2 ns;
		test_d <= '0';
   end process StimuliProcess;




end Behavioral;

