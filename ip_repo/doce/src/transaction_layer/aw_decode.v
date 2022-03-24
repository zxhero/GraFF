module aw_channel_out_reg_slice(
  input         clock,
  input         reset,
  input         io_dout_ready,
  output        io_dout_valid,
  output [79:0] io_dout_bits_aw,
  output        io_din_ready,
  input         io_din_valid,
  input  [79:0] io_din_bits_aw
);
`ifdef RANDOMIZE_REG_INIT
  reg [95:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  reg [79:0] data_aw; // @[DoCE.scala 13:21]
  reg  valid; // @[DoCE.scala 14:22]
  wire  _T = ~io_dout_valid; // @[DoCE.scala 15:24]
  assign io_dout_valid = valid; // @[DoCE.scala 21:17]
  assign io_dout_bits_aw = data_aw; // @[DoCE.scala 22:16]
  assign io_din_ready = io_dout_ready | _T; // @[DoCE.scala 20:33]
  always @(posedge clock) begin
    if (reset) begin // @[DoCE.scala 13:21]
      data_aw <= 80'h0; // @[DoCE.scala 13:21]
    end else if (io_dout_ready | ~io_dout_valid) begin // @[DoCE.scala 15:39]
      data_aw <= io_din_bits_aw; // @[DoCE.scala 16:10]
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
  _RAND_0 = {3{`RANDOM}};
  data_aw = _RAND_0[79:0];
  _RAND_1 = {1{`RANDOM}};
  valid = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module w_channel_out_reg_slice(
  input          clock,
  input          reset,
  input          io_dout_ready,
  output         io_dout_valid,
  output [143:0] io_dout_bits_w,
  output         io_dout_bits_last,
  output         io_din_ready,
  input          io_din_valid,
  input  [143:0] io_din_bits_w,
  input          io_din_bits_last
);
`ifdef RANDOMIZE_REG_INIT
  reg [159:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  reg [143:0] data_w; // @[DoCE.scala 13:21]
  reg  data_last; // @[DoCE.scala 13:21]
  reg  valid; // @[DoCE.scala 14:22]
  wire  _T = ~io_dout_valid; // @[DoCE.scala 15:24]
  assign io_dout_valid = valid; // @[DoCE.scala 21:17]
  assign io_dout_bits_w = data_w; // @[DoCE.scala 22:16]
  assign io_dout_bits_last = data_last; // @[DoCE.scala 22:16]
  assign io_din_ready = io_dout_ready | _T; // @[DoCE.scala 20:33]
  always @(posedge clock) begin
    if (reset) begin // @[DoCE.scala 13:21]
      data_w <= 144'h0; // @[DoCE.scala 13:21]
    end else if (io_dout_ready | ~io_dout_valid) begin // @[DoCE.scala 15:39]
      data_w <= io_din_bits_w; // @[DoCE.scala 16:10]
    end
    if (reset) begin // @[DoCE.scala 13:21]
      data_last <= 1'h0; // @[DoCE.scala 13:21]
    end else if (io_dout_ready | ~io_dout_valid) begin // @[DoCE.scala 15:39]
      data_last <= io_din_bits_last; // @[DoCE.scala 16:10]
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
  _RAND_0 = {5{`RANDOM}};
  data_w = _RAND_0[143:0];
  _RAND_1 = {1{`RANDOM}};
  data_last = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  valid = _RAND_2[0:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module aw_decode(
  input          clock,
  input          reset,
  input          io_aw_channel_ready,
  output         io_aw_channel_valid,
  output [79:0]  io_aw_channel_bits_aw,
  input          io_w_channel_ready,
  output         io_w_channel_valid,
  output [143:0] io_w_channel_bits_w,
  output         io_w_channel_bits_last,
  output         io_din_channel_ready,
  input          io_din_channel_valid,
  input  [127:0] io_din_channel_bits_din,
  input          io_din_channel_bits_last,
  input  [48:0]  io_phy_base_0,
  input  [48:0]  io_phy_base_1
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [127:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  aw_channel_out_clock; // @[DoCE.scala 159:30]
  wire  aw_channel_out_reset; // @[DoCE.scala 159:30]
  wire  aw_channel_out_io_dout_ready; // @[DoCE.scala 159:30]
  wire  aw_channel_out_io_dout_valid; // @[DoCE.scala 159:30]
  wire [79:0] aw_channel_out_io_dout_bits_aw; // @[DoCE.scala 159:30]
  wire  aw_channel_out_io_din_ready; // @[DoCE.scala 159:30]
  wire  aw_channel_out_io_din_valid; // @[DoCE.scala 159:30]
  wire [79:0] aw_channel_out_io_din_bits_aw; // @[DoCE.scala 159:30]
  wire  w_channel_out_clock; // @[DoCE.scala 162:29]
  wire  w_channel_out_reset; // @[DoCE.scala 162:29]
  wire  w_channel_out_io_dout_ready; // @[DoCE.scala 162:29]
  wire  w_channel_out_io_dout_valid; // @[DoCE.scala 162:29]
  wire [143:0] w_channel_out_io_dout_bits_w; // @[DoCE.scala 162:29]
  wire  w_channel_out_io_dout_bits_last; // @[DoCE.scala 162:29]
  wire  w_channel_out_io_din_ready; // @[DoCE.scala 162:29]
  wire  w_channel_out_io_din_valid; // @[DoCE.scala 162:29]
  wire [143:0] w_channel_out_io_din_bits_w; // @[DoCE.scala 162:29]
  wire  w_channel_out_io_din_bits_last; // @[DoCE.scala 162:29]
  reg [31:0] bit_recv; // @[DoCE.scala 157:25]
  reg [31:0] bit_sent; // @[DoCE.scala 158:25]
  reg [127:0] mid_w; // @[DoCE.scala 166:20]
  wire  _T = io_din_channel_ready & io_din_channel_valid; // @[DoCE.scala 171:29]
  wire [31:0] _bit_recv_T_1 = bit_recv + 32'h80; // @[DoCE.scala 175:28]
  wire [31:0] _bit_sent_T_1 = bit_sent + 32'h90; // @[DoCE.scala 183:28]
  wire [31:0] _bit_sent_T_3 = bit_sent + 32'h80; // @[DoCE.scala 186:26]
  wire [31:0] left = bit_recv - bit_sent; // @[DoCE.scala 202:23]
  wire  _T_6 = bit_sent == 32'h0 & io_din_channel_valid; // @[DoCE.scala 207:31]
  wire  _GEN_9 = bit_sent == 32'h0 & io_din_channel_valid ? aw_channel_out_io_din_ready : io_din_channel_valid; // @[DoCE.scala 207:55 DoCE.scala 209:32]
  wire  _GEN_11 = left == 32'h0 & _GEN_9; // @[DoCE.scala 205:23 DoCE.scala 197:24]
  wire [15:0] w_channel_out_io_din_bits_w_lo = mid_w[127:112]; // @[DoCE.scala 217:104]
  wire [143:0] _w_channel_out_io_din_bits_w_T = {io_din_channel_bits_din,w_channel_out_io_din_bits_w_lo}; // @[Cat.scala 30:58]
  wire  _GEN_12 = io_din_channel_valid ? w_channel_out_io_din_ready : _GEN_11; // @[DoCE.scala 214:35 DoCE.scala 215:32]
  wire [143:0] _GEN_13 = io_din_channel_valid ? _w_channel_out_io_din_bits_w_T : 144'h0; // @[DoCE.scala 214:35 DoCE.scala 217:39 DoCE.scala 199:31]
  wire  _GEN_14 = io_din_channel_valid & io_din_channel_bits_last; // @[DoCE.scala 214:35 DoCE.scala 218:42 DoCE.scala 200:34]
  wire  _GEN_15 = left == 32'h10 ? _GEN_12 : _GEN_11; // @[DoCE.scala 205:23]
  wire  _GEN_16 = left == 32'h10 & io_din_channel_valid; // @[DoCE.scala 205:23 DoCE.scala 198:30]
  wire [143:0] _GEN_17 = left == 32'h10 ? _GEN_13 : 144'h0; // @[DoCE.scala 205:23 DoCE.scala 199:31]
  wire  _GEN_18 = left == 32'h10 & _GEN_14; // @[DoCE.scala 205:23 DoCE.scala 200:34]
  wire [111:0] w_channel_out_io_din_bits_w_hi_1 = io_din_channel_bits_din[111:0]; // @[DoCE.scala 217:69]
  wire [31:0] w_channel_out_io_din_bits_w_lo_1 = mid_w[127:96]; // @[DoCE.scala 217:104]
  wire [143:0] _w_channel_out_io_din_bits_w_T_1 = {w_channel_out_io_din_bits_w_hi_1,w_channel_out_io_din_bits_w_lo_1}; // @[Cat.scala 30:58]
  wire  _GEN_19 = io_din_channel_valid ? w_channel_out_io_din_ready : _GEN_15; // @[DoCE.scala 214:35 DoCE.scala 215:32]
  wire  _GEN_20 = io_din_channel_valid | _GEN_16; // @[DoCE.scala 214:35 DoCE.scala 216:38]
  wire [143:0] _GEN_21 = io_din_channel_valid ? _w_channel_out_io_din_bits_w_T_1 : _GEN_17; // @[DoCE.scala 214:35 DoCE.scala 217:39]
  wire  _GEN_22 = io_din_channel_valid ? io_din_channel_bits_last : _GEN_18; // @[DoCE.scala 214:35 DoCE.scala 218:42]
  wire  _GEN_23 = left == 32'h20 ? _GEN_19 : _GEN_15; // @[DoCE.scala 205:23]
  wire  _GEN_24 = left == 32'h20 ? _GEN_20 : _GEN_16; // @[DoCE.scala 205:23]
  wire [143:0] _GEN_25 = left == 32'h20 ? _GEN_21 : _GEN_17; // @[DoCE.scala 205:23]
  wire  _GEN_26 = left == 32'h20 ? _GEN_22 : _GEN_18; // @[DoCE.scala 205:23]
  wire [95:0] w_channel_out_io_din_bits_w_hi_2 = io_din_channel_bits_din[95:0]; // @[DoCE.scala 217:69]
  wire [47:0] w_channel_out_io_din_bits_w_lo_2 = mid_w[127:80]; // @[DoCE.scala 217:104]
  wire [143:0] _w_channel_out_io_din_bits_w_T_2 = {w_channel_out_io_din_bits_w_hi_2,w_channel_out_io_din_bits_w_lo_2}; // @[Cat.scala 30:58]
  wire  _GEN_27 = io_din_channel_valid ? w_channel_out_io_din_ready : _GEN_23; // @[DoCE.scala 214:35 DoCE.scala 215:32]
  wire  _GEN_28 = io_din_channel_valid | _GEN_24; // @[DoCE.scala 214:35 DoCE.scala 216:38]
  wire [143:0] _GEN_29 = io_din_channel_valid ? _w_channel_out_io_din_bits_w_T_2 : _GEN_25; // @[DoCE.scala 214:35 DoCE.scala 217:39]
  wire  _GEN_30 = io_din_channel_valid ? io_din_channel_bits_last : _GEN_26; // @[DoCE.scala 214:35 DoCE.scala 218:42]
  wire  _GEN_31 = left == 32'h30 ? _GEN_27 : _GEN_23; // @[DoCE.scala 205:23]
  wire  _GEN_32 = left == 32'h30 ? _GEN_28 : _GEN_24; // @[DoCE.scala 205:23]
  wire [143:0] _GEN_33 = left == 32'h30 ? _GEN_29 : _GEN_25; // @[DoCE.scala 205:23]
  wire  _GEN_34 = left == 32'h30 ? _GEN_30 : _GEN_26; // @[DoCE.scala 205:23]
  wire [79:0] w_channel_out_io_din_bits_w_hi_3 = io_din_channel_bits_din[79:0]; // @[DoCE.scala 217:69]
  wire [63:0] w_channel_out_io_din_bits_w_lo_3 = mid_w[127:64]; // @[DoCE.scala 217:104]
  wire [143:0] _w_channel_out_io_din_bits_w_T_3 = {w_channel_out_io_din_bits_w_hi_3,w_channel_out_io_din_bits_w_lo_3}; // @[Cat.scala 30:58]
  wire  _GEN_35 = io_din_channel_valid ? w_channel_out_io_din_ready : _GEN_31; // @[DoCE.scala 214:35 DoCE.scala 215:32]
  wire  _GEN_36 = io_din_channel_valid | _GEN_32; // @[DoCE.scala 214:35 DoCE.scala 216:38]
  wire [143:0] _GEN_37 = io_din_channel_valid ? _w_channel_out_io_din_bits_w_T_3 : _GEN_33; // @[DoCE.scala 214:35 DoCE.scala 217:39]
  wire  _GEN_38 = io_din_channel_valid ? io_din_channel_bits_last : _GEN_34; // @[DoCE.scala 214:35 DoCE.scala 218:42]
  wire  _GEN_39 = left == 32'h40 ? _GEN_35 : _GEN_31; // @[DoCE.scala 205:23]
  wire  _GEN_40 = left == 32'h40 ? _GEN_36 : _GEN_32; // @[DoCE.scala 205:23]
  wire [143:0] _GEN_41 = left == 32'h40 ? _GEN_37 : _GEN_33; // @[DoCE.scala 205:23]
  wire  _GEN_42 = left == 32'h40 ? _GEN_38 : _GEN_34; // @[DoCE.scala 205:23]
  wire [63:0] w_channel_out_io_din_bits_w_hi_4 = io_din_channel_bits_din[63:0]; // @[DoCE.scala 217:69]
  wire [79:0] w_channel_out_io_din_bits_w_lo_4 = mid_w[127:48]; // @[DoCE.scala 217:104]
  wire [143:0] _w_channel_out_io_din_bits_w_T_4 = {w_channel_out_io_din_bits_w_hi_4,w_channel_out_io_din_bits_w_lo_4}; // @[Cat.scala 30:58]
  wire  _GEN_43 = io_din_channel_valid ? w_channel_out_io_din_ready : _GEN_39; // @[DoCE.scala 214:35 DoCE.scala 215:32]
  wire  _GEN_44 = io_din_channel_valid | _GEN_40; // @[DoCE.scala 214:35 DoCE.scala 216:38]
  wire [143:0] _GEN_45 = io_din_channel_valid ? _w_channel_out_io_din_bits_w_T_4 : _GEN_41; // @[DoCE.scala 214:35 DoCE.scala 217:39]
  wire  _GEN_46 = io_din_channel_valid ? io_din_channel_bits_last : _GEN_42; // @[DoCE.scala 214:35 DoCE.scala 218:42]
  wire  _GEN_47 = left == 32'h50 ? _GEN_43 : _GEN_39; // @[DoCE.scala 205:23]
  wire  _GEN_48 = left == 32'h50 ? _GEN_44 : _GEN_40; // @[DoCE.scala 205:23]
  wire [143:0] _GEN_49 = left == 32'h50 ? _GEN_45 : _GEN_41; // @[DoCE.scala 205:23]
  wire  _GEN_50 = left == 32'h50 ? _GEN_46 : _GEN_42; // @[DoCE.scala 205:23]
  wire [47:0] w_channel_out_io_din_bits_w_hi_5 = io_din_channel_bits_din[47:0]; // @[DoCE.scala 217:69]
  wire [95:0] w_channel_out_io_din_bits_w_lo_5 = mid_w[127:32]; // @[DoCE.scala 217:104]
  wire [143:0] _w_channel_out_io_din_bits_w_T_5 = {w_channel_out_io_din_bits_w_hi_5,w_channel_out_io_din_bits_w_lo_5}; // @[Cat.scala 30:58]
  wire  _GEN_51 = io_din_channel_valid ? w_channel_out_io_din_ready : _GEN_47; // @[DoCE.scala 214:35 DoCE.scala 215:32]
  wire  _GEN_52 = io_din_channel_valid | _GEN_48; // @[DoCE.scala 214:35 DoCE.scala 216:38]
  wire [143:0] _GEN_53 = io_din_channel_valid ? _w_channel_out_io_din_bits_w_T_5 : _GEN_49; // @[DoCE.scala 214:35 DoCE.scala 217:39]
  wire  _GEN_54 = io_din_channel_valid ? io_din_channel_bits_last : _GEN_50; // @[DoCE.scala 214:35 DoCE.scala 218:42]
  wire  _GEN_55 = left == 32'h60 ? _GEN_51 : _GEN_47; // @[DoCE.scala 205:23]
  wire  _GEN_56 = left == 32'h60 ? _GEN_52 : _GEN_48; // @[DoCE.scala 205:23]
  wire [143:0] _GEN_57 = left == 32'h60 ? _GEN_53 : _GEN_49; // @[DoCE.scala 205:23]
  wire  _GEN_58 = left == 32'h60 ? _GEN_54 : _GEN_50; // @[DoCE.scala 205:23]
  wire [31:0] w_channel_out_io_din_bits_w_hi_6 = io_din_channel_bits_din[31:0]; // @[DoCE.scala 217:69]
  wire [111:0] w_channel_out_io_din_bits_w_lo_6 = mid_w[127:16]; // @[DoCE.scala 217:104]
  wire [143:0] _w_channel_out_io_din_bits_w_T_6 = {w_channel_out_io_din_bits_w_hi_6,w_channel_out_io_din_bits_w_lo_6}; // @[Cat.scala 30:58]
  wire  _GEN_59 = io_din_channel_valid ? w_channel_out_io_din_ready : _GEN_55; // @[DoCE.scala 214:35 DoCE.scala 215:32]
  wire  _GEN_60 = io_din_channel_valid | _GEN_56; // @[DoCE.scala 214:35 DoCE.scala 216:38]
  wire [143:0] _GEN_61 = io_din_channel_valid ? _w_channel_out_io_din_bits_w_T_6 : _GEN_57; // @[DoCE.scala 214:35 DoCE.scala 217:39]
  wire  _GEN_62 = io_din_channel_valid ? io_din_channel_bits_last : _GEN_58; // @[DoCE.scala 214:35 DoCE.scala 218:42]
  wire  _GEN_63 = left == 32'h70 ? _GEN_59 : _GEN_55; // @[DoCE.scala 205:23]
  wire  _GEN_64 = left == 32'h70 ? _GEN_60 : _GEN_56; // @[DoCE.scala 205:23]
  wire [143:0] _GEN_65 = left == 32'h70 ? _GEN_61 : _GEN_57; // @[DoCE.scala 205:23]
  wire  _GEN_66 = left == 32'h70 ? _GEN_62 : _GEN_58; // @[DoCE.scala 205:23]
  wire [15:0] w_channel_out_io_din_bits_w_hi_7 = io_din_channel_bits_din[15:0]; // @[DoCE.scala 217:69]
  wire [143:0] _w_channel_out_io_din_bits_w_T_7 = {w_channel_out_io_din_bits_w_hi_7,mid_w}; // @[Cat.scala 30:58]
  wire  _GEN_67 = io_din_channel_valid ? w_channel_out_io_din_ready : _GEN_63; // @[DoCE.scala 214:35 DoCE.scala 215:32]
  wire  _GEN_68 = io_din_channel_valid | _GEN_64; // @[DoCE.scala 214:35 DoCE.scala 216:38]
  wire [143:0] _GEN_69 = io_din_channel_valid ? _w_channel_out_io_din_bits_w_T_7 : _GEN_65; // @[DoCE.scala 214:35 DoCE.scala 217:39]
  wire  _GEN_70 = io_din_channel_valid ? io_din_channel_bits_last : _GEN_66; // @[DoCE.scala 214:35 DoCE.scala 218:42]
  wire [75:0] aw_channel_out_io_din_bits_aw_hi = io_din_channel_bits_din[83:8]; // @[DoCE.scala 224:63]
  wire [3:0] aw_channel_out_io_din_bits_aw_lo = io_din_channel_bits_din[3:0]; // @[DoCE.scala 224:95]
  wire [79:0] _aw_channel_out_io_din_bits_aw_T = {aw_channel_out_io_din_bits_aw_hi,aw_channel_out_io_din_bits_aw_lo}; // @[Cat.scala 30:58]
  wire [43:0] aw_channel_out_io_din_bits_aw_hi_2 = io_phy_base_0[43:0]; // @[DoCE.scala 227:24]
  wire [47:0] _aw_channel_out_io_din_bits_aw_T_2 = {aw_channel_out_io_din_bits_aw_hi_2,4'h0}; // @[Cat.scala 30:58]
  wire [79:0] _aw_channel_out_io_din_bits_aw_WIRE = {{32'd0}, _aw_channel_out_io_din_bits_aw_T_2}; // @[DoCE.scala 227:51 DoCE.scala 227:51]
  wire [79:0] _aw_channel_out_io_din_bits_aw_T_3 = _aw_channel_out_io_din_bits_aw_T |
    _aw_channel_out_io_din_bits_aw_WIRE; // @[DoCE.scala 226:105]
  wire [43:0] aw_channel_out_io_din_bits_aw_hi_4 = io_phy_base_1[43:0]; // @[DoCE.scala 230:24]
  wire [47:0] _aw_channel_out_io_din_bits_aw_T_5 = {aw_channel_out_io_din_bits_aw_hi_4,4'h0}; // @[Cat.scala 30:58]
  wire [79:0] _aw_channel_out_io_din_bits_aw_WIRE_1 = {{32'd0}, _aw_channel_out_io_din_bits_aw_T_5}; // @[DoCE.scala 230:51 DoCE.scala 230:51]
  wire [79:0] _aw_channel_out_io_din_bits_aw_T_6 = _aw_channel_out_io_din_bits_aw_T |
    _aw_channel_out_io_din_bits_aw_WIRE_1; // @[DoCE.scala 229:105]
  wire [79:0] _GEN_75 = io_din_channel_bits_din[7:4] == io_phy_base_1[47:44] & io_phy_base_1[48] ?
    _aw_channel_out_io_din_bits_aw_T_6 : _aw_channel_out_io_din_bits_aw_T; // @[DoCE.scala 228:91 DoCE.scala 229:35 DoCE.scala 224:33]
  aw_channel_out_reg_slice aw_channel_out ( // @[DoCE.scala 159:30]
    .clock(aw_channel_out_clock),
    .reset(aw_channel_out_reset),
    .io_dout_ready(aw_channel_out_io_dout_ready),
    .io_dout_valid(aw_channel_out_io_dout_valid),
    .io_dout_bits_aw(aw_channel_out_io_dout_bits_aw),
    .io_din_ready(aw_channel_out_io_din_ready),
    .io_din_valid(aw_channel_out_io_din_valid),
    .io_din_bits_aw(aw_channel_out_io_din_bits_aw)
  );
  w_channel_out_reg_slice w_channel_out ( // @[DoCE.scala 162:29]
    .clock(w_channel_out_clock),
    .reset(w_channel_out_reset),
    .io_dout_ready(w_channel_out_io_dout_ready),
    .io_dout_valid(w_channel_out_io_dout_valid),
    .io_dout_bits_w(w_channel_out_io_dout_bits_w),
    .io_dout_bits_last(w_channel_out_io_dout_bits_last),
    .io_din_ready(w_channel_out_io_din_ready),
    .io_din_valid(w_channel_out_io_din_valid),
    .io_din_bits_w(w_channel_out_io_din_bits_w),
    .io_din_bits_last(w_channel_out_io_din_bits_last)
  );
  assign io_aw_channel_valid = aw_channel_out_io_dout_valid; // @[DoCE.scala 194:17]
  assign io_aw_channel_bits_aw = aw_channel_out_io_dout_bits_aw; // @[DoCE.scala 194:17]
  assign io_w_channel_valid = w_channel_out_io_dout_valid; // @[DoCE.scala 195:16]
  assign io_w_channel_bits_w = w_channel_out_io_dout_bits_w; // @[DoCE.scala 195:16]
  assign io_w_channel_bits_last = w_channel_out_io_dout_bits_last; // @[DoCE.scala 195:16]
  assign io_din_channel_ready = left == 32'h80 ? _GEN_67 : _GEN_63; // @[DoCE.scala 205:23]
  assign aw_channel_out_clock = clock;
  assign aw_channel_out_reset = reset;
  assign aw_channel_out_io_dout_ready = io_aw_channel_ready; // @[DoCE.scala 194:17]
  assign aw_channel_out_io_din_valid = left == 32'h0 & _T_6; // @[DoCE.scala 205:23 DoCE.scala 201:31]
  assign aw_channel_out_io_din_bits_aw = io_din_channel_bits_din[7:4] == io_phy_base_0[47:44] & io_phy_base_0[48] ?
    _aw_channel_out_io_din_bits_aw_T_3 : _GEN_75; // @[DoCE.scala 225:85 DoCE.scala 226:35]
  assign w_channel_out_clock = clock;
  assign w_channel_out_reset = reset;
  assign w_channel_out_io_dout_ready = io_w_channel_ready; // @[DoCE.scala 195:16]
  assign w_channel_out_io_din_valid = left == 32'h80 ? _GEN_68 : _GEN_64; // @[DoCE.scala 205:23]
  assign w_channel_out_io_din_bits_w = left == 32'h80 ? _GEN_69 : _GEN_65; // @[DoCE.scala 205:23]
  assign w_channel_out_io_din_bits_last = left == 32'h80 ? _GEN_70 : _GEN_66; // @[DoCE.scala 205:23]
  always @(posedge clock) begin
    if (reset) begin // @[DoCE.scala 157:25]
      bit_recv <= 32'h0; // @[DoCE.scala 157:25]
    end else if (io_din_channel_ready & io_din_channel_valid) begin // @[DoCE.scala 171:53]
      if (io_din_channel_bits_last) begin // @[DoCE.scala 172:35]
        bit_recv <= 32'h0; // @[DoCE.scala 173:16]
      end else begin
        bit_recv <= _bit_recv_T_1; // @[DoCE.scala 175:16]
      end
    end
    if (reset) begin // @[DoCE.scala 158:25]
      bit_sent <= 32'h0; // @[DoCE.scala 158:25]
    end else if (w_channel_out_io_din_valid & w_channel_out_io_din_ready) begin // @[DoCE.scala 179:65]
      if (w_channel_out_io_din_bits_last) begin // @[DoCE.scala 180:41]
        bit_sent <= 32'h0; // @[DoCE.scala 181:16]
      end else begin
        bit_sent <= _bit_sent_T_1; // @[DoCE.scala 183:16]
      end
    end else if (aw_channel_out_io_din_valid & aw_channel_out_io_din_ready) begin // @[DoCE.scala 185:73]
      bit_sent <= _bit_sent_T_3; // @[DoCE.scala 186:14]
    end
    if (reset) begin // @[DoCE.scala 166:20]
      mid_w <= 128'h0; // @[DoCE.scala 166:20]
    end else if (_T) begin // @[DoCE.scala 189:53]
      mid_w <= io_din_channel_bits_din; // @[DoCE.scala 190:11]
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
  bit_recv = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  bit_sent = _RAND_1[31:0];
  _RAND_2 = {4{`RANDOM}};
  mid_w = _RAND_2[127:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
