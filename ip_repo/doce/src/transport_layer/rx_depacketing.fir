;buildInfoPackage: chisel3, version: 3.4.3, scalaVersion: 2.12.12, sbtVersion: 1.3.10
circuit rx_depacketing : 
  module rx_depacketing : 
    input clock : Clock
    input reset : UInt<1>
    output io : {axis_str_to_trans : {flip ready : UInt<1>, valid : UInt<1>, bits : {tdata : UInt<128>, tkeep : UInt<4>, tlast : UInt<1>}}, flip axi_str_from_router : {flip ready : UInt<1>, valid : UInt<1>, bits : {tdata : UInt<128>, tkeep : UInt<4>, tlast : UInt<1>}}}
    
    io.axis_str_to_trans.bits.tlast <= io.axi_str_from_router.bits.tlast @[DoCE.scala 272:26]
    io.axis_str_to_trans.bits.tkeep <= io.axi_str_from_router.bits.tkeep @[DoCE.scala 272:26]
    io.axis_str_to_trans.bits.tdata <= io.axi_str_from_router.bits.tdata @[DoCE.scala 272:26]
    io.axis_str_to_trans.valid <= io.axi_str_from_router.valid @[DoCE.scala 272:26]
    io.axi_str_from_router.ready <= io.axis_str_to_trans.ready @[DoCE.scala 272:26]
    
