`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/13 09:57:46
// Design Name: 
// Module Name: axis_switch
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
//图像数据流通道切换，是选择实时采集通道还是触发采集通道

    module axis_switch
    (
        input       aclk            ,//FCLK_CLK0 from design_1_wrapper 100
        input       vsyhc           ,//帧同步 
        input       ps_triger0      ,//PS写入的数据，from slv_reg0[2]，高电平控制m1抓图图像采集
		input       ps_triger1      ,//PS写入的数据，from slv_reg0[3]，高电平控制m0实时图像采集
        output      pl_achieve      ,//PS读出的数据，to R0_reg1[1]-->PSRO_reg2   （fpga 完成一帧写入）     
        input       s_axis_tvalid   ,//主机告诉从机数据本次传输有效；
        output      s_axis_tready   ,//从机告诉主机做好传输准备；
       // input[31:0] s_axis_tdata    ,//ssx_axis_tdata,ssy_axis_tdata,//数据，可选宽度32,64,128,256bit
        input       s_axis_tlast    ,//主机告诉从机该次传输为突发传输的结尾；
        input       s_axis_tuser    ,//用户定义信号，宽度为128bit。
        output      m_0_axis_tvalid ,
        input       m_0_axis_tready ,//PS告诉PL做好传输准备
        input       m_2_axis_tready ,//PS告诉PL做好传输准备
        input       m_3_axis_tready ,//PS告诉PL做好传输准备
        output[31:0]m_0_axis_tdata  ,
        output      m_0_axis_tlast  ,
        output      m_0_axis_tuser  ,
        output      m_1_axis_tvalid ,
        input       m_1_axis_tready ,//PS告诉PL做好传输准备
       // output[31:0]m_1_axis_tdata  ,
        output      m_1_axis_tlast  ,
        output      m_1_axis_tuser  
    );
    
    localparam LH = 2'b01,HL=2'b10;
    reg tran_1frame  = 0;
	reg tran_en      = 0;
	reg pl_achieve_reg = 0; //fpga 完成一帧写入
	reg[1:0] vsyhc_reg = 2'b00;
	reg[1:0] ps_triger0_reg = 2'b00;
	
//一张图作为一帧数据，vsyhc使能且ps_triger0置一，触发采集1张图
	assign m_1_axis_tvalid = (s_axis_tvalid & tran_en);//s_axis_tvalid主机告诉从机数据本次传输有效
//	assign m_1_axis_tdata  = s_axis_tdata  ;
	assign m_1_axis_tlast  = s_axis_tlast  ;//from data_conv_model.v	  	
	assign m_1_axis_tuser  = (s_axis_tuser & tran_en);	

//一张图作为一帧数据，vsyhc使能且ps_triger1置一，实时采集1张图	（触发采集时实时不采集）
	assign m_0_axis_tvalid = (s_axis_tvalid & ps_triger1 & (~tran_en));	
//	assign m_0_axis_tdata  = s_axis_tdata  ;
	assign m_0_axis_tlast  = s_axis_tlast  ;//from data_conv_model.v		
	assign m_0_axis_tuser  = (s_axis_tuser & ps_triger1 & (~tran_en));
	
	

	assign s_axis_tready = (m_0_axis_tready || m_1_axis_tready|| m_2_axis_tready|| m_3_axis_tready  );//to data_conv_model.v
	assign pl_achieve    = pl_achieve_reg;//fpga 完成一帧(一张图)写入 to ps   用来干什么？	

    always@(posedge aclk )
    begin
        vsyhc_reg <= {vsyhc_reg[0],vsyhc}; //左移(取出前后两个周期的值用来读取沿)
        ps_triger0_reg <={ps_triger0_reg[0],ps_triger0};   
    end
    
    always@(posedge aclk)
    begin
        if(vsyhc_reg == LH)
        begin
            if(ps_triger0 == 1)
                begin
                    tran_1frame <= 1'b1;
                end
            else
                begin
                    tran_1frame <= 1'b0;
                end
        end

    end
    
    
    always@(posedge aclk)
    begin
        if(vsyhc_reg == LH)//vsyhc（帧同步）是上升沿
        begin
            if((ps_triger0 == 1) && (tran_1frame == 0))
                begin
                    tran_en <= 1'b1;              
                end
            else
                begin
                    tran_en <= 1'b0;
                end
        end

    end
    
    
    always@(posedge aclk)
    begin            
        if(vsyhc_reg == LH )
        begin
            if((ps_triger0 == 1)&&(tran_1frame == 1))
            begin
                pl_achieve_reg <= 1'b1;  
            end
            else
            begin
                pl_achieve_reg <= 1'b0;
            end
        end
        else
        begin
            if(ps_triger0_reg == HL)
            begin
                pl_achieve_reg <= 1'b0;
            end           
        end            
    end

    endmodule
    
    
    
    
