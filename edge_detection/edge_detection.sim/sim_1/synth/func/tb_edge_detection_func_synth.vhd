-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.2.1 (lin64) Build 1957588 Wed Aug  9 16:32:10 MDT 2017
-- Date        : Fri Dec 21 16:07:00 2018
-- Host        : trungnguyen running 64-bit unknown
-- Command     : write_vhdl -mode funcsim -nolib -force -file
--               /home/trungnguyen/01.IMPL/01.HDL/IPCORES/vttek/vt_util/edge_detection/edge_detection.sim/sim_1/synth/func/tb_edge_detection_func_synth.vhd
-- Design      : edge_detection
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xczu9eg-ffvb1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity edge_detection is
  port (
    clk : in STD_LOGIC;
    input : in STD_LOGIC;
    edge_detected : inout STD_LOGIC;
    rising_edge_detected : out STD_LOGIC;
    falling_edge_detected : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of edge_detection : entity is true;
end edge_detection;

architecture STRUCTURE of edge_detection is
  signal clk_IBUF : STD_LOGIC;
  signal clk_IBUF_BUFG : STD_LOGIC;
  signal delay_input : STD_LOGIC;
  signal delay_input_reg_i_1_n_0 : STD_LOGIC;
  signal edge_detected_OBUF : STD_LOGIC;
  signal falling_edge_detected_OBUF : STD_LOGIC;
  signal rising_edge_detected_OBUF : STD_LOGIC;
  attribute XILINX_LEGACY_PRIM : string;
  attribute XILINX_LEGACY_PRIM of clk_IBUF_BUFG_inst : label is "BUFG";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of edge_detected_OBUF_inst_i_1 : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of rising_edge_detected_OBUF_inst_i_1 : label is "soft_lutpair0";
begin
clk_IBUF_BUFG_inst: unisim.vcomponents.BUFGCE
    generic map(
      CE_TYPE => "ASYNC"
    )
        port map (
      CE => '1',
      I => clk_IBUF,
      O => clk_IBUF_BUFG
    );
clk_IBUF_inst: unisim.vcomponents.IBUF
     port map (
      I => clk,
      O => clk_IBUF
    );
delay_input_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_IBUF_BUFG,
      CE => '1',
      D => delay_input_reg_i_1_n_0,
      Q => delay_input,
      R => '0'
    );
delay_input_reg_i_1: unisim.vcomponents.IBUF
     port map (
      I => input,
      O => delay_input_reg_i_1_n_0
    );
edge_detected_OBUF_inst: unisim.vcomponents.OBUF
     port map (
      I => edge_detected_OBUF,
      O => edge_detected
    );
edge_detected_OBUF_inst_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => delay_input,
      I1 => delay_input_reg_i_1_n_0,
      O => edge_detected_OBUF
    );
falling_edge_detected_OBUF_inst: unisim.vcomponents.OBUF
     port map (
      I => falling_edge_detected_OBUF,
      O => falling_edge_detected
    );
falling_edge_detected_OBUF_inst_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => edge_detected_OBUF,
      I1 => delay_input,
      O => falling_edge_detected_OBUF
    );
rising_edge_detected_OBUF_inst: unisim.vcomponents.OBUF
     port map (
      I => rising_edge_detected_OBUF,
      O => rising_edge_detected
    );
rising_edge_detected_OBUF_inst_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => delay_input,
      I1 => edge_detected_OBUF,
      O => rising_edge_detected_OBUF
    );
end STRUCTURE;
