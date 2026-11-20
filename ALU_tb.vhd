library ieee;
use ieee.std_logic_1164.all;

entity ALU_tb is
end ALU_tb;

architecture tb_ALU of ALU_tb is
component ALU is
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
	end component;
	
	signal X : std_logic_vector(3 downto 0);
	signal Y : std_logic_vector(3 downto 0);
	signal CBi : std_logic;
	signal OP : std_logic_vector(2 downto 0);
	signal R : std_logic_vector(3 downto 0);
	signal BE: std_logic;
	signal GE: std_logic;
	signal Z: std_logic;
	signal OV: std_logic;
	signal CBo: std_logic;

	begin
	
	UUT: ALU port map(X => X, Y => Y, CBi => CBi, OP => OP, R => R, BE => BE, GE => GE, Z => Z, OV => OV, CBo => CBo);
	
	process
	begin
--todos os vetores de teste foram tiradas das diretamente das operaçoes da tabela do enunciado	
			-- #1
        X <= "0000";  --N(0) Z(0)    
        Y <= "1111";  --N(15) Z(-1)   
        CBi <= '0';        
        OP <= "000";      
        wait for 10 ns;   -- R = "1111"(15), R(Z) = -1, OV = 0, CBo = 0, BE = -, GE = -, Z = 0
         
        -- #2
        X <= "0000"; --N(0) Z(0)    
        Y <= "1111"; --N(15) Z(-1)    
        CBi <= '1';   -- 15 + 1 = 16 ; 16 - 16 = 0 ; 0 - 1 + 1 = 0         
        OP <= "000";      
        wait for 10 ns; --R = "0000"(0), R(Z) = 0 , OV = 0, CBo = 1, BE = -, GE -, Z = 1

        -- #3
        X <= "0010";     -- N(2), Z(2)
        Y <= "0101";     -- N(5), Z(5)
        CBi <= '1';      -- 7 + 1 = 8
        OP <= "000";     -- Adição
        wait for 10 ns;  -- R = "1000"(8), R(-8), OV = 1, CBo = 0, BE = -, GE = -, Z = 0 

        -- #4
        X <= "1111";     -- N(15), Z(-1)       -
        Y <= "1010";     -- N(10), Z(-6)
        CBi <= '1';      -- 9 + 1 = 10   -- -7 + 1 = -6
        OP <= "000";     -- Adição
        wait for 10 ns;  -- R(2) = "1010"(10), R(Z) = -6 , OV = 0, CBo = 1, BE = -, GE =-, Z = 0

        -- #5 		
        X <= "0000"; -- N(0), Z(0)
        Y <= "1111"; -- N(15), Z(-1) 
        CBi <= '1';   --  -1 + 1 = 0
        OP <= "001";    -- Subtração
        wait for 10 ns; -- R = "0000"(0) , R(Z) = 0, OV = 0, CBo = 1, BE = 1, GE = 1, Z = 1

        -- #6
        X <= "0001";  -- N(1), Z(1)
        Y <= "0101";  --N(5), Z(5) 
        CBi <= '1';   -- -4 - 1 = -5
        OP <= "001";     -- Subtração
        wait for 10 ns;  -- R = "1011"(11), R(Z) = -5, OV = 0, CBo = 1, BE = 1, GE = 0, Z = 0

        -- #7
        X <= "0010";  -- N(2), Z(2)         X -(-6) - 1 = 7 <=> X + 6 - 1 = 7 <=> X = 7 - 6 + 1 = 2  
        Y <= "1010";  -- N(10), Z(-6)
        CBi <= '1';   -- -8 - 1 = - 9 ; 16 - 9 = 7     2 + 6 - 1 = 7
        OP <= "001";     -- Subtracao
        wait for 10 ns;  -- R = "0111"(7), R(Z) = 7, OV = 0, CBo = 1, BE = 1, GE = 1, Z = 0
		 
		  -- #8
		  X <= "1111";  --nas operacoes com o Xor0 ativo, o X = 0, ent o valor a ser testado nao importa pq vai ser sempre convertido a 0 
        Y <= "1111";  -- N(15), Z(-1)
        CBi <= '0';   -- -- 15 + 0 = 15
        OP <= "010";     -- adicao
        wait for 10 ns;  -- R = "1111"(15), R(Z) = -1, OV = 0, CBo = 0, BE = - , GE = - , Z = 0
		  
		  -- #9
		  X <= "1111";  
        Y <= "0001";  -- N(1), Z(1)
        CBi <= '1';   -- -- 1 + 1 = 2
        OP <= "010";     -- adicao
        wait for 10 ns;  -- R = "0010"(2), R(Z) = 2, OV = 0, CBo = 0, BE = - , GE = - , Z = 0
		 
		  -- #10
		  X <= "1111";  
        Y <= "0111";  -- N(7), Z(7)
        CBi <= '1';   -- -- 7 + 1 = 8
        OP <= "010";     -- adicao
        wait for 10 ns;  --R = "1000"(8), R(Z) = -8, OV = 1, CBo = 0, BE = -, GE = - , Z = 0 
		  
		  -- #11	
		  X <= "1111";  
        Y <= "1111";  -- N(15), Z(-1)
        CBi <= '1';   -- -- 15 + 1 = 16 ; 16 - 16 = 0 ; -1 + 1 = 0
        OP <= "010";     -- adicao
        wait for 10 ns;  --R = "0000"(0), R(Z) = 0, OV = 0, CBo = 1, BE = -, GE = - , Z = 1
		  
		  -- #12	
		  X <= "1111";  
        Y <= "0000";  -- N(0), Z(0)
        CBi <= '0';   -- --  0 - 0 - 0 = 0 
        OP <= "011";     -- subtracao
        wait for 10 ns;  --R = "0000"(0), R(Z) = 0, OV = 0, CBo = 0, BE = -, GE = -, Z = 1
		  
		  -- #13	
		  X <= "1111";  
        Y <= "1000";  -- N(8), Z(-8)
        CBi <= '0';   -- 0 - 8 - 0 = -8  ;  0 - (-8) - 0 = 8
        OP <= "011";     -- subtracao
        wait for 10 ns;  --R = "1000"(8), R(Z) = -8, OV = 1, CBo = 1, BE = - , GE = - , Z = 0
		  
		  -- #14	
		  X <= "1111";  
        Y <= "0110";  -- N(6), Z(6)
        CBi <= '1';   -- 0 - 6 - 1 = -7  ;  0 - 6 - 1 = -7
        OP <= "011";     -- subtracao
        wait for 10 ns;  --R = "1001"(9), R(Z) = -7, OV = 0, CBo = 1, BE = -, GE = -, Z = 0
		  
		  -- #15	
		  X <= "1111";     
        Y <= "0111";  -- 0 - Y - 1 = 8 <=> Y = -9  16 - 9 = 7  Y = 7 ; 0 - Y - 1 = -8 <=> Y = 7
        CBi <= '1';   --  0 - 7 - 1 = -8      
        OP <= "011";     -- subtracao
        wait for 10 ns;  --R = "1000"(8), R(Z) = -8, OV = 0, CBo = 1, BE = - , GE = - , Z = 0
		  
		  -- #16 
		X <= "0001";  --N(1); Z(+1)       
		Y <= "1100";  --N(12); Z(-4) 
		CBi <= '1'; 
		OP <= "100";	  -- AND NOT    
		wait for 10 ns; --R = "0001"(1); R(Z) = +1 ; OV = - , CBo = - , BE = - , GE = - , Z = 0
		
		-- #17 
		X <= "1101";  --N(13); Z(-3)       
		Y <= "1001";		--N(9); Z(-7)
	   CBi <= '0';	
		OP <= "100";	  -- AND NOT    
		wait for 10 ns; --R = "0100"(4); R(Z) = +4 ; OV = - , CBo = - , BE = - , GE = - , Z = 0
		
		-- #18 
		X <= "1010";  --N(10); Z(-6)       
		Y <= "1110";  --N(14); Z(-2) 
		CBi <= '0';
		OP <= "101";	  -- NAND       --A.B = "1010" NOT(A:B) = "0101" 
		wait for 10 ns; --R = "0101"(5); R(Z) = +5 ; OV = - , CBo = - , BE = - , GE = - , Z = 0
		
		-- #19 
		X <= "1001";  --N(9); Z(-7)       
		Y <= "0110";  --N(6); Z(+6)    --"10", deslocamento de 2 bits
		CBi <= '0';
		OP <= "110";	  -- LSL    
		wait for 10 ns; --R = "0100"(4); R(Z) = +4 ; OV =  - , CBo = 0, BE = - , GE = - , Z = 0 
		
		-- #20 
		X <= "1111";  --N(15); Z(-1)       
		Y <= "0000";  --Aqui o B nao importa, pois nao entra na operacao, ent fica a 0
		Cbi <= '1';
		OP <= "111";	  -- ASR    
		wait for 10 ns; --R = "1111"(15); R(Z) = -1 ; OV = -,  CBo = 1, BE = -, GE = -, Z = 0
		
		  --#21
		  X <= "0111";  --N(7), Z(+7) 
		  Y <= "1000";  --N(8) , Z(-8)
		  CBi <= '0';   -- 7 - 8 = -1 ; 7 - (-8) = 15,  15 - 16 = -1
		  OP <= "001";
		  wait for 10 ns; --R = "1111"(15), R(Z) = -1 ; OV = 1; CBo = 1, BE = 1, GE = 1, Z = 0
		  
		  --#22
		  X <= "1000";  --N(8), Z(-8) 
		  Y <= "0000";  --N(0) , Z(0)
		  CBi <= '1';   -- 8 - 1 = 7 ; -8 - 1 = -9, 16 - 9 = 7
		  OP <= "001";
		  wait for 10 ns; --R = "0111"(7), R(Z) = +7 ; OV = 1; CBo = 0, BE = 0, GE = 0, Z = 0
		  
		  -- #23 
		X <= "1000";  --N(8); Z(-8)       
		Y <= "1101";  --N(13); Z(-3)   --"01", deslocamento de 1 bit
		CBi <= '0';
		OP <= "110";	  -- LSL    
		wait for 10 ns; --R = "0000"(0); R(Z) = 0; OV = - , CBo = 1, BE = - , GE = - , Z = 1 
		
		-- #24 
		X <= "1011";  --N(11); Z(-5)       
		Y <= "0100";  --N(4); Z(+4)   --"00", deslocamento de 0 bit
		CBi <= '1';
		Op <= "110";	  -- LSL    
		wait for 10 ns; --R = "1011"(11); R(Z) = -5; OV = -, CBo = 0, BE = - , GE = - , Z = 0 
		  
        wait;
    end process;
	
	end tb_ALU;