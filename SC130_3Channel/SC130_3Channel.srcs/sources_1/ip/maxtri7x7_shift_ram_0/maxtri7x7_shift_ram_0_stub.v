// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
// Date        : Wed Oct 31 13:26:43 2018
// Host        : VT2OB6D7ZB52FZ0 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top maxtri7x7_shift_ram_0 -prefix
//               maxtri7x7_shift_ram_0_ line_shift_ram_0_stub.v
// Design      : line_shift_ram_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "c_shift_ram_v12_0_12,Vivado 2018.1" *)
module maxtri7x7_shift_ram_0(D, CLK, CE, Q)
/* synthesis syn_black_box black_box_pad_pin="D[12:0],CLK,CE,Q[12:0]" */;
  input [12:0]D;
  input CLK;
  input CE;
  output [12:0]Q;
endmodule
