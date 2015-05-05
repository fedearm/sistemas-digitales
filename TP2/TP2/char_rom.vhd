library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Char_ROM is
	generic(
		N: integer:= 6;
		M: integer:= 3;
		W: integer:= 8
	);
	port(
		char_address: in std_logic_vector(5 downto 0);
		font_row, font_col: in std_logic_vector(M-1 downto 0);
		rom_out: out std_logic
	);
end;

architecture p of Char_ROM is
	subtype tipoLinea is std_logic_vector(0 to W-1);

	type char is array(0 to W-1) of tipoLinea;
						
	constant Err: char:= (
								"00000000",
								"01111110",
								"01111110",
								"01100110",
								"01100110",
								"01111110",
								"01111110",
								"00000000"
						);

	constant n_1: char:= (
								"00000000",
								"00001000",
								"00011000",
								"00001000",
								"00001000",
								"00001000",
								"00011100",
								"00000000"
						);

	constant n_2: char:= (
								"00000000",
								"00011100",
								"00100010",
								"00000010",
								"00000100",
								"00001000",
								"00111110",
								"00000000"
						);

	constant n_3: char:= (
								"00000000",
								"00111110",
								"00000100",
								"00001000",
								"00000100",
								"00100010",
								"00011100",
								"00000000"
						);

	constant n_4: char:= (
								"00000000",
								"00000100",
								"00001100",
								"00010100",
								"00111110",
								"00000100",
								"00000100",
								"00000000"
						);
	constant n_5: char:= (
								"00000000",
								"00111110",
								"00100000",
								"00111100",
								"00001010",
								"00100010",
								"00011100",
								"00000000"
						);

	constant n_6: char:= (
								"00000000",
								"00001110",
								"00010000",
								"00100000",
								"00111100",
								"00100010",
								"00011100",
								"00000000"
						);

	constant n_7: char:= (
								"00000000",
								"00111110",
								"00000010",
								"00000100",
								"00000100",
								"00001000",
								"00001000",
								"00000000"
						);

	constant n_8: char:= (
								"00000000",
								"00011100",
								"00100010",
								"00011100",
								"00100010",
								"00100010",
								"00011100",
								"00000000"
						);


	constant n_9: char:= (
								"00000000",
								"00011100",
								"00100010",
								"00100010",
								"00011110",
								"00000010",
								"00000010",
								"00000000"
						);

	constant n_0: char:= (
								"00000000",
								"00011100",
								"00100010",
								"00100010",
								"00100010",
								"00100010",
								"00011100",
								"00000000"
						);

	constant dot: char:= (
								"00000000",
								"00000000",
								"00000000",
								"00000000",
								"00000000",
								"00011000",
								"00011000",
								"00000000"
						);
	
	constant l_V: char:= (
								"00000000",
								"01000010",
								"01000010",
								"01000010",
								"00100100",
								"00100100",
								"00011000",
								"00000000"
						);
													
	type memo is array(0 to 255) of tipoLinea;
	signal RAM: memo:= (
								0 => n_0(0), 1 => n_0(1), 2 => n_0(2), 3 => n_0(3), 4 => n_0(4), 5 => n_0(5), 6 => n_0(6), 7 => n_0(7),
								8 => n_1(0), 9 => n_1(1), 10 => n_1(2), 11 => n_1(3), 12 => n_1(4), 13 => n_1(5), 14 => n_1(6), 15 => n_1(7),
								16 => n_2(0), 17 => n_2(1), 18 => n_2(2), 19 => n_2(3), 20 => n_2(4), 21 => n_2(5), 22 => n_2(6), 23 => n_2(7),
								24 => n_3(0), 25 => n_3(1), 26 => n_3(2), 27 => n_3(3), 28 => n_3(4), 29 => n_3(5), 30 => n_3(6), 31 => n_3(7),
								32 => n_4(0), 33 => n_4(1), 34 => n_4(2), 35 => n_4(3), 36 => n_4(4), 37 => n_4(5), 38 => n_4(6), 39 => n_4(7),
								40 => n_5(0), 41 => n_5(1), 42 => n_5(2), 43 => n_5(3), 44 => n_5(4), 45 => n_5(5), 46 => n_5(6), 47 => n_5(7),
								48 => n_6(0), 49 => n_6(1), 50 => n_6(2), 51 => n_6(3), 52 => n_6(4), 53 => n_6(5), 54 => n_6(6), 55 => n_6(7),
								56 => n_7(0), 57 => n_7(1), 58 => n_7(2), 59 => n_7(3), 60 => n_7(4), 61 => n_7(5), 62 => n_7(6), 63 => n_7(7),
								64 => n_8(0), 65 => n_8(1), 66 => n_8(2), 67 => n_8(3), 68 => n_8(4), 69 => n_8(5), 70 => n_8(6), 71 => n_8(7),
								72 => n_9(0), 73 => n_9(1), 74 => n_9(2), 75 => n_9(3), 76 => n_9(4), 77 => n_9(5), 78 => n_9(6), 79 => n_9(7),
								80 => Err(0), 81 => Err(1), 82 => Err(2), 83 => Err(3), 84 => Err(4), 85 => Err(5), 86 => Err(6), 87 => Err(7),
								88 => dot(0), 89 => dot(1), 90 => dot(2), 91 => dot(3), 92 => dot(4), 93 => dot(5), 94 => dot(6), 95 => dot(7),
								96 => l_V(0), 97 => l_V(1), 98 => l_V(2), 99 => l_V(3), 100=> l_V(4), 101=> l_V(5), 102=> l_V(6), 103=> l_V(7),
								
								104 to 255 => "00000000"
							);

	signal char_addr_aux: std_logic_vector(8 downto 0);
	
begin

	char_addr_aux <= char_address & font_row;
	rom_out <= RAM(conv_integer(char_addr_aux))(conv_integer(font_col));

end;