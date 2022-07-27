library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity topo is
	port(SW: in std_logic_vector(3 downto 0);
		CLOCK_50: in std_logic;
		KEY: in std_logic_vector(2 downto 0);
		HEX0, HEX1, HEX2: out std_logic_vector(6 downto 0);
		LEDR: out std_logic_vector(17 downto 0));
end topo;

architecture comp of topo is

component bloco_operativo
	port(DATA: in std_logic_vector(3 downto 0);
       CLK, CLEAR: in std_logic;
		 EN1, EN2, EN3: in std_logic;
		 ENS1, ENS2, ENS3: in std_logic;
		 CMD_PISCA_LED: in std_logic;
		 LED_SENHA_ERRADA: out std_logic;
		 STATUS_SENHA: out std_logic;
		 DISPLAY1, DISPLAY2, DISPLAY3: out std_logic_vector(6 downto 0));
end component;

component bloco_de_controle
	port(STATUS_SENHA: in std_logic;
       INICIO: in std_logic;
		 OK: in std_logic;
		 MUDA_SENHA: in std_logic;
		 CLK: in std_logic;
		 EN1, EN2, EN3: OUT std_logic;
		 ENS1, ENS2, ENS3: OUT std_logic;
		 CMD_PISCA_LED: OUT std_logic;
		 CLEAR: OUT std_logic;
		 saida: out std_logic_vector(3 downto 0));
end component;

component comparador
		generic(N: integer := 4); 
		port(A, B: in std_logic_vector(N-1 downto 0);
       Y: out std_logic);
end component;

component decod_7seg
		port(x: in std_logic_vector(3 downto 0);
		 y: out std_logic_vector(6 downto 0));
end component;

component divisorFrequencia
		generic(freqIn : integer := 50000000;
	       freqOut : integer := 1);
		port(clockIn : in std_logic;
	    clockOut: out std_logic);
end component;

component reg
		generic(N: integer := 4;
          D0: integer := 0);
			 
		port(D: in std_logic_vector(N-1 downto 0);
       EN, CLEAR, CLK: in std_logic;
		 Q: out std_logic_vector(N-1 downto 0));
end component;

component sinalizador
		port(EN, CLK: in std_logic;
       Y: out std_logic);
end component;

signal F_COUT, F_EN1, F_EN2, F_EN3, F_ENS1, F_ENS2, F_ENS3, F_CPLED, F_CLEAR, F_STATUSSENHA: std_logic;

begin
	L0: divisorFrequencia generic map(50000000, 1000) port map(CLOCK_50, F_COUT);
	L1: bloco_operativo port map(SW(3 downto 0), F_COUT, F_CLEAR, F_EN1, F_EN2, F_EN3, F_ENS1, F_ENS2, F_ENS3, F_CPLED, LEDR(0), F_STATUSSENHA, HEX0(6 downto 0), HEX1(6 downto 0), HEX2(6 downto 0));
	L2: bloco_de_controle port map(F_STATUSSENHA, not KEY(0), not KEY(1), not KEY(2), F_COUT, F_EN1, F_EN2, F_EN3, F_ENS1, F_ENS2, F_ENS3, F_CPLED, F_CLEAR, LEDR(17 downto 14));
	
	LEDR(1) <= F_STATUSSENHA;
	
end comp;