onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+maxtri7x7_shift_ram_0 -L xilinx_vip -L xil_defaultlib -L xpm -L xbip_utils_v3_0_9 -L c_reg_fd_v12_0_5 -L c_mux_bit_v12_0_5 -L c_shift_ram_v12_0_12 -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.maxtri7x7_shift_ram_0 xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {maxtri7x7_shift_ram_0.udo}

run -all

endsim

quit -force
