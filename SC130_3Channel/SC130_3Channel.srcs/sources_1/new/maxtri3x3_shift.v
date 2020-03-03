`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/10/31 17:01:10
// Design Name: 
// Module Name: maxtri3x3_shift
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
`define USE_FIFO
//`define USE_SHIFT

module maxtri3x3_shift
#(
    parameter IMG_HEIGHT = 480
)
(
    input          pixel_clk,
    input[9 : 0 ]  s_axis_tdata ,
    input          s_axis_tlast ,
    input          s_axis_tuser ,
    input          s_axis_tvalid ,
    
    output         m_axis_tlast ,
    output         m_axis_tuser ,
    output         m_axis_tvalid ,   
    output[9:0]    matrix_01,
    output[9:0]    matrix_11,
    output[9:0]    matrix_21

);
     
//     parameter IMG_WIDTH = 480;
//     parameter HL = 2'b10;
     localparam HL = 2'b10;
     
     reg start_flg = 1'b0;
     reg[10:0] line_count;
     reg[1:0] tvalid_reg;
     
     reg       s_axis_tlast_dly1 ;
     reg       s_axis_tuser_dly1 ;
     reg       s_axis_tvalid_dly1;
     reg[9:0]  s_axis_tdata_dly1 ;
     
//     reg       s_axis_tready_dly1;
    reg        s_axis_tlast_dly2 ;
    reg        s_axis_tuser_dly2 ;
    reg        s_axis_tvalid_dly2;
    reg[9:0]   s_axis_tdata_dly2 ;
    
    reg        s_axis_tlast_dly3 ;
    reg        s_axis_tuser_dly3 ;
    reg        s_axis_tvalid_dly3;
    reg[9:0]   s_axis_tdata_dly3 ;    

     
     reg      line_buff_0_tlast ;
     reg      line_buff_0_tuser ;
     reg      line_buff_0_tvalid;  
     reg[9:0] line_buff_0_tdata ;
     
     reg      line_buff_1_tlast ;
     reg      line_buff_1_tuser ;
     reg      line_buff_1_tvalid;  
     reg[9:0] line_buff_1_tdata ;
     
     reg        line_buff_1_CE;
     reg[12:0]  line_buff_1_D ;
     wire[12:0] line_buff_1_Q ;

     reg      line_buff_2_tlast ;
     reg      line_buff_2_tuser ;
     reg      line_buff_2_tvalid;  
     reg[9:0] line_buff_2_tdata ;
     
     wire[12:0] line_buff_2_Q ;
     
     
    assign m_axis_tlast  = line_buff_1_tlast ;
    assign m_axis_tuser  = line_buff_1_tuser;
    assign m_axis_tvalid = line_buff_1_tvalid;   
    assign matrix_01     = line_buff_0_tdata ;
    assign matrix_11     = line_buff_1_tdata ;
    assign matrix_21     = line_buff_2_tdata ;
     
     
//    assign  s_axis_tready = s_axis_tready_dly1;

    always@(posedge pixel_clk )
    begin
        s_axis_tlast_dly1 <= s_axis_tlast ;
        s_axis_tuser_dly1 <= s_axis_tuser ;
        s_axis_tvalid_dly1<= s_axis_tvalid;
        s_axis_tdata_dly1 <= s_axis_tdata ;
//        s_axis_tready_dly1<= m_axis_tready;

        s_axis_tlast_dly2  <= s_axis_tlast_dly1  ;
        s_axis_tuser_dly2  <= s_axis_tuser_dly1  ;
        s_axis_tvalid_dly2 <= s_axis_tvalid_dly1 ;
        s_axis_tdata_dly2  <= s_axis_tdata_dly1  ;
        
        s_axis_tlast_dly3  <= s_axis_tlast_dly2  ;
        s_axis_tuser_dly3  <= s_axis_tuser_dly2  ;
        s_axis_tvalid_dly3 <= s_axis_tvalid_dly2 ;
        s_axis_tdata_dly3  <= s_axis_tdata_dly2  ;

    end
    
    always@(posedge pixel_clk)
    begin
        tvalid_reg <= {tvalid_reg[0],s_axis_tvalid};//左移
    end



    
    always@(posedge pixel_clk)
    begin
        if(s_axis_tuser)
        begin
            line_count <= 11'd0;    
        end
        else
        begin
            if(tvalid_reg == HL )//tvalid下降沿，像素行加1
            begin
                line_count <= line_count + 1'b1;    
            end
            else
            begin
                line_count <= line_count;
            end
        end
    end
    

