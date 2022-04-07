`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2022 09:57:13 AM
// Design Name: 
// Module Name: bfs_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module bfs_top(
    input gt_txusrclk,
    input peripheral_reset,
    input doceclk,
    input cmacclk,
    
    input  [63:0]  io_config_awaddr,
  input          io_config_awvalid,
  output         io_config_awready,
  input  [63:0]  io_config_araddr,
  input          io_config_arvalid,
  output         io_config_arready,
  input  [31:0]  io_config_wdata,
  input  [3:0]   io_config_wstrb,
  input          io_config_wvalid,
  output         io_config_wready,
  output [31:0]  io_config_rdata,
  output [1:0]   io_config_rresp,
  output         io_config_rvalid,
  input          io_config_rready,
  output [1:0]   io_config_bresp,
  output         io_config_bvalid,
  input          io_config_bready,

  input [511:0]doce_axis_rxd_tdata,
  input [63:0]doce_axis_rxd_tkeep,
  input doce_axis_rxd_tlast,
  output doce_axis_rxd_tready,
  input doce_axis_rxd_tvalid,
  output [511:0]doce_axis_txd_tdata,
  output [63:0]doce_axis_txd_tkeep,
  output doce_axis_txd_tlast,
  input doce_axis_txd_tready,
  output doce_axis_txd_tvalid
    );
    
    wire [63:0]  io_PLmemory_0_awaddr;
    wire [5:0]   io_PLmemory_0_awid;
    wire [7:0]   io_PLmemory_0_awlen;
    wire [2:0]   io_PLmemory_0_awsize;
    wire [1:0]   io_PLmemory_0_awburst;
    wire         io_PLmemory_0_awlock;
    wire         io_PLmemory_0_awvalid;
    wire         io_PLmemory_0_awready;
    wire [63:0]  io_PLmemory_0_araddr;
    wire [5:0]   io_PLmemory_0_arid;
    wire [7:0]   io_PLmemory_0_arlen;
    wire [2:0]   io_PLmemory_0_arsize;
    wire [1:0]   io_PLmemory_0_arburst;
    wire         io_PLmemory_0_arlock;
    wire         io_PLmemory_0_arvalid;
    wire         io_PLmemory_0_arready;
    wire [511:0] io_PLmemory_0_wdata;
    wire [63:0]  io_PLmemory_0_wstrb;
    wire         io_PLmemory_0_wlast;
    wire         io_PLmemory_0_wvalid;
    wire         io_PLmemory_0_wready;
    wire  [511:0]io_PLmemory_0_rdata;
    wire  [5:0]  io_PLmemory_0_rid;
    wire         io_PLmemory_0_rlast;
    wire  [1:0]  io_PLmemory_0_rresp;
    wire         io_PLmemory_0_rvalid;
    wire         io_PLmemory_0_rready;
    wire  [1:0]  io_PLmemory_0_bresp;
    wire  [5:0]  io_PLmemory_0_bid;
    wire         io_PLmemory_0_bvalid;
    wire         io_PLmemory_0_bready;

    wire [63:0]  io_PLmemory_1_awaddr;
    wire [5:0]   io_PLmemory_1_awid;
    wire [7:0]   io_PLmemory_1_awlen;
    wire [2:0]   io_PLmemory_1_awsize;
    wire [1:0]   io_PLmemory_1_awburst;
    wire         io_PLmemory_1_awlock;
    wire         io_PLmemory_1_awvalid;
    wire         io_PLmemory_1_awready;
    wire [63:0]  io_PLmemory_1_araddr;
    wire [5:0]   io_PLmemory_1_arid;
    wire [7:0]   io_PLmemory_1_arlen;
    wire [2:0]   io_PLmemory_1_arsize;
    wire [1:0]   io_PLmemory_1_arburst;
    wire         io_PLmemory_1_arlock;
    wire         io_PLmemory_1_arvalid;
    wire         io_PLmemory_1_arready;
    wire [511:0] io_PLmemory_1_wdata;
    wire [63:0]  io_PLmemory_1_wstrb;
    wire         io_PLmemory_1_wlast;
    wire         io_PLmemory_1_wvalid;
    wire         io_PLmemory_1_wready;
    wire  [511:0]io_PLmemory_1_rdata;
    wire  [5:0]  io_PLmemory_1_rid;
    wire         io_PLmemory_1_rlast;
    wire  [1:0]  io_PLmemory_1_rresp;
    wire         io_PLmemory_1_rvalid;
    wire         io_PLmemory_1_rready;
    wire  [1:0]  io_PLmemory_1_bresp;
    wire  [5:0]  io_PLmemory_1_bid;
    wire         io_PLmemory_1_bvalid;
    wire         io_PLmemory_1_bready;

     wire [0 : 0] M00_AXI_AWID;
     wire [63 : 0] M00_AXI_AWADDR;
     wire [7 : 0] M00_AXI_AWLEN;
     wire [2 : 0] M00_AXI_AWSIZE;
     wire [1 : 0] M00_AXI_AWBURST;
     wire M00_AXI_AWLOCK;
     wire [3 : 0] M00_AXI_AWCACHE;
     wire [2 : 0] M00_AXI_AWPROT;
     //wire [3 : 0] M00_AXI_AWQOS;
     wire M00_AXI_AWVALID;
    wire M00_AXI_AWREADY;
     wire [511 : 0] M00_AXI_WDATA;
     wire [63 : 0] M00_AXI_WSTRB;
     wire M00_AXI_WLAST;
     wire M00_AXI_WVALID;
    wire M00_AXI_WREADY;
    wire [0 : 0] M00_AXI_BID;
    wire [1 : 0] M00_AXI_BRESP;
    wire M00_AXI_BVALID;
     wire M00_AXI_BREADY;
     wire [0 : 0] M00_AXI_ARID;
     wire [63 : 0] M00_AXI_ARADDR;
     wire [7 : 0] M00_AXI_ARLEN;
     wire [2 : 0] M00_AXI_ARSIZE;
     wire [1 : 0] M00_AXI_ARBURST;
     wire M00_AXI_ARLOCK;
     wire [3 : 0] M00_AXI_ARCACHE;
     wire [2 : 0] M00_AXI_ARPROT;
     //wire [3 : 0] M00_AXI_ARQOS;
     wire M00_AXI_ARVALID;
    wire M00_AXI_ARREADY;
    wire [0 : 0] M00_AXI_RID;
    wire [511 : 0] M00_AXI_RDATA;
    wire [1 : 0] M00_AXI_RRESP;
    wire M00_AXI_RLAST;
    wire M00_AXI_RVALID;
     wire M00_AXI_RREADY;

    wire clka;
    wire rsta;
    wire ena;
    wire [63 : 0] wea;
    wire [31 : 0] addra;
    wire [511 : 0] dina;
     wire [511 : 0] douta;
    wire clkb;
    wire rstb;
    wire enb;
    wire [63 : 0] web;
    wire [31 : 0] addrb;
    wire [511 : 0] dinb;
     wire [511 : 0] doutb;

    wire [0 : 0]    M01_AXI_AWID;
    wire [63 : 0]   M01_AXI_AWADDR;
    wire [7 : 0]    M01_AXI_AWLEN;
    wire [2 : 0]    M01_AXI_AWSIZE;
    wire [1 : 0]    M01_AXI_AWBURST;
    wire            M01_AXI_AWLOCK;
    wire [3 : 0]    M01_AXI_AWCACHE;
    wire [2 : 0]    M01_AXI_AWPROT;
    wire            M01_AXI_AWVALID;
    wire            M01_AXI_AWREADY;
    wire [511 : 0]  M01_AXI_WDATA;
    wire [63 : 0]   M01_AXI_WSTRB;
    wire            M01_AXI_WLAST;
    wire            M01_AXI_WVALID;
    wire            M01_AXI_WREADY;
    wire [0 : 0]    M01_AXI_BID;
    wire [1 : 0]    M01_AXI_BRESP;
    wire            M01_AXI_BVALID;
    wire            M01_AXI_BREADY;
    wire [0 : 0]    M01_AXI_ARID;
    wire [63 : 0]   M01_AXI_ARADDR;
    wire [7 : 0]    M01_AXI_ARLEN;
    wire [2 : 0]    M01_AXI_ARSIZE;
    wire [1 : 0]    M01_AXI_ARBURST;
    wire            M01_AXI_ARLOCK;
    wire [3 : 0]    M01_AXI_ARCACHE;
    wire [2 : 0]    M01_AXI_ARPROT;
    wire            M01_AXI_ARVALID;
    wire            M01_AXI_ARREADY;
    wire [0 : 0]    M01_AXI_RID;
    wire [511 : 0]  M01_AXI_RDATA;
    wire [1 : 0]    M01_AXI_RRESP;
    wire            M01_AXI_RLAST;
    wire            M01_AXI_RVALID;
    wire            M01_AXI_RREADY;

    wire clka1;
    wire rsta1;
    wire ena1;
    wire [63 : 0] wea1;
    wire [31 : 0] addra1;
    wire [511 : 0] dina1;
    wire [511 : 0] douta1;
    wire clkb1;
    wire rstb1;
    wire enb1;
    wire [63 : 0] web1;
    wire [31 : 0] addrb1;
    wire [511 : 0] dinb1;
    wire [511 : 0] doutb1;

    MIG_SIM u_mig(
      .s_axi_aclk     (gt_txusrclk),
      .s_axi_aresetn  (~peripheral_reset),
      .s_axi_awid     (M00_AXI_AWID),
      .s_axi_awaddr   (M00_AXI_AWADDR),
      .s_axi_awlen    (M00_AXI_AWLEN),
      .s_axi_awsize   (M00_AXI_AWSIZE),
      .s_axi_awburst  (M00_AXI_AWBURST),
      .s_axi_awlock   (M00_AXI_AWLOCK),
      .s_axi_awcache  (M00_AXI_AWCACHE),
      .s_axi_awprot   (M00_AXI_AWPROT),
      .s_axi_awvalid  (M00_AXI_AWVALID),
      .s_axi_awready  (M00_AXI_AWREADY),
      .s_axi_wdata    (M00_AXI_WDATA),
      .s_axi_wstrb    (M00_AXI_WSTRB),
      .s_axi_wlast    (M00_AXI_WLAST),
      .s_axi_wvalid   (M00_AXI_WVALID),
      .s_axi_wready   (M00_AXI_WREADY),
      .s_axi_bid      (M00_AXI_BID),
      .s_axi_bresp    (M00_AXI_BRESP),
      .s_axi_bvalid   (M00_AXI_BVALID),
      .s_axi_bready   (M00_AXI_BREADY),
      .s_axi_arid     (M00_AXI_ARID),
      .s_axi_araddr   (M00_AXI_ARADDR),
      .s_axi_arlen    (M00_AXI_ARLEN),
      .s_axi_arsize   (M00_AXI_ARSIZE),
      .s_axi_arburst  (M00_AXI_ARBURST),
      .s_axi_arlock   (M00_AXI_ARLOCK),
      .s_axi_arcache  (M00_AXI_ARCACHE),
      .s_axi_arprot   (M00_AXI_ARPROT),
      .s_axi_arvalid  (M00_AXI_ARVALID),
      .s_axi_arready  (M00_AXI_ARREADY),
      .s_axi_rid      (M00_AXI_RID),
      .s_axi_rdata    (M00_AXI_RDATA),
      .s_axi_rresp    (M00_AXI_RRESP),
      .s_axi_rlast    (M00_AXI_RLAST),
      .s_axi_rvalid   (M00_AXI_RVALID),
      .s_axi_rready   (M00_AXI_RREADY),
      .bram_rst_a     (rsta),
      .bram_clk_a     (clka),
      .bram_en_a      (ena),
      .bram_we_a      (wea),
      .bram_addr_a    (addra),
      .bram_wrdata_a  (dina),
      .bram_rddata_a  (douta),
      .bram_rst_b     (rstb),
      .bram_clk_b     (clkb),
      .bram_en_b      (enb),
      .bram_we_b      (web),
      .bram_addr_b    (addrb),
      .bram_wrdata_b  (dinb)  ,
      .bram_rddata_b  (doutb)
    );

    blk_mem_gen_0 u_mem(
      .clka    (clka),
      .rsta    (rsta),
      .ena     (ena),
      .wea     (wea),
      .addra   ({addra}),
      .dina    (dina),
      .douta   (douta),
      .clkb    (clkb),
      .rstb    (rstb),
      .enb     (enb),
      .web     (web),
      .addrb   ({addrb}),
      .dinb    (dinb),
      .doutb   (doutb)
    );

        MIG_SIM u_mig_2(
      .s_axi_aclk     (gt_txusrclk),
      .s_axi_aresetn  (~peripheral_reset),
      .s_axi_awid     (M01_AXI_AWID),
      .s_axi_awaddr   (M01_AXI_AWADDR),
      .s_axi_awlen    (M01_AXI_AWLEN),
      .s_axi_awsize   (M01_AXI_AWSIZE),
      .s_axi_awburst  (M01_AXI_AWBURST),
      .s_axi_awlock   (M01_AXI_AWLOCK),
      .s_axi_awcache  (M01_AXI_AWCACHE),
      .s_axi_awprot   (M01_AXI_AWPROT),
      .s_axi_awvalid  (M01_AXI_AWVALID),
      .s_axi_awready  (M01_AXI_AWREADY),
      .s_axi_wdata    (M01_AXI_WDATA),
      .s_axi_wstrb    (M01_AXI_WSTRB),
      .s_axi_wlast    (M01_AXI_WLAST),
      .s_axi_wvalid   (M01_AXI_WVALID),
      .s_axi_wready   (M01_AXI_WREADY),
      .s_axi_bid      (M01_AXI_BID),
      .s_axi_bresp    (M01_AXI_BRESP),
      .s_axi_bvalid   (M01_AXI_BVALID),
      .s_axi_bready   (M01_AXI_BREADY),
      .s_axi_arid     (M01_AXI_ARID),
      .s_axi_araddr   (M01_AXI_ARADDR),
      .s_axi_arlen    (M01_AXI_ARLEN),
      .s_axi_arsize   (M01_AXI_ARSIZE),
      .s_axi_arburst  (M01_AXI_ARBURST),
      .s_axi_arlock   (M01_AXI_ARLOCK),
      .s_axi_arcache  (M01_AXI_ARCACHE),
      .s_axi_arprot   (M01_AXI_ARPROT),
      .s_axi_arvalid  (M01_AXI_ARVALID),
      .s_axi_arready  (M01_AXI_ARREADY),
      .s_axi_rid      (M01_AXI_RID),
      .s_axi_rdata    (M01_AXI_RDATA),
      .s_axi_rresp    (M01_AXI_RRESP),
      .s_axi_rlast    (M01_AXI_RLAST),
      .s_axi_rvalid   (M01_AXI_RVALID),
      .s_axi_rready   (M01_AXI_RREADY),
      .bram_rst_a     (rsta1),
      .bram_clk_a     (clka1),
      .bram_en_a      (ena1),
      .bram_we_a      (wea1),
      .bram_addr_a    (addra1),
      .bram_wrdata_a  (dina1),
      .bram_rddata_a  (douta1),
      .bram_rst_b     (rstb1),
      .bram_clk_b     (clkb1),
      .bram_en_b      (enb1),
      .bram_we_b      (web1),
      .bram_addr_b    (addrb1),
      .bram_wrdata_b  (dinb1)  ,
      .bram_rddata_b  (doutb1)
    );

    u_mem_2 u_mem_2(
      .clka    (clka1),
      .rsta    (rsta1),
      .ena     (ena1),
      .wea     (wea1),
      .addra   ({addra1}),
      .dina    (dina1),
      .douta   (douta1),
      .clkb    (clkb1),
      .rstb    (rstb1),
      .enb     (enb1),
      .web     (web1),
      .addrb   ({addrb1}),
      .dinb    (dinb1),
      .doutb   (doutb1)
    );
  wire         io_PSmempory_aw_ready;
  wire         io_PSmempory_aw_valid;
  wire [63:0]  io_PSmempory_aw_bits_awaddr;
  wire [5:0]   io_PSmempory_aw_bits_awid;
  wire [7:0]   io_PSmempory_aw_bits_awlen;
  wire [2:0]   io_PSmempory_aw_bits_awsize;
  wire [1:0]   io_PSmempory_aw_bits_awburst;
  wire         io_PSmempory_aw_bits_awlock;
  wire         io_PSmempory_ar_ready;
  wire         io_PSmempory_ar_valid;
  wire [63:0]  io_PSmempory_ar_bits_araddr;
  wire [5:0]   io_PSmempory_ar_bits_arid;
  wire [7:0]   io_PSmempory_ar_bits_arlen;
  wire [2:0]   io_PSmempory_ar_bits_arsize;
  wire [1:0]   io_PSmempory_ar_bits_arburst;
  wire         io_PSmempory_ar_bits_arlock;
  wire         io_PSmempory_w_ready;
  wire         io_PSmempory_w_valid;
  wire [127:0] io_PSmempory_w_bits_wdata;
  wire [15:0]  io_PSmempory_w_bits_wstrb;
  wire         io_PSmempory_w_bits_wlast;
  wire         io_PSmempory_r_ready;
  wire         io_PSmempory_r_valid;
  wire [127:0] io_PSmempory_r_bits_rdata;
  wire [5:0]   io_PSmempory_r_bits_rid;
  wire         io_PSmempory_r_bits_rlast;
  wire         io_PSmempory_b_ready;
  wire         io_PSmempory_b_valid;
  wire [1:0]   io_PSmempory_b_bits_bresp;
  wire [5:0]   io_PSmempory_b_bits_bid;

  wire         io_PSmempory_1_aw_ready;
  wire         io_PSmempory_1_aw_valid;
  wire [63:0]  io_PSmempory_1_aw_bits_awaddr;
  wire [5:0]   io_PSmempory_1_aw_bits_awid;
  wire [7:0]   io_PSmempory_1_aw_bits_awlen;
  wire [2:0]   io_PSmempory_1_aw_bits_awsize;
  wire [1:0]   io_PSmempory_1_aw_bits_awburst;
  wire         io_PSmempory_1_aw_bits_awlock;
  wire         io_PSmempory_1_ar_ready;
  wire         io_PSmempory_1_ar_valid;
  wire [63:0]  io_PSmempory_1_ar_bits_araddr;
  wire [5:0]   io_PSmempory_1_ar_bits_arid;
  wire [7:0]   io_PSmempory_1_ar_bits_arlen;
  wire [2:0]   io_PSmempory_1_ar_bits_arsize;
  wire [1:0]   io_PSmempory_1_ar_bits_arburst;
  wire         io_PSmempory_1_ar_bits_arlock;
  wire         io_PSmempory_1_w_ready;
  wire         io_PSmempory_1_w_valid;
  wire [127:0] io_PSmempory_1_w_bits_wdata;
  wire [15:0]  io_PSmempory_1_w_bits_wstrb;
  wire         io_PSmempory_1_w_bits_wlast;
  wire         io_PSmempory_1_r_ready;
  wire         io_PSmempory_1_r_valid;
  wire [127:0] io_PSmempory_1_r_bits_rdata;
  wire [5:0]   io_PSmempory_1_r_bits_rid;
  wire         io_PSmempory_1_r_bits_rlast;
  wire         io_PSmempory_1_b_ready;
  wire         io_PSmempory_1_b_valid;
  wire [1:0]   io_PSmempory_1_b_bits_bresp;
  wire [5:0]   io_PSmempory_1_b_bits_bid;

  wire         io_PSmempory_2_aw_ready;
  wire         io_PSmempory_2_aw_valid;
  wire [63:0]  io_PSmempory_2_aw_bits_awaddr;
  wire [5:0]   io_PSmempory_2_aw_bits_awid;
  wire [7:0]   io_PSmempory_2_aw_bits_awlen;
  wire [2:0]   io_PSmempory_2_aw_bits_awsize;
  wire [1:0]   io_PSmempory_2_aw_bits_awburst;
  wire         io_PSmempory_2_aw_bits_awlock;
  wire         io_PSmempory_2_ar_ready;
  wire         io_PSmempory_2_ar_valid;
  wire [63:0]  io_PSmempory_2_ar_bits_araddr;
  wire [5:0]   io_PSmempory_2_ar_bits_arid;
  wire [7:0]   io_PSmempory_2_ar_bits_arlen;
  wire [2:0]   io_PSmempory_2_ar_bits_arsize;
  wire [1:0]   io_PSmempory_2_ar_bits_arburst;
  wire         io_PSmempory_2_ar_bits_arlock;
  wire         io_PSmempory_2_w_ready;
  wire         io_PSmempory_2_w_valid;
  wire [127:0] io_PSmempory_2_w_bits_wdata;
  wire [15:0]  io_PSmempory_2_w_bits_wstrb;
  wire         io_PSmempory_2_w_bits_wlast;
  wire         io_PSmempory_2_r_ready;
  wire         io_PSmempory_2_r_valid;
  wire [127:0] io_PSmempory_2_r_bits_rdata;
  wire [5:0]   io_PSmempory_2_r_bits_rid;
  wire         io_PSmempory_2_r_bits_rlast;
  wire         io_PSmempory_2_b_ready;
  wire         io_PSmempory_2_b_valid;
  wire [1:0]   io_PSmempory_2_b_bits_bresp;
  wire [5:0]   io_PSmempory_2_b_bits_bid;

  wire         io_PSmempory_3_aw_ready;
  wire         io_PSmempory_3_aw_valid;
  wire [63:0]  io_PSmempory_3_aw_bits_awaddr;
  wire [5:0]   io_PSmempory_3_aw_bits_awid;
  wire [7:0]   io_PSmempory_3_aw_bits_awlen;
  wire [2:0]   io_PSmempory_3_aw_bits_awsize;
  wire [1:0]   io_PSmempory_3_aw_bits_awburst;
  wire         io_PSmempory_3_aw_bits_awlock;
  wire         io_PSmempory_3_ar_ready;
  wire         io_PSmempory_3_ar_valid;
  wire [63:0]  io_PSmempory_3_ar_bits_araddr;
  wire [5:0]   io_PSmempory_3_ar_bits_arid;
  wire [7:0]   io_PSmempory_3_ar_bits_arlen;
  wire [2:0]   io_PSmempory_3_ar_bits_arsize;
  wire [1:0]   io_PSmempory_3_ar_bits_arburst;
  wire         io_PSmempory_3_ar_bits_arlock;
  wire         io_PSmempory_3_w_ready;
  wire         io_PSmempory_3_w_valid;
  wire [127:0] io_PSmempory_3_w_bits_wdata;
  wire [15:0]  io_PSmempory_3_w_bits_wstrb;
  wire         io_PSmempory_3_w_bits_wlast;
  wire         io_PSmempory_3_r_ready;
  wire         io_PSmempory_3_r_valid;
  wire [127:0] io_PSmempory_3_r_bits_rdata;
  wire [5:0]   io_PSmempory_3_r_bits_rid;
  wire         io_PSmempory_3_r_bits_rlast;
  wire         io_PSmempory_3_b_ready;
  wire         io_PSmempory_3_b_valid;
  wire [1:0]   io_PSmempory_3_b_bits_bresp;
  wire [5:0]   io_PSmempory_3_b_bits_bid;

  wire         io_Re_memory_out_aw_ready;
  wire         io_Re_memory_out_aw_valid;
  wire [63:0]  io_Re_memory_out_aw_bits_awaddr;
  wire [5:0]   io_Re_memory_out_aw_bits_awid;
  wire [7:0]   io_Re_memory_out_aw_bits_awlen;
  wire [2:0]   io_Re_memory_out_aw_bits_awsize;
  wire [1:0]   io_Re_memory_out_aw_bits_awburst;
  wire         io_Re_memory_out_aw_bits_awlock;
  wire         io_Re_memory_out_ar_ready;
  wire         io_Re_memory_out_ar_valid;
  wire [63:0]  io_Re_memory_out_ar_bits_araddr;
  wire [5:0]   io_Re_memory_out_ar_bits_arid;
  wire [7:0]   io_Re_memory_out_ar_bits_arlen;
  wire [2:0]   io_Re_memory_out_ar_bits_arsize;
  wire [1:0]   io_Re_memory_out_ar_bits_arburst;
  wire         io_Re_memory_out_ar_bits_arlock;
  wire         io_Re_memory_out_w_ready;
  wire         io_Re_memory_out_w_valid;
  wire [511:0] io_Re_memory_out_w_bits_wdata;
  wire [63:0]  io_Re_memory_out_w_bits_wstrb;
  wire         io_Re_memory_out_w_bits_wlast;
  wire         io_Re_memory_out_r_ready;
  wire         io_Re_memory_out_r_valid;
  wire [511:0] io_Re_memory_out_r_bits_rdata;
  wire [5:0]   io_Re_memory_out_r_bits_rid;
  wire         io_Re_memory_out_r_bits_rlast;
  wire         io_Re_memory_out_b_ready;
  wire         io_Re_memory_out_b_valid;
  wire [1:0]   io_Re_memory_out_b_bits_bresp;
  wire [5:0]   io_Re_memory_out_b_bits_bid;

  wire         io_Re_memory_in_aw_ready;
  wire         io_Re_memory_in_aw_valid;
  wire [63:0]  io_Re_memory_in_aw_bits_awaddr;
  wire [9:0]   io_Re_memory_in_aw_bits_awid;
  wire [7:0]   io_Re_memory_in_aw_bits_awlen;
  wire [2:0]   io_Re_memory_in_aw_bits_awsize;
  wire [1:0]   io_Re_memory_in_aw_bits_awburst;
  wire         io_Re_memory_in_aw_bits_awlock;
  wire         io_Re_memory_in_ar_ready;
  wire         io_Re_memory_in_ar_valid;
  wire [63:0]  io_Re_memory_in_ar_bits_araddr;
  wire [9:0]   io_Re_memory_in_ar_bits_arid;
  wire [7:0]   io_Re_memory_in_ar_bits_arlen;
  wire [2:0]   io_Re_memory_in_ar_bits_arsize;
  wire [1:0]   io_Re_memory_in_ar_bits_arburst;
  wire         io_Re_memory_in_ar_bits_arlock;
  wire         io_Re_memory_in_w_ready;
  wire         io_Re_memory_in_w_valid;
  wire [511:0] io_Re_memory_in_w_bits_wdata;
  wire [63:0]  io_Re_memory_in_w_bits_wstrb;
  wire         io_Re_memory_in_w_bits_wlast;
  wire         io_Re_memory_in_r_ready;
  wire         io_Re_memory_in_r_valid;
  wire [511:0] io_Re_memory_in_r_bits_rdata;
  wire [9:0]   io_Re_memory_in_r_bits_rid;
  wire         io_Re_memory_in_r_bits_rlast;
  wire         io_Re_memory_in_b_ready;
  wire         io_Re_memory_in_b_valid;
  wire [1:0]   io_Re_memory_in_b_bits_bresp;
  wire [9:0]   io_Re_memory_in_b_bits_bid;

  wire [63:0]  bfs_io_config_awaddr;
  wire         bfs_io_config_awvalid;
  wire         bfs_io_config_awready;
  wire [63:0]  bfs_io_config_araddr;
  wire         bfs_io_config_arvalid;
  wire         bfs_io_config_arready;
  wire [31:0]  bfs_io_config_wdata;
  wire [3:0]   bfs_io_config_wstrb;
  wire         bfs_io_config_wvalid;
  wire         bfs_io_config_wready;
  wire [31:0]  bfs_io_config_rdata;
  wire [1:0]   bfs_io_config_rresp;
  wire         bfs_io_config_rvalid;
  wire         bfs_io_config_rready;
  wire [1:0]   bfs_io_config_bresp;
  wire         bfs_io_config_bvalid;
  wire         bfs_io_config_bready;

    design_1 u_xbar(
      .INTERCONNECT_ACLK      (gt_txusrclk),
      .INTERCONNECT_ARESETN   (~peripheral_reset),
      .clk_doce                 (doceclk),
      .doce_resetn              (~peripheral_reset),
      .clk_cmac                  (cmacclk),
      .cmac_resetn              (~peripheral_reset),

      .doce_axis_rxd_tdata    (doce_axis_rxd_tdata),
      .doce_axis_rxd_tkeep    (doce_axis_rxd_tkeep),
      .doce_axis_rxd_tlast    (doce_axis_rxd_tlast),
      .doce_axis_rxd_tready   (doce_axis_rxd_tready),
      .doce_axis_rxd_tvalid   (doce_axis_rxd_tvalid),
      .doce_axis_txd_tdata    (doce_axis_txd_tdata),
      .doce_axis_txd_tkeep    (doce_axis_txd_tkeep),
      .doce_axis_txd_tlast    (doce_axis_txd_tlast),
      .doce_axis_txd_tready   (doce_axis_txd_tready),
      .doce_axis_txd_tvalid   (doce_axis_txd_tvalid),

      .io_PLmemory_0_awid           ({1'b0, io_PLmemory_0_awid[5:0]}),
      .io_PLmemory_0_awaddr         (io_PLmemory_0_awaddr),
      .io_PLmemory_0_awlen          (io_PLmemory_0_awlen),
      .io_PLmemory_0_awsize         (io_PLmemory_0_awsize),
      .io_PLmemory_0_awburst        (io_PLmemory_0_awburst),
      .io_PLmemory_0_awlock         (io_PLmemory_0_awlock),
      .io_PLmemory_0_awvalid        (io_PLmemory_0_awvalid),
      .io_PLmemory_0_awready        (io_PLmemory_0_awready),
      .io_PLmemory_0_wdata          (io_PLmemory_0_wdata),
      .io_PLmemory_0_wstrb          (io_PLmemory_0_wstrb),
      .io_PLmemory_0_wlast          (io_PLmemory_0_wlast),
      .io_PLmemory_0_wvalid         (io_PLmemory_0_wvalid),
      .io_PLmemory_0_wready         (io_PLmemory_0_wready),
      .io_PLmemory_0_bid            (io_PLmemory_0_bid),
      .io_PLmemory_0_bresp          (io_PLmemory_0_bresp),
      .io_PLmemory_0_bvalid         (io_PLmemory_0_bvalid),
      .io_PLmemory_0_bready         (io_PLmemory_0_bready),
      .io_PLmemory_0_arid           ({1'b0, io_PLmemory_0_arid[5:0]}),
      .io_PLmemory_0_araddr         (io_PLmemory_0_araddr),
      .io_PLmemory_0_arlen          (io_PLmemory_0_arlen),
      .io_PLmemory_0_arsize         (io_PLmemory_0_arsize),
      .io_PLmemory_0_arburst        (io_PLmemory_0_arburst),
      .io_PLmemory_0_arlock         (io_PLmemory_0_arlock),
      .io_PLmemory_0_arvalid        (io_PLmemory_0_arvalid),
      .io_PLmemory_0_arready        (io_PLmemory_0_arready),
      .io_PLmemory_0_rid            (io_PLmemory_0_rid),
      .io_PLmemory_0_rdata          (io_PLmemory_0_rdata),
      .io_PLmemory_0_rresp          (io_PLmemory_0_rresp),
      .io_PLmemory_0_rlast          (io_PLmemory_0_rlast),
      .io_PLmemory_0_rvalid         (io_PLmemory_0_rvalid),
      .io_PLmemory_0_rready         (io_PLmemory_0_rready),

      .io_PLmemory_1_awid           ({1'b0, io_PLmemory_1_awid[5:0]}),
      .io_PLmemory_1_awaddr         (io_PLmemory_1_awaddr),
      .io_PLmemory_1_awlen          (io_PLmemory_1_awlen),
      .io_PLmemory_1_awsize         (io_PLmemory_1_awsize),
      .io_PLmemory_1_awburst        (io_PLmemory_1_awburst),
      .io_PLmemory_1_awlock         (io_PLmemory_1_awlock),
      .io_PLmemory_1_awvalid        (io_PLmemory_1_awvalid),
      .io_PLmemory_1_awready        (io_PLmemory_1_awready),
      .io_PLmemory_1_wdata          (io_PLmemory_1_wdata),
      .io_PLmemory_1_wstrb          (io_PLmemory_1_wstrb),
      .io_PLmemory_1_wlast          (io_PLmemory_1_wlast),
      .io_PLmemory_1_wvalid         (io_PLmemory_1_wvalid),
      .io_PLmemory_1_wready         (io_PLmemory_1_wready),
      .io_PLmemory_1_bid            (io_PLmemory_1_bid),
      .io_PLmemory_1_bresp          (io_PLmemory_1_bresp),
      .io_PLmemory_1_bvalid         (io_PLmemory_1_bvalid),
      .io_PLmemory_1_bready         (io_PLmemory_1_bready),
      .io_PLmemory_1_arid           ({1'b0, io_PLmemory_1_arid[5:0]}),
      .io_PLmemory_1_araddr         (io_PLmemory_1_araddr),
      .io_PLmemory_1_arlen          (io_PLmemory_1_arlen),
      .io_PLmemory_1_arsize         (io_PLmemory_1_arsize),
      .io_PLmemory_1_arburst        (io_PLmemory_1_arburst),
      .io_PLmemory_1_arlock         (io_PLmemory_1_arlock),
      .io_PLmemory_1_arvalid        (io_PLmemory_1_arvalid),
      .io_PLmemory_1_arready        (io_PLmemory_1_arready),
      .io_PLmemory_1_rid            (io_PLmemory_1_rid),
      .io_PLmemory_1_rdata          (io_PLmemory_1_rdata),
      .io_PLmemory_1_rresp          (io_PLmemory_1_rresp),
      .io_PLmemory_1_rlast          (io_PLmemory_1_rlast),
      .io_PLmemory_1_rvalid         (io_PLmemory_1_rvalid),
      .io_PLmemory_1_rready         (io_PLmemory_1_rready),

      .io_PLmemory_2_awaddr         (M00_AXI_AWADDR),  
      .io_PLmemory_2_awlen          (M00_AXI_AWLEN),
      .io_PLmemory_2_awsize         (M00_AXI_AWSIZE),
      .io_PLmemory_2_awburst        (M00_AXI_AWBURST),
      .io_PLmemory_2_awlock         (M00_AXI_AWLOCK),
      .io_PLmemory_2_awcache        (M00_AXI_AWCACHE),
      .io_PLmemory_2_awprot         (M00_AXI_AWPROT),
      .io_PLmemory_2_awqos          (M00_AXI_AWQOS),
      .io_PLmemory_2_awvalid        (M00_AXI_AWVALID),
      .io_PLmemory_2_awready        (M00_AXI_AWREADY),
      .io_PLmemory_2_awid           (M00_AXI_AWID),
      .io_PLmemory_2_wdata          (M00_AXI_WDATA),
      .io_PLmemory_2_wstrb          (M00_AXI_WSTRB),
      .io_PLmemory_2_wlast          (M00_AXI_WLAST),
      .io_PLmemory_2_wvalid         (M00_AXI_WVALID),
      .io_PLmemory_2_wready         (M00_AXI_WREADY),
      .io_PLmemory_2_bid            (M00_AXI_BID),
      .io_PLmemory_2_bresp          (M00_AXI_BRESP),
      .io_PLmemory_2_bvalid         (M00_AXI_BVALID),
      .io_PLmemory_2_bready         (M00_AXI_BREADY),
      .io_PLmemory_2_arid           (M00_AXI_ARID),
      .io_PLmemory_2_araddr         (M00_AXI_ARADDR),
      .io_PLmemory_2_arlen          (M00_AXI_ARLEN),
      .io_PLmemory_2_arsize         (M00_AXI_ARSIZE),
      .io_PLmemory_2_arburst        (M00_AXI_ARBURST),
      .io_PLmemory_2_arlock         (M00_AXI_ARLOCK),
      .io_PLmemory_2_arcache        (M00_AXI_ARCACHE),
      .io_PLmemory_2_arprot         (M00_AXI_ARPROT),
      .io_PLmemory_2_arqos          (M00_AXI_ARQOS),
      .io_PLmemory_2_arvalid        (M00_AXI_ARVALID),
      .io_PLmemory_2_arready        (M00_AXI_ARREADY),
      .io_PLmemory_2_rid            (M00_AXI_RID),
      .io_PLmemory_2_rdata          (M00_AXI_RDATA),
      .io_PLmemory_2_rresp          (M00_AXI_RRESP),
      .io_PLmemory_2_rlast          (M00_AXI_RLAST),
      .io_PLmemory_2_rvalid         (M00_AXI_RVALID),
      .io_PLmemory_2_rready         (M00_AXI_RREADY),

      .io_PLmemory_3_awaddr         (M01_AXI_AWADDR),  
      .io_PLmemory_3_awlen          (M01_AXI_AWLEN),
      .io_PLmemory_3_awsize         (M01_AXI_AWSIZE),
      .io_PLmemory_3_awburst        (M01_AXI_AWBURST),
      .io_PLmemory_3_awlock         (M01_AXI_AWLOCK),
      .io_PLmemory_3_awcache        (M01_AXI_AWCACHE),
      .io_PLmemory_3_awprot         (M01_AXI_AWPROT),
      .io_PLmemory_3_awqos          (M01_AXI_AWQOS),
      .io_PLmemory_3_awvalid        (M01_AXI_AWVALID),
      .io_PLmemory_3_awready        (M01_AXI_AWREADY),
      .io_PLmemory_3_awid           (M01_AXI_AWID),
      .io_PLmemory_3_wdata          (M01_AXI_WDATA),
      .io_PLmemory_3_wstrb          (M01_AXI_WSTRB),
      .io_PLmemory_3_wlast          (M01_AXI_WLAST),
      .io_PLmemory_3_wvalid         (M01_AXI_WVALID),
      .io_PLmemory_3_wready         (M01_AXI_WREADY),
      .io_PLmemory_3_bid            (M01_AXI_BID),
      .io_PLmemory_3_bresp          (M01_AXI_BRESP),
      .io_PLmemory_3_bvalid         (M01_AXI_BVALID),
      .io_PLmemory_3_bready         (M01_AXI_BREADY),
      .io_PLmemory_3_arid           (M01_AXI_ARID),
      .io_PLmemory_3_araddr         (M01_AXI_ARADDR),
      .io_PLmemory_3_arlen          (M01_AXI_ARLEN),
      .io_PLmemory_3_arsize         (M01_AXI_ARSIZE),
      .io_PLmemory_3_arburst        (M01_AXI_ARBURST),
      .io_PLmemory_3_arlock         (M01_AXI_ARLOCK),
      .io_PLmemory_3_arcache        (M01_AXI_ARCACHE),
      .io_PLmemory_3_arprot         (M01_AXI_ARPROT),
      .io_PLmemory_3_arqos          (M01_AXI_ARQOS),
      .io_PLmemory_3_arvalid        (M01_AXI_ARVALID),
      .io_PLmemory_3_arready        (M01_AXI_ARREADY),
      .io_PLmemory_3_rid            (M01_AXI_RID),
      .io_PLmemory_3_rdata          (M01_AXI_RDATA),
      .io_PLmemory_3_rresp          (M01_AXI_RRESP),
      .io_PLmemory_3_rlast          (M01_AXI_RLAST),
      .io_PLmemory_3_rvalid         (M01_AXI_RVALID),
      .io_PLmemory_3_rready         (M01_AXI_RREADY),

      .io_PSMemory_araddr         (io_PSmempory_ar_bits_araddr),
      .io_PSMemory_arburst        (io_PSmempory_ar_bits_arburst),
      .io_PSMemory_arcache        (),
      .io_PSMemory_arid           ({2'd0, io_PSmempory_ar_bits_arid}),
      .io_PSMemory_arlen          (io_PSmempory_ar_bits_arlen),
      .io_PSMemory_arlock         (io_PSmempory_ar_bits_arlock),
      .io_PSMemory_arprot         (),
      .io_PSMemory_arqos          (),
      .io_PSMemory_arready        (io_PSmempory_ar_ready),
      .io_PSMemory_arsize         (io_PSmempory_ar_bits_arsize),
      .io_PSMemory_arvalid        (io_PSmempory_ar_valid),
      .io_PSMemory_awaddr         (io_PSmempory_aw_bits_awaddr),
      .io_PSMemory_awburst        (io_PSmempory_aw_bits_awburst),
      .io_PSMemory_awcache        (),
      .io_PSMemory_awid           ({2'd0, io_PSmempory_aw_bits_awid}),
      .io_PSMemory_awlen          (io_PSmempory_aw_bits_awlen),
      .io_PSMemory_awlock         (io_PSmempory_aw_bits_awlock),
      .io_PSMemory_awprot         (),
      .io_PSMemory_awqos          (),
      .io_PSMemory_awready        (io_PSmempory_aw_ready),
      .io_PSMemory_awsize         (io_PSmempory_aw_bits_awsize),
      .io_PSMemory_awvalid        (io_PSmempory_aw_valid),
      .io_PSMemory_bid            (io_PSmempory_b_bits_bid),
      .io_PSMemory_bready         (io_PSmempory_b_ready),
      .io_PSMemory_bresp          (io_PSmempory_b_bits_bresp),
      .io_PSMemory_bvalid         (io_PSmempory_b_valid),
      .io_PSMemory_rdata          (io_PSmempory_r_bits_rdata),
      .io_PSMemory_rid            (io_PSmempory_r_bits_rid),
      .io_PSMemory_rlast          (io_PSmempory_r_bits_rlast),
      .io_PSMemory_rready         (io_PSmempory_r_ready),
      .io_PSMemory_rresp          (),
      .io_PSMemory_rvalid         (io_PSmempory_r_valid),
      .io_PSMemory_wdata          (io_PSmempory_w_bits_wdata),
      .io_PSMemory_wlast          (io_PSmempory_w_bits_wlast),
      .io_PSMemory_wready         (io_PSmempory_w_ready),
      .io_PSMemory_wstrb          (io_PSmempory_w_bits_wstrb),
      .io_PSMemory_wvalid         (io_PSmempory_w_valid),

      .io_PSMemory_1_araddr         (io_PSmempory_1_ar_bits_araddr),
      .io_PSMemory_1_arburst        (io_PSmempory_1_ar_bits_arburst),
      .io_PSMemory_1_arid           ({2'd1, io_PSmempory_1_ar_bits_arid}),
      .io_PSMemory_1_arlen          (io_PSmempory_1_ar_bits_arlen),
      .io_PSMemory_1_arlock         (io_PSmempory_1_ar_bits_arlock),
      .io_PSMemory_1_arready        (io_PSmempory_1_ar_ready),
      .io_PSMemory_1_arsize         (io_PSmempory_1_ar_bits_arsize),
      .io_PSMemory_1_arvalid        (io_PSmempory_1_ar_valid),
      .io_PSMemory_1_awaddr         (io_PSmempory_1_aw_bits_awaddr),
      .io_PSMemory_1_awburst        (io_PSmempory_1_aw_bits_awburst),
      .io_PSMemory_1_awid           ({2'd1, io_PSmempory_1_aw_bits_awid}),
      .io_PSMemory_1_awlen          (io_PSmempory_1_aw_bits_awlen),
      .io_PSMemory_1_awlock         (io_PSmempory_1_aw_bits_awlock),
      .io_PSMemory_1_awready        (io_PSmempory_1_aw_ready),
      .io_PSMemory_1_awsize         (io_PSmempory_1_aw_bits_awsize),
      .io_PSMemory_1_awvalid        (io_PSmempory_1_aw_valid),
      .io_PSMemory_1_bid            (io_PSmempory_1_b_bits_bid),
      .io_PSMemory_1_bready         (io_PSmempory_1_b_ready),
      .io_PSMemory_1_bresp          (io_PSmempory_1_b_bits_bresp),
      .io_PSMemory_1_bvalid         (io_PSmempory_1_b_valid),
      .io_PSMemory_1_rdata          (io_PSmempory_1_r_bits_rdata),
      .io_PSMemory_1_rid            (io_PSmempory_1_r_bits_rid),
      .io_PSMemory_1_rlast          (io_PSmempory_1_r_bits_rlast),
      .io_PSMemory_1_rready         (io_PSmempory_1_r_ready),
      .io_PSMemory_1_rvalid         (io_PSmempory_1_r_valid),
      .io_PSMemory_1_wdata          (io_PSmempory_1_w_bits_wdata),
      .io_PSMemory_1_wlast          (io_PSmempory_1_w_bits_wlast),
      .io_PSMemory_1_wready         (io_PSmempory_1_w_ready),
      .io_PSMemory_1_wstrb          (io_PSmempory_1_w_bits_wstrb),
      .io_PSMemory_1_wvalid         (io_PSmempory_1_w_valid),

      .io_PSMemory_2_araddr         (io_PSmempory_2_ar_bits_araddr),
      .io_PSMemory_2_arburst        (io_PSmempory_2_ar_bits_arburst),
      .io_PSMemory_2_arid           ({2'd2, io_PSmempory_2_ar_bits_arid}),
      .io_PSMemory_2_arlen          (io_PSmempory_2_ar_bits_arlen),
      .io_PSMemory_2_arlock         (io_PSmempory_2_ar_bits_arlock),
      .io_PSMemory_2_arready        (io_PSmempory_2_ar_ready),
      .io_PSMemory_2_arsize         (io_PSmempory_2_ar_bits_arsize),
      .io_PSMemory_2_arvalid        (io_PSmempory_2_ar_valid),
      .io_PSMemory_2_awaddr         (io_PSmempory_2_aw_bits_awaddr),
      .io_PSMemory_2_awburst        (io_PSmempory_2_aw_bits_awburst),
      .io_PSMemory_2_awid           ({2'd2, io_PSmempory_2_aw_bits_awid}),
      .io_PSMemory_2_awlen          (io_PSmempory_2_aw_bits_awlen),
      .io_PSMemory_2_awlock         (io_PSmempory_2_aw_bits_awlock),
      .io_PSMemory_2_awready        (io_PSmempory_2_aw_ready),
      .io_PSMemory_2_awsize         (io_PSmempory_2_aw_bits_awsize),
      .io_PSMemory_2_awvalid        (io_PSmempory_2_aw_valid),
      .io_PSMemory_2_bid            (io_PSmempory_2_b_bits_bid),
      .io_PSMemory_2_bready         (io_PSmempory_2_b_ready),
      .io_PSMemory_2_bresp          (io_PSmempory_2_b_bits_bresp),
      .io_PSMemory_2_bvalid         (io_PSmempory_2_b_valid),
      .io_PSMemory_2_rdata          (io_PSmempory_2_r_bits_rdata),
      .io_PSMemory_2_rid            (io_PSmempory_2_r_bits_rid),
      .io_PSMemory_2_rlast          (io_PSmempory_2_r_bits_rlast),
      .io_PSMemory_2_rready         (io_PSmempory_2_r_ready),
      .io_PSMemory_2_rvalid         (io_PSmempory_2_r_valid),
      .io_PSMemory_2_wdata          (io_PSmempory_2_w_bits_wdata),
      .io_PSMemory_2_wlast          (io_PSmempory_2_w_bits_wlast),
      .io_PSMemory_2_wready         (io_PSmempory_2_w_ready),
      .io_PSMemory_2_wstrb          (io_PSmempory_2_w_bits_wstrb),
      .io_PSMemory_2_wvalid         (io_PSmempory_2_w_valid),

      .io_PSMemory_3_araddr         (io_PSmempory_3_ar_bits_araddr),
      .io_PSMemory_3_arburst        (io_PSmempory_3_ar_bits_arburst),
      .io_PSMemory_3_arid           ({2'd3, io_PSmempory_3_ar_bits_arid}),
      .io_PSMemory_3_arlen          (io_PSmempory_3_ar_bits_arlen),
      .io_PSMemory_3_arlock         (io_PSmempory_3_ar_bits_arlock),
      .io_PSMemory_3_arready        (io_PSmempory_3_ar_ready),
      .io_PSMemory_3_arsize         (io_PSmempory_3_ar_bits_arsize),
      .io_PSMemory_3_arvalid        (io_PSmempory_3_ar_valid),
      .io_PSMemory_3_awaddr         (io_PSmempory_3_aw_bits_awaddr),
      .io_PSMemory_3_awburst        (io_PSmempory_3_aw_bits_awburst),
      .io_PSMemory_3_awid           ({2'd3, io_PSmempory_3_aw_bits_awid}),
      .io_PSMemory_3_awlen          (io_PSmempory_3_aw_bits_awlen),
      .io_PSMemory_3_awlock         (io_PSmempory_3_aw_bits_awlock),
      .io_PSMemory_3_awready        (io_PSmempory_3_aw_ready),
      .io_PSMemory_3_awsize         (io_PSmempory_3_aw_bits_awsize),
      .io_PSMemory_3_awvalid        (io_PSmempory_3_aw_valid),
      .io_PSMemory_3_bid            (io_PSmempory_3_b_bits_bid),
      .io_PSMemory_3_bready         (io_PSmempory_3_b_ready),
      .io_PSMemory_3_bresp          (io_PSmempory_3_b_bits_bresp),
      .io_PSMemory_3_bvalid         (io_PSmempory_3_b_valid),
      .io_PSMemory_3_rdata          (io_PSmempory_3_r_bits_rdata),
      .io_PSMemory_3_rid            (io_PSmempory_3_r_bits_rid),
      .io_PSMemory_3_rlast          (io_PSmempory_3_r_bits_rlast),
      .io_PSMemory_3_rready         (io_PSmempory_3_r_ready),
      .io_PSMemory_3_rvalid         (io_PSmempory_3_r_valid),
      .io_PSMemory_3_wdata          (io_PSmempory_3_w_bits_wdata),
      .io_PSMemory_3_wlast          (io_PSmempory_3_w_bits_wlast),
      .io_PSMemory_3_wready         (io_PSmempory_3_w_ready),
      .io_PSMemory_3_wstrb          (io_PSmempory_3_w_bits_wstrb),
      .io_PSMemory_3_wvalid         (io_PSmempory_3_w_valid),

      .io_Re_memory_out_araddr         (io_Re_memory_out_ar_bits_araddr),
      .io_Re_memory_out_arburst        (io_Re_memory_out_ar_bits_arburst),
      .io_Re_memory_out_arid           (io_Re_memory_out_ar_bits_arid),
      .io_Re_memory_out_arlen          (io_Re_memory_out_ar_bits_arlen),
      .io_Re_memory_out_arlock         (io_Re_memory_out_ar_bits_arlock),
      .io_Re_memory_out_arready        (io_Re_memory_out_ar_ready),
      .io_Re_memory_out_arsize         (io_Re_memory_out_ar_bits_arsize),
      .io_Re_memory_out_arvalid        (io_Re_memory_out_ar_valid),
      .io_Re_memory_out_awaddr         (io_Re_memory_out_aw_bits_awaddr),
      .io_Re_memory_out_awburst        (io_Re_memory_out_aw_bits_awburst),
      .io_Re_memory_out_awid           (io_Re_memory_out_aw_bits_awid),
      .io_Re_memory_out_awlen          (io_Re_memory_out_aw_bits_awlen),
      .io_Re_memory_out_awlock         (io_Re_memory_out_aw_bits_awlock),
      .io_Re_memory_out_awready        (io_Re_memory_out_aw_ready),
      .io_Re_memory_out_awsize         (io_Re_memory_out_aw_bits_awsize),
      .io_Re_memory_out_awvalid        (io_Re_memory_out_aw_valid),
      .io_Re_memory_out_bid            (io_Re_memory_out_b_bits_bid),
      .io_Re_memory_out_bready         (io_Re_memory_out_b_ready),
      .io_Re_memory_out_bresp          (io_Re_memory_out_b_bits_bresp),
      .io_Re_memory_out_bvalid         (io_Re_memory_out_b_valid),
      .io_Re_memory_out_rdata          (io_Re_memory_out_r_bits_rdata),
      .io_Re_memory_out_rid            (io_Re_memory_out_r_bits_rid),
      .io_Re_memory_out_rlast          (io_Re_memory_out_r_bits_rlast),
      .io_Re_memory_out_rready         (io_Re_memory_out_r_ready),
      .io_Re_memory_out_rvalid         (io_Re_memory_out_r_valid),
      .io_Re_memory_out_wdata          (io_Re_memory_out_w_bits_wdata),
      .io_Re_memory_out_wlast          (io_Re_memory_out_w_bits_wlast),
      .io_Re_memory_out_wready         (io_Re_memory_out_w_ready),
      .io_Re_memory_out_wstrb          (io_Re_memory_out_w_bits_wstrb),
      .io_Re_memory_out_wvalid         (io_Re_memory_out_w_valid),

      .io_Re_memory_in_araddr         (io_Re_memory_in_ar_bits_araddr),
      .io_Re_memory_in_arburst        (io_Re_memory_in_ar_bits_arburst),
      .io_Re_memory_in_arid           (io_Re_memory_in_ar_bits_arid),
      .io_Re_memory_in_arlen          (io_Re_memory_in_ar_bits_arlen),
      .io_Re_memory_in_arlock         (io_Re_memory_in_ar_bits_arlock),
      .io_Re_memory_in_arready        (io_Re_memory_in_ar_ready),
      .io_Re_memory_in_arsize         (io_Re_memory_in_ar_bits_arsize),
      .io_Re_memory_in_arvalid        (io_Re_memory_in_ar_valid),
      .io_Re_memory_in_awaddr         (io_Re_memory_in_aw_bits_awaddr),
      .io_Re_memory_in_awburst        (io_Re_memory_in_aw_bits_awburst),
      .io_Re_memory_in_awid           (io_Re_memory_in_aw_bits_awid),
      .io_Re_memory_in_awlen          (io_Re_memory_in_aw_bits_awlen),
      .io_Re_memory_in_awlock         (io_Re_memory_in_aw_bits_awlock),
      .io_Re_memory_in_awready        (io_Re_memory_in_aw_ready),
      .io_Re_memory_in_awsize         (io_Re_memory_in_aw_bits_awsize),
      .io_Re_memory_in_awvalid        (io_Re_memory_in_aw_valid),
      .io_Re_memory_in_bid            (io_Re_memory_in_b_bits_bid),
      .io_Re_memory_in_bready         (io_Re_memory_in_b_ready),
      .io_Re_memory_in_bresp          (io_Re_memory_in_b_bits_bresp),
      .io_Re_memory_in_bvalid         (io_Re_memory_in_b_valid),
      .io_Re_memory_in_rdata          (io_Re_memory_in_r_bits_rdata),
      .io_Re_memory_in_rid            (io_Re_memory_in_r_bits_rid),
      .io_Re_memory_in_rlast          (io_Re_memory_in_r_bits_rlast),
      .io_Re_memory_in_rready         (io_Re_memory_in_r_ready),
      .io_Re_memory_in_rvalid         (io_Re_memory_in_r_valid),
      .io_Re_memory_in_wdata          (io_Re_memory_in_w_bits_wdata),
      .io_Re_memory_in_wlast          (io_Re_memory_in_w_bits_wlast),
      .io_Re_memory_in_wready         (io_Re_memory_in_w_ready),
      .io_Re_memory_in_wstrb          (io_Re_memory_in_w_bits_wstrb),
      .io_Re_memory_in_wvalid         (io_Re_memory_in_w_valid),

      .io_config_in_awaddr     (io_config_awaddr),
      .io_config_in_awvalid    (io_config_awvalid),
      .io_config_in_awready    (io_config_awready),
      .io_config_in_awlen      ('d0),
      .io_config_in_awsize     ('d2),
      .io_config_in_araddr     (io_config_araddr),
      .io_config_in_arvalid    (io_config_arvalid),
      .io_config_in_arready    (io_config_arready),
      .io_config_in_wdata      (io_config_wdata),
      .io_config_in_wstrb      (io_config_wstrb),
      .io_config_in_wlast      (1'b1),
      .io_config_in_wvalid     (io_config_wvalid),
      .io_config_in_wready     (io_config_wready),
      .io_config_in_rdata      (io_config_rdata),
      .io_config_in_rresp      (io_config_rresp),
      .io_config_in_rvalid     (io_config_rvalid),
      .io_config_in_rready     (io_config_rready),
      .io_config_in_bresp      (io_config_bresp),
      .io_config_in_bvalid     (io_config_bvalid),
      .io_config_in_bready     (io_config_bready),

      .io_config_out_awaddr     (bfs_io_config_awaddr),
      .io_config_out_awvalid    (bfs_io_config_awvalid),
      .io_config_out_awready    (bfs_io_config_awready),
      .io_config_out_araddr     (bfs_io_config_araddr),
      .io_config_out_arvalid    (bfs_io_config_arvalid),
      .io_config_out_arready    (bfs_io_config_arready),
      .io_config_out_wdata      (bfs_io_config_wdata),
      .io_config_out_wstrb      (bfs_io_config_wstrb),
      .io_config_out_wvalid     (bfs_io_config_wvalid),
      .io_config_out_wready     (bfs_io_config_wready),
      .io_config_out_rdata      (bfs_io_config_rdata),
      .io_config_out_rresp      (bfs_io_config_rresp),
      .io_config_out_rvalid     (bfs_io_config_rvalid),
      .io_config_out_rready     (bfs_io_config_rready),
      .io_config_out_bresp      (bfs_io_config_bresp),
      .io_config_out_bvalid     (bfs_io_config_bvalid),
      .io_config_out_bready     (bfs_io_config_bready)
    );

    BFS_ps u_BFS(
      .clock                (gt_txusrclk),
      .reset                (peripheral_reset),
      .io_config_awaddr     (bfs_io_config_awaddr),
      .io_config_awvalid    (bfs_io_config_awvalid),
      .io_config_awready    (bfs_io_config_awready),
      .io_config_araddr     (bfs_io_config_araddr),
      .io_config_arvalid    (bfs_io_config_arvalid),
      .io_config_arready    (bfs_io_config_arready),
      .io_config_wdata      (bfs_io_config_wdata),
      .io_config_wstrb      (bfs_io_config_wstrb),
      .io_config_wvalid     (bfs_io_config_wvalid),
      .io_config_wready     (bfs_io_config_wready),
      .io_config_rdata      (bfs_io_config_rdata),
      .io_config_rresp      (bfs_io_config_rresp),
      .io_config_rvalid     (bfs_io_config_rvalid),
      .io_config_rready     (bfs_io_config_rready),
      .io_config_bresp      (bfs_io_config_bresp),
      .io_config_bvalid     (bfs_io_config_bvalid),
      .io_config_bready     (bfs_io_config_bready),
      .io_PLmemory_0_aw_bits_awaddr   (io_PLmemory_0_awaddr),
      .io_PLmemory_0_aw_bits_awid     (io_PLmemory_0_awid),
      .io_PLmemory_0_aw_bits_awlen    (io_PLmemory_0_awlen),
      .io_PLmemory_0_aw_bits_awsize   (io_PLmemory_0_awsize),
      .io_PLmemory_0_aw_bits_awburst  (io_PLmemory_0_awburst),
      .io_PLmemory_0_aw_bits_awlock   (io_PLmemory_0_awlock),
      .io_PLmemory_0_aw_valid  (io_PLmemory_0_awvalid),
      .io_PLmemory_0_aw_ready  (io_PLmemory_0_awready),
      .io_PLmemory_0_ar_bits_araddr   (io_PLmemory_0_araddr),
      .io_PLmemory_0_ar_bits_arid     (io_PLmemory_0_arid),
      .io_PLmemory_0_ar_bits_arlen    (io_PLmemory_0_arlen),
      .io_PLmemory_0_ar_bits_arsize   (io_PLmemory_0_arsize),
      .io_PLmemory_0_ar_bits_arburst  (io_PLmemory_0_arburst),
      .io_PLmemory_0_ar_bits_arlock   (io_PLmemory_0_arlock),
      .io_PLmemory_0_ar_valid  (io_PLmemory_0_arvalid),
      .io_PLmemory_0_ar_ready  (io_PLmemory_0_arready),
      .io_PLmemory_0_w_bits_wdata    (io_PLmemory_0_wdata),
      .io_PLmemory_0_w_bits_wstrb    (io_PLmemory_0_wstrb),
      .io_PLmemory_0_w_bits_wlast    (io_PLmemory_0_wlast),
      .io_PLmemory_0_w_valid   (io_PLmemory_0_wvalid),
      .io_PLmemory_0_w_ready   (io_PLmemory_0_wready),
      .io_PLmemory_0_r_bits_rdata    (io_PLmemory_0_rdata),
      .io_PLmemory_0_r_bits_rid      (io_PLmemory_0_rid),
      .io_PLmemory_0_r_bits_rlast    (io_PLmemory_0_rlast),
      //.io_PLmemory_0_r_bits_rresp    (io_PLmemory_0_rresp),
      .io_PLmemory_0_r_valid   (io_PLmemory_0_rvalid),
      .io_PLmemory_0_r_ready   (io_PLmemory_0_rready),
      .io_PLmemory_0_b_bits_bresp    (io_PLmemory_0_bresp),
      .io_PLmemory_0_b_bits_bid      (io_PLmemory_0_bid),
      .io_PLmemory_0_b_valid   (io_PLmemory_0_bvalid),
      .io_PLmemory_0_b_ready   (io_PLmemory_0_bready),
      .io_PLmemory_1_aw_bits_awaddr   (io_PLmemory_1_awaddr),
      .io_PLmemory_1_aw_bits_awid     (io_PLmemory_1_awid),
      .io_PLmemory_1_aw_bits_awlen    (io_PLmemory_1_awlen),
      .io_PLmemory_1_aw_bits_awsize   (io_PLmemory_1_awsize),
      .io_PLmemory_1_aw_bits_awburst  (io_PLmemory_1_awburst),
      .io_PLmemory_1_aw_bits_awlock   (io_PLmemory_1_awlock),
      .io_PLmemory_1_aw_valid  (io_PLmemory_1_awvalid),
      .io_PLmemory_1_aw_ready  (io_PLmemory_1_awready),
      .io_PLmemory_1_ar_bits_araddr   (io_PLmemory_1_araddr),
      .io_PLmemory_1_ar_bits_arid     (io_PLmemory_1_arid),
      .io_PLmemory_1_ar_bits_arlen    (io_PLmemory_1_arlen),
      .io_PLmemory_1_ar_bits_arsize   (io_PLmemory_1_arsize),
      .io_PLmemory_1_ar_bits_arburst  (io_PLmemory_1_arburst),
      .io_PLmemory_1_ar_bits_arlock   (io_PLmemory_1_arlock),
      .io_PLmemory_1_ar_valid  (io_PLmemory_1_arvalid),
      .io_PLmemory_1_ar_ready  (io_PLmemory_1_arready),
      .io_PLmemory_1_w_bits_wdata    (io_PLmemory_1_wdata),
      .io_PLmemory_1_w_bits_wstrb    (io_PLmemory_1_wstrb),
      .io_PLmemory_1_w_bits_wlast    (io_PLmemory_1_wlast),
      .io_PLmemory_1_w_valid   (io_PLmemory_1_wvalid),
      .io_PLmemory_1_w_ready   (io_PLmemory_1_wready),
      .io_PLmemory_1_r_bits_rdata    (io_PLmemory_1_rdata),
      .io_PLmemory_1_r_bits_rid      (io_PLmemory_1_rid),
      .io_PLmemory_1_r_bits_rlast    (io_PLmemory_1_rlast),
      //.io_PLmemory_1_r_bits_rresp    (io_PLmemory_1_rresp),
      .io_PLmemory_1_r_valid   (io_PLmemory_1_rvalid),
      .io_PLmemory_1_r_ready   (io_PLmemory_1_rready),
      .io_PLmemory_1_b_bits_bresp    (io_PLmemory_1_bresp),
      .io_PLmemory_1_b_bits_bid      (io_PLmemory_1_bid),
      .io_PLmemory_1_b_valid   (io_PLmemory_1_bvalid),
      .io_PLmemory_1_b_ready   (io_PLmemory_1_bready),

      .io_PSmemory_0_aw_ready          (io_PSmempory_aw_ready),
      .io_PSmemory_0_aw_valid          (io_PSmempory_aw_valid),
      .io_PSmemory_0_aw_bits_awaddr    (io_PSmempory_aw_bits_awaddr),
      .io_PSmemory_0_aw_bits_awid      (io_PSmempory_aw_bits_awid),
      .io_PSmemory_0_aw_bits_awlen     (io_PSmempory_aw_bits_awlen),
      .io_PSmemory_0_aw_bits_awsize    (io_PSmempory_aw_bits_awsize),
      .io_PSmemory_0_aw_bits_awburst   (io_PSmempory_aw_bits_awburst),
      .io_PSmemory_0_aw_bits_awlock    (io_PSmempory_aw_bits_awlock),
      .io_PSmemory_0_ar_ready          (io_PSmempory_ar_ready),
      .io_PSmemory_0_ar_valid          (io_PSmempory_ar_valid),
      .io_PSmemory_0_ar_bits_araddr    (io_PSmempory_ar_bits_araddr),
      .io_PSmemory_0_ar_bits_arid      (io_PSmempory_ar_bits_arid),
      .io_PSmemory_0_ar_bits_arlen     (io_PSmempory_ar_bits_arlen),
      .io_PSmemory_0_ar_bits_arsize    (io_PSmempory_ar_bits_arsize),
      .io_PSmemory_0_ar_bits_arburst   (io_PSmempory_ar_bits_arburst),
      .io_PSmemory_0_ar_bits_arlock    (io_PSmempory_ar_bits_arlock),
      .io_PSmemory_0_w_ready           (io_PSmempory_w_ready),
      .io_PSmemory_0_w_valid           (io_PSmempory_w_valid),
      .io_PSmemory_0_w_bits_wdata      (io_PSmempory_w_bits_wdata),
      .io_PSmemory_0_w_bits_wstrb      (io_PSmempory_w_bits_wstrb),
      .io_PSmemory_0_w_bits_wlast      (io_PSmempory_w_bits_wlast),
      .io_PSmemory_0_r_ready           (io_PSmempory_r_ready),
      .io_PSmemory_0_r_valid           (io_PSmempory_r_valid),
      .io_PSmemory_0_r_bits_rdata      (io_PSmempory_r_bits_rdata),
      .io_PSmemory_0_r_bits_rid        (io_PSmempory_r_bits_rid),
      .io_PSmemory_0_r_bits_rlast      (io_PSmempory_r_bits_rlast),
      .io_PSmemory_0_b_ready           (io_PSmempory_b_ready),
      .io_PSmemory_0_b_valid           (io_PSmempory_b_valid),
      .io_PSmemory_0_b_bits_bresp      (io_PSmempory_b_bits_bresp),
      .io_PSmemory_0_b_bits_bid        (io_PSmempory_b_bits_bid),

      .io_PSmemory_1_aw_ready          (io_PSmempory_1_aw_ready),
      .io_PSmemory_1_aw_valid          (io_PSmempory_1_aw_valid),
      .io_PSmemory_1_aw_bits_awaddr    (io_PSmempory_1_aw_bits_awaddr),
      .io_PSmemory_1_aw_bits_awid      (io_PSmempory_1_aw_bits_awid),
      .io_PSmemory_1_aw_bits_awlen     (io_PSmempory_1_aw_bits_awlen),
      .io_PSmemory_1_aw_bits_awsize    (io_PSmempory_1_aw_bits_awsize),
      .io_PSmemory_1_aw_bits_awburst   (io_PSmempory_1_aw_bits_awburst),
      .io_PSmemory_1_aw_bits_awlock    (io_PSmempory_1_aw_bits_awlock),
      .io_PSmemory_1_ar_ready          (io_PSmempory_1_ar_ready),
      .io_PSmemory_1_ar_valid          (io_PSmempory_1_ar_valid),
      .io_PSmemory_1_ar_bits_araddr    (io_PSmempory_1_ar_bits_araddr),
      .io_PSmemory_1_ar_bits_arid      (io_PSmempory_1_ar_bits_arid),
      .io_PSmemory_1_ar_bits_arlen     (io_PSmempory_1_ar_bits_arlen),
      .io_PSmemory_1_ar_bits_arsize    (io_PSmempory_1_ar_bits_arsize),
      .io_PSmemory_1_ar_bits_arburst   (io_PSmempory_1_ar_bits_arburst),
      .io_PSmemory_1_ar_bits_arlock    (io_PSmempory_1_ar_bits_arlock),
      .io_PSmemory_1_w_ready           (io_PSmempory_1_w_ready),
      .io_PSmemory_1_w_valid           (io_PSmempory_1_w_valid),
      .io_PSmemory_1_w_bits_wdata      (io_PSmempory_1_w_bits_wdata),
      .io_PSmemory_1_w_bits_wstrb      (io_PSmempory_1_w_bits_wstrb),
      .io_PSmemory_1_w_bits_wlast      (io_PSmempory_1_w_bits_wlast),
      .io_PSmemory_1_r_ready           (io_PSmempory_1_r_ready),
      .io_PSmemory_1_r_valid           (io_PSmempory_1_r_valid),
      .io_PSmemory_1_r_bits_rdata      (io_PSmempory_1_r_bits_rdata),
      .io_PSmemory_1_r_bits_rid        (io_PSmempory_1_r_bits_rid),
      .io_PSmemory_1_r_bits_rlast      (io_PSmempory_1_r_bits_rlast),
      .io_PSmemory_1_b_ready           (io_PSmempory_1_b_ready),
      .io_PSmemory_1_b_valid           (io_PSmempory_1_b_valid),
      .io_PSmemory_1_b_bits_bresp      (io_PSmempory_1_b_bits_bresp),
      .io_PSmemory_1_b_bits_bid        (io_PSmempory_1_b_bits_bid),

      .io_PSmemory_2_aw_ready          (io_PSmempory_2_aw_ready),
      .io_PSmemory_2_aw_valid          (io_PSmempory_2_aw_valid),
      .io_PSmemory_2_aw_bits_awaddr    (io_PSmempory_2_aw_bits_awaddr),
      .io_PSmemory_2_aw_bits_awid      (io_PSmempory_2_aw_bits_awid),
      .io_PSmemory_2_aw_bits_awlen     (io_PSmempory_2_aw_bits_awlen),
      .io_PSmemory_2_aw_bits_awsize    (io_PSmempory_2_aw_bits_awsize),
      .io_PSmemory_2_aw_bits_awburst   (io_PSmempory_2_aw_bits_awburst),
      .io_PSmemory_2_aw_bits_awlock    (io_PSmempory_2_aw_bits_awlock),
      .io_PSmemory_2_ar_ready          (io_PSmempory_2_ar_ready),
      .io_PSmemory_2_ar_valid          (io_PSmempory_2_ar_valid),
      .io_PSmemory_2_ar_bits_araddr    (io_PSmempory_2_ar_bits_araddr),
      .io_PSmemory_2_ar_bits_arid      (io_PSmempory_2_ar_bits_arid),
      .io_PSmemory_2_ar_bits_arlen     (io_PSmempory_2_ar_bits_arlen),
      .io_PSmemory_2_ar_bits_arsize    (io_PSmempory_2_ar_bits_arsize),
      .io_PSmemory_2_ar_bits_arburst   (io_PSmempory_2_ar_bits_arburst),
      .io_PSmemory_2_ar_bits_arlock    (io_PSmempory_2_ar_bits_arlock),
      .io_PSmemory_2_w_ready           (io_PSmempory_2_w_ready),
      .io_PSmemory_2_w_valid           (io_PSmempory_2_w_valid),
      .io_PSmemory_2_w_bits_wdata      (io_PSmempory_2_w_bits_wdata),
      .io_PSmemory_2_w_bits_wstrb      (io_PSmempory_2_w_bits_wstrb),
      .io_PSmemory_2_w_bits_wlast      (io_PSmempory_2_w_bits_wlast),
      .io_PSmemory_2_r_ready           (io_PSmempory_2_r_ready),
      .io_PSmemory_2_r_valid           (io_PSmempory_2_r_valid),
      .io_PSmemory_2_r_bits_rdata      (io_PSmempory_2_r_bits_rdata),
      .io_PSmemory_2_r_bits_rid        (io_PSmempory_2_r_bits_rid),
      .io_PSmemory_2_r_bits_rlast      (io_PSmempory_2_r_bits_rlast),
      .io_PSmemory_2_b_ready           (io_PSmempory_2_b_ready),
      .io_PSmemory_2_b_valid           (io_PSmempory_2_b_valid),
      .io_PSmemory_2_b_bits_bresp      (io_PSmempory_2_b_bits_bresp),
      .io_PSmemory_2_b_bits_bid        (io_PSmempory_2_b_bits_bid),

      .io_PSmemory_3_aw_ready          (io_PSmempory_3_aw_ready),
      .io_PSmemory_3_aw_valid          (io_PSmempory_3_aw_valid),
      .io_PSmemory_3_aw_bits_awaddr    (io_PSmempory_3_aw_bits_awaddr),
      .io_PSmemory_3_aw_bits_awid      (io_PSmempory_3_aw_bits_awid),
      .io_PSmemory_3_aw_bits_awlen     (io_PSmempory_3_aw_bits_awlen),
      .io_PSmemory_3_aw_bits_awsize    (io_PSmempory_3_aw_bits_awsize),
      .io_PSmemory_3_aw_bits_awburst   (io_PSmempory_3_aw_bits_awburst),
      .io_PSmemory_3_aw_bits_awlock    (io_PSmempory_3_aw_bits_awlock),
      .io_PSmemory_3_ar_ready          (io_PSmempory_3_ar_ready),
      .io_PSmemory_3_ar_valid          (io_PSmempory_3_ar_valid),
      .io_PSmemory_3_ar_bits_araddr    (io_PSmempory_3_ar_bits_araddr),
      .io_PSmemory_3_ar_bits_arid      (io_PSmempory_3_ar_bits_arid),
      .io_PSmemory_3_ar_bits_arlen     (io_PSmempory_3_ar_bits_arlen),
      .io_PSmemory_3_ar_bits_arsize    (io_PSmempory_3_ar_bits_arsize),
      .io_PSmemory_3_ar_bits_arburst   (io_PSmempory_3_ar_bits_arburst),
      .io_PSmemory_3_ar_bits_arlock    (io_PSmempory_3_ar_bits_arlock),
      .io_PSmemory_3_w_ready           (io_PSmempory_3_w_ready),
      .io_PSmemory_3_w_valid           (io_PSmempory_3_w_valid),
      .io_PSmemory_3_w_bits_wdata      (io_PSmempory_3_w_bits_wdata),
      .io_PSmemory_3_w_bits_wstrb      (io_PSmempory_3_w_bits_wstrb),
      .io_PSmemory_3_w_bits_wlast      (io_PSmempory_3_w_bits_wlast),
      .io_PSmemory_3_r_ready           (io_PSmempory_3_r_ready),
      .io_PSmemory_3_r_valid           (io_PSmempory_3_r_valid),
      .io_PSmemory_3_r_bits_rdata      (io_PSmempory_3_r_bits_rdata),
      .io_PSmemory_3_r_bits_rid        (io_PSmempory_3_r_bits_rid),
      .io_PSmemory_3_r_bits_rlast      (io_PSmempory_3_r_bits_rlast),
      .io_PSmemory_3_b_ready           (io_PSmempory_3_b_ready),
      .io_PSmemory_3_b_valid           (io_PSmempory_3_b_valid),
      .io_PSmemory_3_b_bits_bresp      (io_PSmempory_3_b_bits_bresp),
      .io_PSmemory_3_b_bits_bid        (io_PSmempory_3_b_bits_bid),

      .io_Re_memory_out_aw_ready           (io_Re_memory_out_aw_ready),
      .io_Re_memory_out_aw_valid           (io_Re_memory_out_aw_valid),
      .io_Re_memory_out_aw_bits_awaddr     (io_Re_memory_out_aw_bits_awaddr),
      .io_Re_memory_out_aw_bits_awid       (io_Re_memory_out_aw_bits_awid),
      .io_Re_memory_out_aw_bits_awlen      (io_Re_memory_out_aw_bits_awlen),
      .io_Re_memory_out_aw_bits_awsize     (io_Re_memory_out_aw_bits_awsize),
      .io_Re_memory_out_aw_bits_awburst    (io_Re_memory_out_aw_bits_awburst),
      .io_Re_memory_out_aw_bits_awlock     (io_Re_memory_out_aw_bits_awlock),
      .io_Re_memory_out_ar_ready           (io_Re_memory_out_ar_ready),
      .io_Re_memory_out_ar_valid           (io_Re_memory_out_ar_valid),
      .io_Re_memory_out_ar_bits_araddr     (io_Re_memory_out_ar_bits_araddr),
      .io_Re_memory_out_ar_bits_arid       (io_Re_memory_out_ar_bits_arid),
      .io_Re_memory_out_ar_bits_arlen      (io_Re_memory_out_ar_bits_arlen),
      .io_Re_memory_out_ar_bits_arsize     (io_Re_memory_out_ar_bits_arsize),
      .io_Re_memory_out_ar_bits_arburst    (io_Re_memory_out_ar_bits_arburst),
      .io_Re_memory_out_ar_bits_arlock     (io_Re_memory_out_ar_bits_arlock),
      .io_Re_memory_out_w_ready            (io_Re_memory_out_w_ready),
      .io_Re_memory_out_w_valid            (io_Re_memory_out_w_valid),
      .io_Re_memory_out_w_bits_wdata       (io_Re_memory_out_w_bits_wdata),
      .io_Re_memory_out_w_bits_wstrb       (io_Re_memory_out_w_bits_wstrb),
      .io_Re_memory_out_w_bits_wlast       (io_Re_memory_out_w_bits_wlast),
      .io_Re_memory_out_r_ready            (io_Re_memory_out_r_ready),
      .io_Re_memory_out_r_valid            (io_Re_memory_out_r_valid),
      .io_Re_memory_out_r_bits_rdata       (io_Re_memory_out_r_bits_rdata),
      .io_Re_memory_out_r_bits_rid         (io_Re_memory_out_r_bits_rid),
      .io_Re_memory_out_r_bits_rlast       (io_Re_memory_out_r_bits_rlast),
      .io_Re_memory_out_b_ready            (io_Re_memory_out_b_ready),
      .io_Re_memory_out_b_valid            (io_Re_memory_out_b_valid),
      .io_Re_memory_out_b_bits_bresp       (io_Re_memory_out_b_bits_bresp),
      .io_Re_memory_out_b_bits_bid         (io_Re_memory_out_b_bits_bid),

      .io_Re_memory_in_aw_ready            (io_Re_memory_in_aw_ready),
      .io_Re_memory_in_aw_valid            (io_Re_memory_in_aw_valid),
      .io_Re_memory_in_aw_bits_awaddr      (io_Re_memory_in_aw_bits_awaddr),
      .io_Re_memory_in_aw_bits_awid        (io_Re_memory_in_aw_bits_awid),
      .io_Re_memory_in_aw_bits_awlen       (io_Re_memory_in_aw_bits_awlen),
      .io_Re_memory_in_aw_bits_awsize      (io_Re_memory_in_aw_bits_awsize),
      .io_Re_memory_in_aw_bits_awburst     (io_Re_memory_in_aw_bits_awburst),
      .io_Re_memory_in_aw_bits_awlock      (io_Re_memory_in_aw_bits_awlock),
      .io_Re_memory_in_ar_ready            (io_Re_memory_in_ar_ready),
      .io_Re_memory_in_ar_valid            (io_Re_memory_in_ar_valid),
      .io_Re_memory_in_ar_bits_araddr      (io_Re_memory_in_ar_bits_araddr),
      .io_Re_memory_in_ar_bits_arid        (io_Re_memory_in_ar_bits_arid),
      .io_Re_memory_in_ar_bits_arlen       (io_Re_memory_in_ar_bits_arlen),
      .io_Re_memory_in_ar_bits_arsize      (io_Re_memory_in_ar_bits_arsize),
      .io_Re_memory_in_ar_bits_arburst     (io_Re_memory_in_ar_bits_arburst),
      .io_Re_memory_in_ar_bits_arlock      (io_Re_memory_in_ar_bits_arlock),
      .io_Re_memory_in_w_ready             (io_Re_memory_in_w_ready),
      .io_Re_memory_in_w_valid             (io_Re_memory_in_w_valid),
      .io_Re_memory_in_w_bits_wdata        (io_Re_memory_in_w_bits_wdata),
      .io_Re_memory_in_w_bits_wstrb        (io_Re_memory_in_w_bits_wstrb),
      .io_Re_memory_in_w_bits_wlast        (io_Re_memory_in_w_bits_wlast),
      .io_Re_memory_in_r_ready             (io_Re_memory_in_r_ready),
      .io_Re_memory_in_r_valid             (io_Re_memory_in_r_valid),
      .io_Re_memory_in_r_bits_rdata        (io_Re_memory_in_r_bits_rdata),
      .io_Re_memory_in_r_bits_rid          (io_Re_memory_in_r_bits_rid),
      .io_Re_memory_in_r_bits_rlast        (io_Re_memory_in_r_bits_rlast),
      .io_Re_memory_in_b_ready             (io_Re_memory_in_b_ready),
      .io_Re_memory_in_b_valid             (io_Re_memory_in_b_valid),
      .io_Re_memory_in_b_bits_bresp        (io_Re_memory_in_b_bits_bresp),
      .io_Re_memory_in_b_bits_bid          (io_Re_memory_in_b_bits_bid)
    );
endmodule
