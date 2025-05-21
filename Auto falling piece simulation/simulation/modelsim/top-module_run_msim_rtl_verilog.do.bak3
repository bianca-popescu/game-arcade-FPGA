transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/carme/Desktop/tetris-FPGA {C:/Users/carme/Desktop/tetris-FPGA/top_module.v}
vlog -vlog01compat -work work +incdir+C:/Users/carme/Desktop/tetris-FPGA {C:/Users/carme/Desktop/tetris-FPGA/tick_generator.v}
vlog -vlog01compat -work work +incdir+C:/Users/carme/Desktop/tetris-FPGA {C:/Users/carme/Desktop/tetris-FPGA/grid.v}

