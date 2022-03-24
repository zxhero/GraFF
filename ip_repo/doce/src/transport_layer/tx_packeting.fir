;buildInfoPackage: chisel3, version: 3.4.3, scalaVersion: 2.12.12, sbtVersion: 1.3.10
circuit tx_packeting : 
  module tx_packeting : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip axis_rd_from_fsm : {flip ready : UInt<1>, valid : UInt<1>, bits : {tdata : UInt<128>, tkeep : UInt<16>, tlast : UInt<1>}}, axi_str_to_router : {flip ready : UInt<1>, valid : UInt<1>, bits : {tdata : UInt<128>, tkeep : UInt<16>, tlast : UInt<1>}}}
    
    io.axi_str_to_router.bits.tlast <= io.axis_rd_from_fsm.bits.tlast @[DoCE.scala 247:26]
    io.axi_str_to_router.bits.tkeep <= io.axis_rd_from_fsm.bits.tkeep @[DoCE.scala 247:26]
    io.axi_str_to_router.bits.tdata <= io.axis_rd_from_fsm.bits.tdata @[DoCE.scala 247:26]
    io.axi_str_to_router.valid <= io.axis_rd_from_fsm.valid @[DoCE.scala 247:26]
    io.axis_rd_from_fsm.ready <= io.axi_str_to_router.ready @[DoCE.scala 247:26]
    
