----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:54:17 07/20/2021 
-- Design Name: 
-- Module Name:    enjuague - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity enjuague is
    Port ( Clk : in  STD_LOGIC;
           I : in  STD_LOGIC;
           s0 : in  STD_LOGIC;
           s2 : in  STD_LOGIC;
           s3 : in  STD_LOGIC;
--           doneM : in  STD_LOGIC;
           Vl : out  STD_LOGIC;
           Vs : out  STD_LOGIC;
           Cvm : out  STD_LOGIC;
           Vmot : out  STD_LOGIC;
           Cb : out  STD_LOGIC;
           Vv : out  STD_LOGIC;
			  EnjHecho : out std_logic;
           LE : out  STD_LOGIC);
end enjuague;

architecture Behavioral of enjuague is

type estado is (detenido,llenandoVl,llenandoVs,motorEncVelBaja,desagote);

signal estado_actual,estado_siguiente : estado;
signal enjuagueHecho : std_logic;
signal tiempoMotor : unsigned(3 downto 1);


begin
	
	--si el boton I='1' comienza con el proceso de lavado
	process(Clk,I)
	begin
		if(I='0')then
			estado_actual<=detenido;
			enjuagueHecho<='0';
			EnjHecho<='0';
		elsif(I='1')then
			if(Clk='1' and Clk'event)then
				
			case estado_actual is
				when detenido =>	--pasa a llenandoVl
					if(enjuagueHecho='0')then
						estado_actual <= estado_siguiente;
						Vl<='1';
					end if;
				when llenandoVl =>
					if(s2='1')then
						estado_actual <= estado_siguiente;
						Vl<='0';
						Vs<='1';
					end if;
					
				when llenandoVs =>
					if(s3='1')then	--si no llego a s3 sigue en el mismo estado
						estado_actual <= estado_siguiente;
						Vs<='0';
						Cvm<='1';
						Vmot<='0';
					end if;
					
				when motorEncVelBaja =>
					if(tiempoMotor = "111")then	--si no termino el tiempo de lavado sigue en el mismo estado
						estado_actual <= estado_siguiente;
						Cvm<='0';
						Cb<='1';
						Vv<='1';
					end if;
					
				when desagote =>
					if(s0='0')then	--si el nivel de agua es superior a s0 sigue en el mismo estado
						estado_actual <= estado_siguiente;
						Cb<='0';
						Vv<='0';
						enjuagueHecho<='1';
						EnjHecho<='1';
					end if;
					
				when others =>
					estado_actual <= detenido;
			end case;
					
			end if;
		end if;
	end process;
	
	--pasa al estado siguiente dependiendo del estado actual
	process(estado_actual,estado_siguiente)
	begin
		case estado_actual is
			when detenido =>
				estado_siguiente <= llenandoVl;
			when llenandoVl =>
				estado_siguiente <= llenandoVs;
			when llenandoVs =>
				estado_siguiente <= motorEncVelBaja;
			when motorEncVelBaja =>
				estado_siguiente <= desagote;
			when desagote =>
				estado_siguiente <= detenido;
			when others =>
				estado_siguiente <= detenido;
		end case;
	end process;
	
	--prende el led de lavado
	process(estado_actual)
	begin
		case estado_actual is
			when detenido =>
				LE <= '0';
			when others =>
				LE <= '1';
		end case;
	end process;
	
	--contador
	process(Clk)
	begin
		if I='0' then
			tiempoMotor <="000";
		elsif Clk='1' and Clk'event and I='1' and enjuagueHecho ='0' then
			if estado_actual=motorEncVelBaja then
				tiempoMotor<=tiempoMotor+1;
			end if;
		end if;

	end process;

end Behavioral;