#!/usr/bin/tclsh

set app_name            "fsbl"
set app_type            {Zynq FSBL}
set bsp_name            "fsbl_bsp"
set hw_name             "design_1_wrapper_hw_platform_0"
set hwspec_file         "design_1_wrapper.hdf"
set proc_name           "ps7_cortexa9_0"
set project_directory   [file dirname [info script]]
set workspace           [file join $project_directory "project.sdk"]

sdk set_workspace $workspace

sdk create_hw_project -name $hw_name -hwspec [file join $workspace $hwspec_file]

hsi::open_hw_design  [file join $workspace $hw_name "system.hdf"]
hsi::create_sw_design $bsp_name -proc $proc_name -os standalone
hsi::add_library xilffs
hsi::generate_bsp -sw $bsp_name -dir [file join $workspace $bsp_name] -compile
hsi::close_sw_design  $bsp_name

sdk create_app_project -name $app_name -hwproject $hw_name -proc $proc_name -os standalone -lang C -app $app_type -bsp $bsp_name

sdk build_project $app_name

exit
