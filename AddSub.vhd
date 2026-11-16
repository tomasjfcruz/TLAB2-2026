library ieee;
use ieee.std_logic_1164.all;

entity AddSub is
    port
    (
    A : in std_logic_vector(3 downto 0);
    B : in std_logic_vector(3 downto 0);
	 AUOp : in std_logic;
	 CBi : in std_logic;	
    S : out std_logic_vector(3 downto 0);
    Co : out std_logic;
	 B3_out : out std_logic   --para ligar ás flags
    );
end AddSub;

architecture structural of AddSub is
component FA is
    port
    (
    A : in std_logic;
    B : in std_logic;
    Ci : in std_logic;
    S : out std_logic;
    Co : out std_logic
    );
end component;

signal carry : std_logic_vector(3 downto 1);
signal B_xor : std_logic_vector(3 downto 0);
signal CO_in : std_logic;
signal C4 : std_logic;

begin

B_xor(0) <= B(0) xor AUOp;
B_xor(1) <= B(1) xor AUOp;
B_xor(2) <= B(2) xor AUOp;
B_xor(3) <= B(3) xor AUOp;

CO_in <= CBi xor AUOp;

U1 : FA port map ( A => A(0), B => B_xor(0), Ci => CO_in, S => S(0), Co => carry(1));
U2 : FA port map ( A => A(1), B => B_xor(1), Ci => carry(1), S => S(1), Co => carry(2));
U3 : FA port map ( A => A(2), B => B_xor(2), Ci => carry(2), S => S(2), Co => carry(3));
U4 : FA port map ( A => A(3), B => B_xor(3), Ci => carry(3), S => S(3), Co => C4);

B3_out <= B_xor(3);  --liga o xor do B3 e o AUOp numa saida para as flags 
Co <= C4 xor AUOp; 

end structural;