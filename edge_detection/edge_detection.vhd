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

entity edge_detection is
    Port ( 
           clk       					: in STD_LOGIC;
           input						: in STD_LOGIC;

           edge_detected    			: inout STD_LOGIC; 	
           rising_edge_detected   		: out STD_LOGIC; 	
           falling_edge_detected   		: out STD_LOGIC
           );
end edge_detection;

architecture Behavioral of edge_detection is
signal delay_input 	: STD_LOGIC;
begin
delay_one_cycle:process( clk )
begin
	if rising_edge( clk ) then
	   delay_input   <= input;
	end if;
end process delay_one_cycle;  

edge_detected 			<= delay_input XOR input;
falling_edge_detected	<= edge_detected AND delay_input;
rising_edge_detected 	<= edge_detected AND ( NOT(delay_input));

end Behavioral;
