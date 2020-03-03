onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+gray_count_bram -L xilinx_vip -L xil_defaultlib -L xpm -L blk_mem_gen_v8_4_1 -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.gray_count_bram xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {gray_count_bram.udo}

run -all

endsim

quit -force
