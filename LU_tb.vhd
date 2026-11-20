library ieee;
use ieee.std_logic_1164.all;

entity LU_tb is
end LU_tb;

architecture tb_LU of LU_tb is
component LU is
port(
--Input ports	
	A : in std_logic_vector(3 downto 0); 
	B : in std_logic_vector(3 downto 0);
	S : in std_logic_vector(1 downto 0);
--Output ports
	R : out std_logic_vector(3 downto 0);
	CY : out std_logic
	);
	end component;
	
	signal A, B, R : std_logic_vector(3 downto 0);
	signal S : std_logic_vector(1 downto 0);
	signal CY : std_logic;

	begin
	
	UUT: LU port map(A => A, B => B, S => S, R => R, CY => CY);
		
	process
	begin
	--todos os vetores de teste foram tiradas das diretamente das operaçoes da tabela do enunciado	
	
		-- #16 
		A <= "0001";  --N(1); Z(+1)       
		B <= "1100";  --N(12); Z(-4) 
		S <= "00";	  -- AND NOT    
		wait for 10 ns; --R = "0001"(1); R(Z) = +1 ; CY = -(dont care)
		
		-- #17 
		A <= "1101";  --N(13); Z(-3)       
		B <= "1001";  --N(9); Z(-7) 
		S <= "00";	  -- AND NOT    
		wait for 10 ns; --R = "0100"(4); R(Z) = +4 ; CY = -
		
		-- #18 
		A <= "1010";  --N(10); Z(-6)       
		B <= "1110";  --N(14); Z(-2) 
		S <= "01";	  -- NAND       --A.B = "1010" NOT(A:B) = "0101" 
		wait for 10 ns; --R = "0101"(5); R(Z) = +5 ; CY = -
		
		-- #19 
		A <= "1001";  --N(9); Z(-7)       
		B <= "0110";  --N(6); Z(+6)    --"10", deslocamento de 2 bits
		S <= "10";	  -- LSL    
		wait for 10 ns; --R = "0100"(4); R(Z) = +4 ; CY = 0 : o bitA(2) (4 - 2 = 2) = 0
		
		-- #20 
		A <= "1111";  --N(15); Z(-1)       
		B <= "0000";  --Aqui o B nao importa, pois nao entra na operacao, ent fica a 0
		S <= "11";	  -- ASR    
		wait for 10 ns; --R = "1111"(15); R(Z) = -1 ; CY = 1 : o ultimo bit a sair (A(0)) = 1
		
		-- #23 
		A <= "1000";  --N(8); Z(-8)       
		B <= "1101";  --N(13); Z(-3)   --"01", deslocamento de 1 bit
		S <= "10";	  -- LSL    
		wait for 10 ns; --R = "0000"(0); R(Z) = 0 ; CY = 1 : o bitA(3) (4 - 1 = 3) = 1
		
		-- #24 
		A <= "1011";  --N(11); Z(-5)       
		B <= "0100";  --N(4); Z(+4)   --"00", deslocamento de 0 bit
		S <= "10";	  -- LSL    
		wait for 10 ns; --R = "1011"(11); R(Z) = -5 ; CY = 0 deslocamento de 0 bits nada muda ent 0
		
		wait;
	end process;
	
	end tb_LU;
		
