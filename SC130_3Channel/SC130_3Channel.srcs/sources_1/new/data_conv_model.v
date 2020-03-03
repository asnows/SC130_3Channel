`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/10 14:54:47
// Design Name: 
// Module Name: data_conv_model
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
//将1280的图像帧转换成3840给千兆网传输

module data_conv_model
#(
  parameter DATA_WIDTH = 8,
  parameter IMG_WIDTH  = 640
)
(

    input       m_aclk          ,//FCLK_CLK0 from design_1_wrapper 100
    input       s_aclk          ,// 像素时钟信号
    input       s_aresetn       ,//from design_1_wrapper.v
    input       s_axis_tvalid   ,
    output      s_axis_tready   ,
    input[31:0] s_axis_tdata    ,//灰度值0~255共8位
    input       s_axis_tlast    ,
    input       s_axis_tuser    ,
    input[3:0]  debug_cmd       ,//4'b0001 
    
    output      m_axis_tvalid   ,
    input       m_axis_tready   ,
    output[31:0]m0_axis_tdata,m1_axis_tdata   ,m2_axis_tdata   ,m3_axis_tdata   ,
    output      m_axis_tlast    ,
    output      m_axis_tuser    
 );
    
    reg        	s_axis_tvalid_dly;
    reg[31:0]   s_axis_tdata_dly ;
    reg        	s_axis_tlast_dly ;
    reg        	s_axis_tuser_dly ;
    reg        	s_axis_tready_reg;
    
    reg         m_axis_tready_dly;
    reg         m_axis_tvalid_reg;
    reg[127:0]  m_axis_tdata_reg ;//24*4 
    reg         m_axis_tlast_reg ; 
    reg         m_axis_tuser_reg ; 
    
    
    wire        data_put_together_tlast	;
    wire        data_put_together_tready;
    wire        data_put_together_tuser ;
    wire        data_put_together_tvalid;
    wire[31:0]  data_put_together_tdata ; 
    
    reg[31:0]	fifo_0_s_axis_tdata	;
    reg      	fifo_0_s_axis_tlast ;
    wire     	fifo_0_s_axis_tready;
    reg      	fifo_0_s_axis_tuser ;
    reg      	fifo_0_s_axis_tvalid;
    
    wire[31:0]	fifo_0_m_axis_tdata ;
    wire      	fifo_0_m_axis_tlast ;
    wire      	fifo_0_m_axis_tready;
    wire      	fifo_0_m_axis_tuser ;
    wire      	fifo_0_m_axis_tvalid;
    
    wire[127:0]	dconv_m_axis_tdata 	;
    wire      	dconv_m_axis_tlast 	;
    wire      	dconv_m_axis_tready	;
    wire[15:0 ]	dconv_m_axis_tkeep 	;
    wire[15:0]	dconv_m_axis_tuser 	;
    wire      	dconv_m_axis_tvalid	;
    
    always@(posedge s_aclk)
    begin
    
        s_axis_tvalid_dly <= s_axis_tvalid;
        s_axis_tdata_dly  <= s_axis_tdata ;
        s_axis_tlast_dly  <= s_axis_tlast ;
        s_axis_tuser_dly  <= s_axis_tuser ;
        s_axis_tready_reg <= fifo_0_s_axis_tready;
    end
    
    
    data_put_together
    #(
        .DATA_WIDTH(DATA_WIDTH),
        .IMG_WIDTH(IMG_WIDTH)
    )
    data_put_together_i
    (
    .pixel_clk    (s_aclk           ), 
    .s_axis_tdata (s_axis_tdata_dly ),
    .s_axis_tlast (s_axis_tlast_dly ),
    .s_axis_tuser (s_axis_tuser_dly ),
    .s_axis_tvalid(s_axis_tvalid_dly),
    
    .m_axis_tlast ( data_put_together_tlast ),
    .m_axis_tuser ( data_put_together_tuser ),
    .m_axis_tvalid( data_put_together_tvalid),
    .m_axis_tdata ( data_put_together_tdata )   
    
    );    
    
    always@(posedge s_aclk)
    begin
        case(debug_cmd)//4'b0001
        4'b0000:
        begin
            fifo_0_s_axis_tvalid =  s_axis_tvalid_dly;
            fifo_0_s_axis_tdata  =  s_axis_tdata_dly ;
            fifo_0_s_axis_tlast  =  s_axis_tlast_dly ;
            fifo_0_s_axis_tuser  =  s_axis_tuser_dly ;
        end
        4'b0001:
        begin
            fifo_0_s_axis_tvalid =  data_put_together_tvalid;
            fifo_0_s_axis_tdata  =  data_put_together_tdata ;
            fifo_0_s_axis_tlast  =  data_put_together_tlast ;
            fifo_0_s_axis_tuser  =  data_put_together_tuser ;     
        end
        default:
        begin
            fifo_0_s_axis_tvalid =  s_axis_tvalid_dly;
            fifo_0_s_axis_tdata  =  s_axis_tdata_dly ;
            fifo_0_s_axis_tlast  =  s_axis_tlast_dly ;
            fifo_0_s_axis_tuser  =  s_axis_tuser_dly ;
        end
        endcase
    end
    
    

    fifo_generator_0 fifo_0_i
    (
        .m_aclk       (m_aclk              ),
        .s_aclk       (s_aclk              ),
        .s_aresetn    (s_aresetn           ),
        .s_axis_tvalid(fifo_0_s_axis_tvalid),
        .s_axis_tready(fifo_0_s_axis_tready),
        .s_axis_tdata (fifo_0_s_axis_tdata ),
        .s_axis_tlast (fifo_0_s_axis_tlast ),//当TLAST信号被响应或者FIFO满了,存储的传送数据将被送至AXI4-Stream master interface（axis_dwidth_converter_0）。
        .s_axis_tuser (fifo_0_s_axis_tuser ), 
        
        .m_axis_tvalid(fifo_0_m_axis_tvalid),
        .m_axis_tready(fifo_0_m_axis_tready),
        .m_axis_tdata (fifo_0_m_axis_tdata ),
        .m_axis_tlast (fifo_0_m_axis_tlast ),
        .m_axis_tuser (fifo_0_m_axis_tuser )
    ); 
    
    
 //数据宽度Slaver：Master=1：4  即8：32
 //数据宽度Slaver：Master=1：4  即32：128
    axis_dwidth_converter_0 dconv_i
    (
        .aclk         (m_aclk              ),
        .aresetn      (s_aresetn           ),
        .s_axis_tvalid(fifo_0_m_axis_tvalid),
        .s_axis_tready(fifo_0_m_axis_tready),
        .s_axis_tdata (fifo_0_m_axis_tdata ),
        .s_axis_tlast (fifo_0_m_axis_tlast ),
        .s_axis_tuser ({fifo_0_m_axis_tuser,fifo_0_m_axis_tuser,fifo_0_m_axis_tuser,fifo_0_m_axis_tuser} ), 
              
        .m_axis_tvalid(dconv_m_axis_tvalid ),
        .m_axis_tready(m_axis_tready_dly   ),
        .m_axis_tdata (dconv_m_axis_tdata  ),
        .m_axis_tkeep (dconv_m_axis_tkeep  ),
        .m_axis_tlast (dconv_m_axis_tlast  ),
        .m_axis_tuser (dconv_m_axis_tuser  )
    );
    
    always@(posedge m_aclk)
    begin
        m_axis_tvalid_reg <= dconv_m_axis_tvalid;
        m_axis_tdata_reg  <= dconv_m_axis_tdata ;
        m_axis_tlast_reg  <= dconv_m_axis_tlast ;
        m_axis_tuser_reg  <= dconv_m_axis_tuser[0] ;
        m_axis_tready_dly <= m_axis_tready 		;
    end
    
    assign  m_axis_tvalid = m_axis_tvalid_reg;
    assign  m0_axis_tdata = {m_axis_tdata_reg[103: 96],m_axis_tdata_reg[71:64],m_axis_tdata_reg[39:32],m_axis_tdata_reg[ 7: 0]};
	assign  m1_axis_tdata = {m_axis_tdata_reg[111:104],m_axis_tdata_reg[79:72],m_axis_tdata_reg[47:40],m_axis_tdata_reg[15: 8]};
	assign  m2_axis_tdata = {m_axis_tdata_reg[119:112],m_axis_tdata_reg[87:80],m_axis_tdata_reg[55:48],m_axis_tdata_reg[23:16]};
	assign  m3_axis_tdata = {m_axis_tdata_reg[127:120],m_axis_tdata_reg[95:88],m_axis_tdata_reg[63:56],m_axis_tdata_reg[31:24]};
    assign  m_axis_tlast  = m_axis_tlast_reg;  
    assign  m_axis_tuser  = m_axis_tuser_reg;   
    assign  s_axis_tready = fifo_0_s_axis_tready;
    assign  dconv_m_axis_tready = m_axis_tready ;
endmodule
