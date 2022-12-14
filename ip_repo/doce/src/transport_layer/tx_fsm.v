/* =====================================================================
* DoCE Transport Layer Wrapper
*
* Author: Ran Zhao (zhaoran@ict.ac.cn)
* Date: 03/07/2017
* Version: v0.0.1
*=======================================================================
*/

`timescale 1ps / 1ps

module tx_fsm #(
    parameter DATA_WIDTH       = 16   //Byte
)(
    input [DATA_WIDTH*8-1:0]  axi_str_tdata_from_trans,
    input [DATA_WIDTH-1:0]   axi_str_tkeep_from_trans,
    input          axi_str_tvalid_from_trans,
    input          axi_str_tlast_from_trans,
    input [16:0]   axi_str_tuser_from_trans,
	output		   axi_str_tready_to_trans,

	input          axi_str_tready_from_router,
    output [DATA_WIDTH*8-1:0] axi_str_tdata_to_router,   
    output [DATA_WIDTH-1:0]  axi_str_tkeep_to_router,   
    output         axi_str_tvalid_to_router,
    output         axi_str_tlast_to_router,
		
	output [3:0]   trans_axis_txd_tuser,
	input [47:0]   tx_dst_mac_addr,
	input [47:0]   doce_mac_addr,
	input [31:0]   doce_ip_addr,
	
    input          user_clk,
    input          reset
);

  //Wire declaration
  wire                       axis_rd_tlast;
  wire                       axis_rd_tvalid;
  wire [DATA_WIDTH*8-1:0]               axis_rd_tdata;
  wire [DATA_WIDTH-1:0]                axis_rd_tkeep;
  wire                       axis_wr_tlast;
  wire                       axis_wr_tvalid;
  wire [DATA_WIDTH*8-1:0]               axis_wr_tdata;
  wire [DATA_WIDTH-1:0]                axis_wr_tkeep;

  wire [127:0]               mac_header;
  wire                       axis_wr_tready;
  
  wire						 cmd_rd_valid;
  wire						 cmd_wr_ready;
  
  wire  [15:0]  			 frame_len;

  //Reg declaration
  reg  [DATA_WIDTH*8-1:0]	axi_str_tdata_from_trans_r;
  reg  [DATA_WIDTH-1:0]	axi_str_tkeep_from_trans_r;
  reg  [16:0]	axi_str_tuser_from_trans_r;
  reg			axi_str_tlast_from_trans_r; 
  reg  		   	axi_str_tvalid_from_trans_r;
  
  reg          		cmd_wr_valid=1'b0;
  reg          		cmd_rd_ready=1'b0;
  reg          		axis_rd_tready='d0 ;
  reg 				axis_rd_tvalid_from_fsm;
  reg  [512:0]		axis_rd_tdata_from_fsm;
  reg  [64:0]		axis_rd_tkeep_from_fsm;
  reg				axis_rd_tlast_from_fsm;
  wire              axis_rd_tready_to_fsm;
 
  localparam
     //states for Read FSM
     READ_MAC_HEADER   = 2'b01,
     BEGIN_READ    = 2'b10;

  reg  [1:0]   state_rd = READ_MAC_HEADER;
  reg   [2:0]  state_count;
  always @(posedge user_clk) begin
    if(reset | state_rd == READ_MAC_HEADER)
      state_count <= 'd0;
    else if(state_rd == BEGIN_READ)
      state_count <= state_count + 'd1;
    else
      state_count <= state_count;
  end

  assign trans_axis_txd_tuser = axi_str_tuser_from_trans[3:0] & {4{axi_str_tvalid_from_trans}};

  assign frame_len = {3'd0, axi_str_tuser_from_trans_r[16:4]} + 'd2;
  
  assign axis_wr_tvalid = axi_str_tvalid_from_trans_r & axis_wr_tready & cmd_wr_ready; 
  assign axis_wr_tlast  = axi_str_tlast_from_trans_r; 
  assign axis_wr_tkeep  = axi_str_tkeep_from_trans_r; 
  assign axis_wr_tdata  = axi_str_tdata_from_trans_r;
  assign axi_str_tready_to_trans  = (axis_wr_tready & cmd_wr_ready);
  
  always @(posedge user_clk)
  begin
    if(axi_str_tready_to_trans) begin
      axi_str_tdata_from_trans_r   <= axi_str_tdata_from_trans;
      axi_str_tkeep_from_trans_r   <= axi_str_tkeep_from_trans;
      axi_str_tvalid_from_trans_r  <= axi_str_tvalid_from_trans;
      axi_str_tuser_from_trans_r	 <= axi_str_tuser_from_trans;
		  axi_str_tlast_from_trans_r   <= axi_str_tlast_from_trans;
    end
  end
  
  reg pkt_firstbeat;
  always @(posedge user_clk)
  begin
	  if(reset)
		  pkt_firstbeat <= 1;
	  else if(axi_str_tready_to_trans & axi_str_tvalid_from_trans)
		  pkt_firstbeat <= axi_str_tlast_from_trans;
	  else
		  pkt_firstbeat <= pkt_firstbeat;
  end

  (*dont_touch = "true" *)reg [31: 0] packet_send;
  always @(posedge user_clk) begin
      if(reset)
          packet_send <= 'd0;
      else if(cmd_wr_valid && cmd_wr_ready)
          packet_send <= packet_send + 'd1;
      else
          packet_send <= packet_send;
  end

   
	always @(posedge user_clk)
	begin
		if(reset)
		begin
			cmd_wr_valid <= 1'b0;
		end
		else
		begin
			cmd_wr_valid <= pkt_firstbeat & axi_str_tvalid_from_trans & axis_wr_tready & cmd_wr_ready; 
		end
	end					

  always @(posedge user_clk)
  begin
	if(reset)
	begin
		state_rd  <= READ_MAC_HEADER;
	end
	else
	begin
		case(state_rd)
		  READ_MAC_HEADER : begin 
						if(cmd_rd_ready & cmd_rd_valid)
							state_rd <= BEGIN_READ;
						else
							state_rd <= READ_MAC_HEADER;
					 end
		  BEGIN_READ : begin
						 //Continue reading data until tlast from XGEMAC is received     
						 if(axis_rd_tlast & axis_rd_tvalid & axis_rd_tready)
						 begin
							  state_rd                <= READ_MAC_HEADER;
						 end 
						 else
						 begin
							  state_rd                <= BEGIN_READ;
						 end 
					 end
		  default    :   state_rd                <= READ_MAC_HEADER;
	 endcase
	end
  end     
 
  always @ *
  begin
       if(state_rd==READ_MAC_HEADER)
       begin 
			axis_rd_tready          <= 1'b0;
			axis_rd_tvalid_from_fsm <= cmd_rd_valid;
			axis_rd_tdata_from_fsm	<= {mac_header, {(513-128){1'b0}}};
			axis_rd_tkeep_from_fsm	<= {16'hffff, {(65-16){1'b0}}};
			axis_rd_tlast_from_fsm	<= 1'b0;
			cmd_rd_ready			<= axis_rd_tready_to_fsm;
       end  
       else if(state_rd==BEGIN_READ)
       begin
			axis_rd_tready          <= axis_rd_tready_to_fsm;
			axis_rd_tvalid_from_fsm <= axis_rd_tvalid;
			axis_rd_tdata_from_fsm	<= {axis_rd_tdata, {(513-DATA_WIDTH*8){1'b0}}};
			axis_rd_tkeep_from_fsm	<= {axis_rd_tkeep, {(65-DATA_WIDTH){1'b0}}};
			axis_rd_tlast_from_fsm	<= axis_rd_tlast;			
			cmd_rd_ready			<= 1'b0;
       end 
       else
       begin
			axis_rd_tdata_from_fsm	<= 513'd0;
			axis_rd_tready          <= 1'b0; 
			axis_rd_tvalid_from_fsm <= 1'b0;
			axis_rd_tkeep_from_fsm	<= 65'd0;
			axis_rd_tlast_from_fsm	<= 1'b0;
			cmd_rd_ready			<= 1'b0;
       end
  end

  // Data FIFO instance: AXI Stream FIFO
  axis_data_fifo axis_fifo_inst1 (
    .m_axis_tready        (axis_rd_tready           ),
    .s_axis_aresetn       (~reset                   ),
    .s_axis_tready        (axis_wr_tready			),
    .s_axis_aclk          (user_clk                 ),
    .s_axis_tvalid        (axis_wr_tvalid           ),
    .m_axis_tvalid        (axis_rd_tvalid           ),
    .m_axis_tlast         (axis_rd_tlast            ),
    .s_axis_tlast         (axis_wr_tlast            ),
    .s_axis_tdata         (axis_wr_tdata            ),
    .m_axis_tdata         (axis_rd_tdata            ),
    .s_axis_tkeep         (axis_wr_tkeep            ),
    .m_axis_tkeep         (axis_rd_tkeep            )
  );

  // Command FIFO
  axis_cmd_fifo cmd_fifo_inst (
	.s_axis_aclk         (user_clk   	),
	.s_axis_aresetn      (~reset      	),
	.s_axis_tdata        ({packet_send[15:0], frame_len[7:0], frame_len[15:8], doce_mac_addr, tx_dst_mac_addr}), // Bus [127 : 0]  
	.s_axis_tvalid       (cmd_wr_valid  ),
	.s_axis_tready       (cmd_wr_ready  ),
	.m_axis_tdata        (mac_header 	), // Bus [127 : 0]  
	.m_axis_tvalid		 (cmd_rd_valid	),
	.m_axis_tready       (cmd_rd_ready  )
  );

  tx_packeting tx_packeting_inst(
    .clock                              (user_clk),
    .reset                              (reset),
    .io_axis_rd_from_fsm_ready          (axis_rd_tready_to_fsm),
    .io_axis_rd_from_fsm_valid          (axis_rd_tvalid_from_fsm),
    .io_axis_rd_from_fsm_bits_tdata     (axis_rd_tdata_from_fsm[512 : 513-DATA_WIDTH*8]), 
    .io_axis_rd_from_fsm_bits_tkeep     (axis_rd_tkeep_from_fsm[64 : 65-DATA_WIDTH]), 
    .io_axis_rd_from_fsm_bits_tlast     (axis_rd_tlast_from_fsm), 
    .io_axi_str_to_router_ready         (axi_str_tready_from_router),
    .io_axi_str_to_router_valid         (axi_str_tvalid_to_router),
    .io_axi_str_to_router_bits_tdata    (axi_str_tdata_to_router),
    .io_axi_str_to_router_bits_tkeep    (axi_str_tkeep_to_router),
    .io_axi_str_to_router_bits_tlast    (axi_str_tlast_to_router)
  );
   
endmodule
