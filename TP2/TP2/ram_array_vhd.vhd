library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
--use IEEE.STD_LOGIC_ARITH.ALL; 

entity ram_array is
	generic( W: integer:= 11 );
	port (
		clk : in std_logic;
		address : in std_logic_vector(8 downto 0);
		we : in std_logic;
		data_i : in std_logic_vector(W-1 downto 0);
		data_o : out std_logic_vector(W-1 downto 0)
   );
end ram_array;

architecture Beh of ram_array is

--Declaration of type and signal of a 256 element RAM
--with each element being 8 bit wide.
type ram_t is array (0 to 511) of std_logic_vector(W-1 downto 0);
signal ram : ram_t := (others => (others => '0'));

begin

--process for read and write operation.
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(we='1') then
				ram(to_integer(unsigned(address))) <= data_i;
			end if;
			data_o <= ram(to_integer(unsigned(address)));
		end if; 
	end process;
end Beh;