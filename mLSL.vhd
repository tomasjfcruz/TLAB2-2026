library ieee;
use ieee.std_logic_1164.all;

entity mLSL is
port(
--Input ports
	A : in std_logic_vector(3 downto 0); -- A é 4 bits
	B : in std_logic_vector(1 downto 0); -- B é 2 bits
-- Output ports
	R : out std_logic_vector(3 downto 0);  -- R(saida) é 4 bits
	CY : out std_logic --saida para as flags
	);
	end mLSL;	
	
architecture structural of mLSL is
begin
R(0) <= A(0) and not B(0) and not B(1);  --R(0)
R(1) <= (A(1) and not B(1) and not B(0)) or (A(0) and not B(1) and B(0)); --R(1)
R(2) <= (A(2) and not B(1) and not B(0)) or (A(1) and not B(1) and B(0)) or (A(0) and B(1) and not B(0)); --R(2)
R(3) <= (A(3) and not B(1) and not B(0)) or (A(2) and not B(1) and B(0)) or (A(1) and B(1) and not B(0)) or (A(0) and B(1) and B(0)); --R(3)
CY <= (A(3) and not B(1) and B(0)) or (A(2) and B(1) and not B(0)) or (A(1) and B(1) and B(0));
--CY -> Y1(01) = X3(A3) ; Y2(10) = X2(A2) ; Y3(11) = X1(A1) 

end structural;