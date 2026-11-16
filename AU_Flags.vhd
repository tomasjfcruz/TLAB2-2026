library ieee;
use ieee.std_logic_1164.all;

entity AU_Flags is
    port
    (
    Am : in std_logic;
    Bm : in std_logic;
	 iCBo : in std_logic;
	 Rm : in std_logic;
    OV : out std_logic;
	 CBo : out std_logic	 
    );
end AU_Flags;

architecture structural of AU_Flags is
begin

OV <= (Am and Bm and not Rm) or (not Am and not Bm and Rm);
CBo <= iCBo;

end structural; 