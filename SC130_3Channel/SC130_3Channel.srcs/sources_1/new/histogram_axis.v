`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/21 09:48:38
// Design Name: 
// Module Name: histogram_axis
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


module histogram_axis
#(
    parameter IMG_HEIGHT = 480
)
(
    input       pixel_clk       ,
    input       s_axis_tlast    ,
    output      s_axis_tready   ,
    input       s_axis_tuser    ,
    input       s_axis_tvalid   ,
    input[7:0]  s_axis_tdata    , 
       
    output      m_axis_tlast    ,
    input       m_axis_tready   ,
    output      m_axis_tuser    ,
    output      m_axis_tvalid   ,
    output[7:0] m_axis_tdata    
 );
 
    localparam HL = 2'b10, 
               LH = 2'b01;
    localparam Init_State  = 2'b00,
               Count_State = 2'b01,
               Proc_State  = 2'b10;
    reg[1:0] state = 2'b00,state_delay1,state_delay2,state_delay3,state_delay4;   
    reg[7:0] count = 8'd0;
    reg[10:0] line_count = 11'd0;        
    
    reg      s_axis_tlast_delay1 ,s_axis_tlast_delay2 ,s_axis_tlast_delay3 ,s_axis_tlast_delay4 ,s_axis_tlast_delay5 ;
    reg      s_axis_tuser_delay1 ,s_axis_tuser_delay2 ,s_axis_tuser_delay3 ,s_axis_tuser_delay4 ,s_axis_tuser_delay5 ;
    reg      s_axis_tvalid_delay1,s_axis_tvalid_delay2,s_axis_tvalid_delay3,s_axis_tvalid_delay4,s_axis_tvalid_delay5;
    reg[7:0] s_axis_tdata_delay1 ,s_axis_tdata_delay2 ,s_axis_tdata_delay3 ,s_axis_tdata_delay4 ; 
    reg      s_axis_tready_reg   ;
    reg      m_axis_tlast_reg    ;
    reg      m_axis_tuser_reg    ;
    reg      m_axis_tvalid_reg   ;
    reg[7:0] m_axis_tdata_reg    ;
    
    reg[1:0] tuser_reg,tlast_reg;
    
    
    reg [7 :0] addr1;
    reg [7 :0] addr2;
    reg        wr_en1;
    reg        wr_en2;
    reg        count_bram_wea ; 
    reg [18:0] count_gray_num = 19'd0;
    reg [18:0] count_bram_dina ;
    reg [7:0]  count_bram_addra;
    reg [7:0]  count_bram_addrb;
    wire[18:0] count_bram_doutb;
    
    reg        norm_bram_wea    ; 
    reg [7:0]  norm_bram_addra  ;
    reg [7:0]  norm_bram_dina   ;
    wire[7:0]  norm_bram_douta  ;
    
    reg[31:0]  norm_reg1;
    reg[31:0]  norm_reg2;
    reg[7 :0]  norm_addr0;
    reg[7 :0]  norm_addr1;
    reg[7 :0]  norm_addr2;
    reg        norm_wea0 ; 
    reg        norm_wea1 ;
    reg        norm_wea2 ;
    reg        norm_wea3 ;    
    
    assign s_axis_tready = s_axis_tready_reg;
    assign m_axis_tlast  = m_axis_tlast_reg ;
    assign m_axis_tuser  = m_axis_tuser_reg ;
    assign m_axis_tvalid = m_axis_tvalid_reg;
    assign m_axis_tdata  = m_axis_tdata_reg ;
    
    always@(posedge pixel_clk)
    begin
        s_axis_tready_reg <= m_axis_tready;
        
        s_axis_tlast_delay1  <= s_axis_tlast ;
        s_axis_tuser_delay1  <= s_axis_tuser ;
        s_axis_tvalid_delay1 <= s_axis_tvalid;
        s_axis_tdata_delay1  <= s_axis_tdata ;
        
        s_axis_tlast_delay2  <= s_axis_tlast_delay1 ;
        s_axis_tuser_delay2  <= s_axis_tuser_delay1 ;
        s_axis_tvalid_delay2 <= s_axis_tvalid_delay1;
        s_axis_tdata_delay2  <= s_axis_tdata_delay1 ;
        
        s_axis_tlast_delay3  <= s_axis_tlast_delay2 ;
        s_axis_tuser_delay3  <= s_axis_tuser_delay2 ;
        s_axis_tvalid_delay3 <= s_axis_tvalid_delay2;
        s_axis_tdata_delay3  <= s_axis_tdata_delay2 ;
        
        s_axis_tlast_delay4  <= s_axis_tlast_delay3  ;
        s_axis_tuser_delay4  <= s_axis_tuser_delay3  ;
        s_axis_tvalid_delay4 <= s_axis_tvalid_delay3 ;
        s_axis_tdata_delay4  <= s_axis_tdata_delay3  ;
        
        s_axis_tlast_delay5  <= s_axis_tlast_delay4 ;
        s_axis_tuser_delay5  <= s_axis_tuser_delay4 ;
        s_axis_tvalid_delay5 <= s_axis_tvalid_delay4;
        
//        s_axis_tlast_delay6  <= s_axis_tlast_delay5 ;
//        s_axis_tuser_delay6  <= s_axis_tuser_delay5 ;
//        s_axis_tvalid_delay6 <= s_axis_tvalid_delay5;
        
        
    end
    
    always@(posedge pixel_clk)
    begin
        tuser_reg <= {tuser_reg[0],s_axis_tuser_delay1};
        tlast_reg <= {tlast_reg[0],s_axis_tlast_delay4};
    end
//行计数    
    always@(posedge pixel_clk)
    begin
        if(tuser_reg == LH)
        begin
            line_count <= 11'd0;    
        end
        else
        begin
            if(tlast_reg == LH )
            begin
                line_count <= line_count + 1'b1;    
            end
            else
            begin
                line_count <= line_count;
            end
        end
    end
    
    always@(posedge pixel_clk)
    begin
        case(state)
            Init_State:
            begin
                if(tuser_reg == LH)
//                if(count == 8'd255)
                begin
                    state <= Count_State;
                    count <= 8'd0;   
                end
                else
                begin
                    state <= Init_State;
                    count <= count + 1'b1; //1帧数据的周期值
                    
                end
            end   
            
            Count_State:
            begin
                if(line_count == IMG_HEIGHT)//1280*1024，行数=1024，即1帧数据结束
                begin
                    state <= Proc_State;
                    count <= 8'd0;   
                end
                else
                begin
                    state <= Count_State;
                end
                
            end  
              
            Proc_State://1帧结束后下一帧开始前
            begin
                if(count == 8'd255)
                begin
//                    state <= Init_State;
//                    count <= 8'd0;
                    //4个延时后回到Init_State
                    state_delay1 <= Init_State ;
                    state_delay2 <= state_delay1 ;
                    state_delay3 <= state_delay2 ; 
                    state_delay4 <= state_delay3 ;
                    state <= state_delay4;
                    
//                    count <= 8'd0;
                    
                    
                end
                else
                begin
                    state <= Proc_State;
                    state_delay1 <= Proc_State ;
                    state_delay2 <= Proc_State ;
                    state_delay3 <= Proc_State ; 
                    state_delay4 <= Proc_State ;
                    count <= count + 1'b1;
                end
            end 
               
            default:
            begin
                state <= Init_State;
                count <= 8'd0;
            end
        endcase
    end
    
    
    
    always@(posedge pixel_clk)
    begin
        case(state)
            Init_State:
            begin
                // initate gray_count_bram with zero
                count_bram_wea  <= 1'b1;
                count_bram_dina <= 19'd0;
                count_bram_addra<= count;
                count_gray_num <= 19'd0;
                //initate normalize   
                norm_bram_wea   <= 1'b0;
                norm_bram_addra <= 8'h00; 
                norm_bram_dina  <= 8'h00;
                norm_reg1  <= 32'd0; 
                norm_reg2  <= 32'd0; 
                norm_addr0 <= 8'h00;
                norm_addr1 <= 8'h00;
                norm_addr2 <= 8'h00;
                norm_wea0  <= 1'b0;
                norm_wea1  <= 1'b0;
                norm_wea2  <= 1'b0;
                norm_wea3  <= 1'b0; 
                
            end
            
            Count_State://第一步是统计直方图每个灰度级出现的次数
            begin
//                count_bram_addrb <= data_in;
                
//                wr_en1 <= href;
//                wr_en2 <= wr_en1;
//                count_bram_wea   <= ((addr2 == addr1) && (wr_en1 == 1'b1))? 1'b0 : wr_en2;
                
//                addr1 <= data_in;
//                addr2 <= addr1;
//                count_bram_addra <= addr2;
//                count_bram_dina  <= count_bram_doutb + count_gray_num + 1'b1;
//                count_gray_num   <= ((addr2 == addr1) && (wr_en2 == 1'b1))?(count_gray_num + 1'b1) : 19'd0;
                
                count_bram_addrb <= s_axis_tdata_delay3;
                
                wr_en1 <= s_axis_tvalid_delay3;
                wr_en2 <= wr_en1;
                count_bram_wea   <= ((addr2 == addr1) && (wr_en1 == 1'b1))? 1'b0 : wr_en2;
                
                addr1 <= s_axis_tdata_delay3;
                addr2 <= addr1;
                count_bram_addra <= addr2;
                count_bram_dina  <= count_bram_doutb + count_gray_num + 1'b1;//相同灰度值计数加1，否则减1
                count_gray_num   <= ((addr2 == addr1) && (wr_en2 == 1'b1))?(count_gray_num + 1'b1) : 19'd0;//相同灰度值为1，否则为0
                
                
                norm_bram_addra <= s_axis_tdata_delay3;
            
            end
            
            Proc_State:
            begin
                count_bram_addrb <= count;
                if(count_bram_addrb > 8'h0)
                begin
                    norm_reg1[31:13] <= count_bram_doutb;
                    norm_reg2 <= norm_reg2 + (norm_reg1>>13) + (norm_reg1>>12) + (norm_reg1>>11);//?
                    //norm_bram_dina <= norm_reg2[20:13];
                    norm_bram_dina <= (norm_reg2[31:13] > 19'd255) ? 8'd255 : norm_reg2[20:13];
                    
                end
            
                norm_addr0 <= count_bram_addrb;
                norm_addr1 <= norm_addr0;
                norm_addr2 <= norm_addr1;
                norm_bram_addra <= norm_addr2;
                
                if(count_bram_addrb < 255)
                    begin
                        norm_wea0 <= 1'b1;
                    end
                else
                    begin
                        norm_wea0 <= 1'b0;
                    end
                    
                norm_wea1 <= norm_wea0;    
                norm_wea2 <= norm_wea1;
                norm_wea3 <= norm_wea2;     
                norm_bram_wea <= norm_wea3;
            
            end
            
        endcase
    end
    
    
    always@(posedge pixel_clk)
    begin
        m_axis_tlast_reg  <= s_axis_tlast_delay5 ;
        m_axis_tuser_reg  <= s_axis_tuser_delay5 ;
        m_axis_tvalid_reg <= s_axis_tvalid_delay5;
        m_axis_tdata_reg  <= norm_bram_douta ;
    end
    
    // store gray count存储灰度计数值
     gray_count_bram count_bram_i
       (
        .clka (pixel_clk        ),
        .wea  (count_bram_wea   ),
        .addra(count_bram_addra ),
        .dina (count_bram_dina  ),
        .clkb (pixel_clk        ),
        .addrb(count_bram_addrb ),
        .doutb(count_bram_doutb )
      );
      
    // store normalize gray 存储归一化灰度值     
    normalize_bram  norm_bram_i
    (
        .clka (pixel_clk         ),
        .wea  (norm_bram_wea     ),
        .addra(norm_bram_addra   ),
        .dina (norm_bram_dina    ),
        .douta(norm_bram_douta   )
    );

 
endmodule
