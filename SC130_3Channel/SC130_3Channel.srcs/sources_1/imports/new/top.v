`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/11 13:44:48
// Design Name: 
// Module Name: top
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
    module top
    (
        output CMOS_XCK,//时钟输入(OSC)
        //DDR管脚配置
        inout  [14:0]DDR_addr,
        inout  [2:0]DDR_ba,
        inout  DDR_cas_n,
        inout  DDR_ck_n,
        inout  DDR_ck_p,
        inout  DDR_cke,
        inout  DDR_cs_n,
        inout  [3:0]DDR_dm,
        inout  [31:0]DDR_dq,
        inout  [3:0]DDR_dqs_n,
        inout  [3:0]DDR_dqs_p,
        inout  DDR_odt,
        inout  DDR_ras_n,
        inout  DDR_reset_n,
        inout  DDR_we_n,
        inout  FIXED_IO_ddr_vrn,
        inout  FIXED_IO_ddr_vrp,
        inout  [53:0]FIXED_IO_mio,
        inout  FIXED_IO_ps_clk,
        inout  FIXED_IO_ps_porb,
        inout  FIXED_IO_ps_srstb,
        inout  iic_0_scl_io,//IIC时钟线
        inout  iic_0_sda_io,//IIC数据线
        
        input      CMOS_PIXCLK,   // 像素时钟信号
        output     CMOS_Trigger0, // 曝光输出脉冲信号 
        output     CMOS_PWDN,    //上电脉冲信号
        input      CMOS_FSYNC,   //  帧同步信号
        input      CMOS_LREF,    //  行同步信号
        input[9:0] CMOS_DATA,    //  像素数据
        inout      PHY_RST_tri_io,
        output     E_OUT1,
        output     E_OUT2,  
        input      E_IN1
        
    );
    
    parameter DATA_WIDTH = 10;
    parameter IMG_WIDTH  = 1280;//640;
    parameter IMG_HEIGHT = 1024;//480;
    
    wire FCLK_CLK0                  ;
    wire sys_reset                  ;
    wire sys_resetn                 ;
    wire [31:0]M00_AXI_0_araddr     ;
    wire [2:0]M00_AXI_0_arprot      ;
    wire [0:0]M00_AXI_0_arready     ;
    wire [0:0]M00_AXI_0_arvalid     ;
    wire [31:0]M00_AXI_0_awaddr     ;
    wire [2:0]M00_AXI_0_awprot      ;
    wire [0:0]M00_AXI_0_awready     ;
    wire [0:0]M00_AXI_0_awvalid     ;
    wire [0:0]M00_AXI_0_bready      ;
    wire [1:0]M00_AXI_0_bresp       ;
    wire [0:0]M00_AXI_0_bvalid      ;
    wire [31:0]M00_AXI_0_rdata      ;
    wire [0:0]M00_AXI_0_rready      ;
    wire [1:0]M00_AXI_0_rresp       ;
    wire [0:0]M00_AXI_0_rvalid      ;
    wire [31:0]M00_AXI_0_wdata      ;
    wire [0:0]M00_AXI_0_wready      ;
    wire [3:0]M00_AXI_0_wstrb       ;
//    wire [0:0]M00_AXI_0_wvalid      ;
    wire [0:0]M00_AXI_0_wvalid      ;
    wire coms_clk                   ;
    
	wire[31:0] R0_reg0,R0_reg1,R0_reg2,R0_reg3,R0_reg4,R0_reg5,R0_reg6,R0_reg7;// 建立8个 PS只读寄存器
    wire[31:0] WO_reg0,WO_reg1,WO_reg2,WO_reg3,WO_reg4,WO_reg5,WO_reg6,WO_reg7;// 建立24个 PS可写寄存器
    wire[31:0] WO_reg8,WO_reg9,WO_reg10,WO_reg11,WO_reg12,WO_reg13,WO_reg14,WO_reg15;// 建立24个 PS可写寄存器
    wire[31:0] WO_reg16,WO_reg17,WO_reg18,WO_reg19,WO_reg20,WO_reg21,WO_reg22,WO_reg23;// 建立24个 PS可写寄存器
    wire[31:0] Trgger_with;
    
    wire      vcap_href   ; 
    wire      vcap_vsync  ; 
    wire[9: 0]vcap_data_in;                                         
    wire[9: 0]vcap_m_axis_tdata ;
    (*mark_debug="true"*)wire      vcap_m_axis_tlast ;
    wire      vcap_m_axis_tready;
    (*mark_debug="true"*)wire      vcap_m_axis_tuser ;
    (*mark_debug="true"*)wire      vcap_m_axis_tvalid;
    
    
    (*mark_debug="true"*)wire[31:0]fifo_0_s_axis_tdata;//, fifo_1_s_axis_tdata, fifo_2_s_axis_tdata ;
    (*mark_debug="true"*)wire      fifo_0_s_axis_tlast;//, fifo_1_s_axis_tlast, fifo_2_s_axis_tlast ;
    wire      fifo_0_s_axis_tready;
    (*mark_debug="true"*)wire      fifo_0_s_axis_tuser;//, fifo_1_s_axis_tuser, fifo_2_s_axis_tuser ;
    (*mark_debug="true"*)wire      fifo_0_s_axis_tvalid;//,fifo_1_s_axis_tvalid,fifo_2_s_axis_tvalid;
    
    
    (*mark_debug="true"*) wire[31:0]dconv_m0_axis_tdata;
    (*mark_debug="true"*) wire[31:0]dconv_m1_axis_tdata;
                           wire[31:0]dconv_m2_axis_tdata ;
                           wire[31:0]dconv_m3_axis_tdata ;
     (*mark_debug="true"*)wire      dconv_m_axis_tlast ;
     wire      dconv_m_axis_tready;
    // wire[3:0 ]dconv_m_axis_tkeep ;
     (*mark_debug="true"*)wire      dconv_m_axis_tuser ;
     (*mark_debug="true"*)wire      dconv_m_axis_tvalid;
    
    (*mark_debug="true"*) wire      sw_m_0_axis_tvalid ;
     wire      sw_m_0_axis_tready ;
     (*mark_debug="true"*)wire[31:0]sw_m_0_axis_tdata  ;
     wire[31:0]sw_m_2_axis_tdata  ;
     wire[31:0]sw_m_3_axis_tdata  ;
     (*mark_debug="true"*)wire      sw_m_0_axis_tlast  ;
     (*mark_debug="true"*)wire      sw_m_0_axis_tuser  ;
     
     (*mark_debug="true"*)wire      sw_m_1_axis_tvalid ;
        wire      sw_m_1_axis_tready ;
     (*mark_debug="true"*)wire[31:0]sw_m_1_axis_tdata  ;
     (*mark_debug="true"*)wire      sw_m_1_axis_tlast  ;
     (*mark_debug="true"*)wire      sw_m_1_axis_tuser  ;
    
    wire      sw_m_2_axis_tvalid ;
    wire      sw_m_2_axis_tready ;
    wire      sw_m_2_axis_tlast  ;
    wire      sw_m_2_axis_tuser  ;
    
    wire      sw_m_3_axis_tvalid ;
    wire      sw_m_3_axis_tready ;
    wire      sw_m_3_axis_tlast  ;
    wire      sw_m_3_axis_tuser  ;     
    wire      coms_xclk_out; 
    
    // wire      hls_orc_video_out_TVALID;
    // wire      hls_orc_video_out_TREADY;
    // wire[7:0 ]hls_orc_video_out_TDATA;
    // wire      hls_orc_video_out_TUSER;
    // wire      hls_orc_video_out_TLAST;
    
    // wire      hist_href;
    // wire      hist_vsync;
    // wire[7:0] hist_data_out;
    
    // wire[DATA_WIDTH - 1:0]  coms_data_in ;
    // wire                    coms_href_in ;
    // wire                    coms_vsync_in;
    
    wire[DATA_WIDTH - 1:0]  coms_data;
    wire                    coms_href;
    wire                    coms_vsync;

    // wire[7:0] coms_10bit_2_bit_data;
    // wire      coms_10bit_2_bit_href;
    // wire      coms_10bit_2_bit_vsync;
    
    wire      isp_model_dpc_en;
    wire      isp_model_gaus_en; 
    wire      isp_model_gaus_sharp_en;  
    wire      isp_model_vsync_out;
    wire      isp_model_href_out ;
    wire[7:0] isp_model_data_out ;
    
    (*mark_debug="true"*)wire      isp_model_axis_tlast  ;
    wire      isp_model_axis_tready ;
    (*mark_debug="true"*)wire      isp_model_axis_tuser  ;
    (*mark_debug="true"*)wire      isp_model_axis_tvalid ;
    wire[9:0] isp_model_axis_tdata  ;
    
    wire     opencv_m_axis_tready   ;
    (*mark_debug="true"*)wire       opencv_m_axis_tlast ;
    (*mark_debug="true"*)wire       opencv_m_axis_tuser ;
    (*mark_debug="true"*)wire       opencv_m_axis_tvalid;
    (*mark_debug="true"*)wire [31:0] opencv_m_axis_tdata  ;
    
    
    /******************* connected wire ********************/
    assign sys_reset = ~sys_resetn;
    assign CMOS_PWDN = ~WO_reg10[0];//控制 CMOS的上电  
    assign E_OUT1 = WO_reg10[1] ;
    assign E_OUT2 = WO_reg10[2] ;
    //assign R0_reg1[3] = E_IN1;
           
    design_1_wrapper design_1_wrapper_i
    (
        .CMOS_XCK            (coms_xclk_out         ),
        .DDR_addr            (DDR_addr              ),
        .DDR_ba              (DDR_ba                ),
        .DDR_cas_n           (DDR_cas_n             ),
        .DDR_ck_n            (DDR_ck_n              ),
        .DDR_ck_p            (DDR_ck_p              ),
        .DDR_cke             (DDR_cke               ),
        .DDR_cs_n            (DDR_cs_n              ),
        .DDR_dm              (DDR_dm                ),
        .DDR_dq              (DDR_dq                ),
        .DDR_dqs_n           (DDR_dqs_n             ),
        .DDR_dqs_p           (DDR_dqs_p             ),
        .DDR_odt             (DDR_odt               ),
        .DDR_ras_n           (DDR_ras_n             ),
        .DDR_reset_n         (DDR_reset_n           ),
        .DDR_we_n            (DDR_we_n              ),
        .E_IN1_tri_i         (E_IN1                 ),
        .FCLK_CLK0           (FCLK_CLK0             ),
        .FIXED_IO_ddr_vrn    (FIXED_IO_ddr_vrn      ),
        .FIXED_IO_ddr_vrp    (FIXED_IO_ddr_vrp      ),
        .FIXED_IO_mio        (FIXED_IO_mio          ),
        .FIXED_IO_ps_clk     (FIXED_IO_ps_clk       ),
        .FIXED_IO_ps_porb    (FIXED_IO_ps_porb      ),
        .FIXED_IO_ps_srstb   (FIXED_IO_ps_srstb     ),
        .M00_AXI_araddr      (M00_AXI_0_araddr      ),
        .M00_AXI_arprot      (M00_AXI_0_arprot      ),
        .M00_AXI_arready     (M00_AXI_0_arready     ),
        .M00_AXI_arvalid     (M00_AXI_0_arvalid     ),
        .M00_AXI_awaddr      (M00_AXI_0_awaddr      ),
        .M00_AXI_awprot      (M00_AXI_0_awprot      ),
        .M00_AXI_awready     (M00_AXI_0_awready     ),
        .M00_AXI_awvalid     (M00_AXI_0_awvalid     ),
        .M00_AXI_bready      (M00_AXI_0_bready      ),
        .M00_AXI_bresp       (M00_AXI_0_bresp       ),
        .M00_AXI_bvalid      (M00_AXI_0_bvalid      ),
        .M00_AXI_rdata       (M00_AXI_0_rdata       ),
        .M00_AXI_rready      (M00_AXI_0_rready      ),
        .M00_AXI_rresp       (M00_AXI_0_rresp       ),
        .M00_AXI_rvalid      (M00_AXI_0_rvalid      ),
        .M00_AXI_wdata       (M00_AXI_0_wdata       ),
        .M00_AXI_wready      (M00_AXI_0_wready      ),
        .M00_AXI_wstrb       (M00_AXI_0_wstrb       ),
        .M00_AXI_wvalid      (M00_AXI_0_wvalid      ),
        .PHY_RST_tri_io      (PHY_RST_tri_io        ),
        .S_AXIS_S2MM_0_tdata (sw_m_0_axis_tdata     ),
        .S_AXIS_S2MM_0_tkeep (4'b1111               ),
        .S_AXIS_S2MM_0_tlast (sw_m_0_axis_tlast     ),
        .S_AXIS_S2MM_0_tready(sw_m_0_axis_tready    ),
        .S_AXIS_S2MM_0_tuser (sw_m_0_axis_tuser     ),
        .S_AXIS_S2MM_0_tvalid(sw_m_0_axis_tvalid    ),
        .S_AXIS_S2MM_1_tdata (sw_m_1_axis_tdata     ),
        .S_AXIS_S2MM_1_tkeep (4'b1111               ),
        .S_AXIS_S2MM_1_tlast (sw_m_1_axis_tlast     ),
        .S_AXIS_S2MM_1_tready(sw_m_1_axis_tready    ), 
        .S_AXIS_S2MM_1_tuser (sw_m_1_axis_tuser     ), 
        .S_AXIS_S2MM_1_tvalid(sw_m_1_axis_tvalid    ),
        .S_AXIS_S2MM_2_tdata (sw_m_2_axis_tdata     ),
        .S_AXIS_S2MM_2_tkeep (4'b1111               ), 
        .S_AXIS_S2MM_2_tlast (sw_m_2_axis_tlast     ),
        .S_AXIS_S2MM_2_tready(sw_m_2_axis_tready    ), 
        .S_AXIS_S2MM_2_tuser (sw_m_2_axis_tuser     ), 
        .S_AXIS_S2MM_2_tvalid(sw_m_2_axis_tvalid    ),
        .S_AXIS_S2MM_3_tdata (sw_m_3_axis_tdata     ),
        .S_AXIS_S2MM_3_tkeep (4'b1111               ),
        .S_AXIS_S2MM_3_tlast (sw_m_3_axis_tlast     ),
        .S_AXIS_S2MM_3_tready(sw_m_3_axis_tready    ), 
        .S_AXIS_S2MM_3_tuser (sw_m_3_axis_tuser     ), 
        .S_AXIS_S2MM_3_tvalid(sw_m_3_axis_tvalid    ),
        .IIC_0_scl_io        (iic_0_scl_io          ),    
        .IIC_0_sda_io        (iic_0_sda_io          ),    
        .peripheral_aresetn  (sys_resetn            ),
        .s2mm_frame_ptr_out  (R0_reg4[5:0]          )

    );

    SC30_v1_0_S00_AXI SC30_v1_0_S00_AXI_inst
    ( 
        .PSRO_reg1(R0_reg0),//to PS
        .PSRO_reg2(R0_reg1),
        .PSRO_reg3(R0_reg2),
        .PSRO_reg4(R0_reg3),
        .PSRO_reg5(R0_reg4),
        .PSRO_reg6(R0_reg5),
        .PSRO_reg7(R0_reg6),
        .PSRO_reg8(R0_reg7),
    
        .PSWO_reg1(WO_reg0),
        .PSWO_reg2(WO_reg1),
        .PSWO_reg3(WO_reg2),
        .PSWO_reg4(WO_reg3),
        .PSWO_reg5(WO_reg4),
        .PSWO_reg6(WO_reg5),
        .PSWO_reg7(WO_reg6),
        .PSWO_reg8(WO_reg7),
        .PSWO_reg9(WO_reg8),
        .PSWO_reg10(WO_reg9),
        .PSWO_reg11(WO_reg10),
        .PSWO_reg12(WO_reg11),//from PS
        .PSWO_reg13(WO_reg12),
        .PSWO_reg14(WO_reg13),
        .PSWO_reg15(WO_reg14),
        .PSWO_reg16(WO_reg15),
        .PSWO_reg17(WO_reg16),
        .PSWO_reg18(WO_reg17),
        .PSWO_reg19(WO_reg18),
        .PSWO_reg20(WO_reg19),
        .PSWO_reg21(WO_reg20),
        .PSWO_reg22(WO_reg21),
        .PSWO_reg23(WO_reg22),
        .PSWO_reg24(WO_reg23),        
            
        .S_AXI_ACLK     (FCLK_CLK0          ),
        .S_AXI_ARESETN  (sys_resetn         ),
        .S_AXI_AWADDR   (M00_AXI_0_awaddr   ),
        .S_AXI_AWPROT   (M00_AXI_0_awprot   ),
        .S_AXI_AWVALID  (M00_AXI_0_awvalid  ),
        .S_AXI_AWREADY  (M00_AXI_0_awready  ),
        .S_AXI_WDATA    (M00_AXI_0_wdata    ),
        .S_AXI_WSTRB    (M00_AXI_0_wstrb    ),
        .S_AXI_WVALID   (M00_AXI_0_wvalid   ),
        .S_AXI_WREADY   (M00_AXI_0_wready   ),
        .S_AXI_BRESP    (M00_AXI_0_bresp    ),
        .S_AXI_BVALID   (M00_AXI_0_bvalid   ),
        .S_AXI_BREADY   (M00_AXI_0_bready   ),
        .S_AXI_ARADDR   (M00_AXI_0_araddr   ),
        .S_AXI_ARPROT   (M00_AXI_0_arprot   ),
        .S_AXI_ARVALID  (M00_AXI_0_arvalid  ),
        .S_AXI_ARREADY  (M00_AXI_0_arready  ),
        .S_AXI_RDATA    (M00_AXI_0_rdata    ),
        .S_AXI_RRESP    (M00_AXI_0_rresp    ),
        .S_AXI_RVALID   (M00_AXI_0_rvalid   ),
        .S_AXI_RREADY   (M00_AXI_0_rready   )
    );

    assign Trgger_with  = (WO_reg9[31:2]==0)?100000000:{2'b00,WO_reg9[31:2]};//默认值1S1帧
//    assign Trgger_with  = (WO_reg9[31:2]==0)?100000000:{WO_reg9[31:2],2'b00};//默认值1S1帧
    assign CMOS_XCK     = (WO_reg0[5] == 1)? coms_xclk_out : 1'b0;
   
    Trgger Trgger  //发送拍照脉冲
    (
//        .Rst            (WO_reg0[0]     ),
        .sysclk         (FCLK_CLK0      ),//系统时钟
        .Control_Mode   (WO_reg9[0]     ),
        .SoftTrggr      (WO_reg9[1]     ),
        .Frame_hz       (Trgger_with    ), 
        .exposure_width (WO_reg5        ),  
        .Trggerio       (CMOS_Trigger0  )
    );
    assign R0_reg2={8'd83,8'd67,8'd13,8'd08};//硬件版本信息
    assign R0_reg3={8'h18,8'h08,8'h16,8'h01};//软件版本信息 

   cmos_sampling#( .DATA_WIDTH(DATA_WIDTH))
   cmos_sampling_i
        (
            .pixel_clk(CMOS_PIXCLK) ,   
            .vsync    (CMOS_FSYNC ) ,       
            .href     (CMOS_LREF  ) ,        
            .data_in  (CMOS_DATA  ) ,
            
            .pixel_clk_out(coms_clk  ),
            .vsync_out    (coms_vsync),       
            .href_out     (coms_href ),        
            .data_out     (coms_data )
        );

    assign isp_model_dpc_en = ~ WO_reg0[0]; 
    assign isp_model_gaus_en = ~WO_reg0[4]; 
    assign isp_model_gaus_sharp_en = ~WO_reg0[30];  
    
	assign vcap_href    =  coms_href   ;
    assign vcap_vsync   =  coms_vsync  ;   
    assign vcap_data_in =  coms_data   ;
	
    video_caputure vcap_i
    (
        .piexl_clk    (coms_clk         ),
        .href         (vcap_href        ),
        .vsync        (vcap_vsync       ),
        .data_in      (vcap_data_in     ),
        .img_width    (WO_reg1[12:0]    ),
       
        .m_axis_tdata (vcap_m_axis_tdata ),
        .m_axis_tlast (vcap_m_axis_tlast ),
      // .m_axis_tready(vcap_m_axis_tready),
        .m_axis_tuser (vcap_m_axis_tuser ),
        .m_axis_tvalid(vcap_m_axis_tvalid)
    ); 
 
    isp_model_axis#( .IMG_WIDTH (IMG_WIDTH ),.IMG_HEIGHT(IMG_HEIGHT) )
    isp_model_axis_i
    (
        .pixel_clk       (coms_clk          ),
        .s_axis_tdata    (vcap_m_axis_tdata ),
        .s_axis_tlast    (vcap_m_axis_tlast ),
        .s_axis_tready   (vcap_m_axis_tready),
        .s_axis_tuser    (vcap_m_axis_tuser ),
        .s_axis_tvalid   (vcap_m_axis_tvalid), 
        .dpc_en          (isp_model_dpc_en  ),  
        .gaus_en         (isp_model_gaus_en ),  
        .gaus_shrap_en   (isp_model_gaus_sharp_en),  
        .dpc_threshold       (WO_reg4[9:0]  ),//颜色黑电G平校正设 from ps WO_reg4[9:0]( PSWO_reg5)         
        .debug_cmd           (WO_reg11[3:0] ), //B颜色黑电平校正设 from ps WO_reg11[3:0]:debug_cmd1
        .gaus_shrap_threshold(WO_reg2[9:0]  ),                     
        .gaus_sharp_factor   (WO_reg2[15:12]),                     
        .m_axis_tlast (isp_model_axis_tlast ),
        .m_axis_tready(isp_model_axis_tready),
        .m_axis_tuser (isp_model_axis_tuser ),
        .m_axis_tvalid(isp_model_axis_tvalid),
        .m_axis_tdata (isp_model_axis_tdata )   
    );
    opencv_model#( .DATA_WIDTH(DATA_WIDTH),.IMG_WIDTH (IMG_WIDTH ),.IMG_HEIGHT(IMG_HEIGHT))
    opencv_model_i
    (
        .pixel_clk         (coms_clk        ),
        .resetn            (sys_resetn      ),
        .debug_cmd         ( WO_reg11[7:4]  ),
        .sobel_enable      (WO_reg11[18]    ),
        .sobel_threshold   (WO_reg11[15:8]  ),
        .sobel_kernel      (WO_reg11[17:16] ),
        .s_axis_tlast     (isp_model_axis_tlast  ),
        .s_axis_tuser     (isp_model_axis_tuser  ),
        .s_axis_tvalid    (isp_model_axis_tvalid ), 
        .s_axis_tdata     (isp_model_axis_tdata  ),
        .s_axis_tready    (isp_model_axis_tready ),
        .m_axis_tready    (opencv_m_axis_tready  ),
        .m_axis_tlast     (opencv_m_axis_tlast   ),
        .m_axis_tuser     (opencv_m_axis_tuser   ),
        .m_axis_tvalid    (opencv_m_axis_tvalid  ),
        .m_axis_tdata     (opencv_m_axis_tdata   )
        //.m_axis_raw_tdata(opencv_m_axis_raw_tdata)      
    );
    
    assign fifo_0_s_axis_tdata  = opencv_m_axis_tdata   ;
    assign fifo_0_s_axis_tlast  = opencv_m_axis_tlast   ;
    assign fifo_0_s_axis_tready = opencv_m_axis_tready  ;
    assign fifo_0_s_axis_tuser  = opencv_m_axis_tuser   ;
    assign fifo_0_s_axis_tvalid = opencv_m_axis_tvalid  ;

    data_conv_model#( .DATA_WIDTH(8),.IMG_WIDTH(IMG_WIDTH))
    data_conv_model_i
    (
        .m_aclk       (FCLK_CLK0            ),
        .s_aclk       (coms_clk             ),
        .s_aresetn    (sys_resetn           ),
        .s_axis_tvalid(fifo_0_s_axis_tvalid ),
        .s_axis_tready(fifo_0_s_axis_tready ),
        .s_axis_tdata (fifo_0_s_axis_tdata  ),
        .s_axis_tlast (fifo_0_s_axis_tlast  ),
        .s_axis_tuser (fifo_0_s_axis_tuser  ),
        .debug_cmd     (4'b0001             ),
        .m_axis_tvalid(dconv_m_axis_tvalid  ), //.m_axis_tvalid(dconv_m_axis_tvalid)   ,.m_axis_tvalid(dconv_m_axis_tvalid)   ,
        .m_axis_tready(dconv_m_axis_tready  ),
        .m0_axis_tdata(dconv_m0_axis_tdata   ),.m1_axis_tdata(dconv_m1_axis_tdata),.m2_axis_tdata (dconv_m2_axis_tdata ),.m3_axis_tdata (dconv_m3_axis_tdata )   , 
        .m_axis_tlast (dconv_m_axis_tlast   ),// .msx_axis_tlast (dconv_msx_axis_tlast),.msy_axis_tlast (dconv_m_axis_tlast )   ,
        .m_axis_tuser (dconv_m_axis_tuser   )   //, .msx_axis_tuser (dconv_msx_axis_tuser),.msy_axis_tuser (dconv_m_axis_tuser )
    );

    axis_switch axis_switch_i
    (
        .aclk           (FCLK_CLK0          ),
        .vsyhc          (CMOS_FSYNC         ),
        .ps_triger0     (WO_reg0[2]         ),
        .ps_triger1     (WO_reg0[3]         ),
        .pl_achieve     (R0_reg1[1]         ),
       // .debug_cmd      ( WO_reg11[7:4]   ),//debug_cmd2        
        .s_axis_tvalid  (dconv_m_axis_tvalid  ),
        .s_axis_tready  (dconv_m_axis_tready  ),
        //.s_axis_tdata   (dconv_m_axis_tdata   ),
        .s_axis_tlast   (dconv_m_axis_tlast   ),
        .s_axis_tuser   (dconv_m_axis_tuser   ),

        .m_0_axis_tvalid(sw_m_0_axis_tvalid ),
        .m_0_axis_tready(sw_m_0_axis_tready ),
        .m_2_axis_tready(sw_m_2_axis_tready ),
        .m_3_axis_tready(sw_m_3_axis_tready ),
        //.m_0_axis_tdata (sw_m_0_axis_tdata  ),
        .m_0_axis_tlast (sw_m_0_axis_tlast  ),
        .m_0_axis_tuser (sw_m_0_axis_tuser  ),
        .m_1_axis_tvalid(sw_m_1_axis_tvalid ),
        .m_1_axis_tready(sw_m_1_axis_tready ),
       // .m_1_axis_tdata (Data_Stream),
        .m_1_axis_tlast (sw_m_1_axis_tlast  ),
        .m_1_axis_tuser (sw_m_1_axis_tuser  )
    );
    assign  sw_m_0_axis_tdata=dconv_m0_axis_tdata;
    assign  sw_m_1_axis_tdata=dconv_m1_axis_tdata;//WO_reg11[7:4]
    assign  sw_m_2_axis_tdata=dconv_m2_axis_tdata;
    assign  sw_m_3_axis_tdata=dconv_m3_axis_tdata;
    assign  sw_m_2_axis_tvalid =sw_m_0_axis_tvalid  ;
    assign  sw_m_2_axis_tlast  =sw_m_0_axis_tlast   ;
    assign  sw_m_2_axis_tuser  =sw_m_0_axis_tuser   ;
    
    assign  sw_m_3_axis_tvalid =sw_m_0_axis_tvalid  ;
    assign  sw_m_3_axis_tlast  =sw_m_0_axis_tlast   ;
    assign  sw_m_3_axis_tuser  =sw_m_0_axis_tuser   ;    

      
endmodule
