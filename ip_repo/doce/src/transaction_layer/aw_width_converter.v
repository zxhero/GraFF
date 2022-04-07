module dout_channel_reg_slice(
  input          clock,
  input          reset,
  input          io_dout_ready,
  output         io_dout_valid,
  output [511:0] io_dout_bits_dout,
  output [63:0]  io_dout_bits_keep,
  output         io_dout_bits_last,
  output [3:0]   io_dout_bits_connection_id,
  output [12:0]  io_dout_bits_byte_num,
  output         io_din_ready,
  input          io_din_valid,
  input  [511:0] io_din_bits_dout,
  input  [63:0]  io_din_bits_keep,
  input          io_din_bits_last,
  input  [3:0]   io_din_bits_connection_id,
  input  [12:0]  io_din_bits_byte_num
);
`ifdef RANDOMIZE_REG_INIT
  reg [511:0] _RAND_0;
  reg [63:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [511:0] _RAND_7;
  reg [63:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
`endif // RANDOMIZE_REG_INIT
  reg [511:0] data_dout; // @[DoCE.scala 14:21]
  reg [63:0] data_keep; // @[DoCE.scala 14:21]
  reg  data_last; // @[DoCE.scala 14:21]
  reg [3:0] data_connection_id; // @[DoCE.scala 14:21]
  reg [12:0] data_byte_num; // @[DoCE.scala 14:21]
  reg  valid; // @[DoCE.scala 15:22]
  reg  ready; // @[DoCE.scala 16:22]
  reg [511:0] data2_dout; // @[DoCE.scala 17:22]
  reg [63:0] data2_keep; // @[DoCE.scala 17:22]
  reg  data2_last; // @[DoCE.scala 17:22]
  reg [3:0] data2_connection_id; // @[DoCE.scala 17:22]
  reg [12:0] data2_byte_num; // @[DoCE.scala 17:22]
  reg  valid2; // @[DoCE.scala 18:23]
  wire  _T = ~valid; // @[DoCE.scala 20:8]
  wire  _GEN_2 = io_din_ready & io_din_bits_last; // @[DoCE.scala 25:29 DoCE.scala 27:12 DoCE.scala 31:12]
  wire  _GEN_5 = io_din_ready & io_din_valid; // @[DoCE.scala 25:29 DoCE.scala 28:13 DoCE.scala 32:13]
  wire  _T_4 = ~valid2; // @[DoCE.scala 38:35]
  assign io_dout_valid = valid; // @[DoCE.scala 48:17]
  assign io_dout_bits_dout = data_dout; // @[DoCE.scala 49:16]
  assign io_dout_bits_keep = data_keep; // @[DoCE.scala 49:16]
  assign io_dout_bits_last = data_last; // @[DoCE.scala 49:16]
  assign io_dout_bits_connection_id = data_connection_id; // @[DoCE.scala 49:16]
  assign io_dout_bits_byte_num = data_byte_num; // @[DoCE.scala 49:16]
  assign io_din_ready = ready | _T | _T_4; // @[DoCE.scala 47:34]
  always @(posedge clock) begin
    if (reset) begin // @[DoCE.scala 14:21]
      data_dout <= 512'h0; // @[DoCE.scala 14:21]
    end else if (~valid | io_dout_ready) begin // @[DoCE.scala 20:31]
      if (valid2) begin // @[DoCE.scala 22:17]
        data_dout <= data2_dout; // @[DoCE.scala 23:12]
      end else if (io_din_ready) begin // @[DoCE.scala 25:29]
        data_dout <= io_din_bits_dout; // @[DoCE.scala 27:12]
      end else begin
        data_dout <= 512'h0; // @[DoCE.scala 31:12]
      end
    end
    if (reset) begin // @[DoCE.scala 14:21]
      data_keep <= 64'h0; // @[DoCE.scala 14:21]
    end else if (~valid | io_dout_ready) begin // @[DoCE.scala 20:31]
      if (valid2) begin // @[DoCE.scala 22:17]
        data_keep <= data2_keep; // @[DoCE.scala 23:12]
      end else if (io_din_ready) begin // @[DoCE.scala 25:29]
        data_keep <= io_din_bits_keep; // @[DoCE.scala 27:12]
      end else begin
        data_keep <= 64'h0; // @[DoCE.scala 31:12]
      end
    end
    if (reset) begin // @[DoCE.scala 14:21]
      data_last <= 1'h0; // @[DoCE.scala 14:21]
    end else if (~valid | io_dout_ready) begin // @[DoCE.scala 20:31]
      if (valid2) begin // @[DoCE.scala 22:17]
        data_last <= data2_last; // @[DoCE.scala 23:12]
      end else begin
        data_last <= _GEN_2;
      end
    end
    if (reset) begin // @[DoCE.scala 14:21]
      data_connection_id <= 4'h0; // @[DoCE.scala 14:21]
    end else if (~valid | io_dout_ready) begin // @[DoCE.scala 20:31]
      if (valid2) begin // @[DoCE.scala 22:17]
        data_connection_id <= data2_connection_id; // @[DoCE.scala 23:12]
      end else if (io_din_ready) begin // @[DoCE.scala 25:29]
        data_connection_id <= io_din_bits_connection_id; // @[DoCE.scala 27:12]
      end else begin
        data_connection_id <= 4'h0; // @[DoCE.scala 31:12]
      end
    end
    if (reset) begin // @[DoCE.scala 14:21]
      data_byte_num <= 13'h0; // @[DoCE.scala 14:21]
    end else if (~valid | io_dout_ready) begin // @[DoCE.scala 20:31]
      if (valid2) begin // @[DoCE.scala 22:17]
        data_byte_num <= data2_byte_num; // @[DoCE.scala 23:12]
      end else if (io_din_ready) begin // @[DoCE.scala 25:29]
        data_byte_num <= io_din_bits_byte_num; // @[DoCE.scala 27:12]
      end else begin
        data_byte_num <= 13'h0; // @[DoCE.scala 31:12]
      end
    end
    if (reset) begin // @[DoCE.scala 15:22]
      valid <= 1'h0; // @[DoCE.scala 15:22]
    end else if (~valid | io_dout_ready) begin // @[DoCE.scala 20:31]
      if (valid2) begin // @[DoCE.scala 22:17]
        valid <= valid2; // @[DoCE.scala 24:13]
      end else begin
        valid <= _GEN_5;
      end
    end
    if (reset) begin // @[DoCE.scala 16:22]
      ready <= 1'h0; // @[DoCE.scala 16:22]
    end else begin
      ready <= io_dout_ready; // @[DoCE.scala 35:9]
    end
    if (reset) begin // @[DoCE.scala 17:22]
      data2_dout <= 512'h0; // @[DoCE.scala 17:22]
    end else if (valid & ~io_dout_ready & ~valid2) begin // @[DoCE.scala 38:44]
      data2_dout <= io_din_bits_dout; // @[DoCE.scala 39:11]
    end else if (io_dout_ready) begin // @[DoCE.scala 41:28]
      data2_dout <= 512'h0; // @[DoCE.scala 43:11]
    end
    if (reset) begin // @[DoCE.scala 17:22]
      data2_keep <= 64'h0; // @[DoCE.scala 17:22]
    end else if (valid & ~io_dout_ready & ~valid2) begin // @[DoCE.scala 38:44]
      data2_keep <= io_din_bits_keep; // @[DoCE.scala 39:11]
    end else if (io_dout_ready) begin // @[DoCE.scala 41:28]
      data2_keep <= 64'h0; // @[DoCE.scala 43:11]
    end
    if (reset) begin // @[DoCE.scala 17:22]
      data2_last <= 1'h0; // @[DoCE.scala 17:22]
    end else if (valid & ~io_dout_ready & ~valid2) begin // @[DoCE.scala 38:44]
      data2_last <= io_din_bits_last; // @[DoCE.scala 39:11]
    end else if (io_dout_ready) begin // @[DoCE.scala 41:28]
      data2_last <= 1'h0; // @[DoCE.scala 43:11]
    end
    if (reset) begin // @[DoCE.scala 17:22]
      data2_connection_id <= 4'h0; // @[DoCE.scala 17:22]
    end else if (valid & ~io_dout_ready & ~valid2) begin // @[DoCE.scala 38:44]
      data2_connection_id <= io_din_bits_connection_id; // @[DoCE.scala 39:11]
    end else if (io_dout_ready) begin // @[DoCE.scala 41:28]
      data2_connection_id <= 4'h0; // @[DoCE.scala 43:11]
    end
    if (reset) begin // @[DoCE.scala 17:22]
      data2_byte_num <= 13'h0; // @[DoCE.scala 17:22]
    end else if (valid & ~io_dout_ready & ~valid2) begin // @[DoCE.scala 38:44]
      data2_byte_num <= io_din_bits_byte_num; // @[DoCE.scala 39:11]
    end else if (io_dout_ready) begin // @[DoCE.scala 41:28]
      data2_byte_num <= 13'h0; // @[DoCE.scala 43:11]
    end
    if (reset) begin // @[DoCE.scala 18:23]
      valid2 <= 1'h0; // @[DoCE.scala 18:23]
    end else if (valid & ~io_dout_ready & ~valid2) begin // @[DoCE.scala 38:44]
      valid2 <= io_din_valid; // @[DoCE.scala 40:12]
    end else if (io_dout_ready) begin // @[DoCE.scala 41:28]
      valid2 <= 1'h0; // @[DoCE.scala 44:12]
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
  data_dout = _RAND_0[511:0];
  _RAND_1 = {2{`RANDOM}};
  data_keep = _RAND_1[63:0];
  _RAND_2 = {1{`RANDOM}};
  data_last = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  data_connection_id = _RAND_3[3:0];
  _RAND_4 = {1{`RANDOM}};
  data_byte_num = _RAND_4[12:0];
  _RAND_5 = {1{`RANDOM}};
  valid = _RAND_5[0:0];
  _RAND_6 = {1{`RANDOM}};
  ready = _RAND_6[0:0];
  _RAND_7 = {16{`RANDOM}};
  data2_dout = _RAND_7[511:0];
  _RAND_8 = {2{`RANDOM}};
  data2_keep = _RAND_8[63:0];
  _RAND_9 = {1{`RANDOM}};
  data2_last = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  data2_connection_id = _RAND_10[3:0];
  _RAND_11 = {1{`RANDOM}};
  data2_byte_num = _RAND_11[12:0];
  _RAND_12 = {1{`RANDOM}};
  valid2 = _RAND_12[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module aw_width_converter(
  input          clock,
  input          reset,
  output         io_aw_channel_ready,
  input          io_aw_channel_valid,
  input  [83:0]  io_aw_channel_bits_aw,
  input  [3:0]   io_aw_channel_bits_connection_id,
  output         io_w_channel_ready,
  input          io_w_channel_valid,
  input  [575:0] io_w_channel_bits_w,
  input          io_w_channel_bits_last,
  (*dont_touch = "true" *)input          io_dout_channel_ready,
  (*dont_touch = "true" *)output         io_dout_channel_valid,
  output [511:0] io_dout_channel_bits_dout,
  output [63:0]  io_dout_channel_bits_keep,
  (*dont_touch = "true" *)output         io_dout_channel_bits_last,
  output [3:0]   io_dout_channel_bits_connection_id,
  output [12:0]  io_dout_channel_bits_byte_num
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [575:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire  out_clock; // @[DoCE.scala 78:19]
  wire  out_reset; // @[DoCE.scala 78:19]
  wire  out_io_dout_ready; // @[DoCE.scala 78:19]
  wire  out_io_dout_valid; // @[DoCE.scala 78:19]
  wire [511:0] out_io_dout_bits_dout; // @[DoCE.scala 78:19]
  wire [63:0] out_io_dout_bits_keep; // @[DoCE.scala 78:19]
  wire  out_io_dout_bits_last; // @[DoCE.scala 78:19]
  wire [3:0] out_io_dout_bits_connection_id; // @[DoCE.scala 78:19]
  wire [12:0] out_io_dout_bits_byte_num; // @[DoCE.scala 78:19]
  wire  out_io_din_ready; // @[DoCE.scala 78:19]
  wire  out_io_din_valid; // @[DoCE.scala 78:19]
  wire [511:0] out_io_din_bits_dout; // @[DoCE.scala 78:19]
  wire [63:0] out_io_din_bits_keep; // @[DoCE.scala 78:19]
  wire  out_io_din_bits_last; // @[DoCE.scala 78:19]
  wire [3:0] out_io_din_bits_connection_id; // @[DoCE.scala 78:19]
  wire [12:0] out_io_din_bits_byte_num; // @[DoCE.scala 78:19]
  (*dont_touch = "true" *)reg [31:0] bit_sent; // @[DoCE.scala 76:25]
  (*dont_touch = "true" *)reg [31:0] bit_recv; // @[DoCE.scala 77:25]
  reg [575:0] mid_w; // @[DoCE.scala 80:20]
  reg  mid_last; // @[DoCE.scala 80:20]
  wire  _T = io_w_channel_ready & io_w_channel_valid; // @[DoCE.scala 85:27]
  wire  _T_1 = out_io_din_valid & out_io_din_ready; // @[DoCE.scala 90:25]
  wire [31:0] _bit_sent_T_1 = bit_sent + 32'h200; // @[DoCE.scala 94:28]
  wire [31:0] _bit_recv_T_1 = bit_recv + 32'h240; // @[DoCE.scala 100:28]
  wire [31:0] _bit_recv_T_3 = _bit_recv_T_1 + 32'h80; // @[DoCE.scala 100:48]
  wire [31:0] left = bit_recv - bit_sent; // @[DoCE.scala 117:23]
  wire [383:0] out_io_din_bits_dout_hi = io_w_channel_bits_w[383:0]; // @[DoCE.scala 126:60]
  wire [127:0] out_io_din_bits_dout_lo = {{44'd0}, io_aw_channel_bits_aw}; // @[DoCE.scala 127:45 DoCE.scala 127:45]
  wire [511:0] _out_io_din_bits_dout_T = {out_io_din_bits_dout_hi,out_io_din_bits_dout_lo}; // @[Cat.scala 30:58]
  wire  _T_11 = bit_sent > 32'h0 & io_w_channel_valid; // @[DoCE.scala 136:35]
  wire [511:0] _GEN_8 = bit_sent > 32'h0 & io_w_channel_valid ? io_w_channel_bits_w[511:0] : out_io_dout_bits_dout; // @[DoCE.scala 136:57 DoCE.scala 138:32 DoCE.scala 110:24]
  wire  _GEN_9 = bit_sent > 32'h0 & io_w_channel_valid ? 1'h0 : out_io_dout_bits_last; // @[DoCE.scala 136:57 DoCE.scala 139:32 DoCE.scala 111:24]
  wire [63:0] _GEN_10 = bit_sent > 32'h0 & io_w_channel_valid ? 64'hffffffffffffffff : out_io_dout_bits_keep; // @[DoCE.scala 136:57 DoCE.scala 140:32 DoCE.scala 112:24]
  wire  _GEN_11 = bit_sent > 32'h0 & io_w_channel_valid & out_io_din_ready; // @[DoCE.scala 136:57 DoCE.scala 141:30 DoCE.scala 116:22]
  wire [511:0] _GEN_12 = bit_sent == 32'h0 & io_aw_channel_valid & io_w_channel_valid ? _out_io_din_bits_dout_T : _GEN_8
    ; // @[DoCE.scala 122:76 DoCE.scala 126:34]
  wire  _GEN_13 = bit_sent == 32'h0 & io_aw_channel_valid & io_w_channel_valid | _T_11; // @[DoCE.scala 122:76 DoCE.scala 129:28]
  wire  _GEN_14 = bit_sent == 32'h0 & io_aw_channel_valid & io_w_channel_valid ? 1'h0 : _GEN_9; // @[DoCE.scala 122:76 DoCE.scala 130:32]
  wire [63:0] _GEN_15 = bit_sent == 32'h0 & io_aw_channel_valid & io_w_channel_valid ? 64'hffffffffffffffff : _GEN_10; // @[DoCE.scala 122:76 DoCE.scala 131:32]
  wire [3:0] _GEN_16 = bit_sent == 32'h0 & io_aw_channel_valid & io_w_channel_valid ? io_aw_channel_bits_connection_id
     : out_io_dout_bits_connection_id; // @[DoCE.scala 122:76 DoCE.scala 132:41 DoCE.scala 113:33]
  wire [12:0] _GEN_17 = bit_sent == 32'h0 & io_aw_channel_valid & io_w_channel_valid ? 13'h58 :
    out_io_dout_bits_byte_num; // @[DoCE.scala 122:76 DoCE.scala 133:36 DoCE.scala 114:28]
  wire  _GEN_18 = bit_sent == 32'h0 & io_aw_channel_valid & io_w_channel_valid & out_io_din_ready; // @[DoCE.scala 122:76 DoCE.scala 134:31 DoCE.scala 115:23]
  wire  _GEN_19 = bit_sent == 32'h0 & io_aw_channel_valid & io_w_channel_valid ? out_io_din_ready : _GEN_11; // @[DoCE.scala 122:76 DoCE.scala 135:30]
  wire [511:0] _GEN_20 = left == 32'h0 ? _GEN_12 : out_io_dout_bits_dout; // @[DoCE.scala 120:23 DoCE.scala 110:24]
  wire  _GEN_21 = left == 32'h0 & _GEN_13; // @[DoCE.scala 120:23 DoCE.scala 109:20]
  wire  _GEN_22 = left == 32'h0 ? _GEN_14 : out_io_dout_bits_last; // @[DoCE.scala 120:23 DoCE.scala 111:24]
  wire [63:0] _GEN_23 = left == 32'h0 ? _GEN_15 : out_io_dout_bits_keep; // @[DoCE.scala 120:23 DoCE.scala 112:24]
  wire  _GEN_27 = left == 32'h0 & _GEN_19; // @[DoCE.scala 120:23 DoCE.scala 116:22]
  wire [447:0] out_io_din_bits_dout_hi_1 = io_w_channel_bits_w[447:0]; // @[DoCE.scala 151:58]
  wire [511:0] _out_io_din_bits_dout_T_3 = {out_io_din_bits_dout_hi_1,mid_w[575:512]}; // @[Cat.scala 30:58]
  wire  _GEN_28 = io_w_channel_valid | _GEN_21; // @[DoCE.scala 149:39 DoCE.scala 150:28]
  wire [511:0] _GEN_29 = io_w_channel_valid ? _out_io_din_bits_dout_T_3 : _GEN_20; // @[DoCE.scala 149:39 DoCE.scala 151:32]
  wire  _GEN_30 = io_w_channel_valid ? 1'h0 : _GEN_22; // @[DoCE.scala 149:39 DoCE.scala 152:32]
  wire [63:0] _GEN_31 = io_w_channel_valid ? 64'hffffffffffffffff : _GEN_23; // @[DoCE.scala 149:39 DoCE.scala 153:32]
  wire  _GEN_32 = io_w_channel_valid ? out_io_din_ready : _GEN_27; // @[DoCE.scala 149:39 DoCE.scala 154:30]
  wire  _GEN_33 = mid_last | _GEN_28; // @[DoCE.scala 144:23 DoCE.scala 145:28]
  wire [511:0] _GEN_34 = mid_last ? {{448'd0}, mid_w[575:512]} : _GEN_29; // @[DoCE.scala 144:23 DoCE.scala 146:32]
  wire  _GEN_35 = mid_last | _GEN_30; // @[DoCE.scala 144:23 DoCE.scala 147:32]
  wire [63:0] _GEN_36 = mid_last ? 64'hff : _GEN_31; // @[DoCE.scala 144:23 DoCE.scala 148:32]
  wire  _GEN_37 = mid_last ? _GEN_27 : _GEN_32; // @[DoCE.scala 144:23]
  wire  _GEN_38 = left == 32'h40 ? _GEN_33 : _GEN_21; // @[DoCE.scala 120:23]
  wire [511:0] _GEN_39 = left == 32'h40 ? _GEN_34 : _GEN_20; // @[DoCE.scala 120:23]
  wire  _GEN_40 = left == 32'h40 ? _GEN_35 : _GEN_22; // @[DoCE.scala 120:23]
  wire [63:0] _GEN_41 = left == 32'h40 ? _GEN_36 : _GEN_23; // @[DoCE.scala 120:23]
  wire  _GEN_42 = left == 32'h40 ? _GEN_37 : _GEN_27; // @[DoCE.scala 120:23]
  wire [511:0] _out_io_din_bits_dout_T_5 = {out_io_din_bits_dout_hi,mid_w[575:448]}; // @[Cat.scala 30:58]
  wire  _GEN_43 = io_w_channel_valid | _GEN_38; // @[DoCE.scala 149:39 DoCE.scala 150:28]
  wire [511:0] _GEN_44 = io_w_channel_valid ? _out_io_din_bits_dout_T_5 : _GEN_39; // @[DoCE.scala 149:39 DoCE.scala 151:32]
  wire  _GEN_45 = io_w_channel_valid ? 1'h0 : _GEN_40; // @[DoCE.scala 149:39 DoCE.scala 152:32]
  wire [63:0] _GEN_46 = io_w_channel_valid ? 64'hffffffffffffffff : _GEN_41; // @[DoCE.scala 149:39 DoCE.scala 153:32]
  wire  _GEN_47 = io_w_channel_valid ? out_io_din_ready : _GEN_42; // @[DoCE.scala 149:39 DoCE.scala 154:30]
  wire  _GEN_48 = mid_last | _GEN_43; // @[DoCE.scala 144:23 DoCE.scala 145:28]
  wire [511:0] _GEN_49 = mid_last ? {{384'd0}, mid_w[575:448]} : _GEN_44; // @[DoCE.scala 144:23 DoCE.scala 146:32]
  wire  _GEN_50 = mid_last | _GEN_45; // @[DoCE.scala 144:23 DoCE.scala 147:32]
  wire [63:0] _GEN_51 = mid_last ? 64'hffff : _GEN_46; // @[DoCE.scala 144:23 DoCE.scala 148:32]
  wire  _GEN_52 = mid_last ? _GEN_42 : _GEN_47; // @[DoCE.scala 144:23]
  wire  _GEN_53 = left == 32'h80 ? _GEN_48 : _GEN_38; // @[DoCE.scala 120:23]
  wire [511:0] _GEN_54 = left == 32'h80 ? _GEN_49 : _GEN_39; // @[DoCE.scala 120:23]
  wire  _GEN_55 = left == 32'h80 ? _GEN_50 : _GEN_40; // @[DoCE.scala 120:23]
  wire [63:0] _GEN_56 = left == 32'h80 ? _GEN_51 : _GEN_41; // @[DoCE.scala 120:23]
  wire  _GEN_57 = left == 32'h80 ? _GEN_52 : _GEN_42; // @[DoCE.scala 120:23]
  wire [319:0] out_io_din_bits_dout_hi_3 = io_w_channel_bits_w[319:0]; // @[DoCE.scala 151:58]
  wire [511:0] _out_io_din_bits_dout_T_7 = {out_io_din_bits_dout_hi_3,mid_w[575:384]}; // @[Cat.scala 30:58]
  wire  _GEN_58 = io_w_channel_valid | _GEN_53; // @[DoCE.scala 149:39 DoCE.scala 150:28]
  wire [511:0] _GEN_59 = io_w_channel_valid ? _out_io_din_bits_dout_T_7 : _GEN_54; // @[DoCE.scala 149:39 DoCE.scala 151:32]
  wire  _GEN_60 = io_w_channel_valid ? 1'h0 : _GEN_55; // @[DoCE.scala 149:39 DoCE.scala 152:32]
  wire [63:0] _GEN_61 = io_w_channel_valid ? 64'hffffffffffffffff : _GEN_56; // @[DoCE.scala 149:39 DoCE.scala 153:32]
  wire  _GEN_62 = io_w_channel_valid ? out_io_din_ready : _GEN_57; // @[DoCE.scala 149:39 DoCE.scala 154:30]
  wire  _GEN_63 = mid_last | _GEN_58; // @[DoCE.scala 144:23 DoCE.scala 145:28]
  wire [511:0] _GEN_64 = mid_last ? {{320'd0}, mid_w[575:384]} : _GEN_59; // @[DoCE.scala 144:23 DoCE.scala 146:32]
  wire  _GEN_65 = mid_last | _GEN_60; // @[DoCE.scala 144:23 DoCE.scala 147:32]
  wire [63:0] _GEN_66 = mid_last ? 64'hffffff : _GEN_61; // @[DoCE.scala 144:23 DoCE.scala 148:32]
  wire  _GEN_67 = mid_last ? _GEN_57 : _GEN_62; // @[DoCE.scala 144:23]
  wire  _GEN_68 = left == 32'hc0 ? _GEN_63 : _GEN_53; // @[DoCE.scala 120:23]
  wire [511:0] _GEN_69 = left == 32'hc0 ? _GEN_64 : _GEN_54; // @[DoCE.scala 120:23]
  wire  _GEN_70 = left == 32'hc0 ? _GEN_65 : _GEN_55; // @[DoCE.scala 120:23]
  wire [63:0] _GEN_71 = left == 32'hc0 ? _GEN_66 : _GEN_56; // @[DoCE.scala 120:23]
  wire  _GEN_72 = left == 32'hc0 ? _GEN_67 : _GEN_57; // @[DoCE.scala 120:23]
  wire [255:0] out_io_din_bits_dout_hi_4 = io_w_channel_bits_w[255:0]; // @[DoCE.scala 151:58]
  wire [511:0] _out_io_din_bits_dout_T_9 = {out_io_din_bits_dout_hi_4,mid_w[575:320]}; // @[Cat.scala 30:58]
  wire  _GEN_73 = io_w_channel_valid | _GEN_68; // @[DoCE.scala 149:39 DoCE.scala 150:28]
  wire [511:0] _GEN_74 = io_w_channel_valid ? _out_io_din_bits_dout_T_9 : _GEN_69; // @[DoCE.scala 149:39 DoCE.scala 151:32]
  wire  _GEN_75 = io_w_channel_valid ? 1'h0 : _GEN_70; // @[DoCE.scala 149:39 DoCE.scala 152:32]
  wire [63:0] _GEN_76 = io_w_channel_valid ? 64'hffffffffffffffff : _GEN_71; // @[DoCE.scala 149:39 DoCE.scala 153:32]
  wire  _GEN_77 = io_w_channel_valid ? out_io_din_ready : _GEN_72; // @[DoCE.scala 149:39 DoCE.scala 154:30]
  wire  _GEN_78 = mid_last | _GEN_73; // @[DoCE.scala 144:23 DoCE.scala 145:28]
  wire [511:0] _GEN_79 = mid_last ? {{256'd0}, mid_w[575:320]} : _GEN_74; // @[DoCE.scala 144:23 DoCE.scala 146:32]
  wire  _GEN_80 = mid_last | _GEN_75; // @[DoCE.scala 144:23 DoCE.scala 147:32]
  wire [63:0] _GEN_81 = mid_last ? 64'hffffffff : _GEN_76; // @[DoCE.scala 144:23 DoCE.scala 148:32]
  wire  _GEN_82 = mid_last ? _GEN_72 : _GEN_77; // @[DoCE.scala 144:23]
  wire  _GEN_83 = left == 32'h100 ? _GEN_78 : _GEN_68; // @[DoCE.scala 120:23]
  wire [511:0] _GEN_84 = left == 32'h100 ? _GEN_79 : _GEN_69; // @[DoCE.scala 120:23]
  wire  _GEN_85 = left == 32'h100 ? _GEN_80 : _GEN_70; // @[DoCE.scala 120:23]
  wire [63:0] _GEN_86 = left == 32'h100 ? _GEN_81 : _GEN_71; // @[DoCE.scala 120:23]
  wire  _GEN_87 = left == 32'h100 ? _GEN_82 : _GEN_72; // @[DoCE.scala 120:23]
  wire [191:0] out_io_din_bits_dout_hi_5 = io_w_channel_bits_w[191:0]; // @[DoCE.scala 151:58]
  wire [511:0] _out_io_din_bits_dout_T_11 = {out_io_din_bits_dout_hi_5,mid_w[575:256]}; // @[Cat.scala 30:58]
  wire  _GEN_88 = io_w_channel_valid | _GEN_83; // @[DoCE.scala 149:39 DoCE.scala 150:28]
  wire [511:0] _GEN_89 = io_w_channel_valid ? _out_io_din_bits_dout_T_11 : _GEN_84; // @[DoCE.scala 149:39 DoCE.scala 151:32]
  wire  _GEN_90 = io_w_channel_valid ? 1'h0 : _GEN_85; // @[DoCE.scala 149:39 DoCE.scala 152:32]
  wire [63:0] _GEN_91 = io_w_channel_valid ? 64'hffffffffffffffff : _GEN_86; // @[DoCE.scala 149:39 DoCE.scala 153:32]
  wire  _GEN_92 = io_w_channel_valid ? out_io_din_ready : _GEN_87; // @[DoCE.scala 149:39 DoCE.scala 154:30]
  wire  _GEN_93 = mid_last | _GEN_88; // @[DoCE.scala 144:23 DoCE.scala 145:28]
  wire [511:0] _GEN_94 = mid_last ? {{192'd0}, mid_w[575:256]} : _GEN_89; // @[DoCE.scala 144:23 DoCE.scala 146:32]
  wire  _GEN_95 = mid_last | _GEN_90; // @[DoCE.scala 144:23 DoCE.scala 147:32]
  wire [63:0] _GEN_96 = mid_last ? 64'hffffffffff : _GEN_91; // @[DoCE.scala 144:23 DoCE.scala 148:32]
  wire  _GEN_97 = mid_last ? _GEN_87 : _GEN_92; // @[DoCE.scala 144:23]
  wire  _GEN_98 = left == 32'h140 ? _GEN_93 : _GEN_83; // @[DoCE.scala 120:23]
  wire [511:0] _GEN_99 = left == 32'h140 ? _GEN_94 : _GEN_84; // @[DoCE.scala 120:23]
  wire  _GEN_100 = left == 32'h140 ? _GEN_95 : _GEN_85; // @[DoCE.scala 120:23]
  wire [63:0] _GEN_101 = left == 32'h140 ? _GEN_96 : _GEN_86; // @[DoCE.scala 120:23]
  wire  _GEN_102 = left == 32'h140 ? _GEN_97 : _GEN_87; // @[DoCE.scala 120:23]
  wire [127:0] out_io_din_bits_dout_hi_6 = io_w_channel_bits_w[127:0]; // @[DoCE.scala 151:58]
  wire [511:0] _out_io_din_bits_dout_T_13 = {out_io_din_bits_dout_hi_6,mid_w[575:192]}; // @[Cat.scala 30:58]
  wire  _GEN_103 = io_w_channel_valid | _GEN_98; // @[DoCE.scala 149:39 DoCE.scala 150:28]
  wire [511:0] _GEN_104 = io_w_channel_valid ? _out_io_din_bits_dout_T_13 : _GEN_99; // @[DoCE.scala 149:39 DoCE.scala 151:32]
  wire  _GEN_105 = io_w_channel_valid ? 1'h0 : _GEN_100; // @[DoCE.scala 149:39 DoCE.scala 152:32]
  wire [63:0] _GEN_106 = io_w_channel_valid ? 64'hffffffffffffffff : _GEN_101; // @[DoCE.scala 149:39 DoCE.scala 153:32]
  wire  _GEN_107 = io_w_channel_valid ? out_io_din_ready : _GEN_102; // @[DoCE.scala 149:39 DoCE.scala 154:30]
  wire  _GEN_108 = mid_last | _GEN_103; // @[DoCE.scala 144:23 DoCE.scala 145:28]
  wire [511:0] _GEN_109 = mid_last ? {{128'd0}, mid_w[575:192]} : _GEN_104; // @[DoCE.scala 144:23 DoCE.scala 146:32]
  wire  _GEN_110 = mid_last | _GEN_105; // @[DoCE.scala 144:23 DoCE.scala 147:32]
  wire [63:0] _GEN_111 = mid_last ? 64'hffffffffffff : _GEN_106; // @[DoCE.scala 144:23 DoCE.scala 148:32]
  wire  _GEN_112 = mid_last ? _GEN_102 : _GEN_107; // @[DoCE.scala 144:23]
  wire  _GEN_113 = left == 32'h180 ? _GEN_108 : _GEN_98; // @[DoCE.scala 120:23]
  wire [511:0] _GEN_114 = left == 32'h180 ? _GEN_109 : _GEN_99; // @[DoCE.scala 120:23]
  wire  _GEN_115 = left == 32'h180 ? _GEN_110 : _GEN_100; // @[DoCE.scala 120:23]
  wire [63:0] _GEN_116 = left == 32'h180 ? _GEN_111 : _GEN_101; // @[DoCE.scala 120:23]
  wire  _GEN_117 = left == 32'h180 ? _GEN_112 : _GEN_102; // @[DoCE.scala 120:23]
  wire [63:0] out_io_din_bits_dout_hi_7 = io_w_channel_bits_w[63:0]; // @[DoCE.scala 151:58]
  wire [511:0] _out_io_din_bits_dout_T_15 = {out_io_din_bits_dout_hi_7,mid_w[575:128]}; // @[Cat.scala 30:58]
  wire  _GEN_118 = io_w_channel_valid | _GEN_113; // @[DoCE.scala 149:39 DoCE.scala 150:28]
  wire [511:0] _GEN_119 = io_w_channel_valid ? _out_io_din_bits_dout_T_15 : _GEN_114; // @[DoCE.scala 149:39 DoCE.scala 151:32]
  wire  _GEN_120 = io_w_channel_valid ? 1'h0 : _GEN_115; // @[DoCE.scala 149:39 DoCE.scala 152:32]
  wire [63:0] _GEN_121 = io_w_channel_valid ? 64'hffffffffffffffff : _GEN_116; // @[DoCE.scala 149:39 DoCE.scala 153:32]
  wire  _GEN_122 = io_w_channel_valid ? out_io_din_ready : _GEN_117; // @[DoCE.scala 149:39 DoCE.scala 154:30]
  wire  _GEN_123 = mid_last | _GEN_118; // @[DoCE.scala 144:23 DoCE.scala 145:28]
  wire [511:0] _GEN_124 = mid_last ? {{64'd0}, mid_w[575:128]} : _GEN_119; // @[DoCE.scala 144:23 DoCE.scala 146:32]
  wire  _GEN_125 = mid_last | _GEN_120; // @[DoCE.scala 144:23 DoCE.scala 147:32]
  wire [63:0] _GEN_126 = mid_last ? 64'hffffffffffffff : _GEN_121; // @[DoCE.scala 144:23 DoCE.scala 148:32]
  wire  _GEN_127 = mid_last ? _GEN_117 : _GEN_122; // @[DoCE.scala 144:23]
  wire  _GEN_128 = left == 32'h1c0 ? _GEN_123 : _GEN_113; // @[DoCE.scala 120:23]
  wire [511:0] _GEN_129 = left == 32'h1c0 ? _GEN_124 : _GEN_114; // @[DoCE.scala 120:23]
  wire  _GEN_130 = left == 32'h1c0 ? _GEN_125 : _GEN_115; // @[DoCE.scala 120:23]
  wire [63:0] _GEN_131 = left == 32'h1c0 ? _GEN_126 : _GEN_116; // @[DoCE.scala 120:23]
  wire [511:0] _GEN_134 = left == 32'h200 ? mid_w[575:64] : _GEN_129; // @[DoCE.scala 120:23 DoCE.scala 158:30]
  wire  _GEN_135 = left == 32'h200 ? 1'h0 : _GEN_130; // @[DoCE.scala 120:23 DoCE.scala 159:30]
  wire [63:0] _GEN_136 = left == 32'h200 ? 64'hffffffffffffffff : _GEN_131; // @[DoCE.scala 120:23 DoCE.scala 160:30]
  dout_channel_reg_slice out ( // @[DoCE.scala 78:19]
    .clock(out_clock),
    .reset(out_reset),
    .io_dout_ready(out_io_dout_ready),
    .io_dout_valid(out_io_dout_valid),
    .io_dout_bits_dout(out_io_dout_bits_dout),
    .io_dout_bits_keep(out_io_dout_bits_keep),
    .io_dout_bits_last(out_io_dout_bits_last),
    .io_dout_bits_connection_id(out_io_dout_bits_connection_id),
    .io_dout_bits_byte_num(out_io_dout_bits_byte_num),
    .io_din_ready(out_io_din_ready),
    .io_din_valid(out_io_din_valid),
    .io_din_bits_dout(out_io_din_bits_dout),
    .io_din_bits_keep(out_io_din_bits_keep),
    .io_din_bits_last(out_io_din_bits_last),
    .io_din_bits_connection_id(out_io_din_bits_connection_id),
    .io_din_bits_byte_num(out_io_din_bits_byte_num)
  );
  assign io_aw_channel_ready = left == 32'h0 & _GEN_18; // @[DoCE.scala 120:23 DoCE.scala 115:23]
  assign io_w_channel_ready = left == 32'h1c0 ? _GEN_127 : _GEN_117; // @[DoCE.scala 120:23]
  assign io_dout_channel_valid = out_io_dout_valid; // @[DoCE.scala 108:19]
  assign io_dout_channel_bits_dout = out_io_dout_bits_dout; // @[DoCE.scala 108:19]
  assign io_dout_channel_bits_keep = out_io_dout_bits_keep; // @[DoCE.scala 108:19]
  assign io_dout_channel_bits_last = out_io_dout_bits_last; // @[DoCE.scala 108:19]
  assign io_dout_channel_bits_connection_id = out_io_dout_bits_connection_id; // @[DoCE.scala 108:19]
  assign io_dout_channel_bits_byte_num = out_io_dout_bits_byte_num; // @[DoCE.scala 108:19]
  assign out_clock = clock;
  assign out_reset = reset;
  assign out_io_dout_ready = io_dout_channel_ready; // @[DoCE.scala 108:19]
  assign out_io_din_valid = left == 32'h240 | (left == 32'h200 | _GEN_128); // @[DoCE.scala 120:23 DoCE.scala 157:26]
  assign out_io_din_bits_dout = left == 32'h240 ? mid_w[511:0] : _GEN_134; // @[DoCE.scala 120:23 DoCE.scala 158:30]
  assign out_io_din_bits_keep = left == 32'h240 ? 64'hffffffffffffffff : _GEN_136; // @[DoCE.scala 120:23 DoCE.scala 160:30]
  assign out_io_din_bits_last = left == 32'h240 ? 1'h0 : _GEN_135; // @[DoCE.scala 120:23 DoCE.scala 159:30]
  assign out_io_din_bits_connection_id = left == 32'h0 ? _GEN_16 : out_io_dout_bits_connection_id; // @[DoCE.scala 120:23 DoCE.scala 113:33]
  assign out_io_din_bits_byte_num = left == 32'h0 ? _GEN_17 : out_io_dout_bits_byte_num; // @[DoCE.scala 120:23 DoCE.scala 114:28]
  always @(posedge clock) begin
    if (reset) begin // @[DoCE.scala 76:25]
      bit_sent <= 32'h0; // @[DoCE.scala 76:25]
    end else if (out_io_din_valid & out_io_din_ready) begin // @[DoCE.scala 90:45]
      if (out_io_din_bits_last) begin // @[DoCE.scala 91:31]
        bit_sent <= 32'h0; // @[DoCE.scala 92:16]
      end else begin
        bit_sent <= _bit_sent_T_1; // @[DoCE.scala 94:16]
      end
    end
    if (reset) begin // @[DoCE.scala 77:25]
      bit_recv <= 32'h0; // @[DoCE.scala 77:25]
    end else if (_T) begin // @[DoCE.scala 98:49]
      if (io_aw_channel_ready & io_aw_channel_valid) begin // @[DoCE.scala 99:53]
        bit_recv <= _bit_recv_T_3; // @[DoCE.scala 100:16]
      end else begin
        bit_recv <= _bit_recv_T_1; // @[DoCE.scala 102:16]
      end
    end else if (_T_1 & out_io_din_bits_last) begin // @[DoCE.scala 104:75]
      bit_recv <= 32'h0; // @[DoCE.scala 105:14]
    end
    if (reset) begin // @[DoCE.scala 80:20]
      mid_w <= 576'h0; // @[DoCE.scala 80:20]
    end else if (io_w_channel_ready & io_w_channel_valid) begin // @[DoCE.scala 85:49]
      mid_w <= io_w_channel_bits_w; // @[DoCE.scala 86:11]
    end
    if (reset) begin // @[DoCE.scala 80:20]
      mid_last <= 1'h0; // @[DoCE.scala 80:20]
    end else if (io_w_channel_ready & io_w_channel_valid) begin // @[DoCE.scala 85:49]
      mid_last <= io_w_channel_bits_last; // @[DoCE.scala 87:14]
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
  _RAND_0 = {1{`RANDOM}};
  bit_sent = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  bit_recv = _RAND_1[31:0];
  _RAND_2 = {18{`RANDOM}};
  mid_w = _RAND_2[575:0];
  _RAND_3 = {1{`RANDOM}};
  mid_last = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
