----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:57:29 07/20/2021 
-- Design Name: 
-- Module Name:    lavarropas - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lavarropas is
    Port ( Clk : in  STD_LOGIC;
           I : in  STD_LOGIC;
           CodProg : in  STD_LOGIC_VECTOR (2 downto 0);
			  s0 : in std_logic;
			  s2 : in std_logic;
			  s3 : in std_logic;
--			  doneM : in std_logic;
           LL : out  STD_LOGIC;
           LE : out  STD_LOGIC;
           LC : out  STD_LOGIC;
           Tt : out  STD_LOGIC);
end lavarropas;

architecture Behavioral of lavarropas is

--estados posibles del lavarropas
type estado is (lavando,enjuagando,centrifugando,detenido);

--señales internas
signal Lav,Enj,Cen,doneL,doneE,doneC : std_logic;
signal estado_actual,estado_siguiente : estado;
--señales auxiliares
signal Il,Ie,Ic : std_logic;
--señales auxiliares lavado
signal Vlaux,Vjaux,Cvmaux,Cbaux,Vvaux,Vmotaux : std_logic;
--señales auxiliares enjuague
signal VlauxE,VsauxE,CvmauxE,CbauxE,VvauxE,VmotauxE : std_logic;
--señales auxiliares centrifugado
signal Cvmauxc,Cbauxc,Vvauxc,Vmotauxc : std_logic;
signal doneProgram : std_logic;

	COMPONENT lavado
	PORT(
		Clk,I,s0,s2,s3: IN std_logic;          
		Vl,Vj,Cvm,Cb,Vv,Vmot,Ll,LavHecho : OUT std_logic
		);
	END COMPONENT;
	COMPONENT enjuague
	PORT(
		Clk,I,s0,s2,s3: IN std_logic;          
		Vl,Vs,Cvm,Vmot,Cb,Vv,LE,EnjHecho : out std_logic
		);
	END COMPONENT;
	
	COMPONENT centrifugado
	PORT(
		Clk,I,s0: IN std_logic;          
		Cvm,Cb,Vv,Vmot,LC,CenHecho : OUT std_logic
		);
	END COMPONENT;

begin

Lav <= CodProg(0);
Enj <= CodProg(1);
Cen <= CodProg(2);

--instancia lavado
Inst_lavado: lavado PORT MAP(
	Clk => Clk,
	I => Il,
	s0 => s0,
	s2 => s2,
	s3 => s3,
	Vl => Vlaux,
	Vj => Vjaux,
	Cvm => Cvmaux,
	Cb => Cbaux,
	Vv => Vvaux,
	Vmot => Vmotaux,
	Ll => LL,
	LavHecho => doneL
);
--instancia enjuague
Inst_enjuague: enjuague PORT MAP(
	Clk => Clk,
	I => Ie,
	s0 => s0,
	s2 => s2,
	s3 => s3,
	Vl => vlauxe,
	Vs => vsauxe,
	Cvm => cvmauxe,
	Vmot => vmotauxe,
	Cb => cbauxe,
	Vv => vvauxe,
	LE => LE,
	EnjHecho => doneE
);
--instancia de centrifugado
Inst_centrifugado: centrifugado PORT MAP(
	Clk => Clk,
	I => Ic,
	s0 => s0,
	Cvm => cvmauxc,
	Cb => cbauxc,
	Vv => vvauxc,
	Vmot => vmotauxc,
	LC => LC,
	CenHecho => doneC
);

process(Clk,I)
begin
	if(I='0')then
		doneProgram <= '0';--cuando es '1' evita que el programa se siga ejecutando a pesar de que el programa finalizó
		estado_actual <= detenido;
		Ic<='0';Il<='0';Ie<='0';
	elsif(I='1' and doneProgram='0')then
		if(Clk='1' and Clk'event)then
			
			if(estado_actual = detenido)then
				estado_actual <= estado_siguiente; 	
				if(Lav='1')then
					il<='1';ie<='0';ic<='0';
				elsif(Lav='0' and Enj='1')then
					il<='0';ie<='1';ic<='0';
				elsif(Lav='0' and Enj='0' and Cen='1')then
					il<='0';ie<='0';ic<='1';
				else
					doneProgram <= '1';
					il<='0';ie<='0';ic<='0';
				end if;
			elsif(estado_actual = lavando)then
				if(doneL='1')then
					estado_actual <= estado_siguiente;
					if(Enj='1')then
						il<='0';ie<='1';ic<='0';
					elsif(Enj='0' and Cen='1')then
						Il<='0';Ie<='0';Ic<='1';
					else
						doneProgram <= '1';
						Il<='0';Ie<='0';Ic<='0';
					end if;
				end if;
			elsif(estado_actual = enjuagando)then
				if(doneE = '1')then
					estado_actual <= estado_siguiente;
					if(Cen ='1')then
						Il<='0';Ie<='0';Ic<='1';
					else
						doneProgram <= '1';
						Il<='0';Ie<='0';Ic<='0';
					end if;
				end if;
			elsif(estado_actual = centrifugando)then
				if(doneC = '1')then
					estado_actual <= estado_siguiente;
					Il<='0';Ie<='0';Ic<='0';
					doneProgram <= '1';
				end if;
			end if;
			
		end if;
	end if;
end process;

process(estado_actual,estado_siguiente)
begin
	--estados : lavando,enjuagando,centrifugando,detenido
	if(estado_actual = detenido)then
		if(Lav='1')then --pasa de detenido a lavado
			estado_siguiente <= lavando;
		elsif(Lav='0' and Enj='1')then --pasa de detenido a enjuague
			estado_siguiente <= enjuagando;
		elsif(Lav='0' and Enj='0' and Cen='1')then --pasa de detenido a centrifugando
			estado_siguiente <= centrifugando;
		end if;
	elsif(estado_actual = lavando)then
		if(Enj='1')then
			estado_siguiente <= enjuagando; --si enj='1' pasa al estado enjuagando
		elsif(Enj='0' and Cen='1')then
			estado_siguiente <= centrifugando; --si enj='0' y cen='1' pasa al estado centrifugando
		elsif(Enj='0' and Cen='0')then		--si ambas son 0 pasa a detenido
			estado_siguiente <= detenido;
		end if;
	elsif(estado_actual = enjuagando)then
		if(Cen='1')then
			estado_siguiente <= centrifugando; --si cen='1' pasa al estsado centrifugando
		elsif(Cen='0')then
			estado_siguiente <= detenido;
		end if;		
	elsif(estado_actual = centrifugando)then
		estado_siguiente <= detenido;
	end if;
	
end process;

--la tapa se traba cuando este en cualquier programa salvo que este detenido
process(estado_actual)
begin
	case estado_actual is
		when detenido =>
			Tt<='0';
		when others =>
			Tt<='1';
	end case;
end process;

end Behavioral;

