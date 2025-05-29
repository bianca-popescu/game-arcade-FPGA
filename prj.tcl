project_new example1 -overwrite
set_global_assignment -name FAMILY MAX10
set_global_assignment -name DEVICE 10M50DAF484C7G
set_global_assignment -name VERILOG_FILE background.v
set_global_assignment -name TOP_LEVEL_ENTITY background

set_location_assignment -to clk PIN_P11

set_location_assignment  -to o_hsync PIN_N3
set_location_assignment  -to o_vsync PIN_N1

set_location_assignment  -to o_red[0] PIN_AA1
set_location_assignment  -to o_red[1] PIN_V1
set_location_assignment  -to o_red[2] PIN_Y2
set_location_assignment  -to o_red[3] PIN_Y1

set_location_assignment  -to o_green[0] PIN_W1
set_location_assignment  -to o_green[1] PIN_T2
set_location_assignment  -to o_green[2] PIN_R2
set_location_assignment  -to o_green[3] PIN_R1

set_location_assignment  -to o_blue[0] PIN_P1
set_location_assignment  -to o_blue[1] PIN_T1
set_location_assignment  -to o_blue[2] PIN_P4
set_location_assignment  -to o_blue[3] PIN_N2



load_package flow
execute_flow -compile
project_close
