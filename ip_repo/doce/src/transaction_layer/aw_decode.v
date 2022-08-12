module aw_decode(
  input          clock,
  input          reset,
  input          io_aw_channel_ready,
  output         io_aw_channel_valid,
  output [79:0]  io_aw_channel_bits_aw,
  input          io_w_channel_ready,
  output         io_w_channel_valid,
  output [575:0] io_w_channel_bits_w,
  output         io_w_channel_bits_last,
  output         io_din_channel_ready,
  input          io_din_channel_valid,
  input  [511:0] io_din_channel_bits_din,
  input          io_din_channel_bits_last,
  input  [48:0]  io_phy_base_0,
  input  [48:0]  io_phy_base_1
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [511:0] _RAND_1;
  reg [31:0] _RAND_2;
`endif // RANDOMIZE_REG_INIT
  wire  in_aclk; // @[DoCE.scala 178:18]
  wire  in_aresetn; // @[DoCE.scala 178:18]
  wire [511:0] in_s_axis_tdata; // @[DoCE.scala 178:18]
  wire [63:0] in_s_axis_tkeep; // @[DoCE.scala 178:18]
  wire  in_s_axis_tlast; // @[DoCE.scala 178:18]
  wire  in_s_axis_tvalid; // @[DoCE.scala 178:18]
  wire  in_s_axis_tready; // @[DoCE.scala 178:18]
  wire [511:0] in_m_axis_tdata; // @[DoCE.scala 178:18]
  wire [63:0] in_m_axis_tkeep; // @[DoCE.scala 178:18]
  wire  in_m_axis_tlast; // @[DoCE.scala 178:18]
  wire  in_m_axis_tvalid; // @[DoCE.scala 178:18]
  wire  in_m_axis_tready; // @[DoCE.scala 178:18]
  wire  aw_channel_out_aclk; // @[DoCE.scala 185:30]
  wire  aw_channel_out_aresetn; // @[DoCE.scala 185:30]
  wire [79:0] aw_channel_out_s_axis_tdata; // @[DoCE.scala 185:30]
  wire [9:0] aw_channel_out_s_axis_tkeep; // @[DoCE.scala 185:30]
  wire  aw_channel_out_s_axis_tlast; // @[DoCE.scala 185:30]
  wire  aw_channel_out_s_axis_tvalid; // @[DoCE.scala 185:30]
  wire  aw_channel_out_s_axis_tready; // @[DoCE.scala 185:30]
  wire [79:0] aw_channel_out_m_axis_tdata; // @[DoCE.scala 185:30]
  wire [9:0] aw_channel_out_m_axis_tkeep; // @[DoCE.scala 185:30]
  wire  aw_channel_out_m_axis_tlast; // @[DoCE.scala 185:30]
  wire  aw_channel_out_m_axis_tvalid; // @[DoCE.scala 185:30]
  wire  aw_channel_out_m_axis_tready; // @[DoCE.scala 185:30]
  wire  w_channel_out_aclk; // @[DoCE.scala 188:29]
  wire  w_channel_out_aresetn; // @[DoCE.scala 188:29]
  wire [575:0] w_channel_out_s_axis_tdata; // @[DoCE.scala 188:29]
  wire [71:0] w_channel_out_s_axis_tkeep; // @[DoCE.scala 188:29]
  wire  w_channel_out_s_axis_tlast; // @[DoCE.scala 188:29]
  wire  w_channel_out_s_axis_tvalid; // @[DoCE.scala 188:29]
  wire  w_channel_out_s_axis_tready; // @[DoCE.scala 188:29]
  wire [575:0] w_channel_out_m_axis_tdata; // @[DoCE.scala 188:29]
  wire [71:0] w_channel_out_m_axis_tkeep; // @[DoCE.scala 188:29]
  wire  w_channel_out_m_axis_tlast; // @[DoCE.scala 188:29]
  wire  w_channel_out_m_axis_tvalid; // @[DoCE.scala 188:29]
  wire  w_channel_out_m_axis_tready; // @[DoCE.scala 188:29]
  reg [15:0] bit_sent; // @[DoCE.scala 177:25]
  reg [511:0] mid_w; // @[DoCE.scala 191:20]
  reg [15:0] mid_count; // @[DoCE.scala 195:26]
  wire  _T = in_m_axis_tvalid & in_m_axis_tready; // @[DoCE.scala 196:29]
  wire  _T_2 = mid_count == 16'h0; // @[DoCE.scala 197:20]
  wire  _T_3 = bit_sent == 16'h0; // @[DoCE.scala 198:21]
  wire [9:0] _GEN_0 = bit_sent == 16'h0 ? 10'h180 : 10'h200; // @[DoCE.scala 198:29 DoCE.scala 199:19 DoCE.scala 201:19]
  wire [15:0] _mid_count_T_1 = mid_count - 16'h40; // @[DoCE.scala 207:32]
  wire [15:0] _bit_sent_T_1 = bit_sent + 16'h240; // @[DoCE.scala 216:28]
  wire [15:0] _bit_sent_T_3 = bit_sent + 16'h80; // @[DoCE.scala 219:26]
  wire  _T_14 = in_m_axis_tvalid; // @[DoCE.scala 244:60]
  wire  _T_15 = _T_3 & in_m_axis_tvalid; // @[DoCE.scala 244:31]
  wire  _GEN_11 = _T_3 & in_m_axis_tvalid ? aw_channel_out_s_axis_tready : in_m_axis_tvalid; // @[DoCE.scala 244:63 DoCE.scala 246:31]
  wire  _GEN_13 = _T_2 & _GEN_11; // @[DoCE.scala 242:28 DoCE.scala 235:23]
  wire [511:0] w_channel_out_io_s_axis_tdata_hi = in_m_axis_tdata; // @[DoCE.scala 254:66]
  wire [63:0] w_channel_out_io_s_axis_tdata_lo = mid_w[511:448]; // @[DoCE.scala 254:101]
  wire [575:0] _w_channel_out_io_s_axis_tdata_T = {w_channel_out_io_s_axis_tdata_hi,w_channel_out_io_s_axis_tdata_lo}; // @[Cat.scala 30:58]
  wire  _GEN_14 = _T_14 ? w_channel_out_s_axis_tready : _GEN_13; // @[DoCE.scala 251:43 DoCE.scala 252:31]
  wire [575:0] _GEN_16 = _T_14 ? _w_channel_out_io_s_axis_tdata_T : 576'h0; // @[DoCE.scala 251:43 DoCE.scala 254:41 DoCE.scala 237:33]
  wire  _GEN_17 = _T_14 & in_m_axis_tlast; // @[DoCE.scala 251:43 DoCE.scala 255:41 DoCE.scala 238:33]
  wire  _GEN_18 = mid_count == 16'h40 ? _GEN_14 : _GEN_13; // @[DoCE.scala 242:28]
  wire  _GEN_19 = mid_count == 16'h40 & _T_14; // @[DoCE.scala 242:28 DoCE.scala 236:34]
  wire [575:0] _GEN_20 = mid_count == 16'h40 ? _GEN_16 : 576'h0; // @[DoCE.scala 242:28 DoCE.scala 237:33]
  wire  _GEN_21 = mid_count == 16'h40 & _GEN_17; // @[DoCE.scala 242:28 DoCE.scala 238:33]
  wire [447:0] w_channel_out_io_s_axis_tdata_hi_1 = in_m_axis_tdata[447:0]; // @[DoCE.scala 254:66]
  wire [127:0] w_channel_out_io_s_axis_tdata_lo_1 = mid_w[511:384]; // @[DoCE.scala 254:101]
  wire [575:0] _w_channel_out_io_s_axis_tdata_T_1 = {w_channel_out_io_s_axis_tdata_hi_1,
    w_channel_out_io_s_axis_tdata_lo_1}; // @[Cat.scala 30:58]
  wire  _GEN_22 = _T_14 ? w_channel_out_s_axis_tready : _GEN_18; // @[DoCE.scala 251:43 DoCE.scala 252:31]
  wire  _GEN_23 = _T_14 | _GEN_19; // @[DoCE.scala 251:43 DoCE.scala 253:42]
  wire [575:0] _GEN_24 = _T_14 ? _w_channel_out_io_s_axis_tdata_T_1 : _GEN_20; // @[DoCE.scala 251:43 DoCE.scala 254:41]
  wire  _GEN_25 = _T_14 ? in_m_axis_tlast : _GEN_21; // @[DoCE.scala 251:43 DoCE.scala 255:41]
  wire  _GEN_26 = mid_count == 16'h80 ? _GEN_22 : _GEN_18; // @[DoCE.scala 242:28]
  wire  _GEN_27 = mid_count == 16'h80 ? _GEN_23 : _GEN_19; // @[DoCE.scala 242:28]
  wire [575:0] _GEN_28 = mid_count == 16'h80 ? _GEN_24 : _GEN_20; // @[DoCE.scala 242:28]
  wire  _GEN_29 = mid_count == 16'h80 ? _GEN_25 : _GEN_21; // @[DoCE.scala 242:28]
  wire [383:0] w_channel_out_io_s_axis_tdata_hi_2 = in_m_axis_tdata[383:0]; // @[DoCE.scala 254:66]
  wire [191:0] w_channel_out_io_s_axis_tdata_lo_2 = mid_w[511:320]; // @[DoCE.scala 254:101]
  wire [575:0] _w_channel_out_io_s_axis_tdata_T_2 = {w_channel_out_io_s_axis_tdata_hi_2,
    w_channel_out_io_s_axis_tdata_lo_2}; // @[Cat.scala 30:58]
  wire  _GEN_30 = _T_14 ? w_channel_out_s_axis_tready : _GEN_26; // @[DoCE.scala 251:43 DoCE.scala 252:31]
  wire  _GEN_31 = _T_14 | _GEN_27; // @[DoCE.scala 251:43 DoCE.scala 253:42]
  wire [575:0] _GEN_32 = _T_14 ? _w_channel_out_io_s_axis_tdata_T_2 : _GEN_28; // @[DoCE.scala 251:43 DoCE.scala 254:41]
  wire  _GEN_33 = _T_14 ? in_m_axis_tlast : _GEN_29; // @[DoCE.scala 251:43 DoCE.scala 255:41]
  wire  _GEN_34 = mid_count == 16'hc0 ? _GEN_30 : _GEN_26; // @[DoCE.scala 242:28]
  wire  _GEN_35 = mid_count == 16'hc0 ? _GEN_31 : _GEN_27; // @[DoCE.scala 242:28]
  wire [575:0] _GEN_36 = mid_count == 16'hc0 ? _GEN_32 : _GEN_28; // @[DoCE.scala 242:28]
  wire  _GEN_37 = mid_count == 16'hc0 ? _GEN_33 : _GEN_29; // @[DoCE.scala 242:28]
  wire [319:0] w_channel_out_io_s_axis_tdata_hi_3 = in_m_axis_tdata[319:0]; // @[DoCE.scala 254:66]
  wire [255:0] w_channel_out_io_s_axis_tdata_lo_3 = mid_w[511:256]; // @[DoCE.scala 254:101]
  wire [575:0] _w_channel_out_io_s_axis_tdata_T_3 = {w_channel_out_io_s_axis_tdata_hi_3,
    w_channel_out_io_s_axis_tdata_lo_3}; // @[Cat.scala 30:58]
  wire  _GEN_38 = _T_14 ? w_channel_out_s_axis_tready : _GEN_34; // @[DoCE.scala 251:43 DoCE.scala 252:31]
  wire  _GEN_39 = _T_14 | _GEN_35; // @[DoCE.scala 251:43 DoCE.scala 253:42]
  wire [575:0] _GEN_40 = _T_14 ? _w_channel_out_io_s_axis_tdata_T_3 : _GEN_36; // @[DoCE.scala 251:43 DoCE.scala 254:41]
  wire  _GEN_41 = _T_14 ? in_m_axis_tlast : _GEN_37; // @[DoCE.scala 251:43 DoCE.scala 255:41]
  wire  _GEN_42 = mid_count == 16'h100 ? _GEN_38 : _GEN_34; // @[DoCE.scala 242:28]
  wire  _GEN_43 = mid_count == 16'h100 ? _GEN_39 : _GEN_35; // @[DoCE.scala 242:28]
  wire [575:0] _GEN_44 = mid_count == 16'h100 ? _GEN_40 : _GEN_36; // @[DoCE.scala 242:28]
  wire  _GEN_45 = mid_count == 16'h100 ? _GEN_41 : _GEN_37; // @[DoCE.scala 242:28]
  wire [255:0] w_channel_out_io_s_axis_tdata_hi_4 = in_m_axis_tdata[255:0]; // @[DoCE.scala 254:66]
  wire [319:0] w_channel_out_io_s_axis_tdata_lo_4 = mid_w[511:192]; // @[DoCE.scala 254:101]
  wire [575:0] _w_channel_out_io_s_axis_tdata_T_4 = {w_channel_out_io_s_axis_tdata_hi_4,
    w_channel_out_io_s_axis_tdata_lo_4}; // @[Cat.scala 30:58]
  wire  _GEN_46 = _T_14 ? w_channel_out_s_axis_tready : _GEN_42; // @[DoCE.scala 251:43 DoCE.scala 252:31]
  wire  _GEN_47 = _T_14 | _GEN_43; // @[DoCE.scala 251:43 DoCE.scala 253:42]
  wire [575:0] _GEN_48 = _T_14 ? _w_channel_out_io_s_axis_tdata_T_4 : _GEN_44; // @[DoCE.scala 251:43 DoCE.scala 254:41]
  wire  _GEN_49 = _T_14 ? in_m_axis_tlast : _GEN_45; // @[DoCE.scala 251:43 DoCE.scala 255:41]
  wire  _GEN_50 = mid_count == 16'h140 ? _GEN_46 : _GEN_42; // @[DoCE.scala 242:28]
  wire  _GEN_51 = mid_count == 16'h140 ? _GEN_47 : _GEN_43; // @[DoCE.scala 242:28]
  wire [575:0] _GEN_52 = mid_count == 16'h140 ? _GEN_48 : _GEN_44; // @[DoCE.scala 242:28]
  wire  _GEN_53 = mid_count == 16'h140 ? _GEN_49 : _GEN_45; // @[DoCE.scala 242:28]
  wire [191:0] w_channel_out_io_s_axis_tdata_hi_5 = in_m_axis_tdata[191:0]; // @[DoCE.scala 254:66]
  wire [383:0] w_channel_out_io_s_axis_tdata_lo_5 = mid_w[511:128]; // @[DoCE.scala 254:101]
  wire [575:0] _w_channel_out_io_s_axis_tdata_T_5 = {w_channel_out_io_s_axis_tdata_hi_5,
    w_channel_out_io_s_axis_tdata_lo_5}; // @[Cat.scala 30:58]
  wire  _GEN_54 = _T_14 ? w_channel_out_s_axis_tready : _GEN_50; // @[DoCE.scala 251:43 DoCE.scala 252:31]
  wire  _GEN_55 = _T_14 | _GEN_51; // @[DoCE.scala 251:43 DoCE.scala 253:42]
  wire [575:0] _GEN_56 = _T_14 ? _w_channel_out_io_s_axis_tdata_T_5 : _GEN_52; // @[DoCE.scala 251:43 DoCE.scala 254:41]
  wire  _GEN_57 = _T_14 ? in_m_axis_tlast : _GEN_53; // @[DoCE.scala 251:43 DoCE.scala 255:41]
  wire  _GEN_58 = mid_count == 16'h180 ? _GEN_54 : _GEN_50; // @[DoCE.scala 242:28]
  wire  _GEN_59 = mid_count == 16'h180 ? _GEN_55 : _GEN_51; // @[DoCE.scala 242:28]
  wire [575:0] _GEN_60 = mid_count == 16'h180 ? _GEN_56 : _GEN_52; // @[DoCE.scala 242:28]
  wire  _GEN_61 = mid_count == 16'h180 ? _GEN_57 : _GEN_53; // @[DoCE.scala 242:28]
  wire [127:0] w_channel_out_io_s_axis_tdata_hi_6 = in_m_axis_tdata[127:0]; // @[DoCE.scala 254:66]
  wire [447:0] w_channel_out_io_s_axis_tdata_lo_6 = mid_w[511:64]; // @[DoCE.scala 254:101]
  wire [575:0] _w_channel_out_io_s_axis_tdata_T_6 = {w_channel_out_io_s_axis_tdata_hi_6,
    w_channel_out_io_s_axis_tdata_lo_6}; // @[Cat.scala 30:58]
  wire  _GEN_62 = _T_14 ? w_channel_out_s_axis_tready : _GEN_58; // @[DoCE.scala 251:43 DoCE.scala 252:31]
  wire  _GEN_63 = _T_14 | _GEN_59; // @[DoCE.scala 251:43 DoCE.scala 253:42]
  wire [575:0] _GEN_64 = _T_14 ? _w_channel_out_io_s_axis_tdata_T_6 : _GEN_60; // @[DoCE.scala 251:43 DoCE.scala 254:41]
  wire  _GEN_65 = _T_14 ? in_m_axis_tlast : _GEN_61; // @[DoCE.scala 251:43 DoCE.scala 255:41]
  wire  _GEN_66 = mid_count == 16'h1c0 ? _GEN_62 : _GEN_58; // @[DoCE.scala 242:28]
  wire  _GEN_67 = mid_count == 16'h1c0 ? _GEN_63 : _GEN_59; // @[DoCE.scala 242:28]
  wire [575:0] _GEN_68 = mid_count == 16'h1c0 ? _GEN_64 : _GEN_60; // @[DoCE.scala 242:28]
  wire  _GEN_69 = mid_count == 16'h1c0 ? _GEN_65 : _GEN_61; // @[DoCE.scala 242:28]
  wire [63:0] w_channel_out_io_s_axis_tdata_hi_7 = in_m_axis_tdata[63:0]; // @[DoCE.scala 254:66]
  wire [575:0] _w_channel_out_io_s_axis_tdata_T_7 = {w_channel_out_io_s_axis_tdata_hi_7,mid_w}; // @[Cat.scala 30:58]
  wire  _GEN_70 = _T_14 ? w_channel_out_s_axis_tready : _GEN_66; // @[DoCE.scala 251:43 DoCE.scala 252:31]
  wire  _GEN_71 = _T_14 | _GEN_67; // @[DoCE.scala 251:43 DoCE.scala 253:42]
  wire [575:0] _GEN_72 = _T_14 ? _w_channel_out_io_s_axis_tdata_T_7 : _GEN_68; // @[DoCE.scala 251:43 DoCE.scala 254:41]
  wire  _GEN_73 = _T_14 ? in_m_axis_tlast : _GEN_69; // @[DoCE.scala 251:43 DoCE.scala 255:41]
  wire [75:0] aw_channel_out_io_s_axis_tdata_hi = in_m_axis_tdata[83:8]; // @[DoCE.scala 261:59]
  wire [3:0] aw_channel_out_io_s_axis_tdata_lo = in_m_axis_tdata[3:0]; // @[DoCE.scala 261:86]
  wire [79:0] _aw_channel_out_io_s_axis_tdata_T = {aw_channel_out_io_s_axis_tdata_hi,aw_channel_out_io_s_axis_tdata_lo}; // @[Cat.scala 30:58]
  wire [43:0] aw_channel_out_io_s_axis_tdata_hi_2 = io_phy_base_0[43:0]; // @[DoCE.scala 264:24]
  wire [47:0] _aw_channel_out_io_s_axis_tdata_T_2 = {aw_channel_out_io_s_axis_tdata_hi_2,4'h0}; // @[Cat.scala 30:58]
  wire [79:0] _aw_channel_out_io_s_axis_tdata_WIRE = {{32'd0}, _aw_channel_out_io_s_axis_tdata_T_2}; // @[DoCE.scala 264:51 DoCE.scala 264:51]
  wire [79:0] _aw_channel_out_io_s_axis_tdata_T_3 = _aw_channel_out_io_s_axis_tdata_T |
    _aw_channel_out_io_s_axis_tdata_WIRE; // @[DoCE.scala 263:96]
  wire [43:0] aw_channel_out_io_s_axis_tdata_hi_4 = io_phy_base_1[43:0]; // @[DoCE.scala 267:24]
  wire [47:0] _aw_channel_out_io_s_axis_tdata_T_5 = {aw_channel_out_io_s_axis_tdata_hi_4,4'h0}; // @[Cat.scala 30:58]
  wire [79:0] _aw_channel_out_io_s_axis_tdata_WIRE_1 = {{32'd0}, _aw_channel_out_io_s_axis_tdata_T_5}; // @[DoCE.scala 267:51 DoCE.scala 267:51]
  wire [79:0] _aw_channel_out_io_s_axis_tdata_T_6 = _aw_channel_out_io_s_axis_tdata_T |
    _aw_channel_out_io_s_axis_tdata_WIRE_1; // @[DoCE.scala 266:96]
  wire [79:0] _GEN_78 = in_m_axis_tdata[7:4] == io_phy_base_1[47:44] & io_phy_base_1[48] ?
    _aw_channel_out_io_s_axis_tdata_T_6 : _aw_channel_out_io_s_axis_tdata_T; // @[DoCE.scala 265:86 DoCE.scala 266:36 DoCE.scala 261:34]
  aw_decode_in_reg_slice in ( // @[DoCE.scala 178:18]
    .aclk(in_aclk),
    .aresetn(in_aresetn),
    .s_axis_tdata(in_s_axis_tdata),
    .s_axis_tkeep(in_s_axis_tkeep),
    .s_axis_tlast(in_s_axis_tlast),
    .s_axis_tvalid(in_s_axis_tvalid),
    .s_axis_tready(in_s_axis_tready),
    .m_axis_tdata(in_m_axis_tdata),
    .m_axis_tkeep(in_m_axis_tkeep),
    .m_axis_tlast(in_m_axis_tlast),
    .m_axis_tvalid(in_m_axis_tvalid),
    .m_axis_tready(in_m_axis_tready)
  );
  aw_channel_out_reg_slice aw_channel_out ( // @[DoCE.scala 185:30]
    .aclk(aw_channel_out_aclk),
    .aresetn(aw_channel_out_aresetn),
    .s_axis_tdata(aw_channel_out_s_axis_tdata),
    .s_axis_tkeep(aw_channel_out_s_axis_tkeep),
    .s_axis_tlast(aw_channel_out_s_axis_tlast),
    .s_axis_tvalid(aw_channel_out_s_axis_tvalid),
    .s_axis_tready(aw_channel_out_s_axis_tready),
    .m_axis_tdata(aw_channel_out_m_axis_tdata),
    .m_axis_tkeep(aw_channel_out_m_axis_tkeep),
    .m_axis_tlast(aw_channel_out_m_axis_tlast),
    .m_axis_tvalid(aw_channel_out_m_axis_tvalid),
    .m_axis_tready(aw_channel_out_m_axis_tready)
  );
  w_channel_out_reg_slice w_channel_out ( // @[DoCE.scala 188:29]
    .aclk(w_channel_out_aclk),
    .aresetn(w_channel_out_aresetn),
    .s_axis_tdata(w_channel_out_s_axis_tdata),
    .s_axis_tkeep(w_channel_out_s_axis_tkeep),
    .s_axis_tlast(w_channel_out_s_axis_tlast),
    .s_axis_tvalid(w_channel_out_s_axis_tvalid),
    .s_axis_tready(w_channel_out_s_axis_tready),
    .m_axis_tdata(w_channel_out_m_axis_tdata),
    .m_axis_tkeep(w_channel_out_m_axis_tkeep),
    .m_axis_tlast(w_channel_out_m_axis_tlast),
    .m_axis_tvalid(w_channel_out_m_axis_tvalid),
    .m_axis_tready(w_channel_out_m_axis_tready)
  );
  assign io_aw_channel_valid = aw_channel_out_m_axis_tvalid; // @[DoCE.scala 227:23]
  assign io_aw_channel_bits_aw = aw_channel_out_m_axis_tdata; // @[DoCE.scala 228:25]
  assign io_w_channel_valid = w_channel_out_m_axis_tvalid; // @[DoCE.scala 230:22]
  assign io_w_channel_bits_w = w_channel_out_m_axis_tdata; // @[DoCE.scala 232:23]
  assign io_w_channel_bits_last = w_channel_out_m_axis_tlast; // @[DoCE.scala 231:26]
  assign io_din_channel_ready = in_s_axis_tready; // @[DoCE.scala 184:24]
  assign in_aclk = clock; // @[DoCE.scala 179:29]
  assign in_aresetn = ~reset; // @[DoCE.scala 180:20]
  assign in_s_axis_tdata = io_din_channel_bits_din; // @[DoCE.scala 182:22]
  assign in_s_axis_tkeep = 64'h0;
  assign in_s_axis_tlast = io_din_channel_bits_last; // @[DoCE.scala 183:22]
  assign in_s_axis_tvalid = io_din_channel_valid; // @[DoCE.scala 181:23]
  assign in_m_axis_tready = mid_count == 16'h200 ? _GEN_70 : _GEN_66; // @[DoCE.scala 242:28]
  assign aw_channel_out_aclk = clock; // @[DoCE.scala 186:41]
  assign aw_channel_out_aresetn = ~reset; // @[DoCE.scala 187:32]
  assign aw_channel_out_s_axis_tdata = in_m_axis_tdata[7:4] == io_phy_base_0[47:44] & io_phy_base_0[48] ?
    _aw_channel_out_io_s_axis_tdata_T_3 : _GEN_78; // @[DoCE.scala 262:80 DoCE.scala 263:36]
  assign aw_channel_out_s_axis_tkeep = 10'h0;
  assign aw_channel_out_s_axis_tlast = 1'h0;
  assign aw_channel_out_s_axis_tvalid = _T_2 & _T_15; // @[DoCE.scala 242:28 DoCE.scala 239:35]
  assign aw_channel_out_m_axis_tready = io_aw_channel_ready; // @[DoCE.scala 229:35]
  assign w_channel_out_aclk = clock; // @[DoCE.scala 189:40]
  assign w_channel_out_aresetn = ~reset; // @[DoCE.scala 190:31]
  assign w_channel_out_s_axis_tdata = mid_count == 16'h200 ? _GEN_72 : _GEN_68; // @[DoCE.scala 242:28]
  assign w_channel_out_s_axis_tkeep = 72'h0;
  assign w_channel_out_s_axis_tlast = mid_count == 16'h200 ? _GEN_73 : _GEN_69; // @[DoCE.scala 242:28]
  assign w_channel_out_s_axis_tvalid = mid_count == 16'h200 ? _GEN_71 : _GEN_67; // @[DoCE.scala 242:28]
  assign w_channel_out_m_axis_tready = io_w_channel_ready; // @[DoCE.scala 233:34]
  always @(posedge clock) begin
    if (reset) begin // @[DoCE.scala 177:25]
      bit_sent <= 16'h0; // @[DoCE.scala 177:25]
    end else if (w_channel_out_s_axis_tvalid & w_channel_out_s_axis_tready) begin // @[DoCE.scala 212:83]
      if (w_channel_out_s_axis_tlast) begin // @[DoCE.scala 213:49]
        bit_sent <= 16'h0; // @[DoCE.scala 214:16]
      end else begin
        bit_sent <= _bit_sent_T_1; // @[DoCE.scala 216:16]
      end
    end else if (aw_channel_out_s_axis_tvalid & aw_channel_out_s_axis_tready) begin // @[DoCE.scala 218:91]
      bit_sent <= _bit_sent_T_3; // @[DoCE.scala 219:14]
    end
    if (reset) begin // @[DoCE.scala 191:20]
      mid_w <= 512'h0; // @[DoCE.scala 191:20]
    end else if (_T) begin // @[DoCE.scala 222:61]
      mid_w <= in_m_axis_tdata; // @[DoCE.scala 223:11]
    end
    if (reset) begin // @[DoCE.scala 195:26]
      mid_count <= 16'h0; // @[DoCE.scala 195:26]
    end else if (in_m_axis_tvalid & in_m_axis_tready) begin // @[DoCE.scala 196:61]
      if (mid_count == 16'h0) begin // @[DoCE.scala 197:28]
        mid_count <= {{6'd0}, _GEN_0};
      end else if (in_m_axis_tlast) begin // @[DoCE.scala 204:40]
        mid_count <= 16'h0; // @[DoCE.scala 205:19]
      end else begin
        mid_count <= _mid_count_T_1; // @[DoCE.scala 207:19]
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
  _RAND_1 = {16{`RANDOM}};
  mid_w = _RAND_1[511:0];
  _RAND_2 = {1{`RANDOM}};
  mid_count = _RAND_2[15:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
