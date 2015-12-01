open_project -reset fib_prj
set_top fib
add_files ../../../../src/main/vivado_hls/fib.c

open_solution -reset "solution1"
set_part {xc7z010clg400-1}
create_clock -period 10 -name default

#source "./fibonacci/solution1/directives.tcl"
#csim_design
csynth_design
#cosim_design
#export_design -evaluate vhdl -format ip_catalog

exit
