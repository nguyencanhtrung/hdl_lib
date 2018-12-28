----------------------------------------------------------------------------------
-- Company: VTTEK
-- Engineer: Nguyen Canh Trung (trungnc10@viettel.com)
-- 
-- Create Date: 03/16/2018 05:38:14 PM
-- Design Name: 
-- Module Name: tb_addr_gen - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.NUMERIC_STD.ALL;


entity tb_addr_gen is
end tb_addr_gen;

architecture Behavioral of tb_addr_gen is
-- Signal declaration
signal rst_n    : STD_LOGIC;
signal clk      : STD_LOGIC;
signal enable   : STD_LOGIC;
           
signal i_addr   : STD_LOGIC_VECTOR (15 downto 0);
signal q_addr   : STD_LOGIC_VECTOR (15 downto 0);

signal clk_period  : time := 10 ns;
-- Component declaration
component address_gen is
    Port ( rst_n    : in STD_LOGIC;
           clk      : in STD_LOGIC;
           enable   : in STD_LOGIC;
           
           i_addr   : out STD_LOGIC_VECTOR (15 downto 0);
           q_addr   : out STD_LOGIC_VECTOR (15 downto 0)
           );
end component;
begin
uut: address_gen port map (
                            rst_n,
                            clk,
                            enable,
                            i_addr,
                            q_addr
                        );


-- clock generation
    clock_gen:process
    begin
        if clk = '1' then
            clk <= '0';
            wait for clk_period/2;
        else
            clk <= '1';
            wait for clk_period/2;
        end if;
    end process clock_gen;

    -- reset controller
    reset_controller:process
    begin
        -- rst generation
        rst_n <= '0';
        wait for clk_period * 100;
        
        rst_n <= '1';
        wait for clk_period * 100;
        wait;
    end process;

    -- enable controller
    enable_controller:process
    begin
        enable <= '1';
        wait;
    end process;
end Behavioral;
