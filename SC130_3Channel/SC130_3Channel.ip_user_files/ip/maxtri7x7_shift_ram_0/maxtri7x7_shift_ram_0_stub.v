// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Tue Mar 17 14:55:25 2020
// Host        : VT2OB6D7ZB52FZ0 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               E:/WorkSpace/project/FPGA/SC130_3Channel/SC130_3Channel/SC130_3Channel.srcs/sources_1/ip/maxtri7x7_shift_ram_0/maxtri7x7_shift_ram_0_stub.v
// Design      : maxtri7x7_shift_ram_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "c_shift_ram_v12_0_14,Vivado 2019.2" *)
module maxtri7x7_shift_ram_0(D, CLK, CE, Q)
/* synthesis syn_black_box black_box_pad_pin="D[12:0],CLK,CE,Q[12:0]" */;
  input [12:0]D;
  input CLK;
  input CE;
  output [12:0]Q;
endmodule
