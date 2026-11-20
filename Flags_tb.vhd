library ieee;
use ieee.std_logic_1164.all;

entity Flags_tb is
end Flags_tb;

architecture tb_Flags of Flags_tb is
component FLags is
port(
	 --input ports
    iOV : in std_logic;   --in OV
	 iCB: in std_logic;     --in CB
	 OP : in std_logic;
	 R : in std_logic_vector(3 downto 0);
	 CY : in std_logic;
	 --output ports
    BE : out std_logic;
	 GE : out std_logic;
	 Z : out std_logic;
	 oOV : out std_logic;   --out OV
	 oCB : out std_logic	 --out CBo
	 );
	end component;
	
	signal iOV : std_logic;
	signal iCB : std_logic;
	signal OP : std_logic;
	signal R : std_logic_vector(3 downto 0);
	signal CY: std_logic;
	signal BE, GE, Z,	oOV, oCB : std_logic;
	
	begin
	
	UUT: Flags port map(iOV => iOV, iCB => iCB, OP => OP, R => R, CY => CY, BE => BE, GE => GE, Z => Z, oOV => oOv, oCB => oCB);
	
	process
	begin
--todos os vetores de teste foram tiradas das diretamente das operaçoes da tabela do enunciado	
        -- #6
        iOV <= '0';  
        iCB <= '1';  
        OP <= '0';  --aritmetica
		  CY <= '0';
		  R <= "1011";    
        wait for 10 ns;  -- Z = 0, BE = 1 (1 < 6(5 + 1)), GE = 0, oOV = 0, oCB = 1

        -- #7
        iOV <= '0';  
        iCB <= '1';  
        OP <= '0';
		  CY <= '0';
		  R <= "0111";    
        wait for 10 ns;  -- Z = 0, BE = 1 (2 < 11), GE = 1(2 > -6), oOV = 0, oCB = 1
		  
		  -- #12	
		  iOV <= '0';  
        iCB <= '0';  
        OP <= '0';
		  CY <= '0';
		  R <= "0000";    
        wait for 10 ns;  -- Z = 1, BE = 1, GE = 1, oOV = 0, oCB = 0
		  
		  -- #19	
		  iOV <= '0';  
        iCB <= '1';  
        OP <= '1';
		  CY <= '0';
		  R <= "0100";    
        wait for 10 ns;  -- Z = 0, BE = -, GE = -, oOV = 0, oCB = 0
		  
		  --#21
		  iOV <= '1';  
        iCB <= '1';  
        OP <= '0';
		  CY <= '0';
		  R <= "1111";    
        wait for 10 ns;  -- Z = 0, BE = 1(7 < 8), GE = 1(7 > -8), oOV = 1, oCB = 1

		  --#22
		  iOV <= '1';  
        iCB <= '0';  
        OP <= '0';
		  CY <= '0';
		  R <= "0111";    
        wait for 10 ns;  -- Z = 0, BE = 0, GE = 0, oOV = 1, oCB = 0
		  
		  --#23
		  iOV <= '0';  
        iCB <= '0';  
        OP <= '1';  --logica
		  CY <= '1';
		  R <= "0000";    
        wait for 10 ns;  -- Z = 1, BE = -, GE = -, oOV = 0, oCB = 1

        wait;
    end process;
	
	end tb_Flags;