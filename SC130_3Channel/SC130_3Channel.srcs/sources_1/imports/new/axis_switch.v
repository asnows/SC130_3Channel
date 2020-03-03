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
//ͼ��������ͨ���л�����ѡ��ʵʱ�ɼ�ͨ�����Ǵ����ɼ�ͨ��

    module axis_switch
    (
        input       aclk            ,//FCLK_CLK0 from design_1_wrapper 100
        input       vsyhc           ,//֡ͬ�� 
        input       ps_triger0      ,//PSд������ݣ�from slv_reg0[2]���ߵ�ƽ����m1ץͼͼ��ɼ�
		input       ps_triger1      ,//PSд������ݣ�from slv_reg0[3]���ߵ�ƽ����m0ʵʱͼ��ɼ�
        output      pl_achieve      ,//PS���������ݣ�to R0_reg1[1]-->PSRO_reg2   ��fpga ���һ֡д�룩     
        input       s_axis_tvalid   ,//�������ߴӻ����ݱ��δ�����Ч��
        output      s_axis_tready   ,//�ӻ������������ô���׼����
       // input[31:0] s_axis_tdata    ,//ssx_axis_tdata,ssy_axis_tdata,//���ݣ���ѡ���32,64,128,256bit
        input       s_axis_tlast    ,//�������ߴӻ��ôδ���Ϊͻ������Ľ�β��
        input       s_axis_tuser    ,//�û������źţ����Ϊ128bit��
        output      m_0_axis_tvalid ,
        input       m_0_axis_tready ,//PS����PL���ô���׼��
        input       m_2_axis_tready ,//PS����PL���ô���׼��
        input       m_3_axis_tready ,//PS����PL���ô���׼��
        output[31:0]m_0_axis_tdata  ,
        output      m_0_axis_tlast  ,
        output      m_0_axis_tuser  ,
        output      m_1_axis_tvalid ,
        input       m_1_axis_tready ,//PS����PL���ô���׼��
       // output[31:0]m_1_axis_tdata  ,
        output      m_1_axis_tlast  ,
        output      m_1_axis_tuser  
    );
    
    localparam LH = 2'b01,HL=2'b10;
    reg tran_1frame  = 0;
	reg tran_en      = 0;
	reg pl_achieve_reg = 0; //fpga ���һ֡д��
	reg[1:0] vsyhc_reg = 2'b00;
	reg[1:0] ps_triger0_reg = 2'b00;
	
//һ��ͼ��Ϊһ֡���ݣ�vsyhcʹ����ps_triger0��һ�������ɼ�1��ͼ
	assign m_1_axis_tvalid = (s_axis_tvalid & tran_en);//s_axis_tvalid�������ߴӻ����ݱ��δ�����Ч
//	assign m_1_axis_tdata  = s_axis_tdata  ;
	assign m_1_axis_tlast  = s_axis_tlast  ;//from data_conv_model.v	  	
	assign m_1_axis_tuser  = (s_axis_tuser & tran_en);	

//һ��ͼ��Ϊһ֡���ݣ�vsyhcʹ����ps_triger1��һ��ʵʱ�ɼ�1��ͼ	�������ɼ�ʱʵʱ���ɼ���
	assign m_0_axis_tvalid = (s_axis_tvalid & ps_triger1 & (~tran_en));	
//	assign m_0_axis_tdata  = s_axis_tdata  ;
	assign m_0_axis_tlast  = s_axis_tlast  ;//from data_conv_model.v		
	assign m_0_axis_tuser  = (s_axis_tuser & ps_triger1 & (~tran_en));
	
	

	assign s_axis_tready = (m_0_axis_tready || m_1_axis_tready|| m_2_axis_tready|| m_3_axis_tready  );//to data_conv_model.v
	assign pl_achieve    = pl_achieve_reg;//fpga ���һ֡(һ��ͼ)д�� to ps   ������ʲô��	

    always@(posedge aclk )
    begin
        vsyhc_reg <= {vsyhc_reg[0],vsyhc}; //����(ȡ��ǰ���������ڵ�ֵ������ȡ��)
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
        if(vsyhc_reg == LH)//vsyhc��֡ͬ������������
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
    
    
    
    
