module dout_channel_reg_slice(
  input          clock,
  input          reset,
  input          io_dout_ready,
  output         io_dout_valid,
  output [127:0] io_dout_bits_dout,
  output [15:0]  io_dout_bits_keep,
  output         io_dout_bits_last,
  output [3:0]   io_dout_bits_connection_id,
  output [12:0]  io_dout_bits_byte_num,
  output         io_din_ready,
  input          io_din_valid,
  input  [127:0] io_din_bits_dout,
  input  [15:0]  io_din_bits_keep,
  input          io_din_bits_last,
  input  [3:0]   io_din_bits_connection_id,
  input  [12:0]  io_din_bits_byte_num
);
`ifdef RANDOMIZE_REG_INIT
  reg [127:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
`endif // RANDOMIZE_REG_INIT
  reg [127:0] data_dout; // @[DoCE.scala 13:21]
  reg [15:0] data_keep; // @[DoCE.scala 13:21]
  reg  data_last; // @[DoCE.scala 13:21]
  reg [3:0] data_connection_id; // @[DoCE.scala 13:21]
  reg [12:0] data_byte_num; // @[DoCE.scala 13:21]
  reg  valid; // @[DoCE.scala 14:22]
  wire  _T = ~io_dout_valid; // @[DoCE.scala 15:24]
  assign io_dout_valid = valid; // @[DoCE.scala 21:17]
  assign io_dout_bits_dout = data_dout; // @[DoCE.scala 22:16]
  assign io_dout_bits_keep = data_keep; // @[DoCE.scala 22:16]
  assign io_dout_bits_last = data_last; // @[DoCE.scala 22:16]
  assign io_dout_bits_connection_id = data_connection_id; // @[DoCE.scala 22:16]
  assign io_dout_bits_byte_num = data_byte_num; // @[DoCE.scala 22:16]
  assign io_din_ready = io_dout_ready | _T; // @[DoCE.scala 20:33]
  always @(posedge clock) begin
    if (reset) begin // @[DoCE.scala 13:21]
      data_dout <= 128'h0; // @[DoCE.scala 13:21]
    end else if (io_dout_ready | ~io_dout_valid) begin // @[DoCE.scala 15:39]
      data_dout <= io_din_bits_dout; // @[DoCE.scala 16:10]
    end
    if (reset) begin // @[DoCE.scala 13:21]
      data_keep <= 16'h0; // @[DoCE.scala 13:21]
    end else if (io_dout_ready | ~io_dout_valid) begin // @[DoCE.scala 15:39]
      data_keep <= io_din_bits_keep; // @[DoCE.scala 16:10]
    end
    if (reset) begin // @[DoCE.scala 13:21]
      data_last <= 1'h0; // @[DoCE.scala 13:21]
    end else if (io_dout_ready | ~io_dout_valid) begin // @[DoCE.scala 15:39]
      data_last <= io_din_bits_last; // @[DoCE.scala 16:10]
    end
    if (reset) begin // @[DoCE.scala 13:21]
      data_connection_id <= 4'h0; // @[DoCE.scala 13:21]
    end else if (io_dout_ready | ~io_dout_valid) begin // @[DoCE.scala 15:39]
      data_connection_id <= io_din_bits_connection_id; // @[DoCE.scala 16:10]
    end
    if (reset) begin // @[DoCE.scala 13:21]
      data_byte_num <= 13'h0; // @[DoCE.scala 13:21]
    end else if (io_dout_ready | ~io_dout_valid) begin // @[DoCE.scala 15:39]
      data_byte_num <= io_din_bits_byte_num; // @[DoCE.scala 16:10]
    end
    if (reset) begin // @[DoCE.scala 14:22]
      valid <= 1'h0; // @[DoCE.scala 14:22]
    end else if (io_dout_ready | ~io_dout_valid) begin // @[DoCE.scala 15:39]
      valid <= io_din_valid; // @[DoCE.scala 17:11]
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
  _RAND_0 = {4{`RANDOM}};
  data_dout = _RAND_0[127:0];
  _RAND_1 = {1{`RANDOM}};
  data_keep = _RAND_1[15:0];
  _RAND_2 = {1{`RANDOM}};
  data_last = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  data_connection_id = _RAND_3[3:0];
  _RAND_4 = {1{`RANDOM}};
  data_byte_num = _RAND_4[12:0];
  _RAND_5 = {1{`RANDOM}};
  valid = _RAND_5[0:0];
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
  input  [143:0] io_w_channel_bits_w,
  input          io_w_channel_bits_last,
  input          io_dout_channel_ready,
  output         io_dout_channel_valid,
  output [127:0] io_dout_channel_bits_dout,
  output [15:0]  io_dout_channel_bits_keep,
  output         io_dout_channel_bits_last,
  output [3:0]   io_dout_channel_bits_connection_id,
  output [12:0]  io_dout_channel_bits_byte_num
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [159:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire  out_clock; // @[DoCE.scala 51:19]
  wire  out_reset; // @[DoCE.scala 51:19]
  wire  out_io_dout_ready; // @[DoCE.scala 51:19]
  wire  out_io_dout_valid; // @[DoCE.scala 51:19]
  wire [127:0] out_io_dout_bits_dout; // @[DoCE.scala 51:19]
  wire [15:0] out_io_dout_bits_keep; // @[DoCE.scala 51:19]
  wire  out_io_dout_bits_last; // @[DoCE.scala 51:19]
  wire [3:0] out_io_dout_bits_connection_id; // @[DoCE.scala 51:19]
  wire [12:0] out_io_dout_bits_byte_num; // @[DoCE.scala 51:19]
  wire  out_io_din_ready; // @[DoCE.scala 51:19]
  wire  out_io_din_valid; // @[DoCE.scala 51:19]
  wire [127:0] out_io_din_bits_dout; // @[DoCE.scala 51:19]
  wire [15:0] out_io_din_bits_keep; // @[DoCE.scala 51:19]
  wire  out_io_din_bits_last; // @[DoCE.scala 51:19]
  wire [3:0] out_io_din_bits_connection_id; // @[DoCE.scala 51:19]
  wire [12:0] out_io_din_bits_byte_num; // @[DoCE.scala 51:19]
  reg [31:0] bit_sent; // @[DoCE.scala 49:25]
  reg [31:0] bit_recv; // @[DoCE.scala 50:25]
  wire [8:0] _GEN_141 = {{1'd0}, io_aw_channel_bits_aw[77:70]}; // @[DoCE.scala 52:46]
  wire [8:0] aw_len = _GEN_141 + 9'h1; // @[DoCE.scala 52:46]
  reg [143:0] mid_w; // @[DoCE.scala 53:20]
  reg  mid_last; // @[DoCE.scala 53:20]
  wire  _T = io_w_channel_ready & io_w_channel_valid; // @[DoCE.scala 58:27]
  wire  _T_1 = out_io_din_valid & out_io_din_ready; // @[DoCE.scala 63:25]
  wire [31:0] _bit_sent_T_1 = bit_sent + 32'h80; // @[DoCE.scala 67:28]
  wire [31:0] _bit_recv_T_1 = bit_recv + 32'h90; // @[DoCE.scala 73:28]
  wire [31:0] _bit_recv_T_3 = _bit_recv_T_1 + 32'h80; // @[DoCE.scala 73:48]
  wire [31:0] left = bit_recv - bit_sent; // @[DoCE.scala 90:23]
  wire [12:0] _out_io_din_bits_byte_num_T = {aw_len,4'hb}; // @[Cat.scala 30:58]
  wire [9:0] _out_io_din_bits_byte_num_T_1 = {aw_len,1'h0}; // @[Cat.scala 30:58]
  wire [12:0] _GEN_142 = {{3'd0}, _out_io_din_bits_byte_num_T_1}; // @[DoCE.scala 106:62]
  wire [12:0] _out_io_din_bits_byte_num_T_3 = _out_io_din_bits_byte_num_T + _GEN_142; // @[DoCE.scala 106:62]
  wire  _T_11 = bit_sent > 32'h0 & io_w_channel_valid; // @[DoCE.scala 109:35]
  wire [127:0] _GEN_8 = bit_sent > 32'h0 & io_w_channel_valid ? io_w_channel_bits_w[127:0] : out_io_dout_bits_dout; // @[DoCE.scala 109:57 DoCE.scala 111:32 DoCE.scala 83:24]
  wire  _GEN_9 = bit_sent > 32'h0 & io_w_channel_valid ? 1'h0 : out_io_dout_bits_last; // @[DoCE.scala 109:57 DoCE.scala 112:32 DoCE.scala 84:24]
  wire [15:0] _GEN_10 = bit_sent > 32'h0 & io_w_channel_valid ? 16'hffff : out_io_dout_bits_keep; // @[DoCE.scala 109:57 DoCE.scala 113:32 DoCE.scala 85:24]
  wire  _GEN_11 = bit_sent > 32'h0 & io_w_channel_valid & out_io_din_ready; // @[DoCE.scala 109:57 DoCE.scala 114:30 DoCE.scala 89:22]
  wire [127:0] _out_io_din_bits_dout_WIRE = {{44'd0}, io_aw_channel_bits_aw}; // @[DoCE.scala 97:67 DoCE.scala 97:67]
  wire [127:0] _GEN_12 = bit_sent == 32'h0 & io_aw_channel_valid & io_w_channel_valid ? _out_io_din_bits_dout_WIRE :
    _GEN_8; // @[DoCE.scala 95:76 DoCE.scala 97:34]
  wire  _GEN_13 = bit_sent == 32'h0 & io_aw_channel_valid & io_w_channel_valid | _T_11; // @[DoCE.scala 95:76 DoCE.scala 102:28]
  wire  _GEN_14 = bit_sent == 32'h0 & io_aw_channel_valid & io_w_channel_valid ? 1'h0 : _GEN_9; // @[DoCE.scala 95:76 DoCE.scala 103:32]
  wire [15:0] _GEN_15 = bit_sent == 32'h0 & io_aw_channel_valid & io_w_channel_valid ? 16'hffff : _GEN_10; // @[DoCE.scala 95:76 DoCE.scala 104:32]
  wire [3:0] _GEN_16 = bit_sent == 32'h0 & io_aw_channel_valid & io_w_channel_valid ? io_aw_channel_bits_connection_id
     : out_io_dout_bits_connection_id; // @[DoCE.scala 95:76 DoCE.scala 105:41 DoCE.scala 86:33]
  wire [12:0] _GEN_17 = bit_sent == 32'h0 & io_aw_channel_valid & io_w_channel_valid ? _out_io_din_bits_byte_num_T_3 :
    out_io_dout_bits_byte_num; // @[DoCE.scala 95:76 DoCE.scala 106:36 DoCE.scala 87:28]
  wire  _GEN_18 = bit_sent == 32'h0 & io_aw_channel_valid & io_w_channel_valid & out_io_din_ready; // @[DoCE.scala 95:76 DoCE.scala 107:31 DoCE.scala 88:23]
  wire  _GEN_19 = bit_sent == 32'h0 & io_aw_channel_valid & io_w_channel_valid ? out_io_din_ready : _GEN_11; // @[DoCE.scala 95:76 DoCE.scala 108:30]
  wire [127:0] _GEN_20 = left == 32'h0 ? _GEN_12 : out_io_dout_bits_dout; // @[DoCE.scala 93:23 DoCE.scala 83:24]
  wire  _GEN_21 = left == 32'h0 & _GEN_13; // @[DoCE.scala 93:23 DoCE.scala 82:20]
  wire  _GEN_22 = left == 32'h0 ? _GEN_14 : out_io_dout_bits_last; // @[DoCE.scala 93:23 DoCE.scala 84:24]
  wire [15:0] _GEN_23 = left == 32'h0 ? _GEN_15 : out_io_dout_bits_keep; // @[DoCE.scala 93:23 DoCE.scala 85:24]
  wire  _GEN_27 = left == 32'h0 & _GEN_19; // @[DoCE.scala 93:23 DoCE.scala 89:22]
  wire [111:0] out_io_din_bits_dout_hi = io_w_channel_bits_w[111:0]; // @[DoCE.scala 124:58]
  wire [127:0] _out_io_din_bits_dout_T_2 = {out_io_din_bits_dout_hi,mid_w[143:128]}; // @[Cat.scala 30:58]
  wire  _GEN_28 = io_w_channel_valid | _GEN_21; // @[DoCE.scala 122:39 DoCE.scala 123:28]
  wire [127:0] _GEN_29 = io_w_channel_valid ? _out_io_din_bits_dout_T_2 : _GEN_20; // @[DoCE.scala 122:39 DoCE.scala 124:32]
  wire  _GEN_30 = io_w_channel_valid ? 1'h0 : _GEN_22; // @[DoCE.scala 122:39 DoCE.scala 125:32]
  wire [15:0] _GEN_31 = io_w_channel_valid ? 16'hffff : _GEN_23; // @[DoCE.scala 122:39 DoCE.scala 126:32]
  wire  _GEN_32 = io_w_channel_valid ? out_io_din_ready : _GEN_27; // @[DoCE.scala 122:39 DoCE.scala 127:30]
  wire  _GEN_33 = mid_last | _GEN_28; // @[DoCE.scala 117:23 DoCE.scala 118:28]
  wire [127:0] _GEN_34 = mid_last ? {{112'd0}, mid_w[143:128]} : _GEN_29; // @[DoCE.scala 117:23 DoCE.scala 119:32]
  wire  _GEN_35 = mid_last | _GEN_30; // @[DoCE.scala 117:23 DoCE.scala 120:32]
  wire [15:0] _GEN_36 = mid_last ? 16'h3 : _GEN_31; // @[DoCE.scala 117:23 DoCE.scala 121:32]
  wire  _GEN_37 = mid_last ? _GEN_27 : _GEN_32; // @[DoCE.scala 117:23]
  wire  _GEN_38 = left == 32'h10 ? _GEN_33 : _GEN_21; // @[DoCE.scala 93:23]
  wire [127:0] _GEN_39 = left == 32'h10 ? _GEN_34 : _GEN_20; // @[DoCE.scala 93:23]
  wire  _GEN_40 = left == 32'h10 ? _GEN_35 : _GEN_22; // @[DoCE.scala 93:23]
  wire [15:0] _GEN_41 = left == 32'h10 ? _GEN_36 : _GEN_23; // @[DoCE.scala 93:23]
  wire  _GEN_42 = left == 32'h10 ? _GEN_37 : _GEN_27; // @[DoCE.scala 93:23]
  wire [95:0] out_io_din_bits_dout_hi_1 = io_w_channel_bits_w[95:0]; // @[DoCE.scala 124:58]
  wire [127:0] _out_io_din_bits_dout_T_4 = {out_io_din_bits_dout_hi_1,mid_w[143:112]}; // @[Cat.scala 30:58]
  wire  _GEN_43 = io_w_channel_valid | _GEN_38; // @[DoCE.scala 122:39 DoCE.scala 123:28]
  wire [127:0] _GEN_44 = io_w_channel_valid ? _out_io_din_bits_dout_T_4 : _GEN_39; // @[DoCE.scala 122:39 DoCE.scala 124:32]
  wire  _GEN_45 = io_w_channel_valid ? 1'h0 : _GEN_40; // @[DoCE.scala 122:39 DoCE.scala 125:32]
  wire [15:0] _GEN_46 = io_w_channel_valid ? 16'hffff : _GEN_41; // @[DoCE.scala 122:39 DoCE.scala 126:32]
  wire  _GEN_47 = io_w_channel_valid ? out_io_din_ready : _GEN_42; // @[DoCE.scala 122:39 DoCE.scala 127:30]
  wire  _GEN_48 = mid_last | _GEN_43; // @[DoCE.scala 117:23 DoCE.scala 118:28]
  wire [127:0] _GEN_49 = mid_last ? {{96'd0}, mid_w[143:112]} : _GEN_44; // @[DoCE.scala 117:23 DoCE.scala 119:32]
  wire  _GEN_50 = mid_last | _GEN_45; // @[DoCE.scala 117:23 DoCE.scala 120:32]
  wire [15:0] _GEN_51 = mid_last ? 16'hf : _GEN_46; // @[DoCE.scala 117:23 DoCE.scala 121:32]
  wire  _GEN_52 = mid_last ? _GEN_42 : _GEN_47; // @[DoCE.scala 117:23]
  wire  _GEN_53 = left == 32'h20 ? _GEN_48 : _GEN_38; // @[DoCE.scala 93:23]
  wire [127:0] _GEN_54 = left == 32'h20 ? _GEN_49 : _GEN_39; // @[DoCE.scala 93:23]
  wire  _GEN_55 = left == 32'h20 ? _GEN_50 : _GEN_40; // @[DoCE.scala 93:23]
  wire [15:0] _GEN_56 = left == 32'h20 ? _GEN_51 : _GEN_41; // @[DoCE.scala 93:23]
  wire  _GEN_57 = left == 32'h20 ? _GEN_52 : _GEN_42; // @[DoCE.scala 93:23]
  wire [79:0] out_io_din_bits_dout_hi_2 = io_w_channel_bits_w[79:0]; // @[DoCE.scala 124:58]
  wire [127:0] _out_io_din_bits_dout_T_6 = {out_io_din_bits_dout_hi_2,mid_w[143:96]}; // @[Cat.scala 30:58]
  wire  _GEN_58 = io_w_channel_valid | _GEN_53; // @[DoCE.scala 122:39 DoCE.scala 123:28]
  wire [127:0] _GEN_59 = io_w_channel_valid ? _out_io_din_bits_dout_T_6 : _GEN_54; // @[DoCE.scala 122:39 DoCE.scala 124:32]
  wire  _GEN_60 = io_w_channel_valid ? 1'h0 : _GEN_55; // @[DoCE.scala 122:39 DoCE.scala 125:32]
  wire [15:0] _GEN_61 = io_w_channel_valid ? 16'hffff : _GEN_56; // @[DoCE.scala 122:39 DoCE.scala 126:32]
  wire  _GEN_62 = io_w_channel_valid ? out_io_din_ready : _GEN_57; // @[DoCE.scala 122:39 DoCE.scala 127:30]
  wire  _GEN_63 = mid_last | _GEN_58; // @[DoCE.scala 117:23 DoCE.scala 118:28]
  wire [127:0] _GEN_64 = mid_last ? {{80'd0}, mid_w[143:96]} : _GEN_59; // @[DoCE.scala 117:23 DoCE.scala 119:32]
  wire  _GEN_65 = mid_last | _GEN_60; // @[DoCE.scala 117:23 DoCE.scala 120:32]
  wire [15:0] _GEN_66 = mid_last ? 16'h3f : _GEN_61; // @[DoCE.scala 117:23 DoCE.scala 121:32]
  wire  _GEN_67 = mid_last ? _GEN_57 : _GEN_62; // @[DoCE.scala 117:23]
  wire  _GEN_68 = left == 32'h30 ? _GEN_63 : _GEN_53; // @[DoCE.scala 93:23]
  wire [127:0] _GEN_69 = left == 32'h30 ? _GEN_64 : _GEN_54; // @[DoCE.scala 93:23]
  wire  _GEN_70 = left == 32'h30 ? _GEN_65 : _GEN_55; // @[DoCE.scala 93:23]
  wire [15:0] _GEN_71 = left == 32'h30 ? _GEN_66 : _GEN_56; // @[DoCE.scala 93:23]
  wire  _GEN_72 = left == 32'h30 ? _GEN_67 : _GEN_57; // @[DoCE.scala 93:23]
  wire [63:0] out_io_din_bits_dout_hi_3 = io_w_channel_bits_w[63:0]; // @[DoCE.scala 124:58]
  wire [127:0] _out_io_din_bits_dout_T_8 = {out_io_din_bits_dout_hi_3,mid_w[143:80]}; // @[Cat.scala 30:58]
  wire  _GEN_73 = io_w_channel_valid | _GEN_68; // @[DoCE.scala 122:39 DoCE.scala 123:28]
  wire [127:0] _GEN_74 = io_w_channel_valid ? _out_io_din_bits_dout_T_8 : _GEN_69; // @[DoCE.scala 122:39 DoCE.scala 124:32]
  wire  _GEN_75 = io_w_channel_valid ? 1'h0 : _GEN_70; // @[DoCE.scala 122:39 DoCE.scala 125:32]
  wire [15:0] _GEN_76 = io_w_channel_valid ? 16'hffff : _GEN_71; // @[DoCE.scala 122:39 DoCE.scala 126:32]
  wire  _GEN_77 = io_w_channel_valid ? out_io_din_ready : _GEN_72; // @[DoCE.scala 122:39 DoCE.scala 127:30]
  wire  _GEN_78 = mid_last | _GEN_73; // @[DoCE.scala 117:23 DoCE.scala 118:28]
  wire [127:0] _GEN_79 = mid_last ? {{64'd0}, mid_w[143:80]} : _GEN_74; // @[DoCE.scala 117:23 DoCE.scala 119:32]
  wire  _GEN_80 = mid_last | _GEN_75; // @[DoCE.scala 117:23 DoCE.scala 120:32]
  wire [15:0] _GEN_81 = mid_last ? 16'hff : _GEN_76; // @[DoCE.scala 117:23 DoCE.scala 121:32]
  wire  _GEN_82 = mid_last ? _GEN_72 : _GEN_77; // @[DoCE.scala 117:23]
  wire  _GEN_83 = left == 32'h40 ? _GEN_78 : _GEN_68; // @[DoCE.scala 93:23]
  wire [127:0] _GEN_84 = left == 32'h40 ? _GEN_79 : _GEN_69; // @[DoCE.scala 93:23]
  wire  _GEN_85 = left == 32'h40 ? _GEN_80 : _GEN_70; // @[DoCE.scala 93:23]
  wire [15:0] _GEN_86 = left == 32'h40 ? _GEN_81 : _GEN_71; // @[DoCE.scala 93:23]
  wire  _GEN_87 = left == 32'h40 ? _GEN_82 : _GEN_72; // @[DoCE.scala 93:23]
  wire [47:0] out_io_din_bits_dout_hi_4 = io_w_channel_bits_w[47:0]; // @[DoCE.scala 124:58]
  wire [127:0] _out_io_din_bits_dout_T_10 = {out_io_din_bits_dout_hi_4,mid_w[143:64]}; // @[Cat.scala 30:58]
  wire  _GEN_88 = io_w_channel_valid | _GEN_83; // @[DoCE.scala 122:39 DoCE.scala 123:28]
  wire [127:0] _GEN_89 = io_w_channel_valid ? _out_io_din_bits_dout_T_10 : _GEN_84; // @[DoCE.scala 122:39 DoCE.scala 124:32]
  wire  _GEN_90 = io_w_channel_valid ? 1'h0 : _GEN_85; // @[DoCE.scala 122:39 DoCE.scala 125:32]
  wire [15:0] _GEN_91 = io_w_channel_valid ? 16'hffff : _GEN_86; // @[DoCE.scala 122:39 DoCE.scala 126:32]
  wire  _GEN_92 = io_w_channel_valid ? out_io_din_ready : _GEN_87; // @[DoCE.scala 122:39 DoCE.scala 127:30]
  wire  _GEN_93 = mid_last | _GEN_88; // @[DoCE.scala 117:23 DoCE.scala 118:28]
  wire [127:0] _GEN_94 = mid_last ? {{48'd0}, mid_w[143:64]} : _GEN_89; // @[DoCE.scala 117:23 DoCE.scala 119:32]
  wire  _GEN_95 = mid_last | _GEN_90; // @[DoCE.scala 117:23 DoCE.scala 120:32]
  wire [15:0] _GEN_96 = mid_last ? 16'h3ff : _GEN_91; // @[DoCE.scala 117:23 DoCE.scala 121:32]
  wire  _GEN_97 = mid_last ? _GEN_87 : _GEN_92; // @[DoCE.scala 117:23]
  wire  _GEN_98 = left == 32'h50 ? _GEN_93 : _GEN_83; // @[DoCE.scala 93:23]
  wire [127:0] _GEN_99 = left == 32'h50 ? _GEN_94 : _GEN_84; // @[DoCE.scala 93:23]
  wire  _GEN_100 = left == 32'h50 ? _GEN_95 : _GEN_85; // @[DoCE.scala 93:23]
  wire [15:0] _GEN_101 = left == 32'h50 ? _GEN_96 : _GEN_86; // @[DoCE.scala 93:23]
  wire  _GEN_102 = left == 32'h50 ? _GEN_97 : _GEN_87; // @[DoCE.scala 93:23]
  wire [31:0] out_io_din_bits_dout_hi_5 = io_w_channel_bits_w[31:0]; // @[DoCE.scala 124:58]
  wire [127:0] _out_io_din_bits_dout_T_12 = {out_io_din_bits_dout_hi_5,mid_w[143:48]}; // @[Cat.scala 30:58]
  wire  _GEN_103 = io_w_channel_valid | _GEN_98; // @[DoCE.scala 122:39 DoCE.scala 123:28]
  wire [127:0] _GEN_104 = io_w_channel_valid ? _out_io_din_bits_dout_T_12 : _GEN_99; // @[DoCE.scala 122:39 DoCE.scala 124:32]
  wire  _GEN_105 = io_w_channel_valid ? 1'h0 : _GEN_100; // @[DoCE.scala 122:39 DoCE.scala 125:32]
  wire [15:0] _GEN_106 = io_w_channel_valid ? 16'hffff : _GEN_101; // @[DoCE.scala 122:39 DoCE.scala 126:32]
  wire  _GEN_107 = io_w_channel_valid ? out_io_din_ready : _GEN_102; // @[DoCE.scala 122:39 DoCE.scala 127:30]
  wire  _GEN_108 = mid_last | _GEN_103; // @[DoCE.scala 117:23 DoCE.scala 118:28]
  wire [127:0] _GEN_109 = mid_last ? {{32'd0}, mid_w[143:48]} : _GEN_104; // @[DoCE.scala 117:23 DoCE.scala 119:32]
  wire  _GEN_110 = mid_last | _GEN_105; // @[DoCE.scala 117:23 DoCE.scala 120:32]
  wire [15:0] _GEN_111 = mid_last ? 16'hfff : _GEN_106; // @[DoCE.scala 117:23 DoCE.scala 121:32]
  wire  _GEN_112 = mid_last ? _GEN_102 : _GEN_107; // @[DoCE.scala 117:23]
  wire  _GEN_113 = left == 32'h60 ? _GEN_108 : _GEN_98; // @[DoCE.scala 93:23]
  wire [127:0] _GEN_114 = left == 32'h60 ? _GEN_109 : _GEN_99; // @[DoCE.scala 93:23]
  wire  _GEN_115 = left == 32'h60 ? _GEN_110 : _GEN_100; // @[DoCE.scala 93:23]
  wire [15:0] _GEN_116 = left == 32'h60 ? _GEN_111 : _GEN_101; // @[DoCE.scala 93:23]
  wire  _GEN_117 = left == 32'h60 ? _GEN_112 : _GEN_102; // @[DoCE.scala 93:23]
  wire [15:0] out_io_din_bits_dout_hi_6 = io_w_channel_bits_w[15:0]; // @[DoCE.scala 124:58]
  wire [127:0] _out_io_din_bits_dout_T_14 = {out_io_din_bits_dout_hi_6,mid_w[143:32]}; // @[Cat.scala 30:58]
  wire  _GEN_118 = io_w_channel_valid | _GEN_113; // @[DoCE.scala 122:39 DoCE.scala 123:28]
  wire [127:0] _GEN_119 = io_w_channel_valid ? _out_io_din_bits_dout_T_14 : _GEN_114; // @[DoCE.scala 122:39 DoCE.scala 124:32]
  wire  _GEN_120 = io_w_channel_valid ? 1'h0 : _GEN_115; // @[DoCE.scala 122:39 DoCE.scala 125:32]
  wire [15:0] _GEN_121 = io_w_channel_valid ? 16'hffff : _GEN_116; // @[DoCE.scala 122:39 DoCE.scala 126:32]
  wire  _GEN_122 = io_w_channel_valid ? out_io_din_ready : _GEN_117; // @[DoCE.scala 122:39 DoCE.scala 127:30]
  wire  _GEN_123 = mid_last | _GEN_118; // @[DoCE.scala 117:23 DoCE.scala 118:28]
  wire [127:0] _GEN_124 = mid_last ? {{16'd0}, mid_w[143:32]} : _GEN_119; // @[DoCE.scala 117:23 DoCE.scala 119:32]
  wire  _GEN_125 = mid_last | _GEN_120; // @[DoCE.scala 117:23 DoCE.scala 120:32]
  wire [15:0] _GEN_126 = mid_last ? 16'h3fff : _GEN_121; // @[DoCE.scala 117:23 DoCE.scala 121:32]
  wire  _GEN_127 = mid_last ? _GEN_117 : _GEN_122; // @[DoCE.scala 117:23]
  wire  _GEN_128 = left == 32'h70 ? _GEN_123 : _GEN_113; // @[DoCE.scala 93:23]
  wire [127:0] _GEN_129 = left == 32'h70 ? _GEN_124 : _GEN_114; // @[DoCE.scala 93:23]
  wire  _GEN_130 = left == 32'h70 ? _GEN_125 : _GEN_115; // @[DoCE.scala 93:23]
  wire [15:0] _GEN_131 = left == 32'h70 ? _GEN_126 : _GEN_116; // @[DoCE.scala 93:23]
  wire [127:0] _GEN_134 = left == 32'h80 ? mid_w[143:16] : _GEN_129; // @[DoCE.scala 93:23 DoCE.scala 131:30]
  wire  _GEN_135 = left == 32'h80 ? 1'h0 : _GEN_130; // @[DoCE.scala 93:23 DoCE.scala 132:30]
  wire [15:0] _GEN_136 = left == 32'h80 ? 16'hffff : _GEN_131; // @[DoCE.scala 93:23 DoCE.scala 133:30]
  dout_channel_reg_slice out ( // @[DoCE.scala 51:19]
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
  assign io_aw_channel_ready = left == 32'h0 & _GEN_18; // @[DoCE.scala 93:23 DoCE.scala 88:23]
  assign io_w_channel_ready = left == 32'h70 ? _GEN_127 : _GEN_117; // @[DoCE.scala 93:23]
  assign io_dout_channel_valid = out_io_dout_valid; // @[DoCE.scala 81:19]
  assign io_dout_channel_bits_dout = out_io_dout_bits_dout; // @[DoCE.scala 81:19]
  assign io_dout_channel_bits_keep = out_io_dout_bits_keep; // @[DoCE.scala 81:19]
  assign io_dout_channel_bits_last = out_io_dout_bits_last; // @[DoCE.scala 81:19]
  assign io_dout_channel_bits_connection_id = out_io_dout_bits_connection_id; // @[DoCE.scala 81:19]
  assign io_dout_channel_bits_byte_num = out_io_dout_bits_byte_num; // @[DoCE.scala 81:19]
  assign out_clock = clock;
  assign out_reset = reset;
  assign out_io_dout_ready = io_dout_channel_ready; // @[DoCE.scala 81:19]
  assign out_io_din_valid = left == 32'h90 | (left == 32'h80 | _GEN_128); // @[DoCE.scala 93:23 DoCE.scala 130:26]
  assign out_io_din_bits_dout = left == 32'h90 ? mid_w[127:0] : _GEN_134; // @[DoCE.scala 93:23 DoCE.scala 131:30]
  assign out_io_din_bits_keep = left == 32'h90 ? 16'hffff : _GEN_136; // @[DoCE.scala 93:23 DoCE.scala 133:30]
  assign out_io_din_bits_last = left == 32'h90 ? 1'h0 : _GEN_135; // @[DoCE.scala 93:23 DoCE.scala 132:30]
  assign out_io_din_bits_connection_id = left == 32'h0 ? _GEN_16 : out_io_dout_bits_connection_id; // @[DoCE.scala 93:23 DoCE.scala 86:33]
  assign out_io_din_bits_byte_num = left == 32'h0 ? _GEN_17 : out_io_dout_bits_byte_num; // @[DoCE.scala 93:23 DoCE.scala 87:28]
  always @(posedge clock) begin
    if (reset) begin // @[DoCE.scala 49:25]
      bit_sent <= 32'h0; // @[DoCE.scala 49:25]
    end else if (out_io_din_valid & out_io_din_ready) begin // @[DoCE.scala 63:45]
      if (out_io_din_bits_last) begin // @[DoCE.scala 64:31]
        bit_sent <= 32'h0; // @[DoCE.scala 65:16]
      end else begin
        bit_sent <= _bit_sent_T_1; // @[DoCE.scala 67:16]
      end
    end
    if (reset) begin // @[DoCE.scala 50:25]
      bit_recv <= 32'h0; // @[DoCE.scala 50:25]
    end else if (_T) begin // @[DoCE.scala 71:49]
      if (io_aw_channel_ready & io_aw_channel_valid) begin // @[DoCE.scala 72:53]
        bit_recv <= _bit_recv_T_3; // @[DoCE.scala 73:16]
      end else begin
        bit_recv <= _bit_recv_T_1; // @[DoCE.scala 75:16]
      end
    end else if (_T_1 & out_io_din_bits_last) begin // @[DoCE.scala 77:75]
      bit_recv <= 32'h0; // @[DoCE.scala 78:14]
    end
    if (reset) begin // @[DoCE.scala 53:20]
      mid_w <= 144'h0; // @[DoCE.scala 53:20]
    end else if (io_w_channel_ready & io_w_channel_valid) begin // @[DoCE.scala 58:49]
      mid_w <= io_w_channel_bits_w; // @[DoCE.scala 59:11]
    end
    if (reset) begin // @[DoCE.scala 53:20]
      mid_last <= 1'h0; // @[DoCE.scala 53:20]
    end else if (io_w_channel_ready & io_w_channel_valid) begin // @[DoCE.scala 58:49]
      mid_last <= io_w_channel_bits_last; // @[DoCE.scala 60:14]
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
  _RAND_2 = {5{`RANDOM}};
  mid_w = _RAND_2[143:0];
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
