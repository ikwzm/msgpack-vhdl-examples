#!/usr/bin/tclsh
set     project_directory   [file dirname [info script]]
set     project_name        "project"
source  [file join ".." ".." ".." ".." ".." ".." "lib" "fpga" "xilinx" "pynqz1" "project" "build_fsbl.tcl"]
