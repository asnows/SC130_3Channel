`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/03 09:56:42
// Design Name: 
// Module Name: opencv_model
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


module opencv_model
    #(
        parameter DATA_WIDTH = 10,
        parameter IMG_WIDTH  = 640,
        parameter IMG_HEIGHT = 480
    )
    (
        input       pixel_clk       ,
        input       resetn          ,
        input[3:0]  debug_cmd       ,
        input       sobel_enable    ,
        input[7:0]  sobel_threshold ,
        input[1:0]  sobel_kernel    ,
        
        input       s_axis_tlast    ,
        input       s_axis_tuser    ,
        input       s_axis_tvalid   , 
        input     [DATA_WIDTH-1:0] s_axis_tdata    ,
        output      s_axis_tready  	,
        
        input      m_axis_tready   	,
        output reg m_axis_tlast    	,
        output reg m_axis_tuser    	,
        output reg m_axis_tvalid   	,
        output reg[31:0] m_axis_tdata
    );
 
    reg                 resetn_dly1          ;
    reg                 sobel_enable_dly1    ;
    reg[7:0]            sobel_threshold_dly1 ;
    reg[1:0]            sobel_kernel_dly1    ;
    
    reg                 s_axis_tlast_dly1    ;
    reg                 s_axis_tuser_dly1    ;
    reg                 s_axis_tvalid_dly1   ;
    reg[DATA_WIDTH-1:0] s_axis_tdata_dly1    ;
       
    wire                 sobel_m_axis_tlast    ;           
    wire                 sobel_m_axis_tuser    ;           
    wire                 sobel_m_axis_tvalid   ;           
    wire[DATA_WIDTH-1:0] sobel_m_axis_tdata,sobelx_m_axis_tdata,sobely_m_axis_tdata    ;
    wire[DATA_WIDTH-1:0] sobel_m_axis_raw_tdata;
    
    // wire                 hls_sobel_m_axis_tlast    ;           
    // wire                 hls_sobel_m_axis_tuser    ;           
    // wire                 hls_sobel_m_axis_tvalid   ;           
    // wire[7:0]            hls_sobel_m_axis_tdata    ;
    
 
    always@(posedge pixel_clk )
    begin
        resetn_dly1 <= resetn;
        sobel_enable_dly1    <= sobel_enable   ;
        sobel_threshold_dly1 <= sobel_threshold;
        sobel_kernel_dly1    <= sobel_kernel   ;       
       
        s_axis_tlast_dly1    <= s_axis_tlast   ;
        s_axis_tuser_dly1    <= s_axis_tuser   ;
        s_axis_tvalid_dly1   <= s_axis_tvalid  ;
        s_axis_tdata_dly1    <= s_axis_tdata   ;    
    end 
 
    sobel_axis 
    #(
        .DATA_WIDTH(DATA_WIDTH),
        .IMG_WIDTH (IMG_WIDTH ),
        .IMG_HEIGHT(IMG_HEIGHT)
    )
    sobel_axis_i
    (
        .pixel_clk(pixel_clk)       ,
        .enable         (sobel_enable_dly1   ),
        .edge_selelct   (1'b1),           
        .threshold      (sobel_threshold_dly1),
        .kernel         (sobel_kernel_dly1   ) ,
        .s_axis_tdata   (s_axis_tdata_dly1   ),
        .s_axis_tlast   (s_axis_tlast_dly1   ),
        .s_axis_tuser   (s_axis_tuser_dly1   ),
        .s_axis_tvalid  (s_axis_tvalid_dly1  ),
        
        .m_axis_tlast    (sobel_m_axis_tlast    ),
        .m_axis_tuser    (sobel_m_axis_tuser    ),
        .m_axis_tvalid   (sobel_m_axis_tvalid   ),
        .m_axis_tdata    (sobel_m_axis_tdata    ),
        .mx_axis_tdata   (sobelx_m_axis_tdata    ),
        .my_axis_tdata   (sobely_m_axis_tdata    ),
        .m_axis_raw_tdata(sobel_m_axis_raw_tdata)
               
    );
    
//    sobel_filter_2 hls_sobel
//    (
//        .video_in_TVALID  (s_axis_tvalid_dly1     ),
//        .video_in_TREADY  (                       ),
//        .video_in_TDATA   (s_axis_tdata_dly1[DATA_WIDTH-1 : 2]),
//        .video_in_TKEEP   (1'b1                   ),
//        .video_in_TSTRB   (                       ),
//        .video_in_TUSER   (s_axis_tuser_dly1      ),
//        .video_in_TLAST   (s_axis_tlast_dly1      ),
//        .video_in_TID     (                       ),
//        .video_in_TDEST   (                       ),
//        .video_out_TVALID (hls_sobel_m_axis_tvalid),
//        .video_out_TREADY (1'b1                   ),
//        .video_out_TDATA  (hls_sobel_m_axis_tdata ),
//        .video_out_TKEEP  (                       ),
//        .video_out_TSTRB  (                       ),
//        .video_out_TUSER  (hls_sobel_m_axis_tuser ),
//        .video_out_TLAST  (hls_sobel_m_axis_tlast ),
//        .video_out_TID    (                       ),
//        .video_out_TDEST  (                       ),
//        .ap_clk           (pixel_clk              ),
//        .ap_rst_n         (resetn_dly1            ),
//        .ap_start         (resetn_dly1            ),
//        .ap_done          (                       ),
//        .ap_ready         (                       ),
//        .ap_idle          (                       )
//    );
    
    

    always@(posedge pixel_clk)
    begin
           case(debug_cmd)
           4'b0000:
           begin
                m_axis_tlast    <= sobel_m_axis_tlast    ;
                m_axis_tuser    <= sobel_m_axis_tuser    ;
                m_axis_tvalid   <= sobel_m_axis_tvalid   ;
                m_axis_tdata    <= {sobely_m_axis_tdata[9:2],sobelx_m_axis_tdata[9:2],sobel_m_axis_raw_tdata[9:2],sobel_m_axis_raw_tdata[9:2]};
            end
            4'b0001:
           begin
                m_axis_tlast    <= sobel_m_axis_tlast    ;
                m_axis_tuser    <= sobel_m_axis_tuser    ;
                m_axis_tvalid   <= sobel_m_axis_tvalid   ;
                m_axis_tdata    <= {sobely_m_axis_tdata[9:2],sobelx_m_axis_tdata[9:2],sobel_m_axis_raw_tdata[9:2],sobelx_m_axis_tdata[9:2]};
            end
            4'b0010:
           begin  
                m_axis_tlast    <= sobel_m_axis_tlast    ;
                m_axis_tuser    <= sobel_m_axis_tuser    ;
                m_axis_tvalid   <= sobel_m_axis_tvalid   ;
                m_axis_tdata    <= {sobely_m_axis_tdata[9:2],sobelx_m_axis_tdata[9:2],sobel_m_axis_raw_tdata[9:2],sobely_m_axis_tdata[9:2]};
            end
            4'b0011:
           begin  
                m_axis_tlast    <= sobel_m_axis_tlast    ;
                m_axis_tuser    <= sobel_m_axis_tuser    ;
                m_axis_tvalid   <= sobel_m_axis_tvalid   ;
                m_axis_tdata    <= {sobely_m_axis_tdata[9:2],sobelx_m_axis_tdata[9:2],sobel_m_axis_raw_tdata[9:2],sobel_m_axis_tdata[9:2]};
            end
            default:
            begin
                m_axis_tlast    <= sobel_m_axis_tlast    ;
                m_axis_tuser    <= sobel_m_axis_tuser    ;
                m_axis_tvalid   <= sobel_m_axis_tvalid   ;
                m_axis_tdata    <= {sobely_m_axis_tdata[9:2],sobelx_m_axis_tdata[9:2],sobel_m_axis_raw_tdata[9:2],sobel_m_axis_raw_tdata[9:2]};
            end
            endcase
    end
    

endmodule
