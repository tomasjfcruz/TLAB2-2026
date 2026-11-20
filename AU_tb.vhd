library ieee;
use ieee.std_logic_1164.all;

entity AU_tb is
end AU_tb;

architecture tb_AU of AU_tb is
component AU is
port(
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
	
	signal A : std_logic_vector(3 downto 0);
	signal B : std_logic_vector(3 downto 0);
	signal CBi : std_logic;
	signal Opau : std_logic;
	signal R : std_logic_vector(3 downto 0);
	signal OV: std_logic;
	signal CBo: std_logic;

	begin
	
	UUT: AU port map(A => A, B => B, CBi => CBi, Opau => Opau, R => R, OV => OV, CBo => CBo);
	
	process
	begin
--todos os vetores de teste foram tiradas das diretamente das operaçoes da tabela do enunciado	
			-- #1
        A <= "0000";  --N(0) Z(0)    
        B <= "1111";  --N(15) Z(-1)   
        CBi <= '0';        
        Opau <= '0';      
        wait for 10 ns;   -- R = "1111"(15), R(Z) = -1, OV = 0, CBo = 0
         
        -- #2
        A <= "0000"; --N(0) Z(0)    
        B <= "1111"; --N(15) Z(-1)    
        CBi <= '1';   -- 15 + 1 = 16 ; 16 - 16 = 0 ; 0 - 1 + 1 = 0         
        Opau <= '0';      
        wait for 10 ns; --R = "0000"(0), R(Z) = 0 , OV = 0, CBo = 1

        -- #3
        A <= "0010";     -- N(2), Z(2)
        B <= "0101";     -- N(5), Z(5)
        CBi <= '1';      -- 7 + 1 = 8
        Opau <= '0';     -- Adição
        wait for 10 ns;  -- R = "1000"(8), R(-8), OV = 1, CBo = 0

        -- #4
        A <= "1111";     -- N(15), Z(-1)       -
        B <= "1010";     -- N(10), Z(-6)
        CBi <= '1';      -- 9 + 1 = 10   -- -7 + 1 = -6
        Opau <= '0';     -- Adição
        wait for 10 ns;  -- R(2) = "1010"(10), R(Z) = -6 , OV = 0, CBo = 1

        -- #5 		
        A <= "0000"; -- N(0), Z(0)
        B <= "1111"; -- N(15), Z(-1) 
        CBi <= '1';   --  -1 + 1 = 0
        Opau <= '1';    -- Subtração
        wait for 10 ns; -- R = "0000"(0) , R(Z) = 0, OV = 0, CBo = 1

        -- #6
        A <= "0001";  -- N(1), Z(1)
        B <= "0101";  --N(5), Z(5) 
        CBi <= '1';   -- -4 - 1 = -5
        Opau <= '1';     -- Subtração
        wait for 10 ns;  -- R = "1011"(11), R(Z) = -5, OV = 0, CBo = 1

        -- #7
        A <= "0010";  -- N(2), Z(2)         X -(-6) - 1 = 7 <=> X + 6 - 1 = 7 <=> X = 7 - 6 + 1 = 2  
        B <= "1010";  -- N(10), Z(-6)
        CBi <= '1';   -- -8 - 1 = - 9 ; 16 - 9 = 7     2 + 6 - 1 = 7
        Opau <= '1';     -- Subtracao
        wait for 10 ns;  -- R = "0111"(7), R(Z) = 7, OV = 0, CBo = 1
		  
		  --Apesar de a AU nao ter o Xor0, colocar o A todo a 0 vai  dar ao mesmo
		  --Assim basta usar o Opau como 0(adicao) ou 1(subtracao), dando 0 Y + CBi e o Y - CBi
		  
		  -- #8
		  A <= "0000";  
        B <= "1111";  -- N(15), Z(-1)
        CBi <= '0';   -- -- 15 + 0 = 15
        Opau <= '0';     -- adicao
        wait for 10 ns;  -- R = "1111"(15), R(Z) = -1, OV = 0, CBo = 0
		  
		  -- #9
		  A <= "0000";  
        B <= "0001";  -- N(1), Z(1)
        CBi <= '1';   -- -- 1 + 1 = 2
        Opau <= '0';     -- adicao
        wait for 10 ns;  -- R = "0010"(2), R(Z) = 2, OV = 0, CBo = 0
		 
		  -- #10
		  A <= "0000";  
        B <= "0111";  -- N(7), Z(7)
        CBi <= '1';   -- -- 7 + 1 = 8
        Opau <= '0';     -- adicao
        wait for 10 ns;  --R = "1000"(8), R(Z) = -8, OV = 1, CBo = 0
		  
		  -- #11	
		  A <= "0000";  
        B <= "1111";  -- N(15), Z(-1)
        CBi <= '1';   -- -- 15 + 1 = 16 ; 16 - 16 = 0 ; -1 + 1 = 0
        Opau <= '0';     -- adicao
        wait for 10 ns;  --R = "0000"(0), R(Z) = 0, OV = 0, CBo = 1
		  
		  -- #12	
		  A <= "0000";  
        B <= "0000";  -- N(0), Z(0)
        CBi <= '0';   -- --  0 - 0 - 0 = 0 
        Opau <= '1';     -- subtracao
        wait for 10 ns;  --R = "0000"(0), R(Z) = 0, OV = 0, CBo = 0
		  
		  -- #13	
		  A <= "0000";  
        B <= "1000";  -- N(8), Z(-8)
        CBi <= '0';   -- 0 - 8 - 0 = -8  ;  0 - (-8) - 0 = 8
        Opau <= '1';     -- subtracao
        wait for 10 ns;  --R = "1000"(8), R(Z) = -8, OV = 1, CBo = 1
		  
		  -- #14	
		  A <= "0000";  
        B <= "0110";  -- N(6), Z(6)
        CBi <= '1';   -- 0 - 6 - 1 = -7  ;  0 - 6 - 1 = -7
        Opau <= '1';     -- subtracao
        wait for 10 ns;  --R = "1001"(9), R(Z) = -7, OV = 0, CBo = 1
		  
		  -- #15	
		  A <= "0000";     
        B <= "0111";  -- 0 - Y - 1 = 8 <=> Y = -9  16 - 9 = 7  Y = 7 ; 0 - Y - 1 = -8 <=> Y = 7
        CBi <= '1';   --  0 - 7 - 1 = -8      
        Opau <= '1';     -- subtracao
        wait for 10 ns;  --R = "1000"(8), R(Z) = -8, OV = 0, CBo = 1
		  
		  --#21
		  A <= "0111";  --N(7), Z(+7) 
		  B <= "1000";  --N(8) , Z(-8)
		  CBi <= '0';   -- 7 - 8 = -1 ; 7 - (-8) = 15,  15 - 16 = -1
		  Opau <= '1';
		  wait for 10 ns; --R = "1111"(15), R(Z) = -1 ; OV = 1; CBo = 1
		  
		  --#22
		  A <= "1000";  --N(8), Z(-8) 
		  B <= "0000";  --N(0) , Z(0)
		  CBi <= '1';   -- 8 - 1 = 7 ; -8 - 1 = -9, 16 - 9 = 7
		  Opau <= '1';
		  wait for 10 ns; --R = "0111"(7), R(Z) = +7 ; OV = 1; CBo = 0
		  
        wait;
    end process;
	
	end tb_AU;