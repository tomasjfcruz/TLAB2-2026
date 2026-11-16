library ieee;
use ieee.std_logic_1164.all;

entity AU is      
port(
--Input ports
	A : in std_logic_vector(3 downto 0); --A é 4 bits
	B : in std_logic_vector(3 downto 0);
	CBi : in std_logic;
	Opau : in std_logic;
-- Output ports
	R : out std_logic_vector(3 downto 0);
	OV : out std_logic;
	CBo : out std_logic 
	);
	end AU;
	
architecture structural of AU is

component AddSub is
    port
    (
    A : in std_logic_vector(3 downto 0);
    B : in std_logic_vector(3 downto 0);
	 AUOp : in std_logic;
	 CBi : in std_logic;	
    S : out std_logic_vector(3 downto 0);
    Co : out std_logic;
	 b3_out : out std_logic
    );
end component;
	
component AU_Flags is
    port
    (
    Am : in std_logic;
    Bm : in std_logic;
	 iCBo : in std_logic;
	 Rm : in std_logic;
    OV : out std_logic;
	 CBo : out std_logic 	
    );
end component;
	
signal R_int : std_logic_vector(3 downto 0);   --int = intermedio
signal CBo_int : std_logic;    					--int = intermedio
signal B3_xor_int : std_logic;

begin

UAddSub: AddSub port map(	
		A => A,
		B => B,
		AUOp => Opau,
		CBi => CBi,	
		S => R_int,           --S á saida R
		Co => CBo_int,        --Carry out para o Co intermedio
		b3_out => B3_xor_int     --A saida do B3 com o Xor do B3 int 
		);
		
UAU_Flags: AU_Flags port map(
		Am => A(3),
		Bm => B3_xor_int,    
		iCBo => CBo_int,
		Rm => R_int(3),
		OV => OV,
		CBo => CBo 
		);
		
R <= R_int;
  
end structural; 	 	
	
	