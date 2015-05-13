
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;

entity ram_array is
	generic ( N:integer:= 8; M:integer := 9 ); 
	port (
		clk   : in  std_logic;
		we      : in  std_logic;
		address : in  std_logic_vector(N-1 downto 0);
		datain  : in  std_logic_vector(M-1 downto 0);
		dataout : out std_logic_vector(M-1 downto 0)
  );
end entity ram_array;

architecture Beh of ram_array is

   type ram_type is array (0 to (2**N)-1) of std_logic_vector(M-1 downto 0);
   signal ram : ram_type;
   signal r_address : std_logic_vector(N-1 downto 0);

begin

  RamProc: process(clk) is

  begin
    if rising_edge(clk) then
      if we = '1' then
        ram(to_integer(unsigned(address))) <= datain;
      end if;
      r_address <= address;
    end if;
  end process RamProc;

  dataout <= ram(to_integer(unsigned(r_address)));

end architecture Beh;