`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/22 11:23:39
// Design Name: 
// Module Name: maxtri7x7_fifo
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
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/22 11:15:13
// Design Name: 
// Module Name: maxtri7x7_fifo
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


module maxtri7x7_fifo#(
    parameter DATA_WIDTH = 10,
    parameter IMG_HEIGHT = 480
)
(
    input       pixel_clk       ,
    input[DATA_WIDTH-1:0]  s_axis_tdata    ,
    input       s_axis_tlast    ,
    input       s_axis_tuser    ,
    input       s_axis_tvalid   ,
    
    output      line_buff_0_tlast    ,
    output      line_buff_0_tuser    ,
    output      line_buff_0_tvalid   ,
    output[DATA_WIDTH-1:0] line_buff_0_tdata, 
    
    output      line_buff_1_tlast    ,
    output      line_buff_1_tuser    ,
    output      line_buff_1_tvalid   ,
    output[DATA_WIDTH-1:0] line_buff_1_tdata, 
    
    output      line_buff_2_tlast    ,
    output      line_buff_2_tuser    ,
    output      line_buff_2_tvalid   ,
    output[DATA_WIDTH-1:0] line_buff_2_tdata, 
    
    output      line_buff_3_tlast    ,
    output      line_buff_3_tuser    ,
    output      line_buff_3_tvalid   ,
    output[DATA_WIDTH-1:0] line_buff_3_tdata, 
    
    output      line_buff_4_tlast    ,
    output      line_buff_4_tuser    ,
    output      line_buff_4_tvalid   ,
    output[DATA_WIDTH-1:0] line_buff_4_tdata, 
    
    output      line_buff_5_tlast    ,
    output      line_buff_5_tuser    ,
    output      line_buff_5_tvalid   ,
    output[DATA_WIDTH-1:0] line_buff_5_tdata, 
    
    output      line_buff_6_tlast    ,
    output      line_buff_6_tuser    ,
    output      line_buff_6_tvalid   ,
    output[DATA_WIDTH-1:0] line_buff_6_tdata 
    
);

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

     
//     reg      line_buff_0_tlast ,line_buff_1_tlast, line_buff_2_tlast, line_buff_3_tlast, line_buff_4_tlast, line_buff_5_tlast, line_buff_6_tlast ;
//     reg      line_buff_0_tuser ,line_buff_1_tuser, line_buff_2_tuser, line_buff_3_tuser, line_buff_4_tuser, line_buff_5_tuser, line_buff_6_tuser ;
//     reg      line_buff_0_tvalid,line_buff_1_tvalid,line_buff_2_tvalid,line_buff_3_tvalid,line_buff_4_tvalid,line_buff_5_tvalid,line_buff_6_tvalid;    
//     reg[9:0] line_buff_0_tdata ,line_buff_1_tdata, line_buff_2_tdata, line_buff_3_tdata, line_buff_4_tdata, line_buff_5_tdata, line_buff_6_tdata ;
          
     reg        line_buff_1_CE;
     reg[12:0]  line_buff_1_D ;
     wire[12:0] line_buff_1_Q ;


     
     wire[12:0] line_buff_2_Q ;
     

     
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
    

     wire[12:0] line_buff_dout_1,line_buff_dout_2,line_buff_dout_3,line_buff_dout_4,line_buff_dout_5,line_buff_dout_6,line_buff_dout_7 ;
     
     reg        line_buff_1_wr,line_buff_2_wr,line_buff_3_wr,line_buff_4_wr,line_buff_5_wr,line_buff_6_wr,line_buff_7_wr;
     reg        line_buff_1_rd,line_buff_2_rd,line_buff_3_rd,line_buff_4_rd,line_buff_5_rd,line_buff_6_rd,line_buff_7_rd;
     
     reg        line_buff_1_wr_ctrl,line_buff_2_wr_ctrl,line_buff_3_wr_ctrl,line_buff_4_wr_ctrl,line_buff_5_wr_ctrl,line_buff_6_wr_ctrl,line_buff_7_wr_ctrl;
     reg        line_buff_1_rd_ctrl,line_buff_2_rd_ctrl,line_buff_3_rd_ctrl,line_buff_4_rd_ctrl,line_buff_5_rd_ctrl,line_buff_6_rd_ctrl,line_buff_7_rd_ctrl; 

     
     
     
     always@(posedge pixel_clk)
     begin
        case(line_count)
        11'd0:begin
              line_buff_1_rd <= 1'b0; 
              line_buff_2_rd <= 1'b0;
              line_buff_3_rd <= 1'b0;
              line_buff_4_rd <= 1'b0;
              line_buff_5_rd <= 1'b0;
              line_buff_6_rd <= 1'b0;
              line_buff_7_rd <= 1'b0;
        end
        11'd1:begin
            line_buff_1_rd <= s_axis_tvalid_dly1; 
        end
        11'd2:begin
            line_buff_1_rd <= s_axis_tvalid_dly1;   
            line_buff_2_rd <= s_axis_tvalid_dly1;
        end
        11'd3:begin
            line_buff_1_rd <= s_axis_tvalid_dly1;   
            line_buff_2_rd <= s_axis_tvalid_dly1;
            line_buff_3_rd <= s_axis_tvalid_dly1;
        end
        11'd4:begin
            line_buff_1_rd <= s_axis_tvalid_dly1;   
            line_buff_2_rd <= s_axis_tvalid_dly1;
            line_buff_3_rd <= s_axis_tvalid_dly1;
            line_buff_4_rd <= s_axis_tvalid_dly1;
        end
        11'd5:begin
            line_buff_1_rd <= s_axis_tvalid_dly1;   
            line_buff_2_rd <= s_axis_tvalid_dly1;
            line_buff_3_rd <= s_axis_tvalid_dly1;
            line_buff_4_rd <= s_axis_tvalid_dly1;
            line_buff_5_rd <= s_axis_tvalid_dly1;
        end
        11'd6:begin
            line_buff_1_rd <= s_axis_tvalid_dly1;   
            line_buff_2_rd <= s_axis_tvalid_dly1;
            line_buff_3_rd <= s_axis_tvalid_dly1;
            line_buff_4_rd <= s_axis_tvalid_dly1;
            line_buff_5_rd <= s_axis_tvalid_dly1;
            line_buff_6_rd <= s_axis_tvalid_dly1;
        end
        11'd7:begin
            line_buff_1_rd <= s_axis_tvalid_dly1;   
            line_buff_2_rd <= s_axis_tvalid_dly1;
            line_buff_3_rd <= s_axis_tvalid_dly1;
            line_buff_4_rd <= s_axis_tvalid_dly1;
            line_buff_5_rd <= s_axis_tvalid_dly1;
            line_buff_6_rd <= s_axis_tvalid_dly1;
            line_buff_7_rd <= s_axis_tvalid_dly1;
        end
        IMG_HEIGHT:begin
            line_buff_1_rd <= 1'b1;   
            line_buff_2_rd <= 1'b1;
            line_buff_3_rd <= 1'b1;
            line_buff_4_rd <= 1'b1;
            line_buff_5_rd <= 1'b1;
            line_buff_6_rd <= 1'b1;
            line_buff_7_rd <= 1'b1;
        end
        default:
        begin
            line_buff_1_rd <= s_axis_tvalid_dly1;   
            line_buff_2_rd <= s_axis_tvalid_dly1;
            line_buff_3_rd <= s_axis_tvalid_dly1;
            line_buff_4_rd <= s_axis_tvalid_dly1;
            line_buff_5_rd <= s_axis_tvalid_dly1;
            line_buff_6_rd <= s_axis_tvalid_dly1;
            line_buff_7_rd <= s_axis_tvalid_dly1;
        end
        endcase
     end
     
     always@(posedge pixel_clk)
     begin
         line_buff_1_wr_ctrl <= s_axis_tvalid_dly2;//s_axis_tvalid延时2个pixel_clk
         line_buff_1_rd_ctrl <= line_buff_1_rd;
         line_buff_2_wr_ctrl <= line_buff_dout_1[10];//s_axis_tvalid_dly2经过line_buff_1输出
         line_buff_2_rd_ctrl <= line_buff_2_rd;
         line_buff_3_wr_ctrl <= line_buff_dout_2[10];//s_axis_tvalid_dly2经过line_buff_1输出
         line_buff_3_rd_ctrl <= line_buff_3_rd;
         line_buff_4_wr_ctrl <= line_buff_dout_3[10];//s_axis_tvalid_dly2经过line_buff_1输出
         line_buff_4_rd_ctrl <= line_buff_4_rd;
         line_buff_5_wr_ctrl <= line_buff_dout_4[10];//s_axis_tvalid_dly2经过line_buff_1输出
         line_buff_5_rd_ctrl <= line_buff_5_rd;
         line_buff_6_wr_ctrl <= line_buff_dout_5[10];//s_axis_tvalid_dly2经过line_buff_1输出
         line_buff_6_rd_ctrl <= line_buff_6_rd;
         line_buff_7_wr_ctrl <= line_buff_dout_6[10];//s_axis_tvalid_dly2经过line_buff_1输出
         line_buff_7_rd_ctrl <= line_buff_7_rd;
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
    fifo_maxtrix line_buff_3
        (
            .clk   (pixel_clk     ),
            .srst  (s_axis_tuser  ),
            .din   (line_buff_dout_2),
            .wr_en (line_buff_dout_2[10] | line_buff_3_wr_ctrl),
            .rd_en (line_buff_3_rd | line_buff_3_rd_ctrl),
            .dout  (line_buff_dout_3),
            .full (),
            .empty ()
        );
        
       fifo_maxtrix line_buff_4
               (
                   .clk   (pixel_clk     ),
                   .srst  (s_axis_tuser  ),
                   .din   (line_buff_dout_3),
                   .wr_en (line_buff_dout_3[10] | line_buff_4_wr_ctrl),
                   .rd_en (line_buff_4_rd | line_buff_4_rd_ctrl),
                   .dout  (line_buff_dout_4),
                   .full (),
                   .empty ()
               );
      fifo_maxtrix line_buff_5
    (
        .clk   (pixel_clk     ),
        .srst  (s_axis_tuser  ),
        .din   (line_buff_dout_4),
        .wr_en (line_buff_dout_4[10] | line_buff_5_wr_ctrl),
        .rd_en (line_buff_5_rd | line_buff_5_rd_ctrl),
        .dout  (line_buff_dout_5),
        .full (),
        .empty ()
    );
        fifo_maxtrix line_buff_6
     (
         .clk   (pixel_clk     ),
         .srst  (s_axis_tuser  ),
         .din   (line_buff_dout_5),
         .wr_en (line_buff_dout_5[10] | line_buff_6_wr_ctrl),
         .rd_en (line_buff_6_rd | line_buff_6_rd_ctrl),
         .dout  (line_buff_dout_6),
         .full (),
         .empty ()
     );

assign        line_buff_0_tlast = s_axis_tlast_dly3 ; 
assign        line_buff_0_tuser = s_axis_tuser_dly3 ; 
assign        line_buff_0_tvalid= s_axis_tvalid_dly3; 
assign        line_buff_0_tdata = s_axis_tdata_dly3 ; 

assign        line_buff_1_tlast = line_buff_dout_1[12]; 
assign        line_buff_1_tuser = line_buff_dout_1[11];      
assign        line_buff_1_tvalid= line_buff_dout_1[10];   
assign        line_buff_1_tdata = line_buff_dout_1[9:0]; 
        
assign        line_buff_2_tlast = line_buff_dout_2[12];  
assign        line_buff_2_tuser = line_buff_dout_2[11];  
assign        line_buff_2_tvalid= line_buff_dout_2[10];  
assign        line_buff_2_tdata = line_buff_dout_2[9:0]; 

assign        line_buff_3_tlast = line_buff_dout_3[12];  
assign        line_buff_3_tuser = line_buff_dout_3[11];  
assign        line_buff_3_tvalid= line_buff_dout_3[10];  
assign        line_buff_3_tdata = line_buff_dout_3[9:0]; 

assign        line_buff_4_tlast = line_buff_dout_4[12];  
assign        line_buff_4_tuser = line_buff_dout_4[11];  
assign        line_buff_4_tvalid= line_buff_dout_4[10];  
assign        line_buff_4_tdata = line_buff_dout_4[9:0]; 

assign        line_buff_5_tlast = line_buff_dout_5[12];  
assign        line_buff_5_tuser = line_buff_dout_5[11];  
assign        line_buff_5_tvalid= line_buff_dout_5[10];  
assign        line_buff_5_tdata = line_buff_dout_5[9:0]; 

assign        line_buff_6_tlast = line_buff_dout_6[12];  
assign        line_buff_6_tuser = line_buff_dout_6[11];  
assign        line_buff_6_tvalid= line_buff_dout_6[10];  
assign        line_buff_6_tdata = line_buff_dout_6[9:0]; 


endmodule
