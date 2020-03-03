`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/15 16:03:30
// Design Name: 
// Module Name: top_tb
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
`define GET_VGA_INFO  

module top_tb(

    );
    
    reg clk_100m = 0;
    reg clk_25m = 0;
    reg  resetn = 0;
    wire reset ;
    wire pixel_clk;
    
    wire hsync_out        ;
    wire hblank_out       ;
    wire vsync_out        ;
    wire vblank_out       ;
    wire active_video_out ;
    reg [9:0] count = 8'd0;
    reg [12:0] img_widh = 13'd640;
    
  
    reg [9:0] testData = 2'd0;
    
    parameter LH = 1'b01;
    parameter HL = 1'b01;
  
    
    reg vsync_tmp;
    
    reg [31:0] pixels_count_back;
    reg [31:0] pixels_high_back;
    reg [31:0] pixels_low_back;
    reg [1:0] vsync_reg;
    reg [1:0] href_reg;
    wire vga_vsync ;
    wire vga_href  ;
    
    assign reset = ~resetn;
    assign pixel_clk = clk_25m;
       
    always 
    begin
        #0.5 clk_100m = 0;
        #0.5 clk_100m = 1;
    end
    
    always 
    begin
        #2 clk_25m = 0;
        #2 clk_25m = 1;
    end
    
    initial
    begin
        #100 resetn = 1;
    end
    
    always@(posedge pixel_clk)
    begin
        if(vsync_out == 1)
            begin
                count <= 8'd0 ;  
            end
        else if(active_video_out == 1)
            
            count <= count + 1;
        else
            count <= 8'd0 ;         
    end
    
    always@(posedge pixel_clk)
    begin
        if(vsync_out == 1)
            begin
                testData <= 8'd0 ;  
            end
        else if(active_video_out == 1)
            
            testData <= $random % 1024;
        else
            testData <= 8'd0 ;         
    end
    
  
    
    
 `ifdef  GET_VGA_INFO  
 
    v_tc_0 v_tc_0_i
    (
    .clk                 (pixel_clk         ),
    .clken               (1'b1            ),
    .gen_clken           (1'b1            ),
    .hsync_out           (hsync_out       ),
    .hblank_out          (hblank_out      ),
    .vsync_out           (vsync_out       ),
    .vblank_out          (vblank_out      ),
    .active_video_out    (active_video_out),
    .resetn              (resetn          ),
    .fsync_out           (                )
    );
    
    always@(posedge pixel_clk)
    begin
        vsync_reg <= {vsync_reg[0],vsync_out};
        href_reg <=  {href_reg[0],active_video_out};
    end
        
    always@(posedge pixel_clk)
    begin
        if(vsync_reg == LH)
        begin
            pixels_count_back <= 32'd0;
        end
        else
        begin
            pixels_count_back <= pixels_count_back + 1'b1;
        end
    end
    
    always@(posedge pixel_clk)
    begin
        if(active_video_out == 1'b1)
        begin
            pixels_high_back <= pixels_high_back + 1'b1;
        end
        else
        begin
            pixels_high_back <= 32'd0;
        end
    end
    
    always@(posedge pixel_clk)
    begin
        if(active_video_out == 1'b0)
        begin
            pixels_low_back <= pixels_low_back + 1'b1;
        end
        else
        begin
            pixels_low_back <= 32'd0;
        end
    end
    
 `else   
    
  vga_timing_gen vga_timing_gen_i
    (
        .pixel_clk(pixel_clk),
        .resetn(resetn),
        .vsync_out(vsync_out),
        .href_out (active_video_out )
    );
  
