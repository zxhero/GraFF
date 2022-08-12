`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2022 02:35:53 PM
// Design Name: 
// Module Name: memory
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


module memory(
input gt_txusrclk,     
input peripheral_reset,
    input [0 : 0]    M00_AXI_AWID,
    input [63 : 0]   M00_AXI_AWADDR,
    input [7 : 0]    M00_AXI_AWLEN,
    input [2 : 0]    M00_AXI_AWSIZE,
    input [1 : 0]    M00_AXI_AWBURST,
    input            M00_AXI_AWLOCK,
    input [3 : 0]    M00_AXI_AWCACHE,
    input [2 : 0]    M00_AXI_AWPROT,
    input            M00_AXI_AWVALID,
    output            M00_AXI_AWREADY,
    input [511 : 0]  M00_AXI_WDATA,
    input [63 : 0]   M00_AXI_WSTRB,
    input            M00_AXI_WLAST,
    input            M00_AXI_WVALID,
    output            M00_AXI_WREADY,
    output [0 : 0]    M00_AXI_BID,
    output [1 : 0]    M00_AXI_BRESP,
    output            M00_AXI_BVALID,
    input            M00_AXI_BREADY,
    input [0 : 0]    M00_AXI_ARID,
    input [63 : 0]   M00_AXI_ARADDR,
    input [7 : 0]    M00_AXI_ARLEN,
    input [2 : 0]    M00_AXI_ARSIZE,
    input [1 : 0]    M00_AXI_ARBURST,
    input            M00_AXI_ARLOCK,
    input [3 : 0]    M00_AXI_ARCACHE,
    input [2 : 0]    M00_AXI_ARPROT,
    input            M00_AXI_ARVALID,
    output            M00_AXI_ARREADY,
    output [0 : 0]    M00_AXI_RID,
    output [511 : 0]  M00_AXI_RDATA,
    output [1 : 0]    M00_AXI_RRESP,
    output            M00_AXI_RLAST,
    output            M00_AXI_RVALID,
    input            M00_AXI_RREADY,
    
    input [0 : 0]    M01_AXI_AWID,
    input [63 : 0]   M01_AXI_AWADDR,
    input [7 : 0]    M01_AXI_AWLEN,
    input [2 : 0]    M01_AXI_AWSIZE,
    input [1 : 0]    M01_AXI_AWBURST,
    input            M01_AXI_AWLOCK,
    input [3 : 0]    M01_AXI_AWCACHE,
    input [2 : 0]    M01_AXI_AWPROT,
    input            M01_AXI_AWVALID,
    output            M01_AXI_AWREADY,
    input [511 : 0]  M01_AXI_WDATA,
    input [63 : 0]   M01_AXI_WSTRB,
    input            M01_AXI_WLAST,
    input            M01_AXI_WVALID,
    output            M01_AXI_WREADY,
    output [0 : 0]    M01_AXI_BID,
    output [1 : 0]    M01_AXI_BRESP,
    output            M01_AXI_BVALID,
    input            M01_AXI_BREADY,
    input [0 : 0]    M01_AXI_ARID,
    input [63 : 0]   M01_AXI_ARADDR,
    input [7 : 0]    M01_AXI_ARLEN,
    input [2 : 0]    M01_AXI_ARSIZE,
    input [1 : 0]    M01_AXI_ARBURST,
    input            M01_AXI_ARLOCK,
    input [3 : 0]    M01_AXI_ARCACHE,
    input [2 : 0]    M01_AXI_ARPROT,
    input            M01_AXI_ARVALID,
    output            M01_AXI_ARREADY,
    output [0 : 0]    M01_AXI_RID,
    output [511 : 0]  M01_AXI_RDATA,
    output [1 : 0]    M01_AXI_RRESP,
    output            M01_AXI_RLAST,
    output            M01_AXI_RVALID,
    input            M01_AXI_RREADY
    );

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
endmodule
