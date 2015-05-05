--------------------------------------------------------------------------
-- Modulo: Controlador VGA
-- Descripción: 
-- Autor: Sistemas Digitales (66.17)
--        Universidad de Buenos Aires - Facultad de Ingeniería
--        www.campus.fi.uba.ar
-- Fecha: 16/04/13
--------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity vga_ctrl is
    port (
		mclk: in std_logic;
		red_i: in std_logic;
		grn_i: in std_logic;
		blu_i: in std_logic;
		bcd0, bcd1, bcd2, bcd3: in std_logic_vector(3 downto 0);
		
		hs: out std_logic;
		vs: out std_logic;
		red_o: out std_logic_vector(2 downto 0);
		grn_o: out std_logic_vector(2 downto 0);
		blu_o: out std_logic_vector(1 downto 0);
		pixel_row: out std_logic_vector(9 downto 0);
		pixel_col: out std_logic_vector(9 downto 0)
	
	);
end vga_ctrl;

architecture vga_ctrl_arq of vga_ctrl is

	-- Numero de pixeles en una linea horizontal (800)
	constant hpixels: unsigned(9 downto 0) := "1100100000";
	-- Numero de lineas horizontales en el display (521)
	constant vlines: unsigned(9 downto 0) := "1000001001";
	
	constant hbp: unsigned(9 downto 0) := "0010010000";	 -- Back porch horizontal (144)
	constant hfp: unsigned(9 downto 0) := "1100010000";	 -- Front porch horizontal (784)
	constant vbp: unsigned(9 downto 0) := "0000011111";	 -- Back porch vertical (31)
	constant vfp: unsigned(9 downto 0) := "0111111111";	 -- Front porch vertical (511)


	constant dir_v:   unsigned(6 downto 0) := "0010000";	 -- Posicion de caracteres vertical
	constant dir_h_1: unsigned(6 downto 0) := "0011111";	 -- Posicion del 1er caracter horizontal
	constant dir_h_2: unsigned(6 downto 0) := "0100000";	 -- Posicion del 1er caracter horizontal
	constant dir_h_3: unsigned(6 downto 0) := "0100001";	 -- Posicion del 1er caracter horizontal
	constant dir_h_4: unsigned(6 downto 0) := "0100010";	 -- Posicion del 1er caracter horizontal
	constant dir_h_5: unsigned(6 downto 0) := "0100011";	 -- Posicion del 1er caracter horizontal

	constant char_dir_dot: std_logic_vector(5 downto 0) := "001011"; --direccion del char rom '.'
	constant char_dir_V:   std_logic_vector(5 downto 0) := "001100"; --direccion del char rom 'V'

	-- Contadores (horizontal y vertical)
	signal hc, vc: unsigned(9 downto 0);
	-- Flag para obtener una habilitación cada dos ciclos de clock
	signal clkdiv_flag: std_logic;
	-- Senal para habilitar la visualización de datos
	signal vidon: std_logic;
	-- Senal para habilitar el contador vertical
	signal vsenable: std_logic;
	
	signal char_address: std_logic_vector(5 downto 0);
	signal col_char, row_char: std_logic_vector(2 downto 0);
	signal rom_out,hay_char: std_logic;

begin

		char_rom_unit: entity work.Char_ROM(p)
		port map ( char_address=>char_address, font_row=>row_char,
						font_col=>col_char, rom_out=>rom_out );


    -- División de la frecuencia del reloj
    process(mclk)
    begin
        if rising_edge(mclk) then
            clkdiv_flag <= not clkdiv_flag;
        end if;
    end process;																			

    -- Contador horizontal
    process(mclk)
    begin
        if rising_edge(mclk) then
            if clkdiv_flag = '1' then
                if hc = hpixels then														
                    hc <= (others => '0');	-- El cont horiz se resetea cuando alcanza la cuenta máxima de pixeles
                    vsenable <= '1';		-- Habilitación del cont vert
                else
                    hc <= hc + 1;			-- Incremento del cont horiz
                    vsenable <= '0';		-- El cont vert se mantiene deshabilitado
                end if;
            end if;
        end if;
    end process;

    -- Contador vertical
    process(mclk)
    begin
        if rising_edge(mclk) then			 
            if clkdiv_flag = '1' then           -- Flag que habilita la operación una vez cada dos ciclos (25 MHz)
                if vsenable = '1' then          -- Cuando el cont horiz llega al máximo de su cuenta habilita al cont vert
                    if vc = vlines then															 
                        vc <= (others => '0');  -- El cont vert se resetea cuando alcanza la cantidad maxima de lineas
                    else
                        vc <= vc + 1;           -- Incremento del cont vert
                    end if;
                end if;
            end if;
        end if;
    end process;

	-- hs <= '1' when (hc(9 downto 7) = "000") else '0';
	-- vs <= '1' when (vc(9 downto 1) = "000000000") else '0';
    hs <= '1' when (hc < "0001100001") else '0';   -- Generación de la señal de sincronismo horizontal
    vs <= '1' when (vc < "0000000011") else '0';   -- Generación de la señal de sincronismo vertical

    pixel_col <= std_logic_vector(hc - 144) when (vidon = '1') else std_logic_vector(hc);    
    pixel_row <= std_logic_vector(vc - 31) when (vidon = '1') else std_logic_vector(vc);
	
	-- Habilitación de la salida de datos por el display cuando se encuentra entre los porches
    vidon <= '1' when (((hc < hfp) and (hc > hbp)) and ((vc < vfp) and (vc > vbp))) else '0';

	col_char <= std_logic_vector(hc(2 downto 0));
	row_char <= std_logic_vector(vc(2 downto 0));

	process(hc,vc)
	begin
		
		red_o <= (others => '0');
		grn_o <= (others => '0');
		blu_o <= (others => '0');
		hay_char <= '0';
	
		if hc(9 downto 3) = dir_h_1 and vc(9 downto 3) = dir_v then
				char_address<= "00" & bcd3;
				hay_char <= '1';
		elsif (hc(9 downto 3) = dir_h_2) and vc(9 downto 3) = dir_v then
				char_address <= char_dir_dot;
				hay_char <= '1';
		elsif (hc(9 downto 3) = dir_h_3) and vc(9 downto 3) = dir_v then
				char_address<="00" & bcd2;
				hay_char <= '1';
		elsif (hc(9 downto 3) = dir_h_4) and vc(9 downto 3) = dir_v then
				char_address<="00" & bcd1;
				hay_char <= '1';
		elsif (hc(9 downto 3) = dir_h_5) and vc(9 downto 3) = dir_v then
				char_address <= char_dir_V;
				hay_char <= '1';
		end if;		


		if rom_out='1' and vidon ='1' and hay_char='1' then
			red_o <= "111";
			grn_o <= "111";
			blu_o <= "11";
		end if;
		
	end process;
end vga_ctrl_arq;