`endif  







    
//    video_caputure vcap_i
//        (
//            .piexl_clk (clk_25m         ),
//            .href      (active_video_out),
//            .vsync     (vsync_out       ),
//            .data_in    (count),
//            .img_width  (img_widh),
            
//            .rest         (reset),
//            .m_axis_clk   (   ),
//            .m_axis_tdata (   ),
//            .m_axis_tlast (   ),
//            .m_axis_tready(   ),
//            .m_axis_tuser (   ),
//            .m_axis_tvalid(   )  
//        );  
        


//    histogram histogram_i
//    (
//       .pixel_clk(clk_25m         ),
//       .href(active_video_out),
//       .vsync(vsync_out       ),
//       .data_in(8'h0c),
////       .data_in(count),
//       .hist_en(1'b1),      
//       .hist_href(),
//       .hist_vsync(),
//       .data_out()
        
//    );
    

// cmos_10bit_2_8bit cmos_10bit_2_8bit_i
//    (
//       .pixel_clk(clk_25m),
//       .vsync(vsync_out       ),
//       .href(active_video_out),
//       .data_in(count),
//        .vsync_out(),
//        .href_out(),
//        .data_out()
//    );
//gray_line_conv gray_line_conv_i     
//    (
//    .pixel_clk(clk_25m),
//    .vsync(vsync_out       ),
//    .href(active_video_out),
//    .data_in(count),
//    .kFactor(8'd9),
//    .bFactor(8'd9),
//    .enable      (1'b1),
//    .vsync_out  (),
//    .href_out    (),
//    .data_out()

//);



// matrix_3x3 matrix_3x3_i
//    (
//    .pixel_clk(clk_25m),
//    .vsync(vsync_out       ),
//    .href(active_video_out),
//    .data_in(count),
//    .rest_n(resetn),
//    .line0_href (),
//    .line1_href (),
//    .line2_href (),
//    .line0_vsync(),
//    .line1_vsync(),
//    .line2_vsync(),
//    .matrix_01(),
//    .matrix_11(),
//    .matrix_21()
//    );
    
    
// cmos_dpc cmos_dpc_i
//    (
//    .pixel_clk(clk_100m),
//    .vsync(vsync_out       ),
//    .href(active_video_out),
//    .dpc_en(1'b1),
//    .data_in(testData),
//    .reset_n(resetn),
//    .thread(10'd80) ,   
//    .vsync_out(),
//    .href_out(),
//    .data_out()
//     );
     

     
//    isp_model isp_model_i
//    (
//        .pixel_clk(pixel_clk),
//        .reset_n(resetn),
//        .vsync(vga_vsync       ),
//        .href(vga_href),
//        .dpc_en(1'b1),
//        .gaus_en(1'b1),       
//        .gaus_shrap_en(1'b1), 
//        .data_in(testData),
//        .dpc_threshold(10'd500),
//        .gaus_shrap_threshold(10'd500),  
//        .gaus_sharp_factor(8'd10),     
//        .vsync_out(),
//        .href_out(),
//        .data_out()
//    );
    
//     vga_delay vga_delay_i
//        (
//            .pixel_clk(clk_100m),
//            .resetn(resetn),
//            .vsync(vsync_out       ),
//            .href(active_video_out),
//            .data_in(testData),
//            .line0_href (),    
//            .line1_href (),    
//            .line2_href (),    
//            .line0_vsync(),    
//            .line1_vsync(),    
//            .line2_vsync(),    
//            .data0_out()       
            
            
            
//        );

//     maxtri_timing_get maxtri_timing_i
//        (
//           .pixel_clk(pixel_clk),
//           .resetn(resetn),
//           .vsync(vsync_out       ),
//           .href(active_video_out),
//           .data_in(testData),
//           .line0_href (),
//           .line1_href (),
//           .line2_href (),
//           .line0_vsync(),
//           .line1_vsync(),
//           .line2_vsync(),
//           .data0_out()
            
//        );
        
// maxtri3x3 maxtri3x3_i
//        (
        
//            .pixel_clk(clk_100m),
//            .resetn(resetn),
//            .vsync(vsync_out       ),
//            .href(active_video_out),
//            .data_in(testData),
            
//            .line1_href_out (),
//            .line1_vsync_out(),
//            . matrix_01(),
//            . matrix_11(),
//            . matrix_21()
        
//        );


    wire [9 : 0 ] vcap_m_axis_tdata ;
    wire          vcap_m_axis_tlast ;
    wire          vcap_m_axis_tready;
    wire          vcap_m_axis_tuser ;
    wire          vcap_m_axis_tvalid;   


    video_caputure vcap_i
    (
        .piexl_clk    (pixel_clk        ),
        .href         (active_video_out ),
        .vsync        (vsync_out        ),
        .data_in      (testData         ),
        .img_width    (13'd640         ),
       
        .m_axis_tdata (vcap_m_axis_tdata ),
        .m_axis_tlast (vcap_m_axis_tlast ),
        .m_axis_tready(vcap_m_axis_tready),
        .m_axis_tuser (vcap_m_axis_tuser ),
        .m_axis_tvalid(vcap_m_axis_tvalid)
    ); 



    maxtri3x3_shift
    #(
        .IMG_HEIGHT(480)
    ) maxtri_shift_i
    (
       .pixel_clk(pixel_clk        ),
       .s_axis_tdata ({2'b00,vcap_m_axis_tdata} ),
       .s_axis_tlast (vcap_m_axis_tlast ),

       .s_axis_tuser (vcap_m_axis_tuser ),
       .s_axis_tvalid(vcap_m_axis_tvalid), 
      
       .m_axis_tlast (),

       .m_axis_tuser (),
       .m_axis_tvalid() ,   
       .matrix_01(),
       .matrix_11(),
       .matrix_21()
    
    );

//histogram_axis
//#(
//    .IMG_HEIGHT(480)
//)
//histogram_axis
//(
//    .pixel_clk(pixel_clk)       ,
//    .s_axis_tlast  (vcap_m_axis_tlast )  ,
//    .s_axis_tready (vcap_m_axis_tready)  ,
//    .s_axis_tuser  (vcap_m_axis_tuser )  ,
//    .s_axis_tvalid (vcap_m_axis_tvalid)  ,
//    .s_axis_tdata  (vcap_m_axis_tdata )  , 
       
//    .m_axis_tlast()    ,
//    .m_axis_tready(1'b1)   ,
//    .m_axis_tuser  ()  ,
//    .m_axis_tvalid ()  ,
//    .m_axis_tdata  ()  
// );

// img_integral img_integral_i
//    (
//        .pixel_clk (pixel_clk),
//        .resetn    (resetn),
//        .enable    (1'b1),
//        .vsync     (vsync_out),
//        .href      (active_video_out),
//        .data_in   (count),
//        .vsync_out (),
//        .href_out  (),
//        .data_out  ()
//    );

// maxtri7x7_shift 
//    #(
//        .DATA_WIDTH (10 ),
//        .IMG_HEIGHT (480)
//    )
//    maxtri7x7_shift_i
//    (
//        .pixel_clk(pixel_clk),       
//        .s_axis_tdata (vcap_m_axis_tdata )   ,
//        .s_axis_tlast (vcap_m_axis_tlast )   ,
//        .s_axis_tuser (vcap_m_axis_tuser )   ,
//        .s_axis_tvalid(vcap_m_axis_tvalid)   ,
        
//        .line_buff_0_tlast ()   ,
//        .line_buff_0_tuser ()   ,
//        .line_buff_0_tvalid()   ,
//        .line_buff_0_tdata ()   ,
        
//        .line_buff_1_tlast ()   ,
//        .line_buff_1_tuser ()   ,
//        .line_buff_1_tvalid()   ,
//        .line_buff_1_tdata ()   ,        
        
//        .line_buff_2_tlast ()   ,
//        .line_buff_2_tuser ()   ,
//        .line_buff_2_tvalid()   ,
//        .line_buff_2_tdata ()   ,        
        
//        .line_buff_3_tlast ()   ,
//        .line_buff_3_tuser ()   ,
//        .line_buff_3_tvalid()   ,
//        .line_buff_3_tdata ()   ,        
        
        
//        .line_buff_4_tlast ()   ,
//        .line_buff_4_tuser ()   ,
//        .line_buff_4_tvalid()   ,
//        .line_buff_4_tdata ()   , 
        
//        .line_buff_5_tlast ()   ,
//        .line_buff_5_tuser ()   ,
//        .line_buff_5_tvalid()   ,
//        .line_buff_5_tdata ()   , 
        
//        .line_buff_6_tlast ()   ,        
//        .line_buff_6_tuser ()   ,               
//        .line_buff_6_tvalid()   ,        
//        .line_buff_6_tdata ()         
               
        
//    );
    
//     sobel_axis
//        #(
//            .DATA_WIDTH(10),
//            .IMG_WIDTH (640 ),
//            .IMG_HEIGHT(480)
//        )
//        sobel_axis_i
//        (
//        .pixel_clk(pixel_clk), 
//        .threshold(8'd50)       ,      
//        .s_axis_tdata (vcap_m_axis_tdata )   ,
//        .s_axis_tlast (vcap_m_axis_tlast )   ,
//        .s_axis_tuser (vcap_m_axis_tuser )   ,
//        .s_axis_tvalid(vcap_m_axis_tvalid)   ,
//        .m_axis_tlast ()   ,
//        .m_axis_tuser ()   ,
//        .m_axis_tvalid()   ,
//        .m_axis_tdata ()   
//         );

//    opencv_model
//    #(
//        .DATA_WIDTH(10),
//        .IMG_WIDTH (640 ),
//        .IMG_HEIGHT(480)
//    )
//    opencv_model_i
//    (
//        .pixel_clk(pixel_clk),
//        .resetn(resetn)      ,
//        .debug_cmd(4'b0010)    ,
//        .sobel_enable (1'b1)  ,
//        .sobel_threshold(8'd150)   ,
        
//        .s_axis_tdata (vcap_m_axis_tdata )   ,
//        .s_axis_tlast (vcap_m_axis_tlast )   ,
//        .s_axis_tuser (vcap_m_axis_tuser )   ,
//        .s_axis_tvalid(vcap_m_axis_tvalid)   ,
//        .s_axis_tready()   ,
        
//        .m_axis_tready(1'b1)   ,
//        .m_axis_tlast  ()  ,
//        .m_axis_tuser  ()  ,
//        .m_axis_tvalid ()  ,
//        .m_axis_tdata(),
//        .m_axis_raw_tdata ()     
//    );
    
    
//    data_conv_model data_conv_model_i
//    (
    
//    .m_aclk         (clk_100m          ),
//    .s_aclk         (pixel_clk          ),
//    .s_aresetn      (resetn       ) ,
//    .s_axis_tvalid (vcap_m_axis_tvalid)  ,
//    .s_axis_tready (vcap_m_axis_tready)  ,
//    .s_axis_tdata  (vcap_m_axis_tdata )  ,
//    .s_axis_tlast  (vcap_m_axis_tlast )  ,
//    .s_axis_tuser  (vcap_m_axis_tuser )  ,
//    .debug_cmd     (4'b0001       ),//R颜色黑电平校正设 ,
    
//    .m_axis_tvalid()   ,
//    .m_axis_tready(1'b1)   ,
//    .m_axis_tdata ()   ,
//    .m_axis_tlast ()   ,
//    .m_axis_tuser ()   
//    );
    




         
endmodule
