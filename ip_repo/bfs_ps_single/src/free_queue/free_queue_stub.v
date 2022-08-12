// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2_AR75986 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Sat Jun 11 14:31:57 2022
// Host        : ict-RH2288H-V3 running 64-bit Ubuntu 16.04.7 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/zhangxu/NF_card_hw_sw_dev/fpga/design/bfs-ps/ip_repo/bfs_ps_single/src/free_queue/free_queue_stub.v
// Design      : free_queue
// Purpose     : Stub declaration of top-level module interface
// Device      : xczu19eg-ffvc1760-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_2_5,Vivado 2020.2_AR75986" *)
module free_queue(clk, srst, din, wr_en, rd_en, dout, full, empty, valid, 
  data_count, wr_rst_busy, rd_rst_busy)
/* synthesis syn_black_box black_box_pad_pin="clk,srst,din[5:0],wr_en,rd_en,dout[5:0],full,empty,valid,data_count[5:0],wr_rst_busy,rd_rst_busy" */;
  input clk;
  input srst;
  input [5:0]din;
  input wr_en;
  input rd_en;
  output [5:0]dout;
  output full;
  output empty;
  output valid;
  output [5:0]data_count;
  output wr_rst_busy;
  output rd_rst_busy;
endmodule
