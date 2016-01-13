#
# implementation.tcl  Tcl script for implementation
#
set     project_directory   [file dirname [info script]]
set     project_name        "project"
set     sdk_workspace       [file join $project_directory $project_name.sdk]
#
# Open Project
#
open_project [file join $project_directory $project_name]
#
# Run Synthesis
#
launch_runs synth_1
wait_on_run synth_1
#
# Run Implementation
#
launch_runs impl_1
wait_on_run impl_1
open_run    impl_1
report_utilization -file [file join $project_directory "project.rpt" ]
report_timing      -file [file join $project_directory "project.rpt" ] -append
#
# Write Bitstream File
#
launch_runs impl_1 -to_step write_bitstream -job 4
wait_on_run impl_1
#
# Export Hardware
#
if { [file exists $sdk_workspace] == 0 } {
    file mkdir $sdk_workspace
}
set design_top_name [get_property "top" [current_fileset]]
file copy -force [file join $project_directory $project_name.runs "impl_1" $design_top_name.sysdef] [file join $sdk_workspace $design_top_name.hdf]
#
# Close Project
#
close_project