`ifdef USE_FIFO
     wire[12:0] line_buff_dout_2 ;
     wire[12:0] line_buff_dout_1 ;
     
     reg        line_buff_1_wr;
     reg        line_buff_1_rd;
     reg        line_buff_2_wr;
     reg        line_buff_2_rd; 
     
     reg        line_buff_1_wr_ctrl;
     reg        line_buff_1_rd_ctrl;
     reg        line_buff_2_wr_ctrl;
     reg        line_buff_2_rd_ctrl; 
     
     
     
     always@(posedge pixel_clk)
     begin
     
        if(line_count == 11'd0)
        begin
            line_buff_1_rd <= 1'b0; 
//            line_buff_2_wr <= 1'b0;   
            line_buff_2_rd <= 1'b0;
        end
        else if(line_count == 11'd1)
        begin
            line_buff_1_rd <= s_axis_tvalid_dly1; 
//            line_buff_2_wr <= line_buff_1_rd;   
        end
        else if((11'd1 < line_count)&&(line_count < IMG_HEIGHT))
        begin
            line_buff_1_rd <= s_axis_tvalid_dly1; 
//            line_buff_2_wr <= line_buff_1_rd;   
            line_buff_2_rd <= s_axis_tvalid_dly1;
        end
        else if(line_count == IMG_HEIGHT)
        begin
            line_buff_1_rd <= 1'b1; 
//            line_buff_2_wr <= 1'b1;   
            line_buff_2_rd <= 1'b1;
        end
        else
        begin
            line_buff_1_rd <= line_buff_1_rd; 
//            line_buff_2_wr <= line_buff_2_wr;   
            line_buff_2_rd <= line_buff_2_rd;
        end
        
     end
     
     always@(posedge pixel_clk)
     begin
         line_buff_1_wr_ctrl <= s_axis_tvalid_dly2;//s_axis_tvalid延时2个pixel_clk
         line_buff_1_rd_ctrl <= line_buff_1_rd;
         line_buff_2_wr_ctrl <= line_buff_dout_1[10];//s_axis_tvalid_dly2经过line_buff_1输出
         line_buff_2_rd_ctrl <= line_buff_2_rd;
     end
     

    fifo_maxtrix line_buff_1
    (
        .clk   (pixel_clk     ),
        .srst  (s_axis_tuser  ),//
        .din   ({s_axis_tlast_dly2,s_axis_tuser_dly2,s_axis_tvalid_dly2,s_axis_tdata_dly2}),
        .wr_en (s_axis_tvalid_dly2 | line_buff_1_wr_ctrl),//即s_axis_tvalid_dly2
        .rd_en (line_buff_1_rd | line_buff_1_rd_ctrl),//s_axis_tvalid延时1个pixel_clk宽度向后+1个pixel_clk（即s_axis_tvalid_dly2宽度向前+1个pixel_clk）
        .dout  (line_buff_dout_1),
        .full (),
        .empty ()
    );


    fifo_maxtrix line_buff_2
    (
        .clk   (pixel_clk     ),
        .srst  (s_axis_tuser  ),
        .din   (line_buff_dout_1),
        .wr_en (line_buff_dout_1[10] | line_buff_2_wr_ctrl),
        .rd_en (line_buff_2_rd | line_buff_2_rd_ctrl),
        .dout  (line_buff_dout_2),
        .full (),
        .empty ()
    );
    
    always@(*)
    begin
    
        line_buff_0_tlast <= s_axis_tlast_dly3 ; 
        line_buff_0_tuser <= s_axis_tuser_dly3 ; 
        line_buff_0_tvalid<= s_axis_tvalid_dly3; 
        line_buff_0_tdata <= s_axis_tdata_dly3 ; 

        line_buff_1_tlast  <= line_buff_dout_1[12]; 
        line_buff_1_tuser  <= line_buff_dout_1[11];      
        line_buff_1_tvalid <= line_buff_dout_1[10];   
        line_buff_1_tdata  <= line_buff_dout_1[9:0]; 
        
        line_buff_2_tlast  <= line_buff_dout_2[12];  
        line_buff_2_tuser  <= line_buff_dout_2[11];  
        line_buff_2_tvalid <= line_buff_dout_2[10];  
        line_buff_2_tdata  <= line_buff_dout_2[9:0]; 
    end


`endif

