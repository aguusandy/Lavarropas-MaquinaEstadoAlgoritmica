--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:48:00 07/20/2021
-- Design Name:   
-- Module Name:   /home/narc/Escritorio/facu/programs/tpi/centrifugado_tb.vhd
-- Project Name:  tpi
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: centrifugado
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY centrifugado_tb IS
END centrifugado_tb;
 
ARCHITECTURE behavior OF centrifugado_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT centrifugado
    PORT(
         Clk : IN  std_logic;
         I : IN  std_logic;
         s0 : IN  std_logic;
--         doneM : IN  std_logic;
         Cvm : OUT  std_logic;
         Cb : OUT  std_logic;
         Vv : OUT  std_logic;
         Vmot : OUT  std_logic;
         LC : OUT  std_logic;
			CenHecho : out std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal I : std_logic := '0';
   signal s0 : std_logic := '0';
--   signal doneM : std_logic := '0';

 	--Outputs
   signal Cvm : std_logic;
   signal Cb : std_logic;
   signal Vv : std_logic;
   signal Vmot : std_logic;
   signal LC : std_logic;
	signal CenHecho : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: centrifugado PORT MAP (
          Clk => Clk,
          I => I,
          s0 => s0,
--          doneM => doneM,
          Cvm => Cvm,
          Cb => Cb,
          Vv => Vv,
          Vmot => Vmot,
          LC => LC,
			 CenHecho => CenHecho
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
--      wait for 100 ns;	

--      wait for Clk_period*10;

      -- insert stimulus here 
		I<='0';
		s0<='1';
--		doneM<='0';
		wait for 10 ns;
			
		I<='1';
		wait for 10 ns;
		
--		doneM<='1';
		wait for 90 ns;
			
		s0<='0';
		wait for 10 ns;
			
      wait;
   end process;

END;
