--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:12:50 07/20/2021
-- Design Name:   
-- Module Name:   /home/narc/Escritorio/facu/programs/tpi/lavarropas_tb.vhd
-- Project Name:  tpi
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: lavarropas
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
 
ENTITY lavarropas_tb IS
END lavarropas_tb;
 
ARCHITECTURE behavior OF lavarropas_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT lavarropas
    PORT(
         Clk : IN  std_logic;
         I : IN  std_logic;
         CodProg : IN  std_logic_vector(2 downto 0);
			s0 : in std_logic;
			s2 : in std_logic;
			s3 : in std_logic;
--			doneM : in std_logic;
         LL : OUT  std_logic;
         LE : OUT  std_logic;
         LC : OUT  std_logic;
         Tt : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal I : std_logic := '0';
   signal CodProg : std_logic_vector(2 downto 0) := (others => '0');
	signal s0 : std_logic := '0';
	signal s2 : std_logic := '0';
	signal s3 : std_logic := '0';
--	signal doneM : std_logic := '0';


 	--Outputs
   signal LL : std_logic;
   signal LE : std_logic;
   signal LC : std_logic;
   signal Tt : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: lavarropas PORT MAP (
          Clk => Clk,
          I => I,
          CodProg => CodProg,
			 s0 => s0,
			 s2 => s2,
			 s3 => s3,
--			 doneM => doneM,
          LL => LL,
          LE => LE,
          LC => LC,
          Tt => Tt
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
		
		--simulacion lavado,enjuague y centrifugado
		
		--lavado
		codprog<="101";
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
			wait for 20 ns;

		--enjuague
--		I<='0';
--		s0<='0';
--		s2<='0';
--		s3<='0';
--			wait for 10 ns;
--		I<='1';
--			wait for 10 ns;
--		s0<='1';
--			wait for 10 ns;
--		s2<='1';
--			wait for 10 ns;
--			wait for 10 ns;
--		s3<='1';
--			wait for 90 ns;
--		s3<='0';
--			wait for 10 ns;
--		s2<='0';
--			wait for 10 ns;
--		s0<='0';
--			wait for 10 ns;
		
		--centrifugando
		s0<='1';	
		wait for 90 ns;
		s0<='0';
		wait for 10 ns;

		
      wait;
   end process;

END;
