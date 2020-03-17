vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xilinx_vip
vlib questa_lib/msim/xpm
vlib questa_lib/msim/axi_infrastructure_v1_1_0
vlib questa_lib/msim/axi_vip_v1_1_6
vlib questa_lib/msim/processing_system7_vip_v1_0_8
vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/lib_cdc_v1_0_2
vlib questa_lib/msim/proc_sys_reset_v5_0_13
vlib questa_lib/msim/lib_pkg_v1_0_2
vlib questa_lib/msim/fifo_generator_v13_2_5
vlib questa_lib/msim/lib_fifo_v1_0_14
vlib questa_lib/msim/blk_mem_gen_v8_4_4
vlib questa_lib/msim/lib_bmg_v1_0_13
vlib questa_lib/msim/lib_srl_fifo_v1_0_2
vlib questa_lib/msim/axi_datamover_v5_1_22
vlib questa_lib/msim/axi_vdma_v6_3_8
vlib questa_lib/msim/axi_lite_ipif_v3_0_4
vlib questa_lib/msim/interrupt_control_v3_1_4
vlib questa_lib/msim/axi_gpio_v2_0_22
vlib questa_lib/msim/xlconcat_v2_1_3
vlib questa_lib/msim/generic_baseblocks_v2_1_0
vlib questa_lib/msim/axi_register_slice_v2_1_20
vlib questa_lib/msim/axi_data_fifo_v2_1_19
vlib questa_lib/msim/axi_crossbar_v2_1_21
vlib questa_lib/msim/axi_protocol_converter_v2_1_20

vmap xilinx_vip questa_lib/msim/xilinx_vip
vmap xpm questa_lib/msim/xpm
vmap axi_infrastructure_v1_1_0 questa_lib/msim/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_6 questa_lib/msim/axi_vip_v1_1_6
vmap processing_system7_vip_v1_0_8 questa_lib/msim/processing_system7_vip_v1_0_8
vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap lib_cdc_v1_0_2 questa_lib/msim/lib_cdc_v1_0_2
vmap proc_sys_reset_v5_0_13 questa_lib/msim/proc_sys_reset_v5_0_13
vmap lib_pkg_v1_0_2 questa_lib/msim/lib_pkg_v1_0_2
vmap fifo_generator_v13_2_5 questa_lib/msim/fifo_generator_v13_2_5
vmap lib_fifo_v1_0_14 questa_lib/msim/lib_fifo_v1_0_14
vmap blk_mem_gen_v8_4_4 questa_lib/msim/blk_mem_gen_v8_4_4
vmap lib_bmg_v1_0_13 questa_lib/msim/lib_bmg_v1_0_13
vmap lib_srl_fifo_v1_0_2 questa_lib/msim/lib_srl_fifo_v1_0_2
vmap axi_datamover_v5_1_22 questa_lib/msim/axi_datamover_v5_1_22
vmap axi_vdma_v6_3_8 questa_lib/msim/axi_vdma_v6_3_8
vmap axi_lite_ipif_v3_0_4 questa_lib/msim/axi_lite_ipif_v3_0_4
vmap interrupt_control_v3_1_4 questa_lib/msim/interrupt_control_v3_1_4
vmap axi_gpio_v2_0_22 questa_lib/msim/axi_gpio_v2_0_22
vmap xlconcat_v2_1_3 questa_lib/msim/xlconcat_v2_1_3
vmap generic_baseblocks_v2_1_0 questa_lib/msim/generic_baseblocks_v2_1_0
vmap axi_register_slice_v2_1_20 questa_lib/msim/axi_register_slice_v2_1_20
vmap axi_data_fifo_v2_1_19 questa_lib/msim/axi_data_fifo_v2_1_19
vmap axi_crossbar_v2_1_21 questa_lib/msim/axi_crossbar_v2_1_21
vmap axi_protocol_converter_v2_1_20 questa_lib/msim/axi_protocol_converter_v2_1_20

