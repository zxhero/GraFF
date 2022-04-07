module trans_out_reg_slice(
  input          clock,
  input          reset,
  input          io_dout_ready,
  output         io_dout_valid,
  output [511:0] io_dout_bits_tdata,
  output [63:0]  io_dout_bits_tkeep,
  output         io_dout_bits_tlast,
  output [3:0]   io_dout_bits_tuser,
  output         io_din_ready,
  input          io_din_valid,
  input  [511:0] io_din_bits_tdata,
  input  [63:0]  io_din_bits_tkeep,
  input          io_din_bits_tlast,
  input  [3:0]   io_din_bits_tuser
);
`ifdef RANDOMIZE_REG_INIT
  reg [511:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
`endif // RANDOMIZE_REG_INIT
  reg [511:0] data_tdata; // @[DoCE.scala 268:21]
  reg [63:0] data_tkeep; // @[DoCE.scala 268:21]
  reg  data_tlast; // @[DoCE.scala 268:21]
  reg [3:0] data_tuser; // @[DoCE.scala 268:21]
  reg  valid; // @[DoCE.scala 269:22]
  wire  _T = ~valid; // @[DoCE.scala 270:25]
  assign io_dout_valid = valid; // @[DoCE.scala 276:17]
  assign io_dout_bits_tdata = data_tdata; // @[DoCE.scala 277:16]
  assign io_dout_bits_tkeep = data_tkeep; // @[DoCE.scala 277:16]
  assign io_dout_bits_tlast = data_tlast; // @[DoCE.scala 277:16]
  assign io_dout_bits_tuser = data_tuser; // @[DoCE.scala 277:16]
  assign io_din_ready = io_dout_ready | _T; // @[DoCE.scala 275:33]
  always @(posedge clock) begin
    if (reset) begin // @[DoCE.scala 268:21]
      data_tdata <= 512'h0; // @[DoCE.scala 268:21]
    end else if (io_dout_ready | ~valid) begin // @[DoCE.scala 270:32]
      data_tdata <= io_din_bits_tdata; // @[DoCE.scala 271:10]
    end
    if (reset) begin // @[DoCE.scala 268:21]
      data_tkeep <= 64'h0; // @[DoCE.scala 268:21]
    end else if (io_dout_ready | ~valid) begin // @[DoCE.scala 270:32]
      data_tkeep <= io_din_bits_tkeep; // @[DoCE.scala 271:10]
    end
    if (reset) begin // @[DoCE.scala 268:21]
      data_tlast <= 1'h0; // @[DoCE.scala 268:21]
    end else if (io_dout_ready | ~valid) begin // @[DoCE.scala 270:32]
      data_tlast <= io_din_bits_tlast; // @[DoCE.scala 271:10]
    end
    if (reset) begin // @[DoCE.scala 268:21]
      data_tuser <= 4'h0; // @[DoCE.scala 268:21]
    end else if (io_dout_ready | ~valid) begin // @[DoCE.scala 270:32]
      data_tuser <= io_din_bits_tuser; // @[DoCE.scala 271:10]
    end
    if (reset) begin // @[DoCE.scala 269:22]
      valid <= 1'h0; // @[DoCE.scala 269:22]
    end else if (io_dout_ready | ~valid) begin // @[DoCE.scala 270:32]
      valid <= io_din_valid; // @[DoCE.scala 272:11]
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
  data_tuser = _RAND_3[3:0];
  _RAND_4 = {1{`RANDOM}};
  valid = _RAND_4[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module rx_depacketing(
  input          clock,
  input          reset,
  input          io_axis_str_to_trans_ready,
  output         io_axis_str_to_trans_valid,
  output [511:0] io_axis_str_to_trans_bits_tdata,
  output [63:0]  io_axis_str_to_trans_bits_tkeep,
  output         io_axis_str_to_trans_bits_tlast,
  output [3:0]   io_axis_str_to_trans_bits_tuser,
  output         io_axi_str_from_router_ready,
  input          io_axi_str_from_router_valid,
  input  [511:0] io_axi_str_from_router_bits_tdata,
  input  [63:0]  io_axi_str_from_router_bits_tkeep,
  input          io_axi_str_from_router_bits_tlast,
  input  [3:0]   io_axi_str_from_router_bits_tuser
);
  wire  trans_out_clock; // @[DoCE.scala 345:27]
  wire  trans_out_reset; // @[DoCE.scala 345:27]
  wire  trans_out_io_dout_ready; // @[DoCE.scala 345:27]
  wire  trans_out_io_dout_valid; // @[DoCE.scala 345:27]
  wire [511:0] trans_out_io_dout_bits_tdata; // @[DoCE.scala 345:27]
  wire [63:0] trans_out_io_dout_bits_tkeep; // @[DoCE.scala 345:27]
  wire  trans_out_io_dout_bits_tlast; // @[DoCE.scala 345:27]
  wire [3:0] trans_out_io_dout_bits_tuser; // @[DoCE.scala 345:27]
  wire  trans_out_io_din_ready; // @[DoCE.scala 345:27]
  wire  trans_out_io_din_valid; // @[DoCE.scala 345:27]
  wire [511:0] trans_out_io_din_bits_tdata; // @[DoCE.scala 345:27]
  wire [63:0] trans_out_io_din_bits_tkeep; // @[DoCE.scala 345:27]
  wire  trans_out_io_din_bits_tlast; // @[DoCE.scala 345:27]
  wire [3:0] trans_out_io_din_bits_tuser; // @[DoCE.scala 345:27]
  wire  _io_axis_str_to_trans_valid_T = io_axi_str_from_router_valid & trans_out_io_dout_valid; // @[DoCE.scala 349:36]
  wire [127:0] io_axis_str_to_trans_bits_tdata_hi = io_axi_str_from_router_bits_tdata[127:0]; // @[DoCE.scala 352:77]
  wire [383:0] io_axis_str_to_trans_bits_tdata_lo = trans_out_io_dout_bits_tdata[511:128]; // @[DoCE.scala 353:35]
  wire [15:0] io_axis_str_to_trans_bits_tkeep_hi = io_axi_str_from_router_bits_tkeep[15:0]; // @[DoCE.scala 354:77]
  wire [47:0] io_axis_str_to_trans_bits_tkeep_lo = trans_out_io_dout_bits_tkeep[63:16]; // @[DoCE.scala 355:35]
  trans_out_reg_slice trans_out ( // @[DoCE.scala 345:27]
    .clock(trans_out_clock),
    .reset(trans_out_reset),
    .io_dout_ready(trans_out_io_dout_ready),
    .io_dout_valid(trans_out_io_dout_valid),
    .io_dout_bits_tdata(trans_out_io_dout_bits_tdata),
    .io_dout_bits_tkeep(trans_out_io_dout_bits_tkeep),
    .io_dout_bits_tlast(trans_out_io_dout_bits_tlast),
    .io_dout_bits_tuser(trans_out_io_dout_bits_tuser),
    .io_din_ready(trans_out_io_din_ready),
    .io_din_valid(trans_out_io_din_valid),
    .io_din_bits_tdata(trans_out_io_din_bits_tdata),
    .io_din_bits_tkeep(trans_out_io_din_bits_tkeep),
    .io_din_bits_tlast(trans_out_io_din_bits_tlast),
    .io_din_bits_tuser(trans_out_io_din_bits_tuser)
  );
  assign io_axis_str_to_trans_valid = trans_out_io_dout_bits_tlast ? trans_out_io_dout_valid :
    _io_axis_str_to_trans_valid_T; // @[DoCE.scala 348:38]
  assign io_axis_str_to_trans_bits_tdata = {io_axis_str_to_trans_bits_tdata_hi,io_axis_str_to_trans_bits_tdata_lo}; // @[Cat.scala 30:58]
  assign io_axis_str_to_trans_bits_tkeep = {io_axis_str_to_trans_bits_tkeep_hi,io_axis_str_to_trans_bits_tkeep_lo}; // @[Cat.scala 30:58]
  assign io_axis_str_to_trans_bits_tlast = trans_out_io_dout_bits_tlast; // @[DoCE.scala 350:37]
  assign io_axis_str_to_trans_bits_tuser = trans_out_io_dout_bits_tuser; // @[DoCE.scala 351:37]
  assign io_axi_str_from_router_ready = trans_out_io_din_ready; // @[DoCE.scala 346:22]
  assign trans_out_clock = clock;
  assign trans_out_reset = reset;
  assign trans_out_io_dout_ready = io_axis_str_to_trans_valid & io_axis_str_to_trans_ready; // @[DoCE.scala 356:59]
  assign trans_out_io_din_valid = io_axi_str_from_router_valid; // @[DoCE.scala 346:22]
  assign trans_out_io_din_bits_tdata = io_axi_str_from_router_bits_tdata; // @[DoCE.scala 346:22]
  assign trans_out_io_din_bits_tkeep = io_axi_str_from_router_bits_tkeep; // @[DoCE.scala 346:22]
  assign trans_out_io_din_bits_tlast = io_axi_str_from_router_bits_tlast; // @[DoCE.scala 346:22]
  assign trans_out_io_din_bits_tuser = io_axi_str_from_router_bits_tuser; // @[DoCE.scala 346:22]
endmodule
