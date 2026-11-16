library ieee;
use ieee.std_logic_1164.all;

entity ALU is      
port(
--Input ports
	X : in std_logic_vector(3 downto 0);
	Y : in std_logic_vector(3 downto 0);
	CBi : in std_logic;
	OP : in std_logic_vector(2 downto 0);
-- Output ports
	R : out std_logic_vector(3 downto 0);
	BE : out std_logic;
	GE : out std_logic;
	Z : out std_logic;
	OV : out std_logic;   --out OV
	CBo : out std_logic	 --out CBo 
	);
	end ALU;
	
architecture structural of ALU is

component Xor0 is
   port
	(
   --Input ports
	X : in std_logic_vector(3 downto 0); -- A é 4 bits
	OPA : in std_logic;  -- selector
	-- Output ports
	A : out std_logic_vector(3 downto 0)  -- R(saida) é 4 bits
	);
end component;
	
component DecodeOP is
    port
	(
	--input ports
	OP : in std_logic_vector(2 downto 0);
	--output ports
	OPA : out std_logic;
	OPB : out std_logic;
	OPC : out std_logic;
	OPD : out std_logic;
	OPE : out std_logic;
	OPF : out std_logic
	);
end component;

component AU is
	port
	(
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
end component;

component LU is
port(
--Input ports
	A : in std_logic_vector(3 downto 0); --A é 4 bits
	B : in std_logic_vector(3 downto 0); --B é 4 bits
	S : in std_logic_vector(1 downto 0);   -- seletor = 2 bits
-- Output ports
	R : out std_logic_vector(3 downto 0); --R é 4 bits
	CY : out std_logic
	);
end component;

component MUX is
port(
--Input ports
	A : in std_logic_vector(3 downto 0); -- A é 4 bits
	B : in std_logic_vector(3 downto 0); -- B é 2 bits
	S : in std_logic;  -- selector
-- Output ports
	Y : out std_logic_vector(3 downto 0)  -- R(saida) é 4 bits
	);
end component;

component Flags is
port
    (
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



signal OPA_int, OPB_int, OPC_int, OPD_int, OPE_int, OPF_int : std_logic;
signal A_int : std_logic_vector(3 downto 0);
signal OV_int : std_logic;
signal CBo_int : std_logic;
signal CY_int : std_logic;
signal R_AU : std_logic_vector(3 downto 0);
signal R_LU : std_logic_vector(3 downto 0);
signal Y_MUX : std_logic_vector(3 downto 0); --saida intermedia do MUX 

begin

UXor0: Xor0 port map(	
		X => X,
		OPA => OPA_int,
		A => A_int
		);
		
UDecodeOP: DecodeOP port map(
	OP => OP,  --OP(0) => OP(0) ; OP(1) => OP(1) ; OP(2) => OP(2)	
	OPA => OPA_int,
	OPB => OPB_int,
	OPC => OPC_int,
	OPD => OPD_int,
	OPE => OPE_int,
	OPF => OPF_int
	);
	
UAU: AU port map(
	A => A_int,
	B => Y,
	CBi => CBi,
	Opau => OPB_int,
	R => R_AU,
	OV => OV_int,
	CBo => CBo_int
	);
	
ULU: LU port map(
	A => X,
	B => Y,
	S(0) => OPD_int,
	S(1) => OPE_int,
	R => R_LU,
	CY => CY_int
	);
	
UMUX: MUX port map(
	A => R_AU,
	B => R_LU,
	S => OPC_int,
	Y => Y_MUX
	);
	
UFlags: Flags port map(
    iOV => OV_int,
	 iCB => CBo_int,
	 OP => OPF_int,
	 R => Y_MUX,
	 CY => CY_int,
    BE => BE,
	 GE => GE,
	 Z => Z,
	 oOV => OV,
	 oCB => CBo
    );		
		
R <= Y_MUX;
  
end structural; 	 	
	
	