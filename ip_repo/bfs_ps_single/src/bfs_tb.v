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


module bfs_tb(

    );

  reg				gt_txusrclk;

/* IP cores reset signals */
  reg        peripheral_reset;
  reg               doceclk;
  reg               cmacclk;
   //reg [19: 0] mem [15 : 0];
bfs_top u(

        .io_config_awaddr     (),
      .io_config_awvalid    ('b0),
      .io_config_awready    (),
      .io_config_araddr     (),
      .io_config_arvalid    ('b0),
      .io_config_arready    (),
      .io_config_wdata      (),
      .io_config_wstrb      (),
      .io_config_wvalid     ('b0),
      .io_config_wready     (),
      .io_config_rdata      (),
      .io_config_rresp      (),
      .io_config_rvalid     (),
      .io_config_rready     (1'b1),
      .io_config_bresp      (),
      .io_config_bvalid     (),
      .io_config_bready     (1'b1),
    .gt_txusrclk(gt_txusrclk),
    .peripheral_reset(peripheral_reset),
    .doceclk(doceclk),
    .cmacclk(cmacclk)
);


initial
    begin
        gt_txusrclk = 0;  
        //mem[2] = 'h174;
        //mem[3] = 'h3cd;
        //mem[4] = 'h11a;
        //mem[5] = 'h1a;
        //mem[6] = 'h28d;
        //mem[7] = 'h11a;
        //mem[8] = 'h46;
        forever #1000.000   gt_txusrclk = ~ gt_txusrclk;
    end
    
    initial
    begin
        doceclk = 0;
        forever #500.000   doceclk = ~ doceclk;
    end
    
    initial
    begin
        cmacclk = 0;
        forever #300.000   cmacclk = ~ cmacclk;
    end

    initial
    begin
        peripheral_reset = 1;
        #5000.000   peripheral_reset = 0;
        
        
    end
    


    /*integer out_file;
    initial begin
      out_file = $fopen ( "update.data" );
    end

    always @(posedge gt_txusrclk) begin
      if(u.u_BFS.Applys.update_engine_io_xbar_in_valid && u.u_BFS.Applys.update_engine_io_xbar_in_ready) begin
        $fwrite(out_file,"%t %d\n",$realtime,u.u_BFS.Applys.update_engine_io_xbar_in_bits_tdata);
        $display("%t %d\n",$realtime,u.u_BFS.Applys.update_engine_io_xbar_in_bits_tdata);
      end
      if('d3 == u.u_BFS.controls.status) begin
        $fclose("update.data");
        $stop;
      end
    end*/
    
    integer out_file;
    initial begin
      out_file = $fopen ( "update.data" );
    end

    always @(posedge gt_txusrclk) begin
      //if(u.u_BFS.LevelCache.vertex_update_buffer_0.m_axis_tvalid && u.u_BFS.LevelCache.vertex_update_buffer_0.m_axis_tready) begin
      //  $fwrite(out_file,"%t %d\n",$realtime,u.u_BFS.LevelCache.vertex_update_buffer_0.m_axis_tdata[63:32]);
      //  $display("%t %d\n",$realtime,u.u_BFS.LevelCache.vertex_update_buffer_0.m_axis_tdata[63:32]);
      //end
      //if(u.u_BFS.LevelCache.vertex_update_buffer_1.m_axis_tvalid && u.u_BFS.LevelCache.vertex_update_buffer_1.m_axis_tready) begin
      //  $fwrite(out_file,"%t %d\n",$realtime,u.u_BFS.LevelCache.vertex_update_buffer_1.m_axis_tdata[63:32]);
      //  $display("%t %d\n",$realtime,u.u_BFS.LevelCache.vertex_update_buffer_1.m_axis_tdata[63:32]);
      //end
      //if(u.u_BFS.LevelCache.vertex_update_buffer_2.m_axis_tvalid && u.u_BFS.LevelCache.vertex_update_buffer_2.m_axis_tready) begin
      //  $fwrite(out_file,"%t %d\n",$realtime,u.u_BFS.LevelCache.vertex_update_buffer_2.m_axis_tdata[63:32]);
      //  $display("%t %d\n",$realtime,u.u_BFS.LevelCache.vertex_update_buffer_2.m_axis_tdata[63:32]);
      //end
      //if(u.u_BFS.LevelCache.vertex_update_buffer_3.m_axis_tvalid && u.u_BFS.LevelCache.vertex_update_buffer_3.m_axis_tready) begin
      //  $fwrite(out_file,"%t %d\n",$realtime,u.u_BFS.LevelCache.vertex_update_buffer_3.m_axis_tdata[63:32]);
      //  $display("%t %d\n",$realtime,u.u_BFS.LevelCache.vertex_update_buffer_3.m_axis_tdata[63:32]);
      //end
      if('d3 == u.u_BFS.controls.status) begin
        $fclose("update.data");
        $finish;
      end
    end
endmodule
