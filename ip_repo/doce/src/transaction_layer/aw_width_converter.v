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
  input          io_dout_channel_ready,
  output         io_dout_channel_valid,
  output [511:0] io_dout_channel_bits_dout,
  output [63:0]  io_dout_channel_bits_keep,
  output         io_dout_channel_bits_last,
  output [3:0]   io_dout_channel_bits_connection_id,
  output [12:0]  io_dout_channel_bits_byte_num
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [575:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  wire  out_aclk; // @[DoCE.scala 32:19]
  wire  out_aresetn; // @[DoCE.scala 32:19]
  wire [535:0] out_s_axis_tdata; // @[DoCE.scala 32:19]
  wire [66:0] out_s_axis_tkeep; // @[DoCE.scala 32:19]
  wire  out_s_axis_tlast; // @[DoCE.scala 32:19]
  wire  out_s_axis_tvalid; // @[DoCE.scala 32:19]
  wire  out_s_axis_tready; // @[DoCE.scala 32:19]
  wire [535:0] out_m_axis_tdata; // @[DoCE.scala 32:19]
  wire [66:0] out_m_axis_tkeep; // @[DoCE.scala 32:19]
  wire  out_m_axis_tlast; // @[DoCE.scala 32:19]
  wire  out_m_axis_tvalid; // @[DoCE.scala 32:19]
  wire  out_m_axis_tready; // @[DoCE.scala 32:19]
  wire  aw_in_aclk; // @[DoCE.scala 35:21]
  wire  aw_in_aresetn; // @[DoCE.scala 35:21]
  wire [87:0] aw_in_s_axis_tdata; // @[DoCE.scala 35:21]
  wire [10:0] aw_in_s_axis_tkeep; // @[DoCE.scala 35:21]
  wire  aw_in_s_axis_tlast; // @[DoCE.scala 35:21]
  wire  aw_in_s_axis_tvalid; // @[DoCE.scala 35:21]
  wire  aw_in_s_axis_tready; // @[DoCE.scala 35:21]
  wire [87:0] aw_in_m_axis_tdata; // @[DoCE.scala 35:21]
  wire [10:0] aw_in_m_axis_tkeep; // @[DoCE.scala 35:21]
  wire  aw_in_m_axis_tlast; // @[DoCE.scala 35:21]
  wire  aw_in_m_axis_tvalid; // @[DoCE.scala 35:21]
  wire  aw_in_m_axis_tready; // @[DoCE.scala 35:21]
  wire  w_in_aclk; // @[DoCE.scala 41:20]
  wire  w_in_aresetn; // @[DoCE.scala 41:20]
  wire [575:0] w_in_s_axis_tdata; // @[DoCE.scala 41:20]
  wire [71:0] w_in_s_axis_tkeep; // @[DoCE.scala 41:20]
  wire  w_in_s_axis_tlast; // @[DoCE.scala 41:20]
  wire  w_in_s_axis_tvalid; // @[DoCE.scala 41:20]
  wire  w_in_s_axis_tready; // @[DoCE.scala 41:20]
  wire [575:0] w_in_m_axis_tdata; // @[DoCE.scala 41:20]
  wire [71:0] w_in_m_axis_tkeep; // @[DoCE.scala 41:20]
  wire  w_in_m_axis_tlast; // @[DoCE.scala 41:20]
  wire  w_in_m_axis_tvalid; // @[DoCE.scala 41:20]
  wire  w_in_m_axis_tready; // @[DoCE.scala 41:20]
  reg [15:0] bit_sent; // @[DoCE.scala 31:25]
  reg [575:0] mid_w; // @[DoCE.scala 49:20]
  reg  mid_last; // @[DoCE.scala 49:20]
  reg [15:0] mid_count; // @[DoCE.scala 53:26]
  wire  _T = w_in_m_axis_tready & w_in_m_axis_tvalid; // @[DoCE.scala 54:31]
  wire [15:0] _mid_count_T_1 = mid_count + 16'h40; // @[DoCE.scala 58:30]
  wire  _T_4 = out_s_axis_tvalid & out_s_axis_tready; // @[DoCE.scala 60:36]
  wire  _T_6 = out_s_axis_tlast; // @[DoCE.scala 61:36]
  wire [15:0] _mid_count_T_3 = mid_count - 16'h200; // @[DoCE.scala 64:30]
  wire [15:0] _bit_sent_T_1 = bit_sent + 16'h200; // @[DoCE.scala 77:28]
  wire  _T_16 = w_in_m_axis_tvalid; // @[DoCE.scala 115:97]
  wire [3:0] _GEN_17 = bit_sent == 16'h0 & aw_in_m_axis_tvalid & w_in_m_axis_tvalid ? aw_in_m_axis_tdata[3:0] : 4'h0; // @[DoCE.scala 115:100 DoCE.scala 125:33 DoCE.scala 107:25]
  wire [3:0] out_tmp_connection_id = mid_count == 16'h0 ? _GEN_17 : 4'h0; // @[DoCE.scala 113:28 DoCE.scala 107:25]
  wire [6:0] _GEN_18 = bit_sent == 16'h0 & aw_in_m_axis_tvalid & w_in_m_axis_tvalid ? 7'h58 : 7'h0; // @[DoCE.scala 115:100 DoCE.scala 126:28 DoCE.scala 108:20]
  wire [6:0] _GEN_26 = mid_count == 16'h0 ? _GEN_18 : 7'h0; // @[DoCE.scala 113:28 DoCE.scala 108:20]
  wire [12:0] out_tmp_byte_num = {{6'd0}, _GEN_26}; // @[DoCE.scala 99:21]
  wire [63:0] out_tmp_dout_hi_7 = w_in_m_axis_tdata[63:0]; // @[DoCE.scala 144:51]
  wire [511:0] _out_tmp_dout_T_16 = {out_tmp_dout_hi_7,mid_w[575:128]}; // @[Cat.scala 30:58]
  wire [127:0] out_tmp_dout_hi_6 = w_in_m_axis_tdata[127:0]; // @[DoCE.scala 144:51]
  wire [511:0] _out_tmp_dout_T_14 = {out_tmp_dout_hi_6,mid_w[575:192]}; // @[Cat.scala 30:58]
  wire [191:0] out_tmp_dout_hi_5 = w_in_m_axis_tdata[191:0]; // @[DoCE.scala 144:51]
  wire [511:0] _out_tmp_dout_T_12 = {out_tmp_dout_hi_5,mid_w[575:256]}; // @[Cat.scala 30:58]
  wire [255:0] out_tmp_dout_hi_4 = w_in_m_axis_tdata[255:0]; // @[DoCE.scala 144:51]
  wire [511:0] _out_tmp_dout_T_10 = {out_tmp_dout_hi_4,mid_w[575:320]}; // @[Cat.scala 30:58]
  wire [319:0] out_tmp_dout_hi_3 = w_in_m_axis_tdata[319:0]; // @[DoCE.scala 144:51]
  wire [511:0] _out_tmp_dout_T_8 = {out_tmp_dout_hi_3,mid_w[575:384]}; // @[Cat.scala 30:58]
  wire [383:0] out_tmp_dout_hi_2 = w_in_m_axis_tdata[383:0]; // @[DoCE.scala 144:51]
  wire [511:0] _out_tmp_dout_T_6 = {out_tmp_dout_hi_2,mid_w[575:448]}; // @[Cat.scala 30:58]
  wire [447:0] out_tmp_dout_hi_1 = w_in_m_axis_tdata[447:0]; // @[DoCE.scala 144:51]
  wire [511:0] _out_tmp_dout_T_4 = {out_tmp_dout_hi_1,mid_w[575:512]}; // @[Cat.scala 30:58]
  wire [127:0] out_tmp_dout_lo = {{44'd0}, aw_in_m_axis_tdata[87:4]}; // @[DoCE.scala 120:70 DoCE.scala 120:70]
  wire [511:0] _out_tmp_dout_T_1 = {out_tmp_dout_hi_2,out_tmp_dout_lo}; // @[Cat.scala 30:58]
  wire  _T_20 = bit_sent > 16'h0 & _T_16; // @[DoCE.scala 129:35]
  wire [511:0] _GEN_9 = bit_sent > 16'h0 & _T_16 ? w_in_m_axis_tdata[511:0] : 512'h0; // @[DoCE.scala 129:69 DoCE.scala 131:24 DoCE.scala 104:16]
  wire [511:0] _GEN_13 = bit_sent == 16'h0 & aw_in_m_axis_tvalid & w_in_m_axis_tvalid ? _out_tmp_dout_T_1 : _GEN_9; // @[DoCE.scala 115:100 DoCE.scala 119:26]
  wire [511:0] _GEN_21 = mid_count == 16'h0 ? _GEN_13 : 512'h0; // @[DoCE.scala 113:28 DoCE.scala 104:16]
  wire [511:0] _GEN_30 = _T_16 ? _out_tmp_dout_T_4 : _GEN_21; // @[DoCE.scala 142:51 DoCE.scala 144:24]
  wire [511:0] _GEN_35 = mid_last ? {{448'd0}, mid_w[575:512]} : _GEN_30; // @[DoCE.scala 137:23 DoCE.scala 139:24]
  wire [511:0] _GEN_40 = mid_count == 16'h40 ? _GEN_35 : _GEN_21; // @[DoCE.scala 113:28]
  wire [511:0] _GEN_45 = _T_16 ? _out_tmp_dout_T_6 : _GEN_40; // @[DoCE.scala 142:51 DoCE.scala 144:24]
  wire [511:0] _GEN_50 = mid_last ? {{384'd0}, mid_w[575:448]} : _GEN_45; // @[DoCE.scala 137:23 DoCE.scala 139:24]
  wire [511:0] _GEN_55 = mid_count == 16'h80 ? _GEN_50 : _GEN_40; // @[DoCE.scala 113:28]
  wire [511:0] _GEN_60 = _T_16 ? _out_tmp_dout_T_8 : _GEN_55; // @[DoCE.scala 142:51 DoCE.scala 144:24]
  wire [511:0] _GEN_65 = mid_last ? {{320'd0}, mid_w[575:384]} : _GEN_60; // @[DoCE.scala 137:23 DoCE.scala 139:24]
  wire [511:0] _GEN_70 = mid_count == 16'hc0 ? _GEN_65 : _GEN_55; // @[DoCE.scala 113:28]
  wire [511:0] _GEN_75 = _T_16 ? _out_tmp_dout_T_10 : _GEN_70; // @[DoCE.scala 142:51 DoCE.scala 144:24]
  wire [511:0] _GEN_80 = mid_last ? {{256'd0}, mid_w[575:320]} : _GEN_75; // @[DoCE.scala 137:23 DoCE.scala 139:24]
  wire [511:0] _GEN_85 = mid_count == 16'h100 ? _GEN_80 : _GEN_70; // @[DoCE.scala 113:28]
  wire [511:0] _GEN_90 = _T_16 ? _out_tmp_dout_T_12 : _GEN_85; // @[DoCE.scala 142:51 DoCE.scala 144:24]
  wire [511:0] _GEN_95 = mid_last ? {{192'd0}, mid_w[575:256]} : _GEN_90; // @[DoCE.scala 137:23 DoCE.scala 139:24]
  wire [511:0] _GEN_100 = mid_count == 16'h140 ? _GEN_95 : _GEN_85; // @[DoCE.scala 113:28]
  wire [511:0] _GEN_105 = _T_16 ? _out_tmp_dout_T_14 : _GEN_100; // @[DoCE.scala 142:51 DoCE.scala 144:24]
  wire [511:0] _GEN_110 = mid_last ? {{128'd0}, mid_w[575:192]} : _GEN_105; // @[DoCE.scala 137:23 DoCE.scala 139:24]
  wire [511:0] _GEN_115 = mid_count == 16'h180 ? _GEN_110 : _GEN_100; // @[DoCE.scala 113:28]
  wire [511:0] _GEN_120 = _T_16 ? _out_tmp_dout_T_16 : _GEN_115; // @[DoCE.scala 142:51 DoCE.scala 144:24]
  wire [511:0] _GEN_125 = mid_last ? {{64'd0}, mid_w[575:128]} : _GEN_120; // @[DoCE.scala 137:23 DoCE.scala 139:24]
  wire [511:0] _GEN_130 = mid_count == 16'h1c0 ? _GEN_125 : _GEN_115; // @[DoCE.scala 113:28]
  wire [511:0] _GEN_135 = mid_count == 16'h200 ? mid_w[575:64] : _GEN_130; // @[DoCE.scala 113:28 DoCE.scala 151:22]
  wire [511:0] out_tmp_dout = mid_count == 16'h240 ? mid_w[511:0] : _GEN_135; // @[DoCE.scala 113:28 DoCE.scala 151:22]
  wire [528:0] _out_io_s_axis_tdata_T = {out_tmp_dout,out_tmp_connection_id,out_tmp_byte_num}; // @[Cat.scala 30:58]
  wire [63:0] _GEN_11 = bit_sent > 16'h0 & _T_16 ? 64'hffffffffffffffff : 64'h0; // @[DoCE.scala 129:69 DoCE.scala 133:24 DoCE.scala 106:16]
  wire  _GEN_12 = bit_sent > 16'h0 & _T_16 & out_s_axis_tready; // @[DoCE.scala 129:69 DoCE.scala 134:33 DoCE.scala 109:25]
  wire  _GEN_14 = bit_sent == 16'h0 & aw_in_m_axis_tvalid & w_in_m_axis_tvalid | _T_20; // @[DoCE.scala 115:100 DoCE.scala 122:32]
  wire [63:0] _GEN_16 = bit_sent == 16'h0 & aw_in_m_axis_tvalid & w_in_m_axis_tvalid ? 64'hffffffffffffffff : _GEN_11; // @[DoCE.scala 115:100 DoCE.scala 124:24]
  wire  _GEN_19 = bit_sent == 16'h0 & aw_in_m_axis_tvalid & w_in_m_axis_tvalid & out_s_axis_tready; // @[DoCE.scala 115:100 DoCE.scala 127:34 DoCE.scala 110:26]
  wire  _GEN_20 = bit_sent == 16'h0 & aw_in_m_axis_tvalid & w_in_m_axis_tvalid ? out_s_axis_tready : _GEN_12; // @[DoCE.scala 115:100 DoCE.scala 128:33]
  wire  _GEN_22 = mid_count == 16'h0 & _GEN_14; // @[DoCE.scala 113:28 DoCE.scala 103:24]
  wire [63:0] _GEN_24 = mid_count == 16'h0 ? _GEN_16 : 64'h0; // @[DoCE.scala 113:28 DoCE.scala 106:16]
  wire  _GEN_28 = mid_count == 16'h0 & _GEN_20; // @[DoCE.scala 113:28 DoCE.scala 109:25]
  wire  _GEN_29 = _T_16 | _GEN_22; // @[DoCE.scala 142:51 DoCE.scala 143:32]
  wire [63:0] _GEN_32 = _T_16 ? 64'hffffffffffffffff : _GEN_24; // @[DoCE.scala 142:51 DoCE.scala 146:24]
  wire  _GEN_33 = _T_16 ? out_s_axis_tready : _GEN_28; // @[DoCE.scala 142:51 DoCE.scala 147:33]
  wire  _GEN_34 = mid_last | _GEN_29; // @[DoCE.scala 137:23 DoCE.scala 138:32]
  wire [63:0] _GEN_37 = mid_last ? 64'hff : _GEN_32; // @[DoCE.scala 137:23 DoCE.scala 141:24]
  wire  _GEN_38 = mid_last ? _GEN_28 : _GEN_33; // @[DoCE.scala 137:23]
  wire  _GEN_39 = mid_count == 16'h40 ? _GEN_34 : _GEN_22; // @[DoCE.scala 113:28]
  wire  _GEN_41 = mid_count == 16'h40 & mid_last; // @[DoCE.scala 113:28]
  wire [63:0] _GEN_42 = mid_count == 16'h40 ? _GEN_37 : _GEN_24; // @[DoCE.scala 113:28]
  wire  _GEN_43 = mid_count == 16'h40 ? _GEN_38 : _GEN_28; // @[DoCE.scala 113:28]
  wire  _GEN_44 = _T_16 | _GEN_39; // @[DoCE.scala 142:51 DoCE.scala 143:32]
  wire  _GEN_46 = _T_16 ? 1'h0 : _GEN_41; // @[DoCE.scala 142:51 DoCE.scala 145:24]
  wire [63:0] _GEN_47 = _T_16 ? 64'hffffffffffffffff : _GEN_42; // @[DoCE.scala 142:51 DoCE.scala 146:24]
  wire  _GEN_48 = _T_16 ? out_s_axis_tready : _GEN_43; // @[DoCE.scala 142:51 DoCE.scala 147:33]
  wire  _GEN_49 = mid_last | _GEN_44; // @[DoCE.scala 137:23 DoCE.scala 138:32]
  wire  _GEN_51 = mid_last | _GEN_46; // @[DoCE.scala 137:23 DoCE.scala 140:24]
  wire [63:0] _GEN_52 = mid_last ? 64'hffff : _GEN_47; // @[DoCE.scala 137:23 DoCE.scala 141:24]
  wire  _GEN_53 = mid_last ? _GEN_43 : _GEN_48; // @[DoCE.scala 137:23]
  wire  _GEN_54 = mid_count == 16'h80 ? _GEN_49 : _GEN_39; // @[DoCE.scala 113:28]
  wire  _GEN_56 = mid_count == 16'h80 ? _GEN_51 : mid_count == 16'h40 & mid_last; // @[DoCE.scala 113:28]
  wire [63:0] _GEN_57 = mid_count == 16'h80 ? _GEN_52 : _GEN_42; // @[DoCE.scala 113:28]
  wire  _GEN_58 = mid_count == 16'h80 ? _GEN_53 : _GEN_43; // @[DoCE.scala 113:28]
  wire  _GEN_59 = _T_16 | _GEN_54; // @[DoCE.scala 142:51 DoCE.scala 143:32]
  wire  _GEN_61 = _T_16 ? 1'h0 : _GEN_56; // @[DoCE.scala 142:51 DoCE.scala 145:24]
  wire [63:0] _GEN_62 = _T_16 ? 64'hffffffffffffffff : _GEN_57; // @[DoCE.scala 142:51 DoCE.scala 146:24]
  wire  _GEN_63 = _T_16 ? out_s_axis_tready : _GEN_58; // @[DoCE.scala 142:51 DoCE.scala 147:33]
  wire  _GEN_64 = mid_last | _GEN_59; // @[DoCE.scala 137:23 DoCE.scala 138:32]
  wire  _GEN_66 = mid_last | _GEN_61; // @[DoCE.scala 137:23 DoCE.scala 140:24]
  wire [63:0] _GEN_67 = mid_last ? 64'hffffff : _GEN_62; // @[DoCE.scala 137:23 DoCE.scala 141:24]
  wire  _GEN_68 = mid_last ? _GEN_58 : _GEN_63; // @[DoCE.scala 137:23]
  wire  _GEN_69 = mid_count == 16'hc0 ? _GEN_64 : _GEN_54; // @[DoCE.scala 113:28]
  wire  _GEN_71 = mid_count == 16'hc0 ? _GEN_66 : _GEN_56; // @[DoCE.scala 113:28]
  wire [63:0] _GEN_72 = mid_count == 16'hc0 ? _GEN_67 : _GEN_57; // @[DoCE.scala 113:28]
  wire  _GEN_73 = mid_count == 16'hc0 ? _GEN_68 : _GEN_58; // @[DoCE.scala 113:28]
  wire  _GEN_74 = _T_16 | _GEN_69; // @[DoCE.scala 142:51 DoCE.scala 143:32]
  wire  _GEN_76 = _T_16 ? 1'h0 : _GEN_71; // @[DoCE.scala 142:51 DoCE.scala 145:24]
  wire [63:0] _GEN_77 = _T_16 ? 64'hffffffffffffffff : _GEN_72; // @[DoCE.scala 142:51 DoCE.scala 146:24]
  wire  _GEN_78 = _T_16 ? out_s_axis_tready : _GEN_73; // @[DoCE.scala 142:51 DoCE.scala 147:33]
  wire  _GEN_79 = mid_last | _GEN_74; // @[DoCE.scala 137:23 DoCE.scala 138:32]
  wire  _GEN_81 = mid_last | _GEN_76; // @[DoCE.scala 137:23 DoCE.scala 140:24]
  wire [63:0] _GEN_82 = mid_last ? 64'hffffffff : _GEN_77; // @[DoCE.scala 137:23 DoCE.scala 141:24]
  wire  _GEN_83 = mid_last ? _GEN_73 : _GEN_78; // @[DoCE.scala 137:23]
  wire  _GEN_84 = mid_count == 16'h100 ? _GEN_79 : _GEN_69; // @[DoCE.scala 113:28]
  wire  _GEN_86 = mid_count == 16'h100 ? _GEN_81 : _GEN_71; // @[DoCE.scala 113:28]
  wire [63:0] _GEN_87 = mid_count == 16'h100 ? _GEN_82 : _GEN_72; // @[DoCE.scala 113:28]
  wire  _GEN_88 = mid_count == 16'h100 ? _GEN_83 : _GEN_73; // @[DoCE.scala 113:28]
  wire  _GEN_89 = _T_16 | _GEN_84; // @[DoCE.scala 142:51 DoCE.scala 143:32]
  wire  _GEN_91 = _T_16 ? 1'h0 : _GEN_86; // @[DoCE.scala 142:51 DoCE.scala 145:24]
  wire [63:0] _GEN_92 = _T_16 ? 64'hffffffffffffffff : _GEN_87; // @[DoCE.scala 142:51 DoCE.scala 146:24]
  wire  _GEN_93 = _T_16 ? out_s_axis_tready : _GEN_88; // @[DoCE.scala 142:51 DoCE.scala 147:33]
  wire  _GEN_94 = mid_last | _GEN_89; // @[DoCE.scala 137:23 DoCE.scala 138:32]
  wire  _GEN_96 = mid_last | _GEN_91; // @[DoCE.scala 137:23 DoCE.scala 140:24]
  wire [63:0] _GEN_97 = mid_last ? 64'hffffffffff : _GEN_92; // @[DoCE.scala 137:23 DoCE.scala 141:24]
  wire  _GEN_98 = mid_last ? _GEN_88 : _GEN_93; // @[DoCE.scala 137:23]
  wire  _GEN_99 = mid_count == 16'h140 ? _GEN_94 : _GEN_84; // @[DoCE.scala 113:28]
  wire  _GEN_101 = mid_count == 16'h140 ? _GEN_96 : _GEN_86; // @[DoCE.scala 113:28]
  wire [63:0] _GEN_102 = mid_count == 16'h140 ? _GEN_97 : _GEN_87; // @[DoCE.scala 113:28]
  wire  _GEN_103 = mid_count == 16'h140 ? _GEN_98 : _GEN_88; // @[DoCE.scala 113:28]
  wire  _GEN_104 = _T_16 | _GEN_99; // @[DoCE.scala 142:51 DoCE.scala 143:32]
  wire  _GEN_106 = _T_16 ? 1'h0 : _GEN_101; // @[DoCE.scala 142:51 DoCE.scala 145:24]
  wire [63:0] _GEN_107 = _T_16 ? 64'hffffffffffffffff : _GEN_102; // @[DoCE.scala 142:51 DoCE.scala 146:24]
  wire  _GEN_108 = _T_16 ? out_s_axis_tready : _GEN_103; // @[DoCE.scala 142:51 DoCE.scala 147:33]
  wire  _GEN_109 = mid_last | _GEN_104; // @[DoCE.scala 137:23 DoCE.scala 138:32]
  wire  _GEN_111 = mid_last | _GEN_106; // @[DoCE.scala 137:23 DoCE.scala 140:24]
  wire [63:0] _GEN_112 = mid_last ? 64'hffffffffffff : _GEN_107; // @[DoCE.scala 137:23 DoCE.scala 141:24]
  wire  _GEN_113 = mid_last ? _GEN_103 : _GEN_108; // @[DoCE.scala 137:23]
  wire  _GEN_114 = mid_count == 16'h180 ? _GEN_109 : _GEN_99; // @[DoCE.scala 113:28]
  wire  _GEN_116 = mid_count == 16'h180 ? _GEN_111 : _GEN_101; // @[DoCE.scala 113:28]
  wire [63:0] _GEN_117 = mid_count == 16'h180 ? _GEN_112 : _GEN_102; // @[DoCE.scala 113:28]
  wire  _GEN_118 = mid_count == 16'h180 ? _GEN_113 : _GEN_103; // @[DoCE.scala 113:28]
  wire  _GEN_119 = _T_16 | _GEN_114; // @[DoCE.scala 142:51 DoCE.scala 143:32]
  wire  _GEN_121 = _T_16 ? 1'h0 : _GEN_116; // @[DoCE.scala 142:51 DoCE.scala 145:24]
  wire [63:0] _GEN_122 = _T_16 ? 64'hffffffffffffffff : _GEN_117; // @[DoCE.scala 142:51 DoCE.scala 146:24]
  wire  _GEN_123 = _T_16 ? out_s_axis_tready : _GEN_118; // @[DoCE.scala 142:51 DoCE.scala 147:33]
  wire  _GEN_124 = mid_last | _GEN_119; // @[DoCE.scala 137:23 DoCE.scala 138:32]
  wire  _GEN_126 = mid_last | _GEN_121; // @[DoCE.scala 137:23 DoCE.scala 140:24]
  wire [63:0] _GEN_127 = mid_last ? 64'hffffffffffffff : _GEN_122; // @[DoCE.scala 137:23 DoCE.scala 141:24]
  wire  _GEN_128 = mid_last ? _GEN_118 : _GEN_123; // @[DoCE.scala 137:23]
  wire  _GEN_129 = mid_count == 16'h1c0 ? _GEN_124 : _GEN_114; // @[DoCE.scala 113:28]
  wire  _GEN_131 = mid_count == 16'h1c0 ? _GEN_126 : _GEN_116; // @[DoCE.scala 113:28]
  wire [63:0] _GEN_132 = mid_count == 16'h1c0 ? _GEN_127 : _GEN_117; // @[DoCE.scala 113:28]
  wire  _GEN_136 = mid_count == 16'h200 ? 1'h0 : _GEN_131; // @[DoCE.scala 113:28 DoCE.scala 152:22]
  wire [63:0] _GEN_137 = mid_count == 16'h200 ? 64'hffffffffffffffff : _GEN_132; // @[DoCE.scala 113:28 DoCE.scala 153:22]
  wire [63:0] out_tmp_keep = mid_count == 16'h240 ? 64'hffffffffffffffff : _GEN_137; // @[DoCE.scala 113:28 DoCE.scala 153:22]
  dout_channel_reg_slice out ( // @[DoCE.scala 32:19]
    .aclk(out_aclk),
    .aresetn(out_aresetn),
    .s_axis_tdata(out_s_axis_tdata),
    .s_axis_tkeep(out_s_axis_tkeep),
    .s_axis_tlast(out_s_axis_tlast),
    .s_axis_tvalid(out_s_axis_tvalid),
    .s_axis_tready(out_s_axis_tready),
    .m_axis_tdata(out_m_axis_tdata),
    .m_axis_tkeep(out_m_axis_tkeep),
    .m_axis_tlast(out_m_axis_tlast),
    .m_axis_tvalid(out_m_axis_tvalid),
    .m_axis_tready(out_m_axis_tready)
  );
  aw_channel_reg_slice aw_in ( // @[DoCE.scala 35:21]
    .aclk(aw_in_aclk),
    .aresetn(aw_in_aresetn),
    .s_axis_tdata(aw_in_s_axis_tdata),
    .s_axis_tkeep(aw_in_s_axis_tkeep),
    .s_axis_tlast(aw_in_s_axis_tlast),
    .s_axis_tvalid(aw_in_s_axis_tvalid),
    .s_axis_tready(aw_in_s_axis_tready),
    .m_axis_tdata(aw_in_m_axis_tdata),
    .m_axis_tkeep(aw_in_m_axis_tkeep),
    .m_axis_tlast(aw_in_m_axis_tlast),
    .m_axis_tvalid(aw_in_m_axis_tvalid),
    .m_axis_tready(aw_in_m_axis_tready)
  );
  w_channel_reg_slice w_in ( // @[DoCE.scala 41:20]
    .aclk(w_in_aclk),
    .aresetn(w_in_aresetn),
    .s_axis_tdata(w_in_s_axis_tdata),
    .s_axis_tkeep(w_in_s_axis_tkeep),
    .s_axis_tlast(w_in_s_axis_tlast),
    .s_axis_tvalid(w_in_s_axis_tvalid),
    .s_axis_tready(w_in_s_axis_tready),
    .m_axis_tdata(w_in_m_axis_tdata),
    .m_axis_tkeep(w_in_m_axis_tkeep),
    .m_axis_tlast(w_in_m_axis_tlast),
    .m_axis_tvalid(w_in_m_axis_tvalid),
    .m_axis_tready(w_in_m_axis_tready)
  );
  assign io_aw_channel_ready = aw_in_s_axis_tready; // @[DoCE.scala 40:23]
  assign io_w_channel_ready = w_in_s_axis_tready; // @[DoCE.scala 47:22]
  assign io_dout_channel_valid = out_m_axis_tvalid; // @[DoCE.scala 91:25]
  assign io_dout_channel_bits_dout = out_m_axis_tdata[528:17]; // @[DoCE.scala 92:51]
  assign io_dout_channel_bits_keep = out_m_axis_tkeep[63:0]; // @[DoCE.scala 94:29]
  assign io_dout_channel_bits_last = out_m_axis_tlast; // @[DoCE.scala 93:29]
  assign io_dout_channel_bits_connection_id = out_m_axis_tdata[16:13]; // @[DoCE.scala 96:60]
  assign io_dout_channel_bits_byte_num = out_m_axis_tdata[12:0]; // @[DoCE.scala 95:55]
  assign out_aclk = clock; // @[DoCE.scala 33:30]
  assign out_aresetn = ~reset; // @[DoCE.scala 34:21]
  assign out_s_axis_tdata = {{7'd0}, _out_io_s_axis_tdata_T}; // @[Cat.scala 30:58]
  assign out_s_axis_tkeep = {{3'd0}, out_tmp_keep}; // @[DoCE.scala 113:28 DoCE.scala 153:22]
  assign out_s_axis_tlast = mid_count == 16'h240 ? 1'h0 : _GEN_136; // @[DoCE.scala 113:28 DoCE.scala 152:22]
  assign out_s_axis_tvalid = mid_count == 16'h240 | (mid_count == 16'h200 | _GEN_129); // @[DoCE.scala 113:28 DoCE.scala 150:30]
  assign out_m_axis_tready = io_dout_channel_ready; // @[DoCE.scala 97:24]
  assign aw_in_aclk = clock; // @[DoCE.scala 36:32]
  assign aw_in_aresetn = ~reset; // @[DoCE.scala 37:23]
  assign aw_in_s_axis_tdata = {io_aw_channel_bits_aw,io_aw_channel_bits_connection_id}; // @[Cat.scala 30:58]
  assign aw_in_s_axis_tkeep = 11'h0;
  assign aw_in_s_axis_tlast = 1'h0;
  assign aw_in_s_axis_tvalid = io_aw_channel_valid; // @[DoCE.scala 39:26]
  assign aw_in_m_axis_tready = mid_count == 16'h0 & _GEN_19; // @[DoCE.scala 113:28 DoCE.scala 110:26]
  assign w_in_aclk = clock; // @[DoCE.scala 42:31]
  assign w_in_aresetn = ~reset; // @[DoCE.scala 43:22]
  assign w_in_s_axis_tdata = io_w_channel_bits_w; // @[DoCE.scala 44:24]
  assign w_in_s_axis_tkeep = 72'h0;
  assign w_in_s_axis_tlast = io_w_channel_bits_last; // @[DoCE.scala 45:24]
  assign w_in_s_axis_tvalid = io_w_channel_valid; // @[DoCE.scala 46:25]
  assign w_in_m_axis_tready = mid_count == 16'h1c0 ? _GEN_128 : _GEN_118; // @[DoCE.scala 113:28]
  always @(posedge clock) begin
    if (reset) begin // @[DoCE.scala 31:25]
      bit_sent <= 16'h0; // @[DoCE.scala 31:25]
    end else if (_T_4) begin // @[DoCE.scala 73:63]
      if (_T_6) begin // @[DoCE.scala 74:39]
        bit_sent <= 16'h0; // @[DoCE.scala 75:16]
      end else begin
        bit_sent <= _bit_sent_T_1; // @[DoCE.scala 77:16]
      end
    end
    if (reset) begin // @[DoCE.scala 49:20]
      mid_w <= 576'h0; // @[DoCE.scala 49:20]
    end else if (_T) begin // @[DoCE.scala 68:65]
      mid_w <= w_in_m_axis_tdata; // @[DoCE.scala 69:11]
    end
    if (reset) begin // @[DoCE.scala 49:20]
      mid_last <= 1'h0; // @[DoCE.scala 49:20]
    end else if (_T) begin // @[DoCE.scala 68:65]
      mid_last <= w_in_m_axis_tlast; // @[DoCE.scala 70:14]
    end
    if (reset) begin // @[DoCE.scala 53:26]
      mid_count <= 16'h0; // @[DoCE.scala 53:26]
    end else if (w_in_m_axis_tready & w_in_m_axis_tvalid) begin // @[DoCE.scala 54:65]
      if (aw_in_m_axis_tready & aw_in_m_axis_tvalid) begin // @[DoCE.scala 55:69]
        mid_count <= 16'hc0; // @[DoCE.scala 56:17]
      end else begin
        mid_count <= _mid_count_T_1; // @[DoCE.scala 58:17]
      end
    end else if (out_s_axis_tvalid & out_s_axis_tready) begin // @[DoCE.scala 60:69]
      if (out_s_axis_tlast) begin // @[DoCE.scala 61:39]
        mid_count <= 16'h0; // @[DoCE.scala 62:17]
      end else begin
        mid_count <= _mid_count_T_3; // @[DoCE.scala 64:17]
      end
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
  bit_sent = _RAND_0[15:0];
  _RAND_1 = {18{`RANDOM}};
  mid_w = _RAND_1[575:0];
  _RAND_2 = {1{`RANDOM}};
  mid_last = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  mid_count = _RAND_3[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
