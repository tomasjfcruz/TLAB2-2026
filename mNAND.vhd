library ieee;
use ieee.std_logic_1164.all;

entity mNAND is
port(
--Input ports
	A : in std_logic_vector(3 downto 0); --A é 4 bits
	B : in std_logic_vector(3 downto 0); --B é 4 bits
-- Output ports
	R : out std_logic_vector(3 downto 0) --R é 4 bits
	);
	end mNAND;

architecture structural of mNAND is
begin
R(0) <= A(0) nand B(0);
R(1) <= A(1) nand B(1);
R(2) <= A(2) nand B(2);
R(3) <= A(3) nand B(3);

end structural;