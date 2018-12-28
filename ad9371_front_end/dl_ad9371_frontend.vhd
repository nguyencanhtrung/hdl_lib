----------------------------------------------------------------------------------
-- Company: VTTEK
-- Engineer: Nguyen Canh Trung  (trungnc10@viettel.com.vn)
-- 
-- Create Date: 03/14/2018 04:36:49 PM
-- Design Name: 
-- Module Name: dfe_data_extraction - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description:  This module is used in ONE PHASE mode of DPD
--      DATA_IN  255 .. 63:48 .. 47:32 .. 31:16 .. 15:0
--      I/Q               Q        I   ..   Q        I
--      Antenna            Antenna 1   ..    Antenna 0
--
--
--      REG    31 .. 16  15 .. 0
--              n + 1       n
-- 
-- I : Real part
-- Q : Imaginary part 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--      01/04/18    :   Handling ip_valid and ip_ready
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity dl_ad9371_frontend is
    Generic( NUM_ANTENNA : natural := 8 ); -- USELESS 
    Port ( rst_n    : in STD_LOGIC;
           clk      : in STD_LOGIC;
           
           ip_valid : out STD_LOGIC;
           ip_ready : out STD_LOGIC;
           
           ext_valid: in STD_LOGIC;
           ext_ready: in STD_LOGIC;
           
           data_in  : in STD_LOGIC_VECTOR (255 downto 0);
           
           I_0      : out STD_LOGIC_VECTOR (31 downto 0);
           Q_0      : out STD_LOGIC_VECTOR (31 downto 0);
           
           I_1      : out STD_LOGIC_VECTOR (31 downto 0);
           Q_1      : out STD_LOGIC_VECTOR (31 downto 0);
           
           I_2      : out STD_LOGIC_VECTOR (31 downto 0);
           Q_2      : out STD_LOGIC_VECTOR (31 downto 0);
           
           I_3      : out STD_LOGIC_VECTOR (31 downto 0);
           Q_3      : out STD_LOGIC_VECTOR (31 downto 0);
           
           I_4      : out STD_LOGIC_VECTOR (31 downto 0);
           Q_4      : out STD_LOGIC_VECTOR (31 downto 0);
          
           I_5      : out STD_LOGIC_VECTOR (31 downto 0);
           Q_5      : out STD_LOGIC_VECTOR (31 downto 0);
         
           I_6      : out STD_LOGIC_VECTOR (31 downto 0);
           Q_6      : out STD_LOGIC_VECTOR (31 downto 0);
          
           I_7      : out STD_LOGIC_VECTOR (31 downto 0);
           Q_7      : out STD_LOGIC_VECTOR (31 downto 0)
           );
end dl_ad9371_frontend;

architecture Behavioral of dl_ad9371_frontend is
signal I0, Q0       :   std_logic_vector( 15 downto 0 );
signal I1, Q1       :   std_logic_vector( 15 downto 0 );
signal I2, Q2       :   std_logic_vector( 15 downto 0 );
signal I3, Q3       :   std_logic_vector( 15 downto 0 );
signal I4, Q4       :   std_logic_vector( 15 downto 0 );
signal I5, Q5       :   std_logic_vector( 15 downto 0 );
signal I6, Q6       :   std_logic_vector( 15 downto 0 );
signal I7, Q7       :   std_logic_vector( 15 downto 0 );

signal I0_32, Q0_32 :   std_logic_vector( 31 downto 0 );
signal I1_32, Q1_32 :   std_logic_vector( 31 downto 0 );
signal I2_32, Q2_32 :   std_logic_vector( 31 downto 0 );
signal I3_32, Q3_32 :   std_logic_vector( 31 downto 0 );
signal I4_32, Q4_32 :   std_logic_vector( 31 downto 0 );
signal I5_32, Q5_32 :   std_logic_vector( 31 downto 0 );
signal I6_32, Q6_32 :   std_logic_vector( 31 downto 0 );
signal I7_32, Q7_32 :   std_logic_vector( 31 downto 0 );

signal out_dat_enb, ip_pause  :   std_logic;
begin
data_extraction: process( clk )
begin
    if rising_edge( clk ) then
        if rst_n = '0' then 
            ip_ready    <= '0';
            I0          <= (OTHERS => '0'); 
            Q0          <= (OTHERS => '0'); 
            
            I1          <= (OTHERS => '0'); 
            Q1          <= (OTHERS => '0'); 
            
            I2          <= (OTHERS => '0'); 
            Q2          <= (OTHERS => '0'); 
            
            I3          <= (OTHERS => '0'); 
            Q3          <= (OTHERS => '0'); 
            
            I4          <= (OTHERS => '0'); 
            Q4          <= (OTHERS => '0'); 
            
            I5          <= (OTHERS => '0'); 
            Q5          <= (OTHERS => '0'); 
            
            I6          <= (OTHERS => '0'); 
            Q6          <= (OTHERS => '0'); 
            
            I7          <= (OTHERS => '0'); 
            Q7          <= (OTHERS => '0'); 
            
        else
            -- 1. IP is ready
            ip_ready  <= '1';
            -- 2. IP fetchs data when its available for reading
            if( ext_valid = '1' AND ext_ready = '1' ) then
                I0    <= data_in( 15 downto 0 );
                Q0    <= data_in( 31 downto 16 );
                
                I1    <= data_in( 47 downto 32 );
                Q1    <= data_in( 63 downto 48 );
                
                I2    <= data_in( 79 downto 64 );
                Q2    <= data_in( 95 downto 80 );
                
                I3    <= data_in( 111 downto 96 );
                Q3    <= data_in( 127 downto 112 );
                
                I4    <= data_in( 143 downto 128 );
                Q4    <= data_in( 159 downto 144 );
                
                I5    <= data_in( 175 downto 160 );
                Q5    <= data_in( 191 downto 176 );
                
                I6    <= data_in( 207 downto 192 );
                Q6    <= data_in( 223 downto 208 );
                
                I7    <= data_in( 239 downto 224 );
                Q7    <= data_in( 255 downto 240 ); 
                  
                -- PAUSE IP if producer IP is not available or consumer IP is busy
                ip_pause    <= '0';
            else 
                ip_ready    <= '0'; -- pause the ip immediately
                ip_pause    <= '1'; -- pause the ip, keep previous data
            end if;            
       end if;
    end if;
