`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/10 08:37:15
// Design Name: 
// Module Name: data_put_together
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


module data_put_together
    #(
        parameter DATA_WIDTH = 8,
        parameter IMG_WIDTH  = 640
    )
    (
        input       pixel_clk       ,
        input[31:0]  s_axis_tdata    ,
        input       s_axis_tlast    ,
        input       s_axis_tuser    ,
        input       s_axis_tvalid   ,
        
        output      m_axis_tlast    ,
        output      m_axis_tuser    ,
        output      m_axis_tvalid   ,
        output[31:0] m_axis_tdata    
    
     );
     
     reg[31:0] s_axis_tdata_dly1 ;
     reg                 s_axis_tlast_dly1 ;
     reg                 s_axis_tuser_dly1 ;
     reg                 s_axis_tvalid_dly1;
    
     reg                 m_axis_tlast_reg ;
     reg                 m_axis_tuser_reg ;
     reg                 m_axis_tvalid_reg;
     reg[31:0] m_axis_tdata_reg ;
     
     reg[9:0]   line_count = 10'd1;
     wire[7:0]   factor = 8'd0;
     
     
     
     assign m_axis_tlast  = m_axis_tlast_reg ;
     assign m_axis_tuser  = m_axis_tuser_reg ;
     assign m_axis_tvalid = m_axis_tvalid_reg;  
     assign m_axis_tdata  = m_axis_tdata_reg ;
     
     assign factor = 3840/IMG_WIDTH;//3840需要的行数
     
     
     always@(posedge pixel_clk)
     begin
         s_axis_tdata_dly1  <= s_axis_tdata ;
         s_axis_tlast_dly1  <= s_axis_tlast ;
         s_axis_tuser_dly1  <= s_axis_tuser ;
         s_axis_tvalid_dly1 <= s_axis_tvalid;
     end
     
     always@(posedge pixel_clk)
     begin
        if(s_axis_tuser_dly1 == 1'b1)
        begin
            line_count <= 10'd1;    
        end
        else
        begin
            if(s_axis_tlast_dly1 == 1'b1)
            begin
                line_count <= line_count + 1'b1;      
            end
            else
            begin
                line_count <= line_count;
            end
        end
     end
//每传输3840作为一次突发传输     
     always@(posedge pixel_clk)
     begin
        //if((line_count % 10'd6) == 10'd0)
        if((line_count % factor) == 10'd0)
        begin
            m_axis_tlast_reg <= s_axis_tlast_dly1;
        end
        else
        begin
            m_axis_tlast_reg <= 1'b0;
        end
        
     end
     
     always@(posedge pixel_clk)
     begin
         m_axis_tuser_reg  <= s_axis_tuser_dly1 ;
         m_axis_tvalid_reg <= s_axis_tvalid_dly1;  
         m_axis_tdata_reg  <= s_axis_tdata_dly1;
     end
     
     
endmodule
