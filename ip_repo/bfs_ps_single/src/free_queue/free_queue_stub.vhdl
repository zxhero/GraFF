-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.2_AR75986 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
-- Date        : Sat Jun 11 14:31:57 2022
-- Host        : ict-RH2288H-V3 running 64-bit Ubuntu 16.04.7 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/zhangxu/NF_card_hw_sw_dev/fpga/design/bfs-ps/ip_repo/bfs_ps_single/src/free_queue/free_queue_stub.vhdl
-- Design      : free_queue
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xczu19eg-ffvc1760-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity free_queue is
  Port ( 
    clk : in STD_LOGIC;
    srst : in STD_LOGIC;
    din : in STD_LOGIC_VECTOR ( 5 downto 0 );
    wr_en : in STD_LOGIC;
    rd_en : in STD_LOGIC;
    dout : out STD_LOGIC_VECTOR ( 5 downto 0 );
    full : out STD_LOGIC;
    empty : out STD_LOGIC;
    valid : out STD_LOGIC;
    data_count : out STD_LOGIC_VECTOR ( 5 downto 0 );
    wr_rst_busy : out STD_LOGIC;
    rd_rst_busy : out STD_LOGIC
  );

end free_queue;

architecture stub of free_queue is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,srst,din[5:0],wr_en,rd_en,dout[5:0],full,empty,valid,data_count[5:0],wr_rst_busy,rd_rst_busy";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "fifo_generator_v13_2_5,Vivado 2020.2_AR75986";
begin
end;
