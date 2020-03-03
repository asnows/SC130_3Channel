#set_property IOSTANDARD LVCMOS18 [get_ports CMOS_XCK]
#set_property IOSTANDARD LVCMOS33 [get_ports iic_0_scl_io]
#set_property IOSTANDARD LVCMOS33 [get_ports iic_0_sda_io]
#set_property IOSTANDARD LVCMOS33 [get_ports CMOS_PIXCLK]
#set_property IOSTANDARD LVCMOS33 [get_ports CMOS_LREF]
#set_property IOSTANDARD LVCMOS18 [get_ports CMOS_FSYNC]
#set_property IOSTANDARD LVCMOS33 [get_ports {CMOS_DATA[0]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {CMOS_DATA[1]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {CMOS_DATA[2]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {CMOS_DATA[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {CMOS_DATA[4]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {CMOS_DATA[5]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {CMOS_DATA[6]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {CMOS_DATA[7]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {CMOS_DATA[8]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {CMOS_DATA[9]}]
#set_property IOSTANDARD LVCMOS33 [get_ports CMOS_PWDN]
#set_property IOSTANDARD LVCMOS33 [get_ports CMOS_Trigger0]

set_property IOSTANDARD LVCMOS18 [get_ports CMOS_XCK]
set_property IOSTANDARD LVCMOS18 [get_ports iic_0_scl_io]
set_property IOSTANDARD LVCMOS18 [get_ports iic_0_sda_io]
set_property IOSTANDARD LVCMOS18 [get_ports CMOS_PIXCLK]
set_property IOSTANDARD LVCMOS18 [get_ports CMOS_LREF]
set_property IOSTANDARD LVCMOS18 [get_ports CMOS_FSYNC]
set_property IOSTANDARD LVCMOS18 [get_ports {CMOS_DATA[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {CMOS_DATA[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {CMOS_DATA[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {CMOS_DATA[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {CMOS_DATA[4]}]
set_property IOSTANDARD LVCMOS18 [get_ports {CMOS_DATA[5]}]
set_property IOSTANDARD LVCMOS18 [get_ports {CMOS_DATA[6]}]
set_property IOSTANDARD LVCMOS18 [get_ports {CMOS_DATA[7]}]
set_property IOSTANDARD LVCMOS18 [get_ports {CMOS_DATA[8]}]
set_property IOSTANDARD LVCMOS18 [get_ports {CMOS_DATA[9]}]
set_property IOSTANDARD LVCMOS18 [get_ports CMOS_PWDN]
set_property IOSTANDARD LVCMOS18 [get_ports CMOS_Trigger0]

#set_property PACKAGE_PIN H20 [get_ports CMOS_PWDN]
#set_property PACKAGE_PIN J20 [get_ports CMOS_Trigger0]
#set_property PACKAGE_PIN M17 [get_ports CMOS_XCK]
#set_property PACKAGE_PIN F16 [get_ports iic_0_scl_io]
#set_property PACKAGE_PIN F17 [get_ports iic_0_sda_io]
#set_property PACKAGE_PIN M18 [get_ports CMOS_PIXCLK]
#set_property PACKAGE_PIN F19 [get_ports CMOS_LREF]
#set_property PACKAGE_PIN L16 [get_ports CMOS_FSYNC]
#set_property PACKAGE_PIN M20 [get_ports {CMOS_DATA[0]}]
#set_property PACKAGE_PIN M19 [get_ports {CMOS_DATA[1]}]
#set_property PACKAGE_PIN K18 [get_ports {CMOS_DATA[2]}]
#set_property PACKAGE_PIN K17 [get_ports {CMOS_DATA[3]}]
#set_property PACKAGE_PIN L17 [get_ports {CMOS_DATA[4]}]
#set_property PACKAGE_PIN J19 [get_ports {CMOS_DATA[5]}]
#set_property PACKAGE_PIN G19 [get_ports {CMOS_DATA[6]}]
#set_property PACKAGE_PIN L20 [get_ports {CMOS_DATA[7]}]
#set_property PACKAGE_PIN L19 [get_ports {CMOS_DATA[8]}]
#set_property PACKAGE_PIN K19 [get_ports {CMOS_DATA[9]}]


#emmc
set_property PACKAGE_PIN M18 [get_ports CMOS_PWDN]
set_property PACKAGE_PIN M17 [get_ports CMOS_Trigger0]
set_property PACKAGE_PIN J20 [get_ports CMOS_XCK]
set_property PACKAGE_PIN F20 [get_ports iic_0_scl_io]
set_property PACKAGE_PIN H20 [get_ports iic_0_sda_io]
set_property PACKAGE_PIN G20 [get_ports CMOS_PIXCLK]
set_property PACKAGE_PIN L17 [get_ports CMOS_LREF]
set_property PACKAGE_PIN J19 [get_ports CMOS_FSYNC]
set_property PACKAGE_PIN K19 [get_ports {CMOS_DATA[0]}]
set_property PACKAGE_PIN L19 [get_ports {CMOS_DATA[1]}]
set_property PACKAGE_PIN L20 [get_ports {CMOS_DATA[2]}]
set_property PACKAGE_PIN G19 [get_ports {CMOS_DATA[3]}]
set_property PACKAGE_PIN K18 [get_ports {CMOS_DATA[4]}]
set_property PACKAGE_PIN K17 [get_ports {CMOS_DATA[5]}]
set_property PACKAGE_PIN M19 [get_ports {CMOS_DATA[6]}]
set_property PACKAGE_PIN M20 [get_ports {CMOS_DATA[7]}]
set_property PACKAGE_PIN L16 [get_ports {CMOS_DATA[8]}]
set_property PACKAGE_PIN F19 [get_ports {CMOS_DATA[9]}]




set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets CMOS_FSYNC_IBUF]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets CMOS_PIXCLK_IBUF]


set_property PACKAGE_PIN M14 [get_ports E_OUT1]
set_property IOSTANDARD LVCMOS18 [get_ports E_OUT1]
set_property PACKAGE_PIN L15 [get_ports E_OUT2]
set_property IOSTANDARD LVCMOS18 [get_ports E_OUT2]
set_property PACKAGE_PIN L14 [get_ports E_IN1]
set_property IOSTANDARD LVCMOS18 [get_ports E_IN1]








#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets CMOS_PIXCLK]

#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets CMOS_FSYNC_IBUF]

#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ibuf_clkp_cmos_n_0_BUFG_inst_n_0]




create_clock -period 41.667 -name CMOS_PIXCLK -waveform {0.000 20.833} [get_ports CMOS_PIXCLK]
set_clock_groups -asynchronous -group [get_clocks clk_fpga_0] -group [get_clocks CMOS_PIXCLK]
set_clock_groups -asynchronous -group [get_clocks CMOS_PIXCLK] -group [get_clocks clk_fpga_0]

#create_clock -period 18.000 -name CMOS_PIXCLK -waveform {0.000 9.000} [get_ports CMOS_PIXCLK]
#set_input_delay -clock [get_clocks CMOS_PIXCLK] -min -add_delay 3.200 [get_ports {CMOS_DATA[*]}]
#set_input_delay -clock [get_clocks CMOS_PIXCLK] -max -add_delay 7.000 [get_ports {CMOS_DATA[*]}]
#set_input_delay -clock [get_clocks CMOS_PIXCLK] -min -add_delay 3.200 [get_ports CMOS_FSYNC]
#set_input_delay -clock [get_clocks CMOS_PIXCLK] -max -add_delay 7.000 [get_ports CMOS_FSYNC]
#set_input_delay -clock [get_clocks clk_fpga_0] -min -add_delay 3.200 [get_ports CMOS_FSYNC]
#set_input_delay -clock [get_clocks clk_fpga_0] -max -add_delay 7.000 [get_ports CMOS_FSYNC]
#set_input_delay -clock [get_clocks CMOS_PIXCLK] -min -add_delay 3.200 [get_ports CMOS_LREF]
#set_input_delay -clock [get_clocks CMOS_PIXCLK] -max -add_delay 7.000 [get_ports CMOS_LREF]







create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 8192 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list design_1_wrapper_i/design_1_i/processing_system7_0/inst/FCLK_CLK0]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 32 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {Trgger/exposure_width[0]} {Trgger/exposure_width[1]} {Trgger/exposure_width[2]} {Trgger/exposure_width[3]} {Trgger/exposure_width[4]} {Trgger/exposure_width[5]} {Trgger/exposure_width[6]} {Trgger/exposure_width[7]} {Trgger/exposure_width[8]} {Trgger/exposure_width[9]} {Trgger/exposure_width[10]} {Trgger/exposure_width[11]} {Trgger/exposure_width[12]} {Trgger/exposure_width[13]} {Trgger/exposure_width[14]} {Trgger/exposure_width[15]} {Trgger/exposure_width[16]} {Trgger/exposure_width[17]} {Trgger/exposure_width[18]} {Trgger/exposure_width[19]} {Trgger/exposure_width[20]} {Trgger/exposure_width[21]} {Trgger/exposure_width[22]} {Trgger/exposure_width[23]} {Trgger/exposure_width[24]} {Trgger/exposure_width[25]} {Trgger/exposure_width[26]} {Trgger/exposure_width[27]} {Trgger/exposure_width[28]} {Trgger/exposure_width[29]} {Trgger/exposure_width[30]} {Trgger/exposure_width[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 32 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {Trgger/Frame_hz[0]} {Trgger/Frame_hz[1]} {Trgger/Frame_hz[2]} {Trgger/Frame_hz[3]} {Trgger/Frame_hz[4]} {Trgger/Frame_hz[5]} {Trgger/Frame_hz[6]} {Trgger/Frame_hz[7]} {Trgger/Frame_hz[8]} {Trgger/Frame_hz[9]} {Trgger/Frame_hz[10]} {Trgger/Frame_hz[11]} {Trgger/Frame_hz[12]} {Trgger/Frame_hz[13]} {Trgger/Frame_hz[14]} {Trgger/Frame_hz[15]} {Trgger/Frame_hz[16]} {Trgger/Frame_hz[17]} {Trgger/Frame_hz[18]} {Trgger/Frame_hz[19]} {Trgger/Frame_hz[20]} {Trgger/Frame_hz[21]} {Trgger/Frame_hz[22]} {Trgger/Frame_hz[23]} {Trgger/Frame_hz[24]} {Trgger/Frame_hz[25]} {Trgger/Frame_hz[26]} {Trgger/Frame_hz[27]} {Trgger/Frame_hz[28]} {Trgger/Frame_hz[29]} {Trgger/Frame_hz[30]} {Trgger/Frame_hz[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 32 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {Trgger/cnt[0]} {Trgger/cnt[1]} {Trgger/cnt[2]} {Trgger/cnt[3]} {Trgger/cnt[4]} {Trgger/cnt[5]} {Trgger/cnt[6]} {Trgger/cnt[7]} {Trgger/cnt[8]} {Trgger/cnt[9]} {Trgger/cnt[10]} {Trgger/cnt[11]} {Trgger/cnt[12]} {Trgger/cnt[13]} {Trgger/cnt[14]} {Trgger/cnt[15]} {Trgger/cnt[16]} {Trgger/cnt[17]} {Trgger/cnt[18]} {Trgger/cnt[19]} {Trgger/cnt[20]} {Trgger/cnt[21]} {Trgger/cnt[22]} {Trgger/cnt[23]} {Trgger/cnt[24]} {Trgger/cnt[25]} {Trgger/cnt[26]} {Trgger/cnt[27]} {Trgger/cnt[28]} {Trgger/cnt[29]} {Trgger/cnt[30]} {Trgger/cnt[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 10 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {cmos_sampling_i/data_out[0]} {cmos_sampling_i/data_out[1]} {cmos_sampling_i/data_out[2]} {cmos_sampling_i/data_out[3]} {cmos_sampling_i/data_out[4]} {cmos_sampling_i/data_out[5]} {cmos_sampling_i/data_out[6]} {cmos_sampling_i/data_out[7]} {cmos_sampling_i/data_out[8]} {cmos_sampling_i/data_out[9]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 10 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {cmos_sampling_i/data_in[0]} {cmos_sampling_i/data_in[1]} {cmos_sampling_i/data_in[2]} {cmos_sampling_i/data_in[3]} {cmos_sampling_i/data_in[4]} {cmos_sampling_i/data_in[5]} {cmos_sampling_i/data_in[6]} {cmos_sampling_i/data_in[7]} {cmos_sampling_i/data_in[8]} {cmos_sampling_i/data_in[9]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 32 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {sw_m_0_axis_tdata[0]} {sw_m_0_axis_tdata[1]} {sw_m_0_axis_tdata[2]} {sw_m_0_axis_tdata[3]} {sw_m_0_axis_tdata[4]} {sw_m_0_axis_tdata[5]} {sw_m_0_axis_tdata[6]} {sw_m_0_axis_tdata[7]} {sw_m_0_axis_tdata[8]} {sw_m_0_axis_tdata[9]} {sw_m_0_axis_tdata[10]} {sw_m_0_axis_tdata[11]} {sw_m_0_axis_tdata[12]} {sw_m_0_axis_tdata[13]} {sw_m_0_axis_tdata[14]} {sw_m_0_axis_tdata[15]} {sw_m_0_axis_tdata[16]} {sw_m_0_axis_tdata[17]} {sw_m_0_axis_tdata[18]} {sw_m_0_axis_tdata[19]} {sw_m_0_axis_tdata[20]} {sw_m_0_axis_tdata[21]} {sw_m_0_axis_tdata[22]} {sw_m_0_axis_tdata[23]} {sw_m_0_axis_tdata[24]} {sw_m_0_axis_tdata[25]} {sw_m_0_axis_tdata[26]} {sw_m_0_axis_tdata[27]} {sw_m_0_axis_tdata[28]} {sw_m_0_axis_tdata[29]} {sw_m_0_axis_tdata[30]} {sw_m_0_axis_tdata[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 32 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {dconv_m1_axis_tdata[0]} {dconv_m1_axis_tdata[1]} {dconv_m1_axis_tdata[2]} {dconv_m1_axis_tdata[3]} {dconv_m1_axis_tdata[4]} {dconv_m1_axis_tdata[5]} {dconv_m1_axis_tdata[6]} {dconv_m1_axis_tdata[7]} {dconv_m1_axis_tdata[8]} {dconv_m1_axis_tdata[9]} {dconv_m1_axis_tdata[10]} {dconv_m1_axis_tdata[11]} {dconv_m1_axis_tdata[12]} {dconv_m1_axis_tdata[13]} {dconv_m1_axis_tdata[14]} {dconv_m1_axis_tdata[15]} {dconv_m1_axis_tdata[16]} {dconv_m1_axis_tdata[17]} {dconv_m1_axis_tdata[18]} {dconv_m1_axis_tdata[19]} {dconv_m1_axis_tdata[20]} {dconv_m1_axis_tdata[21]} {dconv_m1_axis_tdata[22]} {dconv_m1_axis_tdata[23]} {dconv_m1_axis_tdata[24]} {dconv_m1_axis_tdata[25]} {dconv_m1_axis_tdata[26]} {dconv_m1_axis_tdata[27]} {dconv_m1_axis_tdata[28]} {dconv_m1_axis_tdata[29]} {dconv_m1_axis_tdata[30]} {dconv_m1_axis_tdata[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 32 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {dconv_m0_axis_tdata[0]} {dconv_m0_axis_tdata[1]} {dconv_m0_axis_tdata[2]} {dconv_m0_axis_tdata[3]} {dconv_m0_axis_tdata[4]} {dconv_m0_axis_tdata[5]} {dconv_m0_axis_tdata[6]} {dconv_m0_axis_tdata[7]} {dconv_m0_axis_tdata[8]} {dconv_m0_axis_tdata[9]} {dconv_m0_axis_tdata[10]} {dconv_m0_axis_tdata[11]} {dconv_m0_axis_tdata[12]} {dconv_m0_axis_tdata[13]} {dconv_m0_axis_tdata[14]} {dconv_m0_axis_tdata[15]} {dconv_m0_axis_tdata[16]} {dconv_m0_axis_tdata[17]} {dconv_m0_axis_tdata[18]} {dconv_m0_axis_tdata[19]} {dconv_m0_axis_tdata[20]} {dconv_m0_axis_tdata[21]} {dconv_m0_axis_tdata[22]} {dconv_m0_axis_tdata[23]} {dconv_m0_axis_tdata[24]} {dconv_m0_axis_tdata[25]} {dconv_m0_axis_tdata[26]} {dconv_m0_axis_tdata[27]} {dconv_m0_axis_tdata[28]} {dconv_m0_axis_tdata[29]} {dconv_m0_axis_tdata[30]} {dconv_m0_axis_tdata[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 32 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {fifo_0_s_axis_tdata[0]} {fifo_0_s_axis_tdata[1]} {fifo_0_s_axis_tdata[2]} {fifo_0_s_axis_tdata[3]} {fifo_0_s_axis_tdata[4]} {fifo_0_s_axis_tdata[5]} {fifo_0_s_axis_tdata[6]} {fifo_0_s_axis_tdata[7]} {fifo_0_s_axis_tdata[8]} {fifo_0_s_axis_tdata[9]} {fifo_0_s_axis_tdata[10]} {fifo_0_s_axis_tdata[11]} {fifo_0_s_axis_tdata[12]} {fifo_0_s_axis_tdata[13]} {fifo_0_s_axis_tdata[14]} {fifo_0_s_axis_tdata[15]} {fifo_0_s_axis_tdata[16]} {fifo_0_s_axis_tdata[17]} {fifo_0_s_axis_tdata[18]} {fifo_0_s_axis_tdata[19]} {fifo_0_s_axis_tdata[20]} {fifo_0_s_axis_tdata[21]} {fifo_0_s_axis_tdata[22]} {fifo_0_s_axis_tdata[23]} {fifo_0_s_axis_tdata[24]} {fifo_0_s_axis_tdata[25]} {fifo_0_s_axis_tdata[26]} {fifo_0_s_axis_tdata[27]} {fifo_0_s_axis_tdata[28]} {fifo_0_s_axis_tdata[29]} {fifo_0_s_axis_tdata[30]} {fifo_0_s_axis_tdata[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 32 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list {opencv_m_axis_tdata[0]} {opencv_m_axis_tdata[1]} {opencv_m_axis_tdata[2]} {opencv_m_axis_tdata[3]} {opencv_m_axis_tdata[4]} {opencv_m_axis_tdata[5]} {opencv_m_axis_tdata[6]} {opencv_m_axis_tdata[7]} {opencv_m_axis_tdata[8]} {opencv_m_axis_tdata[9]} {opencv_m_axis_tdata[10]} {opencv_m_axis_tdata[11]} {opencv_m_axis_tdata[12]} {opencv_m_axis_tdata[13]} {opencv_m_axis_tdata[14]} {opencv_m_axis_tdata[15]} {opencv_m_axis_tdata[16]} {opencv_m_axis_tdata[17]} {opencv_m_axis_tdata[18]} {opencv_m_axis_tdata[19]} {opencv_m_axis_tdata[20]} {opencv_m_axis_tdata[21]} {opencv_m_axis_tdata[22]} {opencv_m_axis_tdata[23]} {opencv_m_axis_tdata[24]} {opencv_m_axis_tdata[25]} {opencv_m_axis_tdata[26]} {opencv_m_axis_tdata[27]} {opencv_m_axis_tdata[28]} {opencv_m_axis_tdata[29]} {opencv_m_axis_tdata[30]} {opencv_m_axis_tdata[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 32 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list {sw_m_1_axis_tdata[0]} {sw_m_1_axis_tdata[1]} {sw_m_1_axis_tdata[2]} {sw_m_1_axis_tdata[3]} {sw_m_1_axis_tdata[4]} {sw_m_1_axis_tdata[5]} {sw_m_1_axis_tdata[6]} {sw_m_1_axis_tdata[7]} {sw_m_1_axis_tdata[8]} {sw_m_1_axis_tdata[9]} {sw_m_1_axis_tdata[10]} {sw_m_1_axis_tdata[11]} {sw_m_1_axis_tdata[12]} {sw_m_1_axis_tdata[13]} {sw_m_1_axis_tdata[14]} {sw_m_1_axis_tdata[15]} {sw_m_1_axis_tdata[16]} {sw_m_1_axis_tdata[17]} {sw_m_1_axis_tdata[18]} {sw_m_1_axis_tdata[19]} {sw_m_1_axis_tdata[20]} {sw_m_1_axis_tdata[21]} {sw_m_1_axis_tdata[22]} {sw_m_1_axis_tdata[23]} {sw_m_1_axis_tdata[24]} {sw_m_1_axis_tdata[25]} {sw_m_1_axis_tdata[26]} {sw_m_1_axis_tdata[27]} {sw_m_1_axis_tdata[28]} {sw_m_1_axis_tdata[29]} {sw_m_1_axis_tdata[30]} {sw_m_1_axis_tdata[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 1 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list Trgger/Control_Mode]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 1 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list dconv_m_axis_tlast]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 1 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list dconv_m_axis_tuser]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
set_property port_width 1 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list dconv_m_axis_tvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
set_property port_width 1 [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list fifo_0_s_axis_tlast]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
set_property port_width 1 [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list fifo_0_s_axis_tuser]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe17]
set_property port_width 1 [get_debug_ports u_ila_0/probe17]
connect_debug_port u_ila_0/probe17 [get_nets [list fifo_0_s_axis_tvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe18]
set_property port_width 1 [get_debug_ports u_ila_0/probe18]
connect_debug_port u_ila_0/probe18 [get_nets [list cmos_sampling_i/href]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe19]
set_property port_width 1 [get_debug_ports u_ila_0/probe19]
connect_debug_port u_ila_0/probe19 [get_nets [list cmos_sampling_i/href_out]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe20]
set_property port_width 1 [get_debug_ports u_ila_0/probe20]
connect_debug_port u_ila_0/probe20 [get_nets [list isp_model_axis_tlast]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe21]
set_property port_width 1 [get_debug_ports u_ila_0/probe21]
connect_debug_port u_ila_0/probe21 [get_nets [list isp_model_axis_tuser]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe22]
set_property port_width 1 [get_debug_ports u_ila_0/probe22]
connect_debug_port u_ila_0/probe22 [get_nets [list isp_model_axis_tvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe23]
set_property port_width 1 [get_debug_ports u_ila_0/probe23]
connect_debug_port u_ila_0/probe23 [get_nets [list opencv_model_i/sobel_axis_i/m_axis_tlast]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe24]
set_property port_width 1 [get_debug_ports u_ila_0/probe24]
connect_debug_port u_ila_0/probe24 [get_nets [list opencv_model_i/sobel_axis_i/m_axis_tuser]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe25]
set_property port_width 1 [get_debug_ports u_ila_0/probe25]
connect_debug_port u_ila_0/probe25 [get_nets [list opencv_model_i/sobel_axis_i/m_axis_tvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe26]
set_property port_width 1 [get_debug_ports u_ila_0/probe26]
connect_debug_port u_ila_0/probe26 [get_nets [list opencv_m_axis_tlast]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe27]
set_property port_width 1 [get_debug_ports u_ila_0/probe27]
connect_debug_port u_ila_0/probe27 [get_nets [list opencv_m_axis_tuser]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe28]
set_property port_width 1 [get_debug_ports u_ila_0/probe28]
connect_debug_port u_ila_0/probe28 [get_nets [list opencv_m_axis_tvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe29]
set_property port_width 1 [get_debug_ports u_ila_0/probe29]
connect_debug_port u_ila_0/probe29 [get_nets [list cmos_sampling_i/pixel_clk_out]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe30]
set_property port_width 1 [get_debug_ports u_ila_0/probe30]
connect_debug_port u_ila_0/probe30 [get_nets [list Trgger/SoftTrggr]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe31]
set_property port_width 1 [get_debug_ports u_ila_0/probe31]
connect_debug_port u_ila_0/probe31 [get_nets [list sw_m_0_axis_tlast]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe32]
set_property port_width 1 [get_debug_ports u_ila_0/probe32]
connect_debug_port u_ila_0/probe32 [get_nets [list sw_m_0_axis_tuser]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe33]
set_property port_width 1 [get_debug_ports u_ila_0/probe33]
connect_debug_port u_ila_0/probe33 [get_nets [list sw_m_0_axis_tvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe34]
set_property port_width 1 [get_debug_ports u_ila_0/probe34]
connect_debug_port u_ila_0/probe34 [get_nets [list sw_m_1_axis_tlast]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe35]
set_property port_width 1 [get_debug_ports u_ila_0/probe35]
connect_debug_port u_ila_0/probe35 [get_nets [list sw_m_1_axis_tuser]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe36]
set_property port_width 1 [get_debug_ports u_ila_0/probe36]
connect_debug_port u_ila_0/probe36 [get_nets [list sw_m_1_axis_tvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe37]
set_property port_width 1 [get_debug_ports u_ila_0/probe37]
connect_debug_port u_ila_0/probe37 [get_nets [list Trgger/sysclk]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe38]
set_property port_width 1 [get_debug_ports u_ila_0/probe38]
connect_debug_port u_ila_0/probe38 [get_nets [list vcap_i/tlast_tmp]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe39]
set_property port_width 1 [get_debug_ports u_ila_0/probe39]
connect_debug_port u_ila_0/probe39 [get_nets [list Trgger/Trggerio]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe40]
set_property port_width 1 [get_debug_ports u_ila_0/probe40]
connect_debug_port u_ila_0/probe40 [get_nets [list vcap_i/tuser_tmp]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe41]
set_property port_width 1 [get_debug_ports u_ila_0/probe41]
connect_debug_port u_ila_0/probe41 [get_nets [list vcap_m_axis_tlast]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe42]
set_property port_width 1 [get_debug_ports u_ila_0/probe42]
connect_debug_port u_ila_0/probe42 [get_nets [list vcap_m_axis_tuser]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe43]
set_property port_width 1 [get_debug_ports u_ila_0/probe43]
connect_debug_port u_ila_0/probe43 [get_nets [list vcap_m_axis_tvalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe44]
set_property port_width 1 [get_debug_ports u_ila_0/probe44]
connect_debug_port u_ila_0/probe44 [get_nets [list cmos_sampling_i/vsync]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe45]
set_property port_width 1 [get_debug_ports u_ila_0/probe45]
connect_debug_port u_ila_0/probe45 [get_nets [list cmos_sampling_i/vsync_out]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets FCLK_CLK0]
