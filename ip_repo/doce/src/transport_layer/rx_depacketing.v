module rx_depacketing(
  input          clock,
  input          reset,
  input          io_axis_str_to_trans_ready,
  output         io_axis_str_to_trans_valid,
  output [127:0] io_axis_str_to_trans_bits_tdata,
  output [3:0]   io_axis_str_to_trans_bits_tkeep,
  output         io_axis_str_to_trans_bits_tlast,
  output         io_axi_str_from_router_ready,
  input          io_axi_str_from_router_valid,
  input  [127:0] io_axi_str_from_router_bits_tdata,
  input  [3:0]   io_axi_str_from_router_bits_tkeep,
  input          io_axi_str_from_router_bits_tlast
);
  assign io_axis_str_to_trans_valid = io_axi_str_from_router_valid; // @[DoCE.scala 272:26]
  assign io_axis_str_to_trans_bits_tdata = io_axi_str_from_router_bits_tdata; // @[DoCE.scala 272:26]
  assign io_axis_str_to_trans_bits_tkeep = io_axi_str_from_router_bits_tkeep; // @[DoCE.scala 272:26]
  assign io_axis_str_to_trans_bits_tlast = io_axi_str_from_router_bits_tlast; // @[DoCE.scala 272:26]
  assign io_axi_str_from_router_ready = io_axis_str_to_trans_ready; // @[DoCE.scala 272:26]
endmodule
