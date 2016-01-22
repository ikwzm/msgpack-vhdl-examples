set     project_directory  [file dirname [info script]]
set     project_name       "project"
lappend ip_repo_path_list  [file join ".." "ip"]
set     RPC_SERVER_NAME    "ikwzm:msgpack:Fibonacci_Server_svl:1.0"
source  [file join ".." ".." ".." ".." ".." ".." "lib" "fpga" "xilinx" "zybo_test_1" "project" "create_project.tcl"]
set_property strategy "Flow_PerfOptimized_High"             [get_runs synth_1]
set_property strategy "Performance_ExplorePostRoutePhysOpt" [get_runs impl_1 ]
