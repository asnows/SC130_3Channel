onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib normalize_bram_opt

do {wave.do}

view wave
view structure
view signals

do {normalize_bram.udo}

run -all

quit -force
