library ieee;
use ieee.std_logic_1164.all;

entity mANDNOT is
port(
--Input ports
	A : in std_logic_vector(3 downto 0); --A é 4 bits
	B : in std_logic_vector(3 downto 0); --B é 4 bits
-- Output ports
	R : out std_logic_vector(3 downto 0) --R é 4 bits
	);
	end mANDNOT;

architecture structural of mANDNOT is
begin
R(0) <= A(0) and not B(0);
R(1) <= A(1) and not B(1);
R(2) <= A(2) and not B(2);
R(3) <= A(3) and not B(3);

end structural;