vlog -work xilinx_vip -64 -sv -L axi_vip_v1_1_6 -L processing_system7_vip_v1_0_8 -L xilinx_vip "+incdir+D:/Xilinx/Vivado/2019.2/data/xilinx_vip/include" \
"D:/Xilinx/Vivado/2019.2/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"D:/Xilinx/Vivado/2019.2/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"D:/Xilinx/Vivado/2019.2/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"D:/Xilinx/Vivado/2019.2/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"D:/Xilinx/Vivado/2019.2/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"D:/Xilinx/Vivado/2019.2/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"D:/Xilinx/Vivado/2019.2/data/xilinx_vip/hdl/axi_vip_if.sv" \
"D:/Xilinx/Vivado/2019.2/data/xilinx_vip/hdl/clk_vip_if.sv" \
"D:/Xilinx/Vivado/2019.2/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm -64 -sv -L axi_vip_v1_1_6 -L processing_system7_vip_v1_0_8 -L xilinx_vip "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/2d50/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/4fba" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/798b/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2019.2/data/xilinx_vip/include" \
"D:/Xilinx/Vivado/2019.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/Xilinx/Vivado/2019.2/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"D:/Xilinx/Vivado/2019.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"D:/Xilinx/Vivado/2019.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work axi_infrastructure_v1_1_0 -64 "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/2d50/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/4fba" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/798b/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2019.2/data/xilinx_vip/include" \
"../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_6 -64 -sv -L axi_vip_v1_1_6 -L processing_system7_vip_v1_0_8 -L xilinx_vip "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/2d50/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/4fba" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/798b/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2019.2/data/xilinx_vip/include" \
"../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/dc12/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work processing_system7_vip_v1_0_8 -64 -sv -L axi_vip_v1_1_6 -L processing_system7_vip_v1_0_8 -L xilinx_vip "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/2d50/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/4fba" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/798b/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2019.2/data/xilinx_vip/include" \
"../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/2d50/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/2d50/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/4fba" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/798b/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2019.2/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_processing_system7_0_0/sim/design_1_processing_system7_0_0.v" \

vcom -work lib_cdc_v1_0_2 -64 -93 \
"../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work proc_sys_reset_v5_0_13 -64 -93 \
"../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/8842/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/design_1/ip/design_1_rst_processing_system7_0_100M_0/sim/design_1_rst_processing_system7_0_100M_0.vhd" \

vlog -work xil_defaultlib -64 "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/2d50/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/4fba" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/798b/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2019.2/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_clk_wiz_0_0/design_1_clk_wiz_0_0_clk_wiz.v" \
"../../../bd/design_1/ip/design_1_clk_wiz_0_0/design_1_clk_wiz_0_0.v" \

vcom -work lib_pkg_v1_0_2 -64 -93 \
"../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/0513/hdl/lib_pkg_v1_0_rfs.vhd" \

vlog -work fifo_generator_v13_2_5 -64 "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/2d50/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/4fba" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/798b/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2019.2/data/xilinx_vip/include" \
"../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/276e/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_5 -64 -93 \
"../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/276e/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_5 -64 "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/2d50/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/4fba" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/798b/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2019.2/data/xilinx_vip/include" \
"../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/276e/hdl/fifo_generator_v13_2_rfs.v" \

vcom -work lib_fifo_v1_0_14 -64 -93 \
"../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/a5cb/hdl/lib_fifo_v1_0_rfs.vhd" \

vlog -work blk_mem_gen_v8_4_4 -64 "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/2d50/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/4fba" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/798b/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2019.2/data/xilinx_vip/include" \
"../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/2985/simulation/blk_mem_gen_v8_4.v" \

vcom -work lib_bmg_v1_0_13 -64 -93 \
"../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/af67/hdl/lib_bmg_v1_0_rfs.vhd" \

vcom -work lib_srl_fifo_v1_0_2 -64 -93 \
"../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/51ce/hdl/lib_srl_fifo_v1_0_rfs.vhd" \

vcom -work axi_datamover_v5_1_22 -64 -93 \
"../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/1e40/hdl/axi_datamover_v5_1_vh_rfs.vhd" \

vlog -work axi_vdma_v6_3_8 -64 "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/2d50/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/4fba" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/798b/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2019.2/data/xilinx_vip/include" \
"../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/798b/hdl/axi_vdma_v6_3_rfs.v" \

