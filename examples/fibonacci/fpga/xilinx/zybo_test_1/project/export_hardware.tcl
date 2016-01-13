#
# export_hardware.tcl  Tcl script for export hardware
#
set     project_directory   [file dirname [info script]]
set     project_name        "project"
set     sdk_workspace       [file join $project_directory $project_name.sdk]
#
# Open Project
#
open_project [file join $project_directory $project_name]
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
