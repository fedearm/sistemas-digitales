
-- VHDL Instantiation Created from source file tp.vhd -- 18:31:04 05/11/2015
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT tp
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		rst_sd : IN std_logic;
		an_in : IN std_logic;          
		nq_out : OUT std_logic;
		an : OUT std_logic_vector(3 downto 0);
		seg7 : OUT std_logic_vector(7 downto 0);
		hs : OUT std_logic;
		vs : OUT std_logic;
		red_o : OUT std_logic_vector(2 downto 0);
		grn_o : OUT std_logic_vector(2 downto 0);
		blu_o : OUT std_logic_vector(1 downto 0)
		);
	END COMPONENT;

	Inst_tp: tp PORT MAP(
		clk => ,
		rst => ,
		rst_sd => ,
		an_in => ,
		nq_out => ,
		an => ,
		seg7 => ,
		hs => ,
		vs => ,
		red_o => ,
		grn_o => ,
		blu_o => 
	);


