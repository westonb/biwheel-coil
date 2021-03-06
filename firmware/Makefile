VERILOG_SOURCES = rtl/qcw_pll.v
TOPLEVEL=qcw_pll
MODULE=qcw_pll_test
COCOTB=~/Projects/cocotb
PYTHONPATH := ~/Projects/cocotb 
export COCOTB

VIVADO_BASE = /tools/Xilinx/Vivado/2018.3

CFLAGS=--specs=picolibc.specs -Wall --verbose

CC_RISCV=riscv64-unknown-elf-gcc
CFLAGS_RISCV=$(CFLAGS) -march=rv32im -mabi=ilp32 -Tsrc/powerSOC.ld



clean:
	rm -rf build/*
	rm -f bitstream.bit
	rm -f bitstream.bin
	rm -rf xsim.dir/
	rm -f src/firmware.hex
	rm -f src/firmware.bin
	rm -f src/firmware.elf
	rm -f xvlog.pb
	rm -f xelab.pb
	rm -f webtalk*
	rm -f xsim*
	rm -f top_sim.wdb
	rm -f *.wcfg
	rm -f *.wdb


all: bitstream.bit

simulate: src/firmware.hex
	xvlog --nolog rtl/*.v
	xvlog --nolog $(VIVADO_BASE)/data/verilog/src/glbl.v
	xelab --nolog -debug typical controller_top_tb glbl -s top_sim -L UNIFAST_VER -L UNISIMS_VER -L UNIMACRO_VER -L SECUREIP -L xpm
	xsim --nolog -g top_sim
	#vivado -mode tcl -nojournal -log sim/vivado.log -source sim.tcl
simulate_pll:
	xvlog --nolog rtl/qcw_pll.v rtl/qcw_pll_tb.v
	xelab --nolog -debug typical qcw_pll_tb -s pll_sim
	xsim --nolog -g pll_sim

simulate_driver:
	xvlog  rtl/qcw_driver.v rtl/qcw_driver_tb.v rtl/qcw_oscillator.v
	xvlog $(VIVADO_BASE)/data/verilog/src/glbl.v
	xelab -debug typical qcw_driver_tb glbl -s top_sim  -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -L xpm
	xsim  -g top_sim

simulate_xadc:
	xvlog  rtl/xadc_interface.v
	xvlog  rtl/xadc_interface_tb.v 
	xvlog $(VIVADO_BASE)/data/verilog/src/glbl.v
	xelab -debug typical xadc_interface_tb glbl -s top_sim  -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -L xpm
	xsim  -g top_sim

pll_full_simulate:
	python3 qcw_pll_test.py

bitstream.bit: src/firmware.hex
	vivado -mode tcl -nojournal -log build/vivado.log -source build.tcl

#src/firmware.elf: src/sections.lds src/start.s src/firmware.c
#	riscv32-unknown-elf-gcc -march=rv32i -Wl,-Bstatic,-T,src/sections.lds,--strip-debug -ffreestanding -nostdlib -o src/firmware.elf src/start.s src/firmware.c src/peripherals.h
src/firmware.elf: src/firmware.c
	$(CC_RISCV) $(CFLAGS_RISCV) -o $@ $^

src/firmware.bin: src/firmware.elf
	riscv64-unknown-elf-objcopy -O binary src/firmware.elf src/firmware.bin

src/firmware.hex: src/firmware.bin
	python3 makehex.py src/firmware.bin 8192 > src/firmware.hex



