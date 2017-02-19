#
# create_project.tcl  Tcl script for creating project
#

set project_directory       [file dirname [info script]]
set project_name            "fibonacci"
set device_parts            "xc7z010clg400-1"
#
# Create project
#
create_project -force $project_name $project_directory
#
# Set project properties
#
set_property "part"               $device_parts    [get_projects $project_name]
set_property "default_lib"        "xil_defaultlib" [get_projects $project_name]
set_property "simulator_language" "Mixed"          [get_projects $project_name]
set_property "target_language"    "VHDL"           [get_projects $project_name]
#
# Create fileset "sources_1"
#
if {[string equal [get_filesets -quiet sources_1] ""]} {
    create_fileset -srcset sources_1
}
#
# Create fileset "constrs_1"
#
if {[string equal [get_filesets -quiet constrs_1] ""]} {
    create_fileset -constrset constrs_1
}
#
# Create fileset "sim_1"
#
if {[string equal [get_filesets -quiet sim_1] ""]} {
    create_fileset -simset sim_1
}
#
# Create run "synth_1" and set property
#
if {[string equal [get_runs -quiet synth_1] ""]} {
    create_run -name synth_1 -part $device_parts -flow "Vivado Synthesis 2015" -strategy "Vivado Synthesis Defaults" -constrset constrs_1
} else {
  # set_property flow     "Vivado Synthesis 2014"     [get_runs synth_1]
    set_property strategy "Vivado Synthesis Defaults" [get_runs synth_1]
    set_property strategy "Flow_PerfOptimized_High"   [get_runs synth_1]
}
current_run -synthesis [get_runs synth_1]
#
# Create run "impl_1" and set property
#
if {[string equal [get_runs -quiet impl_1] ""]} {
    create_run -name impl_1 -part $device_parts -flow "Vivado Implementation 2015" -strategy "Vivado Implementation Defaults" -constrset constrs_1 -parent_run synth_1
} else {
  # set_property flow     "Vivado Implementation 2014"     [get_runs impl_1]
    set_property strategy "Vivado Implementation Defaults" [get_runs impl_1]
    set_property strategy "Performance_Explore"            [get_runs impl_1]
}
current_run -implementation [get_runs impl_1]
#
# Set 'sources_1' and 'sim_1' fileset object
#

proc add_verilog_file {fileset library_name file_name} {
    set file    [file normalize $file_name]
    set fileset [get_filesets   $fileset  ] 
    add_files -norecurse -fileset $fileset $file
    set file_obj [get_files -of_objects $fileset $file]
    set_property "file_type" "Verilog"     $file_obj
    set_property "library"   $library_name $file_obj
}
add_verilog_file sources_1 WORK ./polyphony_out_fib.v
add_verilog_file sim_1     WORK ./polyphony_out.v
add_verilog_file sim_1     WORK ./polyphony_out_test.v
#
# Set 'constrs_1'  fileset object
#

#
# Set 'sources_1' fileset properties
#
set obj [get_filesets sources_1]
set_property "top" "fib"  $obj
#
# Set 'sim_1' fileset properties
#
set obj [get_filesets sim_1]
set_property "top" "test"  $obj
