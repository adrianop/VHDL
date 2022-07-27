library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bloco_de_controle is

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
end bloco_de_controle;

ARCHITECTURE estrutura OF bloco_de_controle IS

TYPE tipo_estado IS (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15);
SIGNAL estado: tipo_estado;

BEGIN
	
	PROCESS(CLK)
	
	begin
	
		IF(CLK'EVENT AND CLK='1') THEN
			CASE ESTADO IS 
				WHEN S0 => 
					EN1<='0';
					EN2<='0';
					EN3<='0';
					ENS1<='0';
					ENS2<='0';
					ENS3<='0';
					CMD_PISCA_LED<='0';
					CLEAR<='1';
					saida <= "0000";
					if(INICIO='1') then
						estado <= S1;
					end if;
				
				WHEN S1 => 
					EN1<='0';
					EN2<='0';
					EN3<='0';
					ENS1<='0';
					ENS2<='0';
					ENS3<='0';
					CMD_PISCA_LED<='0';
					CLEAR<='1' ;
					saida <= "0001";
					if(OK='1') then
						estado <= S2;
					end if;
					
					
				
				WHEN S2 => 
					EN1<='1';
					EN2<='0';
					EN3<='0';
					ENS1<='0';
					ENS2<='0';
					ENS3<='0';
					CMD_PISCA_LED<='0';
					CLEAR<='0';
					saida <= "0010";
					if(OK='0') then
						estado <= S3;
					end if;
					if(INICIO='1') then
						estado <= S1;
					end if;
					
				
				WHEN S3 => 
					EN1<='0';
					EN2<='0';
					EN3<='0';
					ENS1<='0';
					ENS2<='0';
					ENS3<='0';
					CMD_PISCA_LED<='0';
					CLEAR<='0'; 
					saida <= "0011";
					if(OK='1') then
						estado <= S4;
					end if;
					if(INICIO='1') then
						estado <= S1;
					end if;
				
				WHEN S4 => 
					EN1<='0';
					EN2<='1';
					EN3<='0';
					ENS1<='0';
					ENS2<='0';
					ENS3<='0';
					CMD_PISCA_LED<='0';
					CLEAR<='0'; 
					saida <= "0100";
						if(OK='0') then
						estado <= S5;
					end if;
					if(INICIO='1') then
						estado <= S1;
					end if;
					
				WHEN S5 => 
					EN1<='0';
					EN2<='0';
					EN3<='0';
					ENS1<='0';
					ENS2<='0';
					ENS3<='0';
					CMD_PISCA_LED<='0';
					CLEAR<='0'; 
					saida <= "0101";
					if(OK='1') then
						estado <= S6;
					end if;
					if(INICIO='1') then
						estado <= S1;
					end if;
					
				WHEN S6 => 
					EN1<='0';
					EN2<='0';
					EN3<='1';
					ENS1<='0';
					ENS2<='0';
					ENS3<='0';
					CMD_PISCA_LED<='0';
					CLEAR<='0'; 
					saida <= "0110";
						if(OK='0') then
						estado <= S7;
					end if;
					if(INICIO='1') then
						estado <= S1;
					end if;
					
				
				WHEN S7 => 
					EN1<='0';
					EN2<='0';
					EN3<='0';
					ENS1<='0';
					ENS2<='0';
					ENS3<='0';
					CMD_PISCA_LED<='0';
					CLEAR<='0'; 
					saida <= "0111";
					if(STATUS_SENHA='0') then
						estado <= S8;
					ELSIF(STATUS_SENHA='1') then
						estado <= S9;
					end if;
					if(INICIO='1') then
						estado <= S1;
					end if;
				
				WHEN S8 => 
					EN1<='0';
					EN2<='0';
					EN3<='0';
					ENS1<='0';
					ENS2<='0';
					ENS3<='0';
					CMD_PISCA_LED<='1';
					CLEAR<='0'; 
					saida <= "1000";
					if(OK='1') then
						estado <= S0;
					end if;
								
				
				WHEN S9 => 
					EN1<='0';
					EN2<='0';
					EN3<='0';
					ENS1<='0';
					ENS2<='0';
					ENS3<='0';
					CMD_PISCA_LED<='0';
					CLEAR<='0';
					saida <= "1001";
					if(INICIO='1') then
						estado <= S1;
					ELSIF(MUDA_SENHA='1') then
						estado <= S10;
					ELSIF(OK='1') then
						estado<= s0;
					end if;
				
				WHEN S10 => 
					EN1<='0';
					EN2<='0';
					EN3<='0';
					ENS1<='0';
					ENS2<='0';
					ENS3<='0';
					CMD_PISCA_LED<='0';
					CLEAR<='0'; 
					saida <= "1010";
					if(OK='1') then
						estado <= S11;
					end if;
					if(INICIO='1') then
						estado <= S1;
					end if;
				
				WHEN S11 => 
					EN1<='1';
					EN2<='0';
					EN3<='0';
					ENS1<='1';
					ENS2<='0';
					ENS3<='0';
					CMD_PISCA_LED<='0';
					CLEAR<='0'; 
					saida <= "1011";
					
					if(INICIO='1') then
						estado <= S1;
					end if;
				
					if(OK='0') then
						estado <= S12;
					end if;
				
				WHEN S12	 => 
					EN1<='0';
					EN2<='0';
					EN3<='0';
					ENS1<='0';
					ENS2<='0';
					ENS3<='0';
					CMD_PISCA_LED<='0';
					CLEAR<='0';
					saida <= "1100";	
					if(OK='1') then
						estado <= S13;
					end if;
					if(INICIO='1') then
						estado <= S1;
					end if;
				
				WHEN S13 => 
					EN1<='0';
					EN2<='1';
					EN3<='0';
					ENS1<='0';
					ENS2<='1';
					ENS3<='0';
					CMD_PISCA_LED<='0';
					CLEAR<='0'; 
					saida <= "1101";
					if(OK='0') then
						estado <= S14;
					end if;
					if(INICIO='1') then
						estado <= S1;
					end if;
				
				WHEN S14	 => 
					EN1<='0';
					EN2<='0';
					EN3<='0';
					ENS1<='0';
					ENS2<='0';
					ENS3<='0';
					CMD_PISCA_LED<='0';
					CLEAR<='0'; 
					saida <= "1110";
					if(OK='1') then
						estado <= S15;
					end if;
					if(INICIO='1') then
						estado <= S1;
					end if;
				
				WHEN S15 => 
					EN1<='0';
					EN2<='0';
					EN3<='1';
					ENS1<='0';
					ENS2<='0';
					ENS3<='1';
					CMD_PISCA_LED<='0';
					CLEAR<='0'; 
					saida <= "1111";
					if(OK='0') then
						estado <= S0;
					end if;
					
					
			END CASE;
		END IF;
	END PROCESS;
END estrutura;