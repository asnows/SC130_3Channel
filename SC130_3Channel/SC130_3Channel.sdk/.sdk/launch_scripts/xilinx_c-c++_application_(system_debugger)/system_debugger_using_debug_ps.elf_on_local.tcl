connect -url tcp:127.0.0.1:3121
source E:/WorkSpace/project/FPGA/SC130_3Channel/SC130_3Channel/SC130_3Channel.sdk/top_hw_platform_0/ps7_init.tcl
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Digilent JTAG-HS1 210512180081"} -index 0
loadhw -hw E:/WorkSpace/project/FPGA/SC130_3Channel/SC130_3Channel/SC130_3Channel.sdk/top_hw_platform_0/system.hdf -mem-ranges [list {0x40000000 0xbfffffff}]
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Digilent JTAG-HS1 210512180081"} -index 0
stop
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent JTAG-HS1 210512180081"} -index 0
rst -processor
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent JTAG-HS1 210512180081"} -index 0
dow E:/WorkSpace/project/FPGA/SC130_3Channel/SC130_3Channel/SC130_3Channel.sdk/ps/Debug/ps.elf
configparams force-mem-access 0
bpadd -addr &main
