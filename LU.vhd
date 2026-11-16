library ieee;
use ieee.std_logic_1164.all;

entity LU is
port(
--Input ports
	A : in std_logic_vector(3 downto 0); --A é 4 bits
	B : in std_logic_vector(3 downto 0); --B é 4 bits
	S : in std_logic_vector(1 downto 0);   -- seletor = 2 bits
-- Output ports
	R : out std_logic_vector(3 downto 0); --R é 4 bits
	CY : out std_logic
	);
	end Lu;
	
architecture structural of LU is

component mANDNOT is
port(
--Input ports
	A : in std_logic_vector(3 downto 0); --A é 4 bits
	B : in std_logic_vector(3 downto 0); --B é 4 bits
-- Output ports
	R : out std_logic_vector(3 downto 0) --R é 4 bits
	);
	end component;
	
component mNAND is
port(
--Input ports
	A : in std_logic_vector(3 downto 0); --A é 4 bits
	B : in std_logic_vector(3 downto 0); --B é 4 bits
-- Output ports
	R : out std_logic_vector(3 downto 0) --R é 4 bits
	);
	end component;	
	
component mLSL is
port(
--Input ports
	A : in std_logic_vector(3 downto 0); -- A é 4 bits
	B : in std_logic_vector(1 downto 0); -- B é 2 bits
-- Output ports
	R : out std_logic_vector(3 downto 0);  -- R(saida) é 4 bits
	CY : out std_logic
	);
	end component;

component mASR is
port(
--Input ports
	A : in std_logic_vector(3 downto 0); -- A é 4 bits
-- Output ports
	R : out std_logic_vector(3 downto 0);  -- R(saida) é 4 bits
	CY : out std_logic --saida para as flags
	);
	end component;
	
signal R_ANDNOT, R_NAND, R_LSL, R_ASR : std_logic_vector(3 downto 0);	
signal CY_LSL, CY_ASR : std_logic;

begin

UmANDNOT: mANDNOT port map(
		A => A, 
		B => B, 
		R => R_ANDNOT
		);

UmNAND: mNAND port map(
		A => A, 
		B => B, 
		R => R_NAND	
		);

UmLSL: mLSL port map(
		A => A, 
		B => B(1 downto 0),  
		R => R_LSL,
		CY => CY_LSL
		);

UmASR: mASR port map(
		A => A,   
		R => R_ASR,
		CY => CY_ASR
		);	
		
		
R(0) <= (R_ANDNOT(0) and not S(1) and not S(0)) or (R_NAND(0) and not S(1) and S(0)) or (R_LSL(0) and S(1) and not S(0)) or (R_ASR(0) and S(1) and S(0));
R(1) <= (R_ANDNOT(1) and not S(1) and not S(0)) or (R_NAND(1) and not S(1) and S(0)) or (R_LSL(1) and S(1) and not S(0)) or (R_ASR(1) and S(1) and S(0));
R(2) <= (R_ANDNOT(2) and not S(1) and not S(0)) or (R_NAND(2) and not S(1) and S(0)) or (R_LSL(2) and S(1) and not S(0)) or (R_ASR(2) and S(1) and S(0));
R(3) <= (R_ANDNOT(3) and not S(1) and not S(0)) or (R_NAND(3) and not S(1) and S(0)) or (R_LSL(3) and S(1) and not S(0)) or (R_ASR(3) and S(1) and S(0));
--R_ANDNOT <= not S(1) and not S(0);    --ANDNOT = S(00)
--R_NAND <= not S(1) and S(0);      --NAND = S(01)
--R_LSL <= S(1) and not S(0);  --LSL = S(10)
--R_ASR <= S(1) and S(0);	      --ASR = S(11)
CY <= (CY_LSL and not S(0)) or (CY_ASR and S(0));
--No CY do LSL e do ASR, so o OP0(S0) que diferencia		
		
end structural; 	 	
	
	