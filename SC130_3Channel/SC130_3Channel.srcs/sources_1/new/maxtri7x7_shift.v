`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/29 11:00:59
// Design Name: 
// Module Name: maxtri7x7_shift
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


module maxtri7x7_shift
    #(
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
    
    reg[DATA_WIDTH-1:0] s_axis_tdata_dly1 , s_axis_tdata_dly2 ;
    reg                 s_axis_tlast_dly1 , s_axis_tlast_dly2 ;
    reg                 s_axis_tuser_dly1 , s_axis_tuser_dly2 ;
    reg                 s_axis_tvalid_dly1, s_axis_tvalid_dly2;
    
    reg[DATA_WIDTH-1:0]  line_buff_0_tdata_reg ,line_buff_1_tdata_reg ,line_buff_2_tdata_reg ,
                         line_buff_3_tdata_reg ,line_buff_4_tdata_reg ,line_buff_5_tdata_reg ,line_buff_6_tdata_reg  ;
    reg                  line_buff_0_tlast_reg ,line_buff_1_tlast_reg ,line_buff_2_tlast_reg ,
                         line_buff_3_tlast_reg ,line_buff_4_tlast_reg ,line_buff_5_tlast_reg ,line_buff_6_tlast_reg  ;
    reg                  line_buff_0_tuser_reg ,line_buff_1_tuser_reg ,line_buff_2_tuser_reg ,
                         line_buff_3_tuser_reg ,line_buff_4_tuser_reg ,line_buff_5_tuser_reg ,line_buff_6_tuser_reg  ;
    reg                  line_buff_0_tvalid_reg,line_buff_1_tvalid_reg,line_buff_2_tvalid_reg,
                         line_buff_3_tvalid_reg,line_buff_4_tvalid_reg,line_buff_5_tvalid_reg,line_buff_6_tvalid_reg ;  
    
    wire[DATA_WIDTH + 2:0] line_buff_1_D  , line_buff_2_D  , line_buff_3_D  , line_buff_4_D  , line_buff_5_D  , line_buff_6_D ;
    wire                 line_buff_1_CE , line_buff_2_CE , line_buff_3_CE , line_buff_4_CE , line_buff_5_CE , line_buff_6_CE;
    wire[DATA_WIDTH + 2:0] line_buff_1_Q  , line_buff_2_Q  , line_buff_3_Q  , line_buff_4_Q  , line_buff_5_Q  , line_buff_6_Q ;
    reg[9:0] count = 10'd0;          
    
   //out connect
    assign line_buff_0_tlast  = line_buff_0_tlast_reg  ;
    assign line_buff_0_tuser  = line_buff_0_tuser_reg  ;
    assign line_buff_0_tvalid = line_buff_0_tvalid_reg ;
    assign line_buff_0_tdata  = line_buff_0_tdata_reg  ;
    
    assign line_buff_1_tlast  = line_buff_1_tlast_reg  ;
    assign line_buff_1_tuser  = (count < IMG_HEIGHT )? (line_buff_1_tuser_reg  & line_buff_0_tvalid_reg) : line_buff_1_tuser_reg  ;
    assign line_buff_1_tvalid = (count < IMG_HEIGHT )? (line_buff_1_tvalid_reg & line_buff_0_tvalid_reg) : line_buff_1_tvalid_reg ;
    assign line_buff_1_tdata  = line_buff_1_tdata_reg  ;
    
    
    assign line_buff_2_tlast  = line_buff_2_tlast_reg  ;
    assign line_buff_2_tuser  = (count < IMG_HEIGHT )? (line_buff_2_tuser_reg  & line_buff_0_tvalid_reg) : line_buff_2_tuser_reg  ;
    assign line_buff_2_tvalid = (count < IMG_HEIGHT )? (line_buff_2_tvalid_reg & line_buff_0_tvalid_reg) : line_buff_2_tvalid_reg ;
    assign line_buff_2_tdata  = line_buff_2_tdata_reg  ;
    
    assign line_buff_3_tlast  = line_buff_3_tlast_reg  ;
    assign line_buff_3_tuser  = (count < IMG_HEIGHT )? (line_buff_3_tuser_reg  & line_buff_0_tvalid_reg) : line_buff_3_tuser_reg  ;
    assign line_buff_3_tvalid = (count < IMG_HEIGHT )? (line_buff_3_tvalid_reg & line_buff_0_tvalid_reg) : line_buff_3_tvalid_reg ;
    assign line_buff_3_tdata  = line_buff_3_tdata_reg  ;
    
    assign line_buff_4_tlast  = line_buff_4_tlast_reg  ;
    assign line_buff_4_tuser  = (count < IMG_HEIGHT )? (line_buff_4_tuser_reg  & line_buff_0_tvalid_reg) : line_buff_4_tuser_reg  ;
    assign line_buff_4_tvalid = (count < IMG_HEIGHT )? (line_buff_4_tvalid_reg & line_buff_0_tvalid_reg) : line_buff_4_tvalid_reg ;
    assign line_buff_4_tdata  = line_buff_4_tdata_reg  ;

    assign line_buff_5_tlast  = line_buff_5_tlast_reg  ;
    assign line_buff_5_tuser  = (count < IMG_HEIGHT )? (line_buff_5_tuser_reg  & line_buff_0_tvalid_reg) : line_buff_5_tuser_reg  ;
    assign line_buff_5_tvalid = (count < IMG_HEIGHT )? (line_buff_5_tvalid_reg & line_buff_0_tvalid_reg) : line_buff_5_tvalid_reg ;
    assign line_buff_5_tdata  = line_buff_5_tdata_reg  ;

    assign line_buff_6_tlast  = line_buff_6_tlast_reg  ;                                                             
    assign line_buff_6_tuser  = (count < IMG_HEIGHT )? (line_buff_6_tuser_reg  & line_buff_0_tvalid_reg) : line_buff_6_tuser_reg  ;
    assign line_buff_6_tvalid = (count < IMG_HEIGHT )? (line_buff_6_tvalid_reg & line_buff_0_tvalid_reg) : line_buff_6_tvalid_reg ;
    assign line_buff_6_tdata  = line_buff_6_tdata_reg  ;
  
    
    
    always@(posedge pixel_clk )
    begin
        s_axis_tlast_dly1 <= s_axis_tlast ;
        s_axis_tuser_dly1 <= s_axis_tuser ;
        s_axis_tvalid_dly1<= s_axis_tvalid;
        s_axis_tdata_dly1 <= s_axis_tdata ;
        
        s_axis_tlast_dly2 <= s_axis_tlast_dly1 ;
        s_axis_tuser_dly2 <= s_axis_tuser_dly1 ;
        s_axis_tvalid_dly2<= s_axis_tvalid_dly1;
        s_axis_tdata_dly2 <= s_axis_tdata_dly1 ;
    end
    
    always@(posedge pixel_clk)
    begin
        if(s_axis_tuser_dly1 == 1)
        begin
            count <= 10'd0;    
        end
        else
        begin
            if(s_axis_tlast_dly2 == 1)
            begin
                count <= count + 1'b1;      
            end
            else
            begin
                count <= count;
            end
        end
    end
    
    
    
    // shift connect
    assign line_buff_1_D  = {s_axis_tlast_dly2,s_axis_tuser_dly2,s_axis_tvalid_dly2,s_axis_tdata_dly2};
    assign line_buff_1_CE = (count < IMG_HEIGHT )? s_axis_tvalid_dly2 : 1'b1;
    
    assign line_buff_2_D  = line_buff_1_Q;
    assign line_buff_2_CE = line_buff_1_CE;
    
    assign line_buff_3_D  = line_buff_2_Q;
    assign line_buff_3_CE = line_buff_1_CE;
    
    assign line_buff_4_D  = line_buff_3_Q;    
    assign line_buff_4_CE = line_buff_1_CE;  
    
    assign line_buff_5_D  = line_buff_4_Q;
    assign line_buff_5_CE = line_buff_1_CE;
    
    assign line_buff_6_D  = line_buff_5_Q;
    assign line_buff_6_CE = line_buff_1_CE;
    
    
    
   // out reg 
   always@(posedge pixel_clk)
    begin
        line_buff_0_tlast_reg <= s_axis_tlast_dly2 ;
        line_buff_0_tuser_reg <= s_axis_tuser_dly2 ;
        line_buff_0_tvalid_reg<= s_axis_tvalid_dly2;
        line_buff_0_tdata_reg <= s_axis_tdata_dly2 ;
        
        line_buff_1_tlast_reg <= line_buff_1_Q[12];
        line_buff_1_tuser_reg <= line_buff_1_Q[11];
        line_buff_1_tvalid_reg<= line_buff_1_Q[10];
        line_buff_1_tdata_reg <= line_buff_1_Q[9:0];
        
        line_buff_2_tlast_reg <= line_buff_2_Q[12];
        line_buff_2_tuser_reg <= line_buff_2_Q[11];
        line_buff_2_tvalid_reg<= line_buff_2_Q[10];
        line_buff_2_tdata_reg <= line_buff_2_Q[9:0];
    
        line_buff_3_tlast_reg <= line_buff_3_Q[12];
        line_buff_3_tuser_reg <= line_buff_3_Q[11];
        line_buff_3_tvalid_reg<= line_buff_3_Q[10];
        line_buff_3_tdata_reg <= line_buff_3_Q[9:0];
    
        line_buff_4_tlast_reg <= line_buff_4_Q[12];
        line_buff_4_tuser_reg <= line_buff_4_Q[11];
        line_buff_4_tvalid_reg<= line_buff_4_Q[10];
        line_buff_4_tdata_reg <= line_buff_4_Q[9:0];
        
        line_buff_5_tlast_reg <= line_buff_5_Q[12];
        line_buff_5_tuser_reg <= line_buff_5_Q[11];
        line_buff_5_tvalid_reg<= line_buff_5_Q[10];
        line_buff_5_tdata_reg <= line_buff_5_Q[9:0];
        
        line_buff_6_tlast_reg <= line_buff_6_Q[12];
        line_buff_6_tuser_reg <= line_buff_6_Q[11];
        line_buff_6_tvalid_reg<= line_buff_6_Q[10];
        line_buff_6_tdata_reg <= line_buff_6_Q[9:0];
    
    end 
    
    
    
    maxtri7x7_shift_ram_0 line_buff_1
    (
        .D   (line_buff_1_D  ),
        .CLK (pixel_clk),
        .CE  (line_buff_1_CE ),
        .Q   (line_buff_1_Q  )
    );
    
    
    maxtri7x7_shift_ram_0 line_buff_2
    (
        .D   (line_buff_2_D  ),
        .CLK (pixel_clk),
        .CE  (line_buff_2_CE ),
        .Q   (line_buff_2_Q  )
    );
    
    
    maxtri7x7_shift_ram_0 line_buff_3
    (
       .D   (line_buff_3_D  ),
       .CLK (pixel_clk),
       .CE  (line_buff_3_CE ),
       .Q   (line_buff_3_Q  )
    );
    
    
    maxtri7x7_shift_ram_0 line_buff_4
    (
        .D   (line_buff_4_D  ),
        .CLK (pixel_clk),
        .CE  (line_buff_4_CE ),
        .Q   (line_buff_4_Q  )
    );
    
    
    maxtri7x7_shift_ram_0 line_buff_5
    (
        .D   (line_buff_5_D  ),
        .CLK (pixel_clk),
        .CE  (line_buff_5_CE ),
        .Q   (line_buff_5_Q  )
    );
    
    
    maxtri7x7_shift_ram_0 line_buff_6
    (
        .D   (line_buff_6_D  ),
        .CLK (pixel_clk),
        .CE  (line_buff_6_CE ),
        .Q   (line_buff_6_Q  )
    );
    
    
    
    
    


endmodule
