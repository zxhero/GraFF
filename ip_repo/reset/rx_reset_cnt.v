`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/08/2019 10:08:56 AM
// Design Name: 
// Module Name: rx_reset_cnt
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


module rx_reset_cnt(
    input clk,
    input reset,
    input rx_status,
    //input rx_aligned,
    
    //output channel_up,
    output gtwiz_rx_reset
    );
    
    
    /*localparam state1 = 4'b0001;
    localparam state2 = 4'b0010;
    localparam state3 = 4'b0100;
    localparam state4 = 4'b1000;
   
    reg [2:0] state = state1;
    reg [31:0] cnt;

   
    always @(posedge clk)
       if (reset)
       begin
          state <= state1;
          cnt <= 'd0;
       end
       else
          case (state)
             state1 : begin
                cnt <= cnt + 1;
                if (cnt > 32'd100000000) begin
                   state <= state2;
                   cnt <= 'd0;
                end
             end
             state2 : begin
                cnt <= cnt + 1;
                if (cnt[5]) begin
                  if (rx_status == 1'b1 && rx_aligned == 1'b1) begin
                     state <= state3;
                     cnt <= 'd0;
                  end
                  else begin
                     state <= state1;
                     cnt <= 'd0;
                  end
                end
                
             end
             state3 : begin
                cnt <= cnt + 1;
                if (cnt > 32'd100000000) begin
                   state <= state4;
                   cnt <= 'd0;
                end
             end
             state4 : begin
                if (rx_status == 1'b1 && rx_aligned == 1'b1) begin
                     state <= state4;
                end
                else begin
                   state <= state2;
                end
             end
             default : begin  // Fault Recovery
                state <= state1;
             end
          endcase
   
    assign gtwiz_rx_reset = state[1];*/
    localparam state1 = 3'b001;
    localparam state2 = 3'b010;
    localparam state3 = 3'b100;
   
    reg [2:0] state = state1;
    reg [26:0] cnt;
   
    always @(posedge clk)
       if (reset)
       begin
          state <= state1;
          cnt <= 'd0;
       end
       else
          case (state)
             state1 : begin
                cnt <= cnt + 1;
                if (cnt[5]) begin
                   state <= state2;
                   cnt <= 'd0;
                end
             end
             state2 : begin
                cnt <= cnt + 1;
                if (cnt[26]) begin
                     state <= state3;
                     cnt <= 'd0;
                end
             end
             state3 : begin
                if (rx_status)
                   state <= state3;
                else
                   state <= state1;
             end
             default : begin  // Fault Recovery
                state <= state1;
             end
          endcase
   
    assign gtwiz_rx_reset = state[0];
    //assign channel_up = state[2];
                             
    
endmodule
