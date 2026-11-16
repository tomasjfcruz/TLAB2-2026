library ieee;
use ieee.std_logic_1164.all;

entity DecodeOP is
	port
	(
	--input ports
	OP0 : in std_logic;
	OP1 : in std_logic;
	OP2 : in std_logic;
	--output ports
	OPA : out std_logic;
	OPB : out std_logic;
	OPC : out std_logic;
	OPD : out std_logic;
	OPE : out std_logic;
	OPF : out std_logic
	);
end DecodeOp;

architecture structural of DecodeOP is
begin

OPA <= OP1;     --OPA = entrada de Xor2, o que define se a operacao precisa ou nao deste bloco = so o OP1
OPB <= OP0;     --so o OP0 que define se = adicao ou subtracao pois o OP1 ja define as operacos com o Xor0, e o OP2 nao importa
OPC <= OP2;     --OPC = MUX entre AU e LU, oq define se a operacao = AU ou LU -> OP2, ent o OPC = OP2
OPD <= OP0;     --OPD = primeiro bit(bit 0) do S(S0) ent vai ser so o OP0
OPE <= OP1;     --OPE mesma situacao que o OPD mas define para o S1
OPF <= OP2;     --OPF = entrada nas flags, decide se vai defeinir as flags da AU ou LU, ent como o OPC e o OP2 que define pois este escolhe entre a AU ou a LU

end structural;

	