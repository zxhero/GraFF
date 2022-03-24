`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2019 11:20:17 AM
// Design Name: 
// Module Name: tx_interface
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


module tx_interface(
    input aclk,
    input reset,
    
    input [511:0] deoi_axis_tdata,
    input deoi_axis_tvalid,
    input deoi_axis_tlast,
    input [63:0] deoi_axis_tkeep,
    output deoi_axis_tready,

    output [511:0] eth_axis_tdata,
    output eth_axis_tvalid,
    output eth_axis_tlast,
    output [63:0] eth_axis_tkeep,
    output eth_axis_tuser,
    input eth_axis_tready
    );
    
    reg [26:0] cnt;

    always @(posedge aclk) begin
       if(reset)
         cnt <= 'd0;
      else if(deoi_axis_tvalid & deoi_axis_tready & deoi_axis_tlast)
         cnt <= 'd0;
      else if(deoi_axis_tvalid & deoi_axis_tready)
         cnt <= cnt + 'd1;
      else
         cnt <= cnt;
    end
   
    assign eth_axis_tvalid = reset ? 'b0 : deoi_axis_tvalid;
    assign eth_axis_tlast = deoi_axis_tlast;
    assign eth_axis_tkeep = (cnt == 'd0) ? 'hffffffffffffffff : deoi_axis_tkeep;
    assign eth_axis_tuser = 'b0;
    assign deoi_axis_tready = eth_axis_tready;
    wire [511:0] Intermediate_tdata;
    wire [7:0] size;
    assign size = Intermediate_tdata[111:104];
    assign eth_axis_tdata = (cnt == 'd0 && size < 'h32) ? {Intermediate_tdata[511:128], 32'h00003200, Intermediate_tdata[95:0]} 
                                          : Intermediate_tdata;

    genvar i;
    generate
       for(i = 0; i < 64;i = i+1)
       begin
          assign Intermediate_tdata[8 * (i+1) - 1 : 8 * i] = deoi_axis_tkeep[i] ? deoi_axis_tdata[8 * (i+1) - 1 : 8 * i] : 8'b0;
       end
    endgenerate

    
endmodule
