library ieee;
use ieee.std_logic_1164.all;

entity MUX is
port(
--Input ports
	A : in std_logic_vector(3 downto 0); -- A é 4 bits
	B : in std_logic_vector(3 downto 0); -- B é 2 bits
	S : in std_logic;  -- selector
-- Output ports
	Y : out std_logic_vector(3 downto 0)  -- R(saida) é 4 bits
	);
	end MUX;
	
architecture structural of MUX is
begin
Y(0) <= (not S	and A(0)) or (S and B(0));
Y(1) <= (not S	and A(1)) or (S and B(1));
Y(2) <= (not S	and A(2)) or (S and B(2));
Y(3) <= (not S	and A(3)) or (S and B(3));

end structural;