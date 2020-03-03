`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/10/18 10:58:06
// Design Name: 
// Module Name: cmos_sampling
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

module cmos_sampling
    #(
        parameter DATA_WIDTH = 10
    )
    (
//在源代码中加入关键字mark_debug="true"来告诉软件这个信号是要被调试的，从而在生成debug核的过程中，这些被调试的信号就直接显示出来了
                             input                       pixel_clk       ,       //DVP 时钟:即 PixCLK 表示输出数据时钟
       (*mark_debug="true"*)input                       vsync           ,       //帧同步 :即FSYNC 脉冲信号表示新一帧数据的开始 
       (*mark_debug="true"*)input                       href            ,       //行同步 :即LREF 表示数据行同步信号  
       (*mark_debug="true"*)input[DATA_WIDTH -1 : 0]    data_in         ,       //COMS 数据位
       
       (*mark_debug="true"*)output                      pixel_clk_out   ,
       (*mark_debug="true"*)output                      vsync_out       ,       
       (*mark_debug="true"*)output                      href_out        ,        
       (*mark_debug="true"*)output[DATA_WIDTH -1 : 0]   data_out

    
    );
    
    localparam HL = 2'b10;
    reg                       vsync_dly1  ;       
    reg                       href_dly1   ;        
    reg[DATA_WIDTH -1 : 0]    data_in_dly1;
    
    reg                      vsync_out_reg ;      
    reg                      href_out_reg ;       
    reg[DATA_WIDTH -1 : 0]   data_out_reg ;
    reg[1:0]  href_reg;  
    
    reg[10:0] href_count = 11'd0;

    assign vsync_out = vsync_out_reg;
    assign href_out  = href_out_reg ;
    assign data_out  = data_out_reg ;
    assign pixel_clk_out = pixel_clk;
    
//    BUF IBUF_inst
//    (
//        .O(pixel_clk_out),//Bufferoutput
//        .I(pixel_clk)//Bufferinput(connectdirectlytotop-levelport)
//    );
//在异步跨时钟域场合，对于控制信号（通常位宽为1-bit）常使用双触发器方法完成跨时钟域操作         
    always@(posedge pixel_clk)
    begin
        vsync_dly1   <=  vsync   ;
        href_dly1    <=  href    ;
        data_in_dly1 <=  data_in ;
        
        vsync_out_reg <= vsync_dly1  ;
        href_out_reg  <= href_dly1   ;
        data_out_reg  <= data_in_dly1;
        
        href_reg <= {href_reg[0],href};//左移(取出前后两个周期的值用来读取沿)
        
    end
//测试用   
    always@(posedge pixel_clk)
    begin
        if(vsync_dly1 == 1'b1)
        begin
            href_count <= 11'd0;
        end
        else if(href_reg == HL)//href（行同步）是下降沿
        begin
            href_count <= href_count + 1'b1;
        end       
    end
//测试用
    
    
    
    

endmodule
