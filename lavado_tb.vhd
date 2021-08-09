--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:50:13 07/20/2021
-- Design Name:   
-- Module Name:   /home/narc/Escritorio/facu/programs/tpi/lavado_tb.vhd
-- Project Name:  tpi
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: lavado
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
 
ENTITY lavado_tb IS
END lavado_tb;
 
ARCHITECTURE behavior OF lavado_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT lavado
    PORT(
         Clk : IN  std_logic;
         I : IN  std_logic;
         s0 : IN  std_logic;
         s2 : IN  std_logic;
         s3 : IN  std_logic;
--         doneM : IN  std_logic;
         Vl : OUT  std_logic;
         Vj : OUT  std_logic;
         Cvm : OUT  std_logic;
         Cb : OUT  std_logic;
         Vv : OUT  std_logic;
         Vmot : OUT  std_logic;
         Ll : OUT  std_logic;
			LavHecho : out std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal I : std_logic := '0';
   signal s0 : std_logic := '0';
   signal s2 : std_logic := '0';
   signal s3 : std_logic := '0';
--   signal doneM : std_logic := '0';

 	--Outputs
   signal Vl : std_logic;
   signal Vj : std_logic;
   signal Cvm : std_logic;
   signal Cb : std_logic;
   signal Vv : std_logic;
   signal Vmot : std_logic;
   signal Ll : std_logic;
	signal LavHecho : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: lavado PORT MAP (
          Clk => Clk,
          I => I,
          s0 => s0,
          s2 => s2,
          s3 => s3,
--          doneM => doneM,
          Vl => Vl,
          Vj => Vj,
          Cvm => Cvm,
          Cb => Cb,
          Vv => Vv,
          Vmot => Vmot,
          Ll => Ll,
			 LavHecho => LavHecho 
        );

--   Clock process definitions
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

      -- insert stimulus here
		
		--lavado
		I<='0';
		s0<='0';
		s2<='0';
		s3<='0';
			wait for 10 ns;
		I<='1';
			wait for 10 ns;
		s0<='1';
			wait for 10 ns;
		s2<='1';
			wait for 10 ns;
			wait for 10 ns;
		s3<='1';
			wait for 90 ns;
		s3<='0';
			wait for 10 ns;
		s2<='0';
			wait for 10 ns;
		s0<='0';
			wait for 10 ns;
	
      wait;
   end process;

END;
