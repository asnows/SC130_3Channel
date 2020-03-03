`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/16 09:13:28
// Design Name: 
// Module Name: isp_model_axis
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


module isp_model_axis
    #(
        parameter IMG_WIDTH  = 640,
        parameter IMG_HEIGHT = 480
    )
    (
        input       pixel_clk       ,
        input[9:0]  s_axis_tdata    ,
        input       s_axis_tlast    ,
        output      s_axis_tready   ,
        input       s_axis_tuser    ,
        input       s_axis_tvalid   ,
        input       dpc_en          ,       //from PS 的 ~PSWO_reg1[0]           （~WO_reg0[0]）
        input       gaus_en         ,       //from PS 的 PSWO_reg1[4]            （WO_reg0[4]）
        input       gaus_shrap_en   ,       //from PS 的 PSWO_reg1[30]           （WO_reg0[30]）
        input[9:0]  dpc_threshold   ,       //from PS 的 PSWO_reg5[9:0]          （WO_reg4[9:0]）
        input[3:0]  debug_cmd       ,       //from PS 的 PSWO_reg12[3:0]         （WO_reg11[3:0]）
        input[9:0]  gaus_shrap_threshold,    //from PS 的 PSWO_reg12[3:0]        （WO_reg11[3:0]）
        input[7:0]  gaus_sharp_factor,       //from PS 的 {4'd0,PSWO_reg3[15:12]} (｛4'd0,WO_reg2[15:12] })
        output      m_axis_tlast    ,
        input       m_axis_tready   ,
        output      m_axis_tuser    ,
        output      m_axis_tvalid   ,
        output[9:0] m_axis_tdata    
    );
    
    reg[9:0]    s_axis_tdata_dely ;
    reg         s_axis_tlast_dely ;
    reg         s_axis_tuser_dely ;
    reg         s_axis_tvalid_dely;
    reg[3:0]    debug_cmd_dely;
    

    
    reg         m_axis_tlast_reg ; 
    reg         m_axis_tuser_reg ; 
    reg         m_axis_tvalid_reg; 
    reg[9:0]    m_axis_tdata_reg ; 
    
    wire        dpc_matrix_tlast ;
    wire        dpc_matrix_tuser ;
    wire        dpc_matrix_tvalid;  
    wire[9:0]   dpc_matrix_01;
    wire[9:0]   dpc_matrix_11;
    wire[9:0]   dpc_matrix_21;
    
    wire        dpc_axis_tlast ;
    wire        dpc_axis_tuser ;
    wire        dpc_axis_tvalid;   
    wire[9:0]   dpc_axis_tdata ;
    
    wire        gaus_matrix_tlast ;
    wire        gaus_matrix_tuser ;
    wire        gaus_matrix_tvalid;  
    wire[9:0]   gaus_matrix_01;
    wire[9:0]   gaus_matrix_11;
    wire[9:0]   gaus_matrix_21;
    
    wire        gaus2_matrix_tlast ;
    wire        gaus2_matrix_tuser ;
    wire        gaus2_matrix_tvalid;  
    wire[9:0]   gaus2_matrix_01;
    wire[9:0]   gaus2_matrix_11;
    wire[9:0]   gaus2_matrix_21;
    
   wire         gaus_filter_tlast      ;
   wire         gaus_filter_tuser      ;
   wire         gaus_filter_tvalid     ;   
   wire[9:0]    gaus_filter_tdata_gaus ;
   wire[9:0]    gaus_filter_tdata_raw  ;
   
   wire         gaus2_filter_tlast      ;
   wire         gaus2_filter_tuser      ;
   wire         gaus2_filter_tvalid     ;   
   wire[9:0]    gaus2_filter_tdata_gaus ;
   wire[9:0]    gaus2_filter_tdata_raw  ;
   
   
    reg         dpc_en_dely          ;
   reg          gaus_en_dely         ;
   reg          gaus_shrap_en_dely   ;
   reg[9:0]     dpc_threshold_dely   ;
   reg[9:0]     gaus_shrap_threshold_dely;
   reg[7:0]     gaus_sharp_factor_dely;
   
   wire         gaus_sharp_tlast ;
   wire         gaus_sharp_tuser ;
   wire         gaus_sharp_tvalid;
   wire[9:0]    gaus_sharp_tdata ;
   
   
  wire          histogram_axis_tlast ;
  wire          histogram_axis_tready;
  wire          histogram_axis_tuser ;
  wire          histogram_axis_tvalid;
  wire[7:0]     histogram_axis_tdata ; 
   
   
    
    assign m_axis_tlast  = m_axis_tlast_reg ;
    assign m_axis_tuser  = m_axis_tuser_reg ;
    assign m_axis_tvalid = m_axis_tvalid_reg;
    assign m_axis_tdata  = m_axis_tdata_reg;
    assign s_axis_tready = m_axis_tready;

//保证reg in reg out  
    always@(posedge pixel_clk)
    begin
        s_axis_tdata_dely  <= s_axis_tdata ;
        s_axis_tlast_dely  <= s_axis_tlast ;
        s_axis_tuser_dely  <= s_axis_tuser ;
        s_axis_tvalid_dely <= s_axis_tvalid;
        
        dpc_en_dely                 <= dpc_en         ;    
        gaus_en_dely                <= gaus_en        ;    
        gaus_shrap_en_dely          <= gaus_shrap_en  ;    
        dpc_threshold_dely          <= dpc_threshold  ; 
        debug_cmd_dely              <= debug_cmd;   
        gaus_shrap_threshold_dely   <= gaus_shrap_threshold;
        gaus_sharp_factor_dely      <= gaus_sharp_factor;   
       
        
    end  
    
    
    maxtri3x3_shift 
    #(
        .IMG_HEIGHT(IMG_HEIGHT)
    )
    maxtri3x3_dpc_i
    (
        .pixel_clk    (pixel_clk          ),
        .s_axis_tdata (s_axis_tdata_dely  ),
        .s_axis_tlast (s_axis_tlast_dely  ),
        .s_axis_tuser (s_axis_tuser_dely  ),
        .s_axis_tvalid(s_axis_tvalid_dely ),
        
        .m_axis_tlast (dpc_matrix_tlast   ),
        .m_axis_tuser (dpc_matrix_tuser   ),
        .m_axis_tvalid(dpc_matrix_tvalid  ),   
        .matrix_01    (dpc_matrix_01      ),
        .matrix_11    (dpc_matrix_11      ),
        .matrix_21    (dpc_matrix_21      )
    
    );
    
    dpc_axis 
    #(
        .IMG_WIDTH (IMG_WIDTH ),
        .IMG_HEIGHT(IMG_HEIGHT)
    )
    dpc_axis_i
    (
        .pixel_clk   (pixel_clk          ),
        .dpc_en      (dpc_en_dely        ),
        .threshold   (10'd40             ),
         
        .s_axis_tlast (dpc_matrix_tlast ),
        .s_axis_tuser (dpc_matrix_tuser ),
        .s_axis_tvalid(dpc_matrix_tvalid),   
        .matrix_data01(dpc_matrix_01    ), 
        .matrix_data11(dpc_matrix_11    ), 
        .matrix_data21(dpc_matrix_21    ),
        
        .m_axis_tlast (dpc_axis_tlast ),
        .m_axis_tuser (dpc_axis_tuser ),
        .m_axis_tvalid(dpc_axis_tvalid),   
        .m_axis_tdata (dpc_axis_tdata )
    
    );
    
    
    maxtri3x3_shift
    #(
        .IMG_HEIGHT(IMG_HEIGHT)
    )
     maxtri3x3_gaus_i
    (
        .pixel_clk    (pixel_clk         ),
        .s_axis_tdata (dpc_axis_tdata    ),
        .s_axis_tlast (dpc_axis_tlast    ),
        .s_axis_tuser (dpc_axis_tuser    ),
        .s_axis_tvalid(dpc_axis_tvalid   ),
        
        .m_axis_tlast (gaus_matrix_tlast   ),
        .m_axis_tuser (gaus_matrix_tuser   ),
        .m_axis_tvalid(gaus_matrix_tvalid  ),   
        .matrix_01    (gaus_matrix_01      ),
        .matrix_11    (gaus_matrix_11      ),
        .matrix_21    (gaus_matrix_21      )
    
    );


    gaus_filter_axis
    #(
        .IMG_WIDTH (IMG_WIDTH ),
        .IMG_HEIGHT(IMG_HEIGHT)
    )
     gaus_filter_axis_i
    (
        .pixel_clk    (pixel_clk           ),
        .gaus_en      (gaus_en_dely        ),
        .s_axis_tlast (gaus_matrix_tlast   ),
        .s_axis_tuser (gaus_matrix_tuser   ),
        .s_axis_tvalid(gaus_matrix_tvalid  ),   
        .matrix_data01(gaus_matrix_01      ), 
        .matrix_data11(gaus_matrix_11      ), 
        .matrix_data21(gaus_matrix_21      ),
        
        .m_axis_tlast     (gaus_filter_tlast     ),
        .m_axis_tuser     (gaus_filter_tuser     ),
        .m_axis_tvalid    (gaus_filter_tvalid    ), 
        .m_axis_tdata_gaus(gaus_filter_tdata_gaus),
        .m_axis_tdata_raw (gaus_filter_tdata_raw )
    
    );
    
    
    gaus_sharp_axis gaus_sharp_axis_i
    (
        .pixel_clk(pixel_clk),
        .shrap_en(gaus_shrap_en_dely),
        .sharp_threlode_in(gaus_shrap_threshold_dely) ,
        .sharp_factor_in  (gaus_sharp_factor_dely   ),
        .s_axis_tlast (gaus_filter_tlast     ),
        .s_axis_tuser (gaus_filter_tuser     ),
        .s_axis_tvalid(gaus_filter_tvalid    ),
        .data_raw_in  (gaus_filter_tdata_raw),
        .data_gaus_in (gaus_filter_tdata_gaus ),
        
        .m_axis_tlast  (gaus_sharp_tlast )  ,
        .m_axis_tuser  (gaus_sharp_tuser )  ,
        .m_axis_tvalid (gaus_sharp_tvalid)  ,
        .m_axis_tdata  (gaus_sharp_tdata )  
    
    );
    
    
    
    
    
    
    histogram_axis
    #(
        .IMG_HEIGHT (IMG_HEIGHT)
    )
    histogram_axis_i
    (
        .pixel_clk     (pixel_clk        ),
        .s_axis_tlast (gaus_sharp_tlast  ),
        //.s_axis_tready(                  ),
        .s_axis_tuser (gaus_sharp_tuser  ),
        .s_axis_tvalid(gaus_sharp_tvalid ),
        .s_axis_tdata (gaus_sharp_tdata[9:2]), 
        .m_axis_tlast (histogram_axis_tlast ),
        .m_axis_tready(histogram_axis_tready),
        .m_axis_tuser (histogram_axis_tuser ),
        .m_axis_tvalid(histogram_axis_tvalid),
        .m_axis_tdata (histogram_axis_tdata )   
    );
    
    
    
    
    
//    maxtri3x3_shift
//    #(
//        .IMG_HEIGHT(IMG_HEIGHT)
//    )
//     maxtri3x3_gaus2_i
//    (
//        .pixel_clk    (pixel_clk         ),
//        .s_axis_tdata ({histogram_axis_tdata,2'b00}),
//        .s_axis_tlast (histogram_axis_tlast    ),
//        .s_axis_tuser (histogram_axis_tuser    ),
//        .s_axis_tvalid(histogram_axis_tvalid   ),
        
//        .m_axis_tlast (gaus2_matrix_tlast   ),
//        .m_axis_tuser (gaus2_matrix_tuser   ),
//        .m_axis_tvalid(gaus2_matrix_tvalid  ),   
//        .matrix_01    (gaus2_matrix_01      ),
//        .matrix_11    (gaus2_matrix_11      ),
//        .matrix_21    (gaus2_matrix_21      )
    
//    );


//    gaus_filter_axis
//    #(
//        .IMG_WIDTH (IMG_WIDTH ),
//        .IMG_HEIGHT(IMG_HEIGHT)
//    )
//     gaus2_filter_axis_i
//    (
//        .pixel_clk    (pixel_clk           ),
//        .gaus_en      (gaus_en_dely        ),
//        .s_axis_tlast (gaus2_matrix_tlast   ),
//        .s_axis_tuser (gaus2_matrix_tuser   ),
//        .s_axis_tvalid(gaus2_matrix_tvalid  ),   
//        .matrix_data01(gaus2_matrix_01      ), 
//        .matrix_data11(gaus2_matrix_11      ), 
//        .matrix_data21(gaus2_matrix_21      ),
        
//        .m_axis_tlast     (gaus2_filter_tlast     ),
//        .m_axis_tuser     (gaus2_filter_tuser     ),
//        .m_axis_tvalid    (gaus2_filter_tvalid    ), 
//        .m_axis_tdata_gaus(gaus2_filter_tdata_gaus),
//        .m_axis_tdata_raw (gaus2_filter_tdata_raw )
    
//    );
    

//根据from PS 的 PSWO_reg12[3:0]         （WO_reg11[3:0]）
//决定ISP算法进行几项
//0：原图
//1：用于dpc处理的3*3表的第二行数据（延时后的原图）
//2：dpc处理后的图
//3：用于gs滤波处理的3*3表的第二行数据（延时后的原图）？？？
//4：gs滤波处理后的图
//5：gs锐化处理后的图
//6：直方图处理后的图
    always@(posedge pixel_clk )
    begin
        case (debug_cmd_dely)
            4'b0000:
            begin
                m_axis_tlast_reg  <= s_axis_tlast_dely ;
                m_axis_tuser_reg  <= s_axis_tuser_dely ;
                m_axis_tvalid_reg <= s_axis_tvalid_dely;
                m_axis_tdata_reg  <= s_axis_tdata_dely;
            end
            
            4'b0001://DPC(Bad Point Correction)------坏点校正
            begin
                m_axis_tlast_reg  <= dpc_matrix_tlast  ;
                m_axis_tuser_reg  <= dpc_matrix_tuser  ;
                m_axis_tvalid_reg <= dpc_matrix_tvalid ;
                m_axis_tdata_reg  <= dpc_matrix_11     ;
            end
            
            4'b0010:
            begin
                m_axis_tlast_reg  <= dpc_axis_tlast ;
                m_axis_tuser_reg  <= dpc_axis_tuser ;
                m_axis_tvalid_reg <= dpc_axis_tvalid;
                m_axis_tdata_reg  <= dpc_axis_tdata ;
            end
            
            4'b0011:
            begin
                m_axis_tlast_reg  <= gaus_matrix_tlast  ;
                m_axis_tuser_reg  <= gaus_matrix_tuser  ;
                m_axis_tvalid_reg <= gaus_matrix_tvalid ;
                m_axis_tdata_reg  <= gaus_matrix_11     ;
            end
            
            4'b0100:
            begin
                m_axis_tlast_reg  <= gaus_filter_tlast     ;
                m_axis_tuser_reg  <= gaus_filter_tuser     ;
                m_axis_tvalid_reg <= gaus_filter_tvalid    ;
                m_axis_tdata_reg  <= gaus_filter_tdata_gaus;
            end
            
            4'b0101:
            begin
                m_axis_tlast_reg  <= gaus_sharp_tlast ;
                m_axis_tuser_reg  <= gaus_sharp_tuser ;
                m_axis_tvalid_reg <= gaus_sharp_tvalid;
                m_axis_tdata_reg  <= gaus_sharp_tdata ;
            end
            
            4'b0110:
            begin
                m_axis_tlast_reg  <= histogram_axis_tlast ;
                m_axis_tuser_reg  <= histogram_axis_tuser ;
                m_axis_tvalid_reg <= histogram_axis_tvalid;
                m_axis_tdata_reg  <= {histogram_axis_tdata,2'b00} ;
            end
            
            4'b0111:
            begin
                m_axis_tlast_reg  <= gaus2_filter_tlast     ;
                m_axis_tuser_reg  <= gaus2_filter_tuser     ;
                m_axis_tvalid_reg <= gaus2_filter_tvalid    ;
                m_axis_tdata_reg  <= gaus2_filter_tdata_gaus;
            end
            
            default:
            begin
                m_axis_tlast_reg  <= s_axis_tlast_dely ;
                m_axis_tuser_reg  <= s_axis_tuser_dely ;
                m_axis_tvalid_reg <= s_axis_tvalid_dely;
                m_axis_tdata_reg  <= s_axis_tdata_dely;
            end
        endcase
    end    
                      
   
endmodule


