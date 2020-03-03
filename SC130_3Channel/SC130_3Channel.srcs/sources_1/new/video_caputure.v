`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/08 15:06:46
// Design Name: 
// Module Name: video_caputure
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


    module video_caputure 
    (
        input  wire          piexl_clk    ,//DVP ʱ��
        input  wire          href         ,//��ͬ��
        input  wire          vsync        ,//֡ͬ��
        input  wire [ 9 : 0] data_in      ,//ͬ�����//COMS ����λ
        input  wire [12 : 0] img_width    ,//from PS ��WO_reg1[12:0]
        output wire [9 : 0 ] m_axis_tdata ,
        output wire          m_axis_tlast ,
       // input  wire          m_axis_tready,
        output wire          m_axis_tuser ,
        output wire          m_axis_tvalid    
    );

        reg[10:0]     row_pixels_count = 11'd0;
        (*mark_debug="true"*)reg           tlast_tmp;
        (*mark_debug="true"*)reg           tuser_tmp ;

        reg  [12 : 0] reg_img_width = 13'd640;

        assign m_axis_tdata = data_in; 
        assign m_axis_tlast = tlast_tmp; 
//        assign m_axis_tready= s_axis_tready; 
        assign m_axis_tuser =(tuser_tmp & href); 
        assign m_axis_tvalid = href;
           
//ÿһ֡��ʼʱ����1�����ڿ���ź�        
//generate tuser
        always @(posedge piexl_clk)
        begin
            if(vsync == 1)
                begin
                    tuser_tmp <= 1'b1;    
                end
            else if(href == 1)
                begin
                    tuser_tmp <= 1'b0;
                end
            else
                begin
                    tuser_tmp <= tuser_tmp;
                end
                 
        end
         
//ͳ�ƴ���һ�еĹ����У�href����ͬ���źţ������ڣ�piexl_clkΪ��λ��������Ĭ��=IMG_WIDTH=1280��1280*1024��
//count row pixels
        always @(posedge piexl_clk)
        begin
            if(vsync == 1 )
                begin
                    row_pixels_count <= 11'd0;
                    reg_img_width <= img_width;
                end
            else if(href == 1)
                begin
                    row_pixels_count <= row_pixels_count + 1; 
                end
            else
                begin
                    row_pixels_count <= 11'd0;
                end
        end
 //һ�н���ʱ����tlast�ź� ��reg_img_width=href�Ŀ�ȣ�piexl_clkΪ��λ��   
//genrate tlast���н�β
        always @(posedge piexl_clk)
        begin
            if(row_pixels_count == (reg_img_width - 2))
                begin
                    tlast_tmp <= 1'b1;
                end
            else
                begin
                    tlast_tmp <= 1'b0;
                end
        end
                      
endmodule
