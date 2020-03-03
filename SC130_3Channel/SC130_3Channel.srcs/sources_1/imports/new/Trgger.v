`timescale 1ns / 1ps
 /*
    根据设定的设定的Frame_hz，输出脉冲
    有两种控制模式 Control_Mode=0.自动模式 Control_Mode=1，软件控制模式
    自动模式：有sysclk系统时钟，Frame_hz 计算输出触发脉冲
              Frame_hz 由软件计算输入 
    软件模式：输出值由Trggerio来决定      
    在自动模式中，1秒输出多少个脉冲，最大120帧   
 */
module Trgger
    (
//         input Rst,
          (*mark_debug="true"*)input sysclk,//系统时钟
          (*mark_debug="true"*)input Control_Mode,
          (*mark_debug="true"*)input SoftTrggr,
          (*mark_debug="true"*)input[31:0]Frame_hz,
          (*mark_debug="true"*)input[31:0] exposure_width,
          (*mark_debug="true"*)output Trggerio
     ); 
 
 //wire[31:0] TriggerTime;//脉冲的时间点
// parameter Pulse_With=3;
//wire[31:0] posedgepoint;//上升点
//assign posedgepoint=TriggerTime-Pulse_With;
//assign TriggerTime =Frame_hz;
localparam HL = 2'b10;
 
(*mark_debug="true"*) reg[31:0] cnt;
reg[31:0] exposure_width_reg = 32'd0;
reg [1:0]   SoftTrggr_reg = 2'b00;
reg         Mode_reg = 1'b0;

// always @(posedge sysclk)
// begin
//    if(cnt==Frame_hz)
//        begin
//	        	cnt <=16'h00000000;
//        end
//    else
//        begin          
//            cnt <= cnt+1;
//        end
// end
 reg r_Trggerio;
//  always @(posedge sysclk)
//    begin
//        if(cnt==Frame_hz-Pulse_With)     r_Trggerio <=1;
//        else if(cnt==Frame_hz)           r_Trggerio <=0;
//        else                             r_Trggerio <=r_Trggerio;
//    end
    

    
    always@(posedge sysclk)
    begin
        exposure_width_reg <= (exposure_width == 32'd0)? 32'd300:exposure_width;
        SoftTrggr_reg <= {SoftTrggr_reg[0],SoftTrggr};
        Mode_reg <= Control_Mode;
    end
    
    
//    always@(posedge sysclk)
//    begin
//        if(cnt >= Frame_hz)
//        begin
//            cnt <= 32'd0;    
//        end
//        else
//        begin
//            cnt <= cnt + 1'b1;  
//        end
//    end   

    always@(posedge sysclk)
    begin
        case (Mode_reg)
        1'b0:
        begin
            if(cnt >= Frame_hz)
            begin
                cnt <= 32'd0;    
            end
            else
            begin
                cnt <= cnt + 1'b1;  
            end
        end
        
        1'b1:
        begin
            if(SoftTrggr_reg == HL)
            begin
                cnt <= 32'd0;      
            end
            else
            begin
                if(cnt < exposure_width_reg)
                begin
                    cnt <= cnt + 1'b1;  
                end
            end
        end
        
        default:;
        endcase
    end



    
//    always@(posedge sysclk)
//    begin
//        case(cnt)
//            32'd0:
//            begin
//                r_Trggerio <= 1'b1;
//            end
            
//            32'd300:
//            begin
//                r_Trggerio <= 1'b0;
//            end
            
//            default:
//            begin
//                r_Trggerio <= r_Trggerio ;
//            end
//        endcase
//    end
    
    always@(posedge sysclk)
    begin
        if(cnt == 32'd0)
        begin
            r_Trggerio <= 1'b1;    
        end
        else if(cnt == exposure_width_reg)
        begin
             r_Trggerio <= 1'b0; 
        end
        else
        begin
            r_Trggerio <= r_Trggerio; 
        end
    end
    
// assign Trggerio = (Control_Mode)?SoftTrggr:r_Trggerio;
assign Trggerio = r_Trggerio;
endmodule
