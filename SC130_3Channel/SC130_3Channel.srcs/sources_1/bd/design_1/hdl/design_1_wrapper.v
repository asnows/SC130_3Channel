//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
//Date        : Tue Mar  3 08:49:13 2020
//Host        : VT2OB6D7ZB52FZ0 running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (CMOS_XCK,
    DDR_addr,
    DDR_ba,
    DDR_cas_n,
    DDR_ck_n,
    DDR_ck_p,
    DDR_cke,
    DDR_cs_n,
    DDR_dm,
    DDR_dq,
    DDR_dqs_n,
    DDR_dqs_p,
    DDR_odt,
    DDR_ras_n,
    DDR_reset_n,
    DDR_we_n,
    FCLK_CLK0,
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    IIC_0_scl_io,
    IIC_0_sda_io,
    M00_AXI_araddr,
    M00_AXI_arprot,
    M00_AXI_arready,
    M00_AXI_arvalid,
    M00_AXI_awaddr,
    M00_AXI_awprot,
    M00_AXI_awready,
    M00_AXI_awvalid,
    M00_AXI_bready,
    M00_AXI_bresp,
    M00_AXI_bvalid,
    M00_AXI_rdata,
    M00_AXI_rready,
    M00_AXI_rresp,
    M00_AXI_rvalid,
    M00_AXI_wdata,
    M00_AXI_wready,
    M00_AXI_wstrb,
    M00_AXI_wvalid,
    PHY_RST_tri_io,
    S_AXIS_S2MM_0_tdata,
    S_AXIS_S2MM_0_tkeep,
    S_AXIS_S2MM_0_tlast,
    S_AXIS_S2MM_0_tready,
    S_AXIS_S2MM_0_tuser,
    S_AXIS_S2MM_0_tvalid,
    S_AXIS_S2MM_1_tdata,
    S_AXIS_S2MM_1_tkeep,
    S_AXIS_S2MM_1_tlast,
    S_AXIS_S2MM_1_tready,
    S_AXIS_S2MM_1_tuser,
    S_AXIS_S2MM_1_tvalid,
    S_AXIS_S2MM_2_tdata,
    S_AXIS_S2MM_2_tkeep,
    S_AXIS_S2MM_2_tlast,
    S_AXIS_S2MM_2_tready,
    S_AXIS_S2MM_2_tuser,
    S_AXIS_S2MM_2_tvalid,
    S_AXIS_S2MM_3_tdata,
    S_AXIS_S2MM_3_tkeep,
    S_AXIS_S2MM_3_tlast,
    S_AXIS_S2MM_3_tready,
    S_AXIS_S2MM_3_tuser,
    S_AXIS_S2MM_3_tvalid,
    peripheral_aresetn,
    s2mm_frame_ptr_out);
  output CMOS_XCK;
  inout [14:0]DDR_addr;
  inout [2:0]DDR_ba;
  inout DDR_cas_n;
  inout DDR_ck_n;
  inout DDR_ck_p;
  inout DDR_cke;
  inout DDR_cs_n;
  inout [3:0]DDR_dm;
  inout [31:0]DDR_dq;
  inout [3:0]DDR_dqs_n;
  inout [3:0]DDR_dqs_p;
  inout DDR_odt;
  inout DDR_ras_n;
  inout DDR_reset_n;
  inout DDR_we_n;
  output FCLK_CLK0;
  inout FIXED_IO_ddr_vrn;
  inout FIXED_IO_ddr_vrp;
  inout [53:0]FIXED_IO_mio;
  inout FIXED_IO_ps_clk;
  inout FIXED_IO_ps_porb;
  inout FIXED_IO_ps_srstb;
  inout IIC_0_scl_io;
  inout IIC_0_sda_io;
  output [31:0]M00_AXI_araddr;
  output [2:0]M00_AXI_arprot;
  input [0:0]M00_AXI_arready;
  output [0:0]M00_AXI_arvalid;
  output [31:0]M00_AXI_awaddr;
  output [2:0]M00_AXI_awprot;
  input [0:0]M00_AXI_awready;
  output [0:0]M00_AXI_awvalid;
  output [0:0]M00_AXI_bready;
  input [1:0]M00_AXI_bresp;
  input [0:0]M00_AXI_bvalid;
  input [31:0]M00_AXI_rdata;
  output [0:0]M00_AXI_rready;
  input [1:0]M00_AXI_rresp;
  input [0:0]M00_AXI_rvalid;
  output [31:0]M00_AXI_wdata;
  input [0:0]M00_AXI_wready;
  output [3:0]M00_AXI_wstrb;
  output [0:0]M00_AXI_wvalid;
  inout [0:0]PHY_RST_tri_io;
  input [31:0]S_AXIS_S2MM_0_tdata;
  input [3:0]S_AXIS_S2MM_0_tkeep;
  input S_AXIS_S2MM_0_tlast;
  output S_AXIS_S2MM_0_tready;
  input [0:0]S_AXIS_S2MM_0_tuser;
  input S_AXIS_S2MM_0_tvalid;
  input [31:0]S_AXIS_S2MM_1_tdata;
  input [3:0]S_AXIS_S2MM_1_tkeep;
  input S_AXIS_S2MM_1_tlast;
  output S_AXIS_S2MM_1_tready;
  input [0:0]S_AXIS_S2MM_1_tuser;
  input S_AXIS_S2MM_1_tvalid;
  input [31:0]S_AXIS_S2MM_2_tdata;
  input [3:0]S_AXIS_S2MM_2_tkeep;
  input S_AXIS_S2MM_2_tlast;
  output S_AXIS_S2MM_2_tready;
  input [0:0]S_AXIS_S2MM_2_tuser;
  input S_AXIS_S2MM_2_tvalid;
  input [31:0]S_AXIS_S2MM_3_tdata;
  input [3:0]S_AXIS_S2MM_3_tkeep;
  input S_AXIS_S2MM_3_tlast;
  output S_AXIS_S2MM_3_tready;
  input [0:0]S_AXIS_S2MM_3_tuser;
  input S_AXIS_S2MM_3_tvalid;
  output [0:0]peripheral_aresetn;
  output [5:0]s2mm_frame_ptr_out;

  wire CMOS_XCK;
  wire [14:0]DDR_addr;
  wire [2:0]DDR_ba;
  wire DDR_cas_n;
  wire DDR_ck_n;
  wire DDR_ck_p;
  wire DDR_cke;
  wire DDR_cs_n;
  wire [3:0]DDR_dm;
  wire [31:0]DDR_dq;
  wire [3:0]DDR_dqs_n;
  wire [3:0]DDR_dqs_p;
  wire DDR_odt;
  wire DDR_ras_n;
  wire DDR_reset_n;
  wire DDR_we_n;
  wire FCLK_CLK0;
  wire FIXED_IO_ddr_vrn;
  wire FIXED_IO_ddr_vrp;
  wire [53:0]FIXED_IO_mio;
  wire FIXED_IO_ps_clk;
  wire FIXED_IO_ps_porb;
  wire FIXED_IO_ps_srstb;
  wire IIC_0_scl_i;
  wire IIC_0_scl_io;
  wire IIC_0_scl_o;
  wire IIC_0_scl_t;
  wire IIC_0_sda_i;
  wire IIC_0_sda_io;
  wire IIC_0_sda_o;
  wire IIC_0_sda_t;
  wire [31:0]M00_AXI_araddr;
  wire [2:0]M00_AXI_arprot;
  wire [0:0]M00_AXI_arready;
  wire [0:0]M00_AXI_arvalid;
  wire [31:0]M00_AXI_awaddr;
  wire [2:0]M00_AXI_awprot;
  wire [0:0]M00_AXI_awready;
  wire [0:0]M00_AXI_awvalid;
  wire [0:0]M00_AXI_bready;
  wire [1:0]M00_AXI_bresp;
  wire [0:0]M00_AXI_bvalid;
  wire [31:0]M00_AXI_rdata;
  wire [0:0]M00_AXI_rready;
  wire [1:0]M00_AXI_rresp;
  wire [0:0]M00_AXI_rvalid;
  wire [31:0]M00_AXI_wdata;
  wire [0:0]M00_AXI_wready;
  wire [3:0]M00_AXI_wstrb;
  wire [0:0]M00_AXI_wvalid;
  wire [0:0]PHY_RST_tri_i_0;
  wire [0:0]PHY_RST_tri_io_0;
  wire [0:0]PHY_RST_tri_o_0;
  wire [0:0]PHY_RST_tri_t_0;
  wire [31:0]S_AXIS_S2MM_0_tdata;
  wire [3:0]S_AXIS_S2MM_0_tkeep;
  wire S_AXIS_S2MM_0_tlast;
  wire S_AXIS_S2MM_0_tready;
  wire [0:0]S_AXIS_S2MM_0_tuser;
  wire S_AXIS_S2MM_0_tvalid;
  wire [31:0]S_AXIS_S2MM_1_tdata;
  wire [3:0]S_AXIS_S2MM_1_tkeep;
  wire S_AXIS_S2MM_1_tlast;
  wire S_AXIS_S2MM_1_tready;
  wire [0:0]S_AXIS_S2MM_1_tuser;
  wire S_AXIS_S2MM_1_tvalid;
  wire [31:0]S_AXIS_S2MM_2_tdata;
  wire [3:0]S_AXIS_S2MM_2_tkeep;
  wire S_AXIS_S2MM_2_tlast;
  wire S_AXIS_S2MM_2_tready;
  wire [0:0]S_AXIS_S2MM_2_tuser;
  wire S_AXIS_S2MM_2_tvalid;
  wire [31:0]S_AXIS_S2MM_3_tdata;
  wire [3:0]S_AXIS_S2MM_3_tkeep;
  wire S_AXIS_S2MM_3_tlast;
  wire S_AXIS_S2MM_3_tready;
  wire [0:0]S_AXIS_S2MM_3_tuser;
  wire S_AXIS_S2MM_3_tvalid;
  wire [0:0]peripheral_aresetn;
  wire [5:0]s2mm_frame_ptr_out;

  IOBUF IIC_0_scl_iobuf
       (.I(IIC_0_scl_o),
        .IO(IIC_0_scl_io),
        .O(IIC_0_scl_i),
        .T(IIC_0_scl_t));
  IOBUF IIC_0_sda_iobuf
       (.I(IIC_0_sda_o),
        .IO(IIC_0_sda_io),
        .O(IIC_0_sda_i),
        .T(IIC_0_sda_t));
  IOBUF PHY_RST_tri_iobuf_0
       (.I(PHY_RST_tri_o_0),
        .IO(PHY_RST_tri_io[0]),
        .O(PHY_RST_tri_i_0),
        .T(PHY_RST_tri_t_0));
  design_1 design_1_i
       (.CMOS_XCK(CMOS_XCK),
        .DDR_addr(DDR_addr),
        .DDR_ba(DDR_ba),
        .DDR_cas_n(DDR_cas_n),
        .DDR_ck_n(DDR_ck_n),
        .DDR_ck_p(DDR_ck_p),
        .DDR_cke(DDR_cke),
        .DDR_cs_n(DDR_cs_n),
        .DDR_dm(DDR_dm),
        .DDR_dq(DDR_dq),
        .DDR_dqs_n(DDR_dqs_n),
        .DDR_dqs_p(DDR_dqs_p),
        .DDR_odt(DDR_odt),
        .DDR_ras_n(DDR_ras_n),
        .DDR_reset_n(DDR_reset_n),
        .DDR_we_n(DDR_we_n),
        .FCLK_CLK0(FCLK_CLK0),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
        .IIC_0_scl_i(IIC_0_scl_i),
        .IIC_0_scl_o(IIC_0_scl_o),
        .IIC_0_scl_t(IIC_0_scl_t),
        .IIC_0_sda_i(IIC_0_sda_i),
        .IIC_0_sda_o(IIC_0_sda_o),
        .IIC_0_sda_t(IIC_0_sda_t),
        .M00_AXI_araddr(M00_AXI_araddr),
        .M00_AXI_arprot(M00_AXI_arprot),
        .M00_AXI_arready(M00_AXI_arready),
        .M00_AXI_arvalid(M00_AXI_arvalid),
        .M00_AXI_awaddr(M00_AXI_awaddr),
        .M00_AXI_awprot(M00_AXI_awprot),
        .M00_AXI_awready(M00_AXI_awready),
        .M00_AXI_awvalid(M00_AXI_awvalid),
        .M00_AXI_bready(M00_AXI_bready),
        .M00_AXI_bresp(M00_AXI_bresp),
        .M00_AXI_bvalid(M00_AXI_bvalid),
        .M00_AXI_rdata(M00_AXI_rdata),
        .M00_AXI_rready(M00_AXI_rready),
        .M00_AXI_rresp(M00_AXI_rresp),
        .M00_AXI_rvalid(M00_AXI_rvalid),
        .M00_AXI_wdata(M00_AXI_wdata),
        .M00_AXI_wready(M00_AXI_wready),
        .M00_AXI_wstrb(M00_AXI_wstrb),
        .M00_AXI_wvalid(M00_AXI_wvalid),
        .PHY_RST_tri_i(PHY_RST_tri_i_0),
        .PHY_RST_tri_o(PHY_RST_tri_o_0),
        .PHY_RST_tri_t(PHY_RST_tri_t_0),
        .S_AXIS_S2MM_0_tdata(S_AXIS_S2MM_0_tdata),
        .S_AXIS_S2MM_0_tkeep(S_AXIS_S2MM_0_tkeep),
        .S_AXIS_S2MM_0_tlast(S_AXIS_S2MM_0_tlast),
        .S_AXIS_S2MM_0_tready(S_AXIS_S2MM_0_tready),
        .S_AXIS_S2MM_0_tuser(S_AXIS_S2MM_0_tuser),
        .S_AXIS_S2MM_0_tvalid(S_AXIS_S2MM_0_tvalid),
        .S_AXIS_S2MM_1_tdata(S_AXIS_S2MM_1_tdata),
        .S_AXIS_S2MM_1_tkeep(S_AXIS_S2MM_1_tkeep),
        .S_AXIS_S2MM_1_tlast(S_AXIS_S2MM_1_tlast),
        .S_AXIS_S2MM_1_tready(S_AXIS_S2MM_1_tready),
        .S_AXIS_S2MM_1_tuser(S_AXIS_S2MM_1_tuser),
        .S_AXIS_S2MM_1_tvalid(S_AXIS_S2MM_1_tvalid),
        .S_AXIS_S2MM_2_tdata(S_AXIS_S2MM_2_tdata),
        .S_AXIS_S2MM_2_tkeep(S_AXIS_S2MM_2_tkeep),
        .S_AXIS_S2MM_2_tlast(S_AXIS_S2MM_2_tlast),
        .S_AXIS_S2MM_2_tready(S_AXIS_S2MM_2_tready),
        .S_AXIS_S2MM_2_tuser(S_AXIS_S2MM_2_tuser),
        .S_AXIS_S2MM_2_tvalid(S_AXIS_S2MM_2_tvalid),
        .S_AXIS_S2MM_3_tdata(S_AXIS_S2MM_3_tdata),
        .S_AXIS_S2MM_3_tkeep(S_AXIS_S2MM_3_tkeep),
        .S_AXIS_S2MM_3_tlast(S_AXIS_S2MM_3_tlast),
        .S_AXIS_S2MM_3_tready(S_AXIS_S2MM_3_tready),
        .S_AXIS_S2MM_3_tuser(S_AXIS_S2MM_3_tuser),
        .S_AXIS_S2MM_3_tvalid(S_AXIS_S2MM_3_tvalid),
        .peripheral_aresetn(peripheral_aresetn),
        .s2mm_frame_ptr_out(s2mm_frame_ptr_out));
endmodule
