library ieee;
use ieee.std_logic_1164.all;

entity Flags is
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
end Flags;

architecture structural of Flags is

signal Z_int: std_logic; --Z intermedio para usar no BE 

begin
Z_int <= not(R(0) or R(1) or R(2) or R(3)); --o Z diz se o todos os bits do resultado sao 0, entao num OR entre todos os bits so da zero se todos forem 0, pq basta 1 ser diferente que ja nao e 0
BE <= iCB or Z_int; --numa subtracao se (A < B) entao vai haver BORROW e (A = B) se o resultado for 0, entao a flag BE = BORROW ou Z(0).
GE <= (not(R(3)) and not iOV) or (R(3) and iOV); --uma subtracao A > B quando o resultado nao negativo, o que se observa pelo ultimo bit(bit de sinal) do resultado(R(3)), porem o OV entra em jogo aqui pois se for 0 nada muda, mas se for 1 o R(3) esta invertido
Z <= Z_int;
oOV <= iOV;   --o modulo da AU ja tem uma componente de flags que diz OV e CB, entao essas duas flags vao entrar nas flags da ALU e o top level simplemente vai colocar na saida do circuito
oCB <= (not OP and iCB) or (OP and CY);   --se OPF = 0, sai o CB da AU ; OPF = 1 sai o CY da LU

end structural; 