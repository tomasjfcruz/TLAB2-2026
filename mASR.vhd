library ieee;
use ieee.std_logic_1164.all;

entity mASR is
port(
--Input ports
	A : in std_logic_vector(3 downto 0); -- A é 4 bits
-- Output ports
	R : out std_logic_vector(3 downto 0);  -- R(saida) é 4 bits
	CY : out std_logic --saida para as flags
	);
	end mASR;	
	
	
architecture structural of mASR is
begin
R(0) <= A(1);  -- em ASR, bit R(i) = o bit a esquerda, ent o R(0) = R(1) porque os bits foram deslocados uma unidade para a direita
R(1) <= A(2); 
R(2) <= A(3);
R(3) <= A(3);  -- em ASR, o ultimo bit do resultado = sempre ao ultimo bit do A = A(3) 
CY <= A(0);   --CY = X0, no caso deste ficheiro = A(0)

end structural; 	