vcom -work axi_vdma_v6_3_8 -64 -93 \
"../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/798b/hdl/axi_vdma_v6_3_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/design_1/ip/design_1_axi_vdma_0_1/sim/design_1_axi_vdma_0_1.vhd" \
"../../../bd/design_1/ip/design_1_axi_vdma_1_0/sim/design_1_axi_vdma_1_0.vhd" \
"../../../bd/design_1/ip/design_1_axi_vdma_0_2/sim/design_1_axi_vdma_0_2.vhd" \

vcom -work axi_lite_ipif_v3_0_4 -64 -93 \
"../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work interrupt_control_v3_1_4 -64 -93 \
"../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/a040/hdl/interrupt_control_v3_1_vh_rfs.vhd" \

vcom -work axi_gpio_v2_0_22 -64 -93 \
"../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/f71e/hdl/axi_gpio_v2_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/design_1/ip/design_1_axi_gpio_0_1/sim/design_1_axi_gpio_0_1.vhd" \
"../../../bd/design_1/ip/design_1_axi_vdma_imgCapture_0/sim/design_1_axi_vdma_imgCapture_0.vhd" \
"../../../bd/design_1/ip/design_1_axi_vdma_imgCapture1_0/sim/design_1_axi_vdma_imgCapture1_0.vhd" \
"../../../bd/design_1/ip/design_1_axi_gpio_0_0/sim/design_1_axi_gpio_0_0.vhd" \

vlog -work xlconcat_v2_1_3 -64 "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/2d50/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/4fba" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/798b/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2019.2/data/xilinx_vip/include" \
"../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/442e/hdl/xlconcat_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/2d50/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/4fba" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/798b/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2019.2/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_xlconcat_0_0/sim/design_1_xlconcat_0_0.v" \

vlog -work generic_baseblocks_v2_1_0 -64 "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/2d50/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/4fba" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/798b/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2019.2/data/xilinx_vip/include" \
"../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_20 -64 "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/2d50/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/4fba" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/798b/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2019.2/data/xilinx_vip/include" \
"../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/72d4/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work axi_data_fifo_v2_1_19 -64 "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/2d50/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/4fba" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/798b/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2019.2/data/xilinx_vip/include" \
"../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/60de/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work axi_crossbar_v2_1_21 -64 "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/2d50/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/4fba" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/798b/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2019.2/data/xilinx_vip/include" \
"../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/6b0d/hdl/axi_crossbar_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/2d50/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/4fba" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/798b/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2019.2/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_xbar_2/sim/design_1_xbar_2.v" \
"../../../bd/design_1/ip/design_1_xbar_3/sim/design_1_xbar_3.v" \
"../../../bd/design_1/ip/design_1_xbar_4/sim/design_1_xbar_4.v" \

vlog -work axi_protocol_converter_v2_1_20 -64 "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/2d50/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/4fba" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/798b/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2019.2/data/xilinx_vip/include" \
"../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/c4a6/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/2d50/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/4fba" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/798b/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2019.2/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_auto_pc_0/sim/design_1_auto_pc_0.v" \
"../../../bd/design_1/ip/design_1_auto_pc_1/sim/design_1_auto_pc_1.v" \
"../../../bd/design_1/ip/design_1_auto_pc_2/sim/design_1_auto_pc_2.v" \
"../../../bd/design_1/ip/design_1_auto_pc_3/sim/design_1_auto_pc_3.v" \
"../../../bd/design_1/ip/design_1_auto_pc_4/sim/design_1_auto_pc_4.v" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/design_1/ip/design_1_axi_gpio_2_0/sim/design_1_axi_gpio_2_0.vhd" \

vlog -work xil_defaultlib -64 "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/2d50/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/4fba" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ipshared/798b/hdl" "+incdir+../../../../SC130_3Channel.srcs/sources_1/bd/design_1/ip/design_1_processing_system7_0_0" "+incdir+D:/Xilinx/Vivado/2019.2/data/xilinx_vip/include" \
"../../../bd/design_1/sim/design_1.v" \

vlog -work xil_defaultlib \
"glbl.v"

