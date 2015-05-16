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
--use IEEE.STD_LOGIC_ARITH.ALL; 

entity vga_ctrl is
    port (
		mclk: in std_logic;
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

	-- Contadores (horizontal y vertical)
	signal hc, vc, pix_h, pix_v: unsigned(9 downto 0) := (others => '0');
	-- Flag para obtener una habilitación cada dos ciclos de clock
	signal clkdiv_flag: std_logic := '0';
	-- Senal para habilitar la visualización de datos
	signal vidon: std_logic := '0';
	-- Senal para habilitar el contador vertical
	signal vsenable: std_logic := '0';
	
	begin
	
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

		 hs <= '1' when (hc < "0001100001") else '0';   -- Generación de la señal de sincronismo horizontal
		 vs <= '1' when (vc < "0000000011") else '0';   -- Generación de la señal de sincronismo vertical

		-- Habilitación de la salida de datos por el display cuando se encuentra entre los porches
		 vidon <= '1' when (((hc < hfp) and (hc > hbp)) and ((vc < vfp) and (vc > vbp))) else '0';

		process(hc,vc,vidon)
		begin
			
			pixel_col <= (others => '0');
			pixel_row <= (others => '0');
			pix_h <= (others => '0');
			pix_v <= (others => '0');
			
			red_o <= (others => '0');
			blu_o <= (others => '0');
			grn_o <= (others => '0');
						
			
			if vidon = '1' then

				pix_h <= unsigned(std_logic_vector(hc - 144));    
				pix_v <= unsigned(std_logic_vector(vc - 31));
				pixel_col <= std_logic_vector(pix_h);
				pixel_row <= std_logic_vector(pix_v);
			end if;
		end process;
end vga_ctrl_arq;