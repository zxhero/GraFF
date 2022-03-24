`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2021 07:47:55 PM
// Design Name: 
// Module Name: padding_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module padding_tb(

    );

  reg				gt_txusrclk;

/* IP cores reset signals */
  reg        peripheral_reset;

    initial
    begin
        gt_txusrclk = 0;
        forever #500.000   gt_txusrclk = ~ gt_txusrclk;
    end

    initial
    begin
        peripheral_reset = 1;
        #5000.000   peripheral_reset = 0;
        
        
    end

    parameter VALID_LASTING = 1;
    //reg [511:0] deoi_axis_tdata;
    reg deoi_axis_tvalid;
    wire deoi_axis_tlast;
    wire [63:0] deoi_axis_tkeep;
    wire deoi_axis_tready;

    reg [26:0] cnt;

    always @(posedge gt_txusrclk) begin
       if(peripheral_reset)
         cnt <= 'd0;
      else if(deoi_axis_tvalid & deoi_axis_tready & deoi_axis_tlast)
         cnt <= 'd0;
      else if(deoi_axis_tvalid & deoi_axis_tready)
        cnt <= cnt + 'd1;
      else
         cnt <= cnt;
    end

    always @(posedge gt_txusrclk) begin
       if(peripheral_reset)
         deoi_axis_tvalid <= 'd0;
      else if(deoi_axis_tvalid == 1'b0)
         deoi_axis_tvalid <= 1'b1;
      else if(cnt == VALID_LASTING)
         deoi_axis_tvalid <= 1'b0;
      else
        deoi_axis_tvalid <= deoi_axis_tvalid;
    end

    assign deoi_axis_tlast = cnt == VALID_LASTING;
    assign deoi_axis_tkeep = (cnt == VALID_LASTING) ? 'h7ffffffffff : 'hffffffffffffffff;

    tx_interface u_interface(
.aclk                       (gt_txusrclk),
.reset                      (peripheral_reset),
    
.deoi_axis_tdata            ({32'h00004600, 96'd122248}),
.deoi_axis_tvalid           (deoi_axis_tvalid),
.deoi_axis_tlast            (deoi_axis_tlast),
.deoi_axis_tkeep            (deoi_axis_tkeep),
.deoi_axis_tready           (deoi_axis_tready),
.eth_axis_tdata             (),
.eth_axis_tvalid            (),
.eth_axis_tlast             (),
.eth_axis_tkeep             (),
.eth_axis_tuser             (),
.eth_axis_tready            (1'b1)
    );
endmodule
