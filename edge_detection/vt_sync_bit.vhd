----------------------------------------------------------------------------------
-- Company:  VTTEK
-- Engineer: Nguyen Canh Trung (trungnc10@viettel.com.vn)
-- 
-- Create Date: 11/30/2018 03:46:31 PM
-- Design Name: 
-- Module Name: synchronizer - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description:
--      Cross-domain synchronisation for single bit 
-- 
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

entity sync_bit is
    Port ( 
           clk       	: in STD_LOGIC;
           
           din    		: in STD_LOGIC; 		-- Asynchronous input signal
           	
           dout   		: out STD_LOGIC 		-- Synchronous output signal
           );
end sync_bit;

architecture Behavioral of sync_bit is

signal sync_reg	:	STD_LOGIC_VECTOR(4 downto 0);

begin
synchronizer:process( clk )
begin
	if rising_edge( clk ) then
		sync_reg(0) <= din;
		sync_reg(1) <= sync_reg(0);
		sync_reg(2) <= sync_reg(1);
		sync_reg(3) <= sync_reg(2);
		sync_reg(4) <= sync_reg(3);
	end if;
end process synchronizer;  

dout 	<= sync_reg(4);

end Behavioral;
