module router_out_reg_slice(
  input          clock,
  input          reset,
  input          io_dout_ready,
  output         io_dout_valid,
  output [511:0] io_dout_bits_tdata,
  output [63:0]  io_dout_bits_tkeep,
  output         io_dout_bits_tlast,
  output         io_din_ready,
  input          io_din_valid,
  input  [511:0] io_din_bits_tdata,
  input  [63:0]  io_din_bits_tkeep,
  input          io_din_bits_tlast
);
`ifdef RANDOMIZE_REG_INIT
  reg [511:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg [511:0] data_tdata; // @[DoCE.scala 278:21]
  reg [63:0] data_tkeep; // @[DoCE.scala 278:21]
  reg  data_tlast; // @[DoCE.scala 278:21]
  reg  valid; // @[DoCE.scala 279:22]
  wire  _T = ~valid; // @[DoCE.scala 280:25]
  assign io_dout_valid = valid; // @[DoCE.scala 286:17]
  assign io_dout_bits_tdata = data_tdata; // @[DoCE.scala 287:16]
  assign io_dout_bits_tkeep = data_tkeep; // @[DoCE.scala 287:16]
  assign io_dout_bits_tlast = data_tlast; // @[DoCE.scala 287:16]
  assign io_din_ready = io_dout_ready | _T; // @[DoCE.scala 285:33]
  always @(posedge clock) begin
    if (reset) begin // @[DoCE.scala 278:21]
      data_tdata <= 512'h0; // @[DoCE.scala 278:21]
    end else if (io_dout_ready | ~valid) begin // @[DoCE.scala 280:32]
      data_tdata <= io_din_bits_tdata; // @[DoCE.scala 281:10]
    end
    if (reset) begin // @[DoCE.scala 278:21]
      data_tkeep <= 64'h0; // @[DoCE.scala 278:21]
    end else if (io_dout_ready | ~valid) begin // @[DoCE.scala 280:32]
      data_tkeep <= io_din_bits_tkeep; // @[DoCE.scala 281:10]
    end
    if (reset) begin // @[DoCE.scala 278:21]
      data_tlast <= 1'h0; // @[DoCE.scala 278:21]
    end else if (io_dout_ready | ~valid) begin // @[DoCE.scala 280:32]
      data_tlast <= io_din_bits_tlast; // @[DoCE.scala 281:10]
    end
    if (reset) begin // @[DoCE.scala 279:22]
      valid <= 1'h0; // @[DoCE.scala 279:22]
    end else if (io_dout_ready | ~valid) begin // @[DoCE.scala 280:32]
      valid <= io_din_valid; // @[DoCE.scala 282:11]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {16{`RANDOM}};
  data_tdata = _RAND_0[511:0];
  _RAND_1 = {2{`RANDOM}};
  data_tkeep = _RAND_1[63:0];
  _RAND_2 = {1{`RANDOM}};
  data_tlast = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  valid = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module tx_packeting(
  input          clock,
  input          reset,
  output         io_axis_rd_from_fsm_ready,
  input          io_axis_rd_from_fsm_valid,
  input  [511:0] io_axis_rd_from_fsm_bits_tdata,
  input  [63:0]  io_axis_rd_from_fsm_bits_tkeep,
  input          io_axis_rd_from_fsm_bits_tlast,
  input          io_axi_str_to_router_ready,
  output         io_axi_str_to_router_valid,
  output [511:0] io_axi_str_to_router_bits_tdata,
  output [63:0]  io_axi_str_to_router_bits_tkeep,
  output         io_axi_str_to_router_bits_tlast
);
  wire  router_out_clock; // @[DoCE.scala 303:28]
  wire  router_out_reset; // @[DoCE.scala 303:28]
  wire  router_out_io_dout_ready; // @[DoCE.scala 303:28]
  wire  router_out_io_dout_valid; // @[DoCE.scala 303:28]
  wire [511:0] router_out_io_dout_bits_tdata; // @[DoCE.scala 303:28]
  wire [63:0] router_out_io_dout_bits_tkeep; // @[DoCE.scala 303:28]
  wire  router_out_io_dout_bits_tlast; // @[DoCE.scala 303:28]
  wire  router_out_io_din_ready; // @[DoCE.scala 303:28]
  wire  router_out_io_din_valid; // @[DoCE.scala 303:28]
  wire [511:0] router_out_io_din_bits_tdata; // @[DoCE.scala 303:28]
  wire [63:0] router_out_io_din_bits_tkeep; // @[DoCE.scala 303:28]
  wire  router_out_io_din_bits_tlast; // @[DoCE.scala 303:28]
  wire  _T_1 = io_axis_rd_from_fsm_bits_tkeep[63:48] == 16'h0; // @[DoCE.scala 310:88]
  wire  _T_2 = io_axis_rd_from_fsm_bits_tlast & _T_1; // @[DoCE.scala 309:41]
  wire  _T_3 = io_axi_str_to_router_valid & io_axi_str_to_router_ready; // @[DoCE.scala 311:39]
  wire [383:0] io_axi_str_to_router_bits_tdata_hi = io_axis_rd_from_fsm_bits_tdata[383:0]; // @[DoCE.scala 329:74]
  wire [127:0] io_axi_str_to_router_bits_tdata_lo = router_out_io_dout_bits_tdata[511:384]; // @[DoCE.scala 330:36]
  wire [511:0] _io_axi_str_to_router_bits_tdata_T = {io_axi_str_to_router_bits_tdata_hi,
    io_axi_str_to_router_bits_tdata_lo}; // @[Cat.scala 30:58]
  wire [47:0] io_axi_str_to_router_bits_tkeep_hi = io_axis_rd_from_fsm_bits_tkeep[47:0]; // @[DoCE.scala 331:74]
  wire [15:0] io_axi_str_to_router_bits_tkeep_lo = router_out_io_dout_bits_tkeep[63:48]; // @[DoCE.scala 332:36]
  wire [63:0] _io_axi_str_to_router_bits_tkeep_T = {io_axi_str_to_router_bits_tkeep_hi,
    io_axi_str_to_router_bits_tkeep_lo}; // @[Cat.scala 30:58]
  router_out_reg_slice router_out ( // @[DoCE.scala 303:28]
    .clock(router_out_clock),
    .reset(router_out_reset),
    .io_dout_ready(router_out_io_dout_ready),
    .io_dout_valid(router_out_io_dout_valid),
    .io_dout_bits_tdata(router_out_io_dout_bits_tdata),
    .io_dout_bits_tkeep(router_out_io_dout_bits_tkeep),
    .io_dout_bits_tlast(router_out_io_dout_bits_tlast),
    .io_din_ready(router_out_io_din_ready),
    .io_din_valid(router_out_io_din_valid),
    .io_din_bits_tdata(router_out_io_din_bits_tdata),
    .io_din_bits_tkeep(router_out_io_din_bits_tkeep),
    .io_din_bits_tlast(router_out_io_din_bits_tlast)
  );
  assign io_axis_rd_from_fsm_ready = _T_2 ? _T_3 : router_out_io_din_ready; // @[DoCE.scala 310:96 DoCE.scala 308:31]
  assign io_axi_str_to_router_valid = router_out_io_dout_bits_tlast ? router_out_io_dout_valid :
    io_axis_rd_from_fsm_valid & router_out_io_dout_valid; // @[DoCE.scala 333:40 DoCE.scala 336:34 DoCE.scala 326:32]
  assign io_axi_str_to_router_bits_tdata = router_out_io_dout_bits_tlast ? {{384'd0}, io_axi_str_to_router_bits_tdata_lo
    } : _io_axi_str_to_router_bits_tdata_T; // @[DoCE.scala 333:40 DoCE.scala 334:39 DoCE.scala 329:37]
  assign io_axi_str_to_router_bits_tkeep = router_out_io_dout_bits_tlast ? {{48'd0}, io_axi_str_to_router_bits_tkeep_lo}
     : _io_axi_str_to_router_bits_tkeep_T; // @[DoCE.scala 333:40 DoCE.scala 335:39 DoCE.scala 331:37]
  assign io_axi_str_to_router_bits_tlast = router_out_io_dout_bits_tlast | _T_2; // @[DoCE.scala 333:40 DoCE.scala 337:39 DoCE.scala 327:37]
  assign router_out_clock = clock;
  assign router_out_reset = reset;
  assign router_out_io_dout_ready = io_axi_str_to_router_valid & io_axi_str_to_router_ready; // @[DoCE.scala 340:60]
  assign router_out_io_din_valid = _T_2 ? 1'h0 : io_axis_rd_from_fsm_valid; // @[DoCE.scala 310:96 DoCE.scala 307:29]
  assign router_out_io_din_bits_tdata = _T_2 ? 512'h0 : io_axis_rd_from_fsm_bits_tdata; // @[DoCE.scala 310:96 DoCE.scala 305:34]
  assign router_out_io_din_bits_tkeep = _T_2 ? 64'h0 : io_axis_rd_from_fsm_bits_tkeep; // @[DoCE.scala 310:96 DoCE.scala 304:34]
  assign router_out_io_din_bits_tlast = _T_2 ? 1'h0 : io_axis_rd_from_fsm_bits_tlast; // @[DoCE.scala 310:96 DoCE.scala 306:34]
endmodule
