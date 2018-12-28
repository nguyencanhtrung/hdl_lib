----------------------------------------------------------------------------------
-- Company:  VTTEK
-- Engineer: Nguyen Canh Trung (trungnc10@viettel.com.vn)
-- 
-- Create Date: 12/19/2018 03:46:31 PM
-- Design Name: 
-- Module Name: edge_detection - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description:
--      Detect Edge of signal 
-- 		Detect Rising/ Falling edge
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
use IEEE.NUMERIC_STD.ALL;

entity tb_edge_detection is
end tb_edge_detection;

architecture Behavioral of tb_edge_detection is
component edge_detection is
    Port ( 
           clk       					: in STD_LOGIC;
           input						: in STD_LOGIC;

           edge_detected    			: inout STD_LOGIC; 	
           rising_edge_detected   		: out STD_LOGIC; 	
           falling_edge_detected   		: out STD_LOGIC
           );
end component;

signal clk                              : STD_LOGIC := '0';
signal input                            : STD_LOGIC := '0';

signal edge_detected                    : STD_LOGIC; 	
signal rising_edge_detected   		    : STD_LOGIC; 
signal falling_edge_detected            : STD_LOGIC;

signal clk_period                       : time := 10 ns;

begin
uut:edge_detection port map ( 
                   clk,
                   input,
        
                   edge_detected,		
                   rising_edge_detected,	
                   falling_edge_detected
           );

clk     <= not (clk) after clk_period/2;

stim_proc:process
begin
    wait until clk = '1';                   -- update input after 1 delta cycle compared to clk           
    input   <= not (input) after 325 ns;
end process;

end Behavioral;