end process data_extraction; 

------------------------------------------------------
------------------------------------------------------
-- Arrange data using internal Registers
------------------------------------------------------
data_concat: process( clk )
variable    up  :   std_logic;
begin
    if rising_edge( clk ) then
        if rst_n = '0' then 
            up                      := '0';
            
            I0_32                   <=  (others => '0');
            Q0_32                   <=  (others => '0');
            
            I1_32                   <=  (others => '0');
            Q1_32                   <=  (others => '0');
            
            I2_32                   <=  (others => '0');
            Q2_32                   <=  (others => '0');
            
            I3_32                   <=  (others => '0');
            Q3_32                   <=  (others => '0');
            
            I4_32                   <=  (others => '0');
            Q4_32                   <=  (others => '0');
            
            I5_32                   <=  (others => '0');
            Q5_32                   <=  (others => '0');
            
            I6_32                   <=  (others => '0');
            Q6_32                   <=  (others => '0');
            
            I7_32                   <=  (others => '0');
            Q7_32                   <=  (others => '0');
            
            out_dat_enb             <= '0';
            
        else
            if ip_pause = '0' then
                if( up = '1' ) then
                    up                      := '0';
                    
                    I0_32( 31 downto 16 )   <=  I0;
                    Q0_32( 31 downto 16 )   <=  Q0;
                    
                    I1_32( 31 downto 16 )   <=  I1;
                    Q1_32( 31 downto 16 )   <=  Q1;
                    
                    I2_32( 31 downto 16 )   <=  I2;
                    Q2_32( 31 downto 16 )   <=  Q2;
                    
                    I3_32( 31 downto 16 )   <=  I3;
                    Q3_32( 31 downto 16 )   <=  Q3;
                    
                    I4_32( 31 downto 16 )   <=  I4;
                    Q4_32( 31 downto 16 )   <=  Q4;
                    
                    I5_32( 31 downto 16 )   <=  I5;
                    Q5_32( 31 downto 16 )   <=  Q5;
                    
                    I6_32( 31 downto 16 )   <=  I6;
                    Q6_32( 31 downto 16 )   <=  Q6;
                    
                    I7_32( 31 downto 16 )   <=  I7;
                    Q7_32( 31 downto 16 )   <=  Q7;
                    
                    out_dat_enb             <= '1'; -- Allow to send data
                else
                    up                     := '1';
                    I0_32( 15 downto 0 )   <=  I0;
                    Q0_32( 15 downto 0 )   <=  Q0;
                    
                    I1_32( 15 downto 0 )   <=  I1;
                    Q1_32( 15 downto 0 )   <=  Q1;
                    
                    I2_32( 15 downto 0 )   <=  I2;
                    Q2_32( 15 downto 0 )   <=  Q2;
                    
                    I3_32( 15 downto 0 )   <=  I3;
                    Q3_32( 15 downto 0 )   <=  Q3;
                    
                    I4_32( 15 downto 0 )   <=  I4;
                    Q4_32( 15 downto 0 )   <=  Q4;
                    
                    I5_32( 15 downto 0 )   <=  I5;
                    Q5_32( 15 downto 0 )   <=  Q5;
                    
                    I6_32( 15 downto 0 )   <=  I6;
                    Q6_32( 15 downto 0 )   <=  Q6;
                    
                    I7_32( 15 downto 0 )   <=  I7;
                    Q7_32( 15 downto 0 )   <=  Q7;
                    
                    out_dat_enb            <= '0';
                end if;
            else
                out_dat_enb                <= '0';
            end if;
        end if;
    end if;
end process data_concat;
------------------------------------------------------
------------------------------------------------------
data_output: process( clk )
begin
    if rising_edge( clk ) then
        if (rst_n = '0') then
           I_0  <= (others => '0');
           Q_0  <= (others => '0');
           
           I_1  <= (others => '0');
           Q_1  <= (others => '0');
           
           I_2  <= (others => '0');
           Q_2  <= (others => '0');
           
           I_3  <= (others => '0');
           Q_3  <= (others => '0');
           
           I_4  <= (others => '0');
           Q_4  <= (others => '0');
          
           I_5  <= (others => '0');
           Q_5  <= (others => '0');
         
           I_6  <= (others => '0');
           Q_6  <= (others => '0');
          
           I_7  <= (others => '0');
           Q_7  <= (others => '0');
           
           ip_valid <= '0';
           
        elsif( out_dat_enb = '1' ) then
           I_0      <= I0_32;
           Q_0      <= Q0_32;
           
           I_1      <= I1_32;
           Q_1      <= Q1_32;
           
           I_2      <= I2_32;
           Q_2      <= Q2_32;
           
           I_3      <= I3_32;
           Q_3      <= Q3_32;
           
           I_4      <= I4_32;
           Q_4      <= Q4_32;
          
           I_5      <= I5_32;
           Q_5      <= Q5_32;
         
           I_6      <= I6_32;
           Q_6      <= Q6_32;
          
           I_7      <= I7_32;
           Q_7      <= Q7_32;
           
           ip_valid <= '1';
           
        else 
           ip_valid <= '0';
        end if;
    end if;
end process data_output;
end Behavioral;
