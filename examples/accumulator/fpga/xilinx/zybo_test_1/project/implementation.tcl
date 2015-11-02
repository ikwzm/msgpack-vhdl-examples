
set project_directory       [file dirname [info script]]
set project_name            "project"

open_project [file join $project_directory $project_name]
launch_runs synth_1
wait_on_run synth_1
launch_runs impl_1
wait_on_run impl_1
open_run    impl_1
report_utilization -file [file join $project_directory "project.rpt" ]
report_timing      -file [file join $project_directory "project.rpt" ] -append
launch_runs impl_1 -to_step write_bitstream -job 4
wait_on_run impl_1
close_project
