module tx_packeting(
  input          clock,
  input          reset,
  output         io_axis_rd_from_fsm_ready,
  input          io_axis_rd_from_fsm_valid,
  input  [127:0] io_axis_rd_from_fsm_bits_tdata,
  input  [15:0]  io_axis_rd_from_fsm_bits_tkeep,
  input          io_axis_rd_from_fsm_bits_tlast,
  input          io_axi_str_to_router_ready,
  output         io_axi_str_to_router_valid,
  output [127:0] io_axi_str_to_router_bits_tdata,
  output [15:0]  io_axi_str_to_router_bits_tkeep,
  output         io_axi_str_to_router_bits_tlast
);
  assign io_axis_rd_from_fsm_ready = io_axi_str_to_router_ready; // @[DoCE.scala 247:26]
  assign io_axi_str_to_router_valid = io_axis_rd_from_fsm_valid; // @[DoCE.scala 247:26]
  assign io_axi_str_to_router_bits_tdata = io_axis_rd_from_fsm_bits_tdata; // @[DoCE.scala 247:26]
  assign io_axi_str_to_router_bits_tkeep = io_axis_rd_from_fsm_bits_tkeep; // @[DoCE.scala 247:26]
  assign io_axi_str_to_router_bits_tlast = io_axis_rd_from_fsm_bits_tlast; // @[DoCE.scala 247:26]
endmodule
