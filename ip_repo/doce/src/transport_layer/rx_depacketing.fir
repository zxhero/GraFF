;buildInfoPackage: chisel3, version: 3.4.3, scalaVersion: 2.12.12, sbtVersion: 1.3.10
circuit rx_depacketing : 
  module trans_out_reg_slice : 
    input clock : Clock
    input reset : Reset
    output io : {dout : {flip ready : UInt<1>, valid : UInt<1>, bits : {tdata : UInt<512>, tkeep : UInt<64>, tlast : UInt<1>, tuser : UInt<4>}}, flip din : {flip ready : UInt<1>, valid : UInt<1>, bits : {tdata : UInt<512>, tkeep : UInt<64>, tlast : UInt<1>, tuser : UInt<4>}}}
    
    wire _data_WIRE : {tdata : UInt<512>, tkeep : UInt<64>, tlast : UInt<1>, tuser : UInt<4>} @[DoCE.scala 268:34]
    _data_WIRE.tuser <= UInt<4>("h00") @[DoCE.scala 268:34]
    _data_WIRE.tlast <= UInt<1>("h00") @[DoCE.scala 268:34]
    _data_WIRE.tkeep <= UInt<64>("h00") @[DoCE.scala 268:34]
    _data_WIRE.tdata <= UInt<512>("h00") @[DoCE.scala 268:34]
    reg data : {tdata : UInt<512>, tkeep : UInt<64>, tlast : UInt<1>, tuser : UInt<4>}, clock with : (reset => (reset, _data_WIRE)) @[DoCE.scala 268:21]
    reg valid : UInt<1>, clock with : (reset => (reset, UInt<1>("h00"))) @[DoCE.scala 269:22]
    node _T = eq(valid, UInt<1>("h00")) @[DoCE.scala 270:25]
    node _T_1 = or(io.dout.ready, _T) @[DoCE.scala 270:22]
    when _T_1 : @[DoCE.scala 270:32]
      data.tuser <= io.din.bits.tuser @[DoCE.scala 271:10]
      data.tlast <= io.din.bits.tlast @[DoCE.scala 271:10]
      data.tkeep <= io.din.bits.tkeep @[DoCE.scala 271:10]
      data.tdata <= io.din.bits.tdata @[DoCE.scala 271:10]
      valid <= io.din.valid @[DoCE.scala 272:11]
      skip @[DoCE.scala 270:32]
    node _io_din_ready_T = eq(valid, UInt<1>("h00")) @[DoCE.scala 275:36]
    node _io_din_ready_T_1 = or(io.dout.ready, _io_din_ready_T) @[DoCE.scala 275:33]
    io.din.ready <= _io_din_ready_T_1 @[DoCE.scala 275:16]
    io.dout.valid <= valid @[DoCE.scala 276:17]
    io.dout.bits.tuser <= data.tuser @[DoCE.scala 277:16]
    io.dout.bits.tlast <= data.tlast @[DoCE.scala 277:16]
    io.dout.bits.tkeep <= data.tkeep @[DoCE.scala 277:16]
    io.dout.bits.tdata <= data.tdata @[DoCE.scala 277:16]
    
  module rx_depacketing : 
    input clock : Clock
    input reset : UInt<1>
    output io : {axis_str_to_trans : {flip ready : UInt<1>, valid : UInt<1>, bits : {tdata : UInt<512>, tkeep : UInt<64>, tlast : UInt<1>, tuser : UInt<4>}}, flip axi_str_from_router : {flip ready : UInt<1>, valid : UInt<1>, bits : {tdata : UInt<512>, tkeep : UInt<64>, tlast : UInt<1>, tuser : UInt<4>}}}
    
    inst trans_out of trans_out_reg_slice @[DoCE.scala 345:27]
    trans_out.clock <= clock
    trans_out.reset <= reset
    trans_out.io.din.bits.tuser <= io.axi_str_from_router.bits.tuser @[DoCE.scala 346:22]
    trans_out.io.din.bits.tlast <= io.axi_str_from_router.bits.tlast @[DoCE.scala 346:22]
    trans_out.io.din.bits.tkeep <= io.axi_str_from_router.bits.tkeep @[DoCE.scala 346:22]
    trans_out.io.din.bits.tdata <= io.axi_str_from_router.bits.tdata @[DoCE.scala 346:22]
    trans_out.io.din.valid <= io.axi_str_from_router.valid @[DoCE.scala 346:22]
    io.axi_str_from_router.ready <= trans_out.io.din.ready @[DoCE.scala 346:22]
    node _io_axis_str_to_trans_valid_T = and(io.axi_str_from_router.valid, trans_out.io.dout.valid) @[DoCE.scala 349:36]
    node _io_axis_str_to_trans_valid_T_1 = mux(trans_out.io.dout.bits.tlast, trans_out.io.dout.valid, _io_axis_str_to_trans_valid_T) @[DoCE.scala 348:38]
    io.axis_str_to_trans.valid <= _io_axis_str_to_trans_valid_T_1 @[DoCE.scala 348:32]
    io.axis_str_to_trans.bits.tlast <= trans_out.io.dout.bits.tlast @[DoCE.scala 350:37]
    io.axis_str_to_trans.bits.tuser <= trans_out.io.dout.bits.tuser @[DoCE.scala 351:37]
    node io_axis_str_to_trans_bits_tdata_hi = bits(io.axi_str_from_router.bits.tdata, 127, 0) @[DoCE.scala 352:77]
    node io_axis_str_to_trans_bits_tdata_lo = bits(trans_out.io.dout.bits.tdata, 511, 128) @[DoCE.scala 353:35]
    node _io_axis_str_to_trans_bits_tdata_T = cat(io_axis_str_to_trans_bits_tdata_hi, io_axis_str_to_trans_bits_tdata_lo) @[Cat.scala 30:58]
    io.axis_str_to_trans.bits.tdata <= _io_axis_str_to_trans_bits_tdata_T @[DoCE.scala 352:37]
    node io_axis_str_to_trans_bits_tkeep_hi = bits(io.axi_str_from_router.bits.tkeep, 15, 0) @[DoCE.scala 354:77]
    node io_axis_str_to_trans_bits_tkeep_lo = bits(trans_out.io.dout.bits.tkeep, 63, 16) @[DoCE.scala 355:35]
    node _io_axis_str_to_trans_bits_tkeep_T = cat(io_axis_str_to_trans_bits_tkeep_hi, io_axis_str_to_trans_bits_tkeep_lo) @[Cat.scala 30:58]
    io.axis_str_to_trans.bits.tkeep <= _io_axis_str_to_trans_bits_tkeep_T @[DoCE.scala 354:37]
    node _trans_out_io_dout_ready_T = and(io.axis_str_to_trans.valid, io.axis_str_to_trans.ready) @[DoCE.scala 356:59]
    trans_out.io.dout.ready <= _trans_out_io_dout_ready_T @[DoCE.scala 356:29]
    
