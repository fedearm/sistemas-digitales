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
use IEEE.STD_LOGIC_ARITH.ALL; 

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


	-- Constantes para dibujo de la pantalla 
	
	constant dir_v_valor:   unsigned(9 downto 0) := "0010000000"; -- Posicion de caracteres vertical
	constant dir_h_valor:   unsigned(9 downto 0) := "0001111111"; -- Posicion de caracteres vertical

	constant dir_h_r_g_max: unsigned(3 downto 0) := "0011"; -- Posicion de referencia de la grid
	constant dir_v_r_g_max: unsigned(6 downto 0) := "0100110";   -- Posicion de referencia de la grid
	constant dir_v_r_g_min: unsigned(6 downto 0) := "0001101";   -- Posicion de referencia de la grid
		
	constant dir_h_max_ref: unsigned(9 downto 0) := "0000000101";   -- Valor de ref maximo	
	constant dir_v_max_ref: unsigned(9 downto 0) := "0100011111";
	constant dir_v_min_ref: unsigned(9 downto 0) := "0111010000";

	constant char_dir_dot: std_logic_vector(5 downto 0) := "001011"; --direccion del char rom '.'
	constant char_dir_V:   std_logic_vector(5 downto 0) := "001100"; --direccion del char rom 'V'
	
	constant max_grid_h: unsigned(9 downto 0) := to_unsigned(400,10);
	constant min_grid_h: unsigned(9 downto 0) := to_unsigned(50,10);
	constant max_grid_v: unsigned(9 downto 0) := to_unsigned(460,10);
	constant min_grid_v: unsigned(9 downto 0) := to_unsigned(240,10);
	
	constant ceros_overflow: std_logic_vector(6 downto 0) := "0000000";
	
	-- Contadores (horizontal y vertical)
	signal hc, vc, pix_h, pix_v: unsigned(9 downto 0);
	-- Flag para obtener una habilitación cada dos ciclos de clock
	signal clkdiv_flag: std_logic;
	-- Senal para habilitar la visualización de datos
	signal vidon: std_logic;
	-- Senal para habilitar el contador vertical
	signal vsenable: std_logic;
	
	signal char_address: std_logic_vector(5 downto 0);
	signal col_char, row_char: std_logic_vector(2 downto 0);
	signal rom_out: std_logic;
		
	signal hay_char, hay_grid, hay_dot, hay_ref: std_logic;
	signal grid_index: unsigned(10 downto 0) := ( others => '0' );
	signal grid_h: unsigned(8 downto 0) := ( others => '0' );
	signal grid_v: unsigned(8 downto 0) := ( others => '0' );
	signal valor:  unsigned(10 downto 0) := ( others => '0' );
	signal valor_medido:  unsigned(8 downto 0) := ( others => '0' );

	--type ram_type is array (0 to (2**7)-1) of std_logic_vector(8 downto 0);
   signal ram_addr,ram_addr_r,ram_addr_w : std_logic_vector(8 downto 0) := (others=>'0');
	signal ram_add_r_aux : std_logic_vector(9 downto 0) := (others=>'0');
	signal grabar_valor, we: std_logic;
	signal valor_ram, valor_ram_in: std_logic_vector(10 downto 0) := ( others => '0' );

	begin
	
		 generator_unit: entity work.generador(Beh)
			generic map(N=>2000000)
			port map(clock=>mclk, over=>grabar_valor);

		 ram_unit: entity work.ram_array(Beh)
			port map(clk=>mclk, address=>ram_addr, we=>we,
				data_i=>valor_ram_in,data_o=>valor_ram );
			
		 char_rom_unit: entity work.Char_ROM(p)
			port map ( char_address=>char_address, font_row=>row_char,
					   font_col=>col_char, rom_out=>rom_out, clk=>mclk );

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

		 valor <= unsigned(ceros_overflow & bcd1) + 
		          unsigned(ceros_overflow & bcd2)*10 +
					 unsigned(ceros_overflow & bcd3)*100;

	   we <= grabar_valor;
		
		ram_addr <= ram_addr_w when we='1' else ram_addr_r;		
		valor_ram_in <= '0' & std_logic_vector(max_grid_v - unsigned(valor)/2 );
      ram_add_r_aux <= std_logic_vector(pix_h-min_grid_h-1);					
		ram_addr_r <= ram_add_r_aux(8 downto 0);
		
		process(grabar_valor)
		begin
			if rising_edge(grabar_valor) then
					ram_addr_w <= ram_addr_w + 1;
					if unsigned(ram_addr_w) > (max_grid_h-min_grid_h) then
						ram_addr_w <= (others => '0');
					end if;
			end if;
		end process;																			

		process(hc,vc,vidon,valor,bcd3,bcd2,bcd1,bcd0,rom_out,valor_ram)
		begin
			
			pixel_col <= (others => '0');
			pixel_row <= (others => '0');
			pix_h <= (others => '0');
			pix_v <= (others => '0');
			col_char <= (others => '0');
			row_char <= (others => '0');
			char_address <= (others => '0');
			grid_index <= (others => '0');
			
			red_o <= (others => '0');
			blu_o <= (others => '0');
			grn_o <= (others => '0');
						
			hay_char <= '0';
			hay_grid <= '0';
			hay_dot  <= '0';
			hay_ref  <= '0';
			
			
			if vidon = '1' then

				 pix_h <= unsigned(std_logic_vector(hc - 144));    
				 pix_v <= unsigned(std_logic_vector(vc - 31));
		       pixel_col <= std_logic_vector(pix_h);
		       pixel_row <= std_logic_vector(pix_v);

			
				if pix_h>dir_h_valor and pix_h<(dir_h_valor+8*4*6+1) and 
				   pix_v>dir_v_valor and pix_v<(dir_v_valor+8*4) then
				
					col_char <= std_logic_vector(pix_h(4 downto 2));
					row_char <= std_logic_vector(pix_v(4 downto 2));
				
					if pix_h < (dir_h_valor+8*4+1) then
						char_address<= "00" & bcd3;
						hay_char <= '1';
					elsif pix_h < (dir_h_valor+8*4*2+1) then
						char_address <= char_dir_dot;
						hay_char <= '1';
					elsif pix_h < (dir_h_valor+8*4*3+1) then
						char_address<="00" & bcd2;
						hay_char <= '1';
					elsif pix_h < (dir_h_valor+8*4*4+1) then
						char_address<="00" & bcd1;
						hay_char <= '1';
					elsif pix_h < (dir_h_valor+8*4*5+1) then
						char_address<="00" & bcd0;
						hay_char <= '1';
					else
						char_address <= char_dir_V;
						hay_char <= '1';
					end if;
				end if;		
			
		
			   -- Grilla
				if pix_h > min_grid_h and pix_h < max_grid_h and pix_v = max_grid_v then
					hay_grid <= '1';
				end if;		
				if pix_h = min_grid_h and pix_v > min_grid_v and pix_v < max_grid_v then
					hay_grid <= '1';
				end if;		
				if pix_h>(min_grid_h-5) and pix_h<(min_grid_h+10) then
					if pix_v = (dir_v_max_ref+7) or pix_v = (dir_v_min_ref-4) then
						hay_grid <= '1';
					end if;
				end if;		
			
			
				if pix_h>dir_h_max_ref and pix_h<(dir_h_max_ref+8*4+2) then

					col_char <= std_logic_vector(pix_h(2 downto 0));
					row_char <= std_logic_vector(pix_v(2 downto 0));
				

					if pix_v>dir_v_max_ref and pix_v<(dir_v_max_ref+8) then
				
						if pix_h < (dir_h_max_ref+8+1) then
							char_address<= "000011";
							hay_char <= '1';
						elsif pix_h < (dir_h_max_ref+8*2+1) then
							char_address <= char_dir_dot;
							hay_char <= '1';
						elsif pix_h < (dir_h_max_ref+8*3+1) then
							char_address<="000011";
							hay_char <= '1';
						else
							char_address <= char_dir_V;
							hay_char <= '1';
						end if;
					end if;

					if pix_v>dir_v_min_ref and pix_v<(dir_v_min_ref+8) then
				
						if pix_h < (dir_h_max_ref+8+1) then
							char_address<= "000000";
							hay_char <= '1';
						elsif pix_h < (dir_h_max_ref+8*2+1) then
							char_address <= char_dir_dot;
							hay_char <= '1';
						elsif pix_h < (dir_h_max_ref+8*3+1) then
							char_address<="000000";
							hay_char <= '1';
						else
							char_address <= char_dir_V;
							hay_char <= '1';
						end if;
					end if;				
				end if;
				
				
				if pix_h > min_grid_h and pix_h < max_grid_h and 
					pix_v > min_grid_v and pix_v < max_grid_v then
				
					grid_index <= unsigned(valor_ram);
					
					if  pix_v = grid_index then
						hay_dot <= '1';
					end if;
				end if;

				if rom_out='1' and hay_char='1' then
					red_o <= "111";
					grn_o <= "111";
					blu_o <= "11";
				end if;
				
				if hay_grid='1' then
					red_o <= "111";
					grn_o <= "111";
					blu_o <= "11";
				end if;
			
				if hay_ref='1' and rom_out='1' then
					red_o <= "111";
					grn_o <= "111";
					blu_o <= "11";
				end if;
				
				if hay_dot='1' then
					red_o <= "000";
					grn_o <= "111";
					blu_o <= "00";
				end if;
			
			end if;
		end process;
end vga_ctrl_arq;