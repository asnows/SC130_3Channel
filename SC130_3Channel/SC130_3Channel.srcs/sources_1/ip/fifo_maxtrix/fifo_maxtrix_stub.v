// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Sat Jun 22 13:19:33 2019
// Host        : PS-03 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               D:/Program/FPGA/WORKING/camera30/SC130_3Channel/prj_sc130.srcs/sources_1/ip/fifo_maxtrix/fifo_maxtrix_stub.v
// Design      : fifo_maxtrix
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_2_2,Vivado 2018.2" *)
module fifo_maxtrix(clk, srst, din, wr_en, rd_en, dout, full, empty)
/* synthesis syn_black_box black_box_pad_pin="clk,srst,din[12:0],wr_en,rd_en,dout[12:0],full,empty" */;
  input clk;
  input srst;
  input [12:0]din;
  input wr_en;
  input rd_en;
  output [12:0]dout;
  output full;
  output empty;
endmodule