`ifdef USE_SHIFT     
    
    always@(posedge pixel_clk)
    begin
    if(s_axis_tuser)
    begin
        start_flg <= 1'b1;
    end
    else
    begin
        if(line_count == IMG_HEIGHT)
        begin
            start_flg <= 1'b0;
        end
        else
        begin
            start_flg <= start_flg;    
        end
    end
    end   

   
     always@(*)
     begin
         line_buff_0_tlast <= s_axis_tlast_dly1 ; //s_axis_tlast 延时1个pixel_clk
         line_buff_0_tuser <= s_axis_tuser_dly1 ; //s_axis_tuser 延时1个pixel_clk
         line_buff_0_tvalid<= s_axis_tvalid_dly1; //s_axis_tvalid延时1个pixel_clk
         line_buff_0_tdata <= s_axis_tdata_dly1 ; //s_axis_tdata 延时1个pixel_clk
         
         line_buff_1_tuser  <= line_buff_1_Q[11] & s_axis_tvalid_dly1; 
         line_buff_2_tuser  <= line_buff_2_Q[11] & s_axis_tvalid_dly1 ;
         
         line_buff_1_tdata  <= line_buff_1_Q[9:0]; 
         line_buff_2_tdata  <= line_buff_2_Q[9:0]; 
     
        if(start_flg == 1'b1)
        begin                     
            line_buff_1_D <= { s_axis_tlast_dly1,s_axis_tuser_dly1,s_axis_tvalid_dly1, s_axis_tdata_dly1  };    
            line_buff_1_CE <=  s_axis_tvalid_dly1;
            if(line_count > 0)
            begin
                line_buff_1_tlast  <= s_axis_tlast_dly1 ; 
                line_buff_1_tvalid <= s_axis_tvalid_dly1;
            end
            else
            begin
                line_buff_1_tlast  <= 1'b0 ; 
                line_buff_1_tvalid <= 1'b0;
            end
            
            if(line_count > 1)
            begin
                line_buff_2_tlast  <= s_axis_tlast_dly1 ; 
                line_buff_2_tvalid <= s_axis_tvalid_dly1;
            end
            else
            begin
                line_buff_2_tlast  <= 1'b0 ; 
                line_buff_2_tvalid <= 1'b0;
            end
            
        end
        else
        begin
        
            line_buff_1_CE <=  1'b1;
            line_buff_1_D  <= 13'd0;
            
            line_buff_1_tlast  <= line_buff_1_Q[12] ; 
            line_buff_1_tvalid <= line_buff_1_Q[10] ;
            
            line_buff_2_tlast  <= line_buff_2_Q[12] ;
            line_buff_2_tvalid <= line_buff_2_Q[10] ;
        
        end
     end
    
    line_shift_ram_0 line_buff_1
    (
        .D   (line_buff_1_D ),
        .CLK (pixel_clk     ),
        .CE  (line_buff_1_CE),
        .Q   (line_buff_1_Q )
    );
    
    line_shift_ram_0 line_buff_2
    (
        .D   (line_buff_1_Q ),
        .CLK (pixel_clk     ),
        .CE  (line_buff_1_CE),
        .Q   (line_buff_2_Q )
    );
   
`endif


endmodule
