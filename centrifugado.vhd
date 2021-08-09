----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:55:49 07/20/2021 
-- Design Name: 
-- Module Name:    centrifugado - Behavioral 
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

entity centrifugado is
    Port ( Clk : in  STD_LOGIC;
           I : in  STD_LOGIC;
           s0 : in  STD_LOGIC;
--           doneM : in  STD_LOGIC;
           Cvm : out  STD_LOGIC;
           Cb : out  STD_LOGIC;
           Vv : out  STD_LOGIC;
           Vmot : out  STD_LOGIC;
			  CenHecho : out std_logic;
           LC : out  STD_LOGIC);
end centrifugado;

architecture Behavioral of centrifugado is

type estado is (detenido,centrifugando,desagote);

signal estado_actual,estado_siguiente : estado;
signal centrifugadoHecho:std_logic;
signal tiempoMotor : unsigned(3 downto 1);

begin
	
	--si el boton I='1' comienza con el proceso de lavado
	process(Clk,I)
	begin
		if(I='0')then
			estado_actual<=detenido;
			centrifugadoHecho<='0';
			CenHecho <= '0';
		elsif(I='1')then
			if(Clk='1' and Clk'event)then
				
			case estado_actual is
				when detenido =>	--pasa a centrifugando
					if(centrifugadoHecho='0')then
						estado_actual <= estado_siguiente;
						Cvm<='1';
						Vmot<='1';
					end if;

				when centrifugando =>
					if(tiempoMotor = "111")then	--si termino el tiempo de lavado pasa al otro estado
						estado_actual <= estado_siguiente;
						Cvm<='0';
						Cb<='1';
						Vv<='1';
					end if;
					
				when desagote =>
					if(s0='0')then	--si el nivel de agua es menor a s0 pasa al otro estado
						estado_actual <= estado_siguiente;
						Cb<='0';
						Vv<='0';
						centrifugadoHecho<='1';
						CenHecho <= '1';
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
				estado_siguiente <= centrifugando;
			when centrifugando =>
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
				LC <= '0';
			when others =>
				LC <= '1';
		end case;
	end process;
	
	--contador
	process(Clk)
	begin
		if I='0' then
			tiempoMotor <="000";
		elsif Clk='1' and Clk'event and I='1' and centrifugadoHecho ='0' then
			if estado_actual=centrifugando then
				tiempoMotor<=tiempoMotor+1;
			end if;
		end if;

	end process;

end Behavioral;