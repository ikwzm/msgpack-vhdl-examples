# 
#  fibonacci_server "fibonacci_server" v1.0
#  2016.02.04.12:06:41
# 

# 
# request TCL package from ACDS 15.1
# 
package require -exact qsys 15.1

# 
# module PTTY_AXI
# 
set_module_property DESCRIPTION                  "Fibonacci Server for MessagePack-RPC"
set_module_property NAME                         fibonacci_server
set_module_property VERSION                      1.0
set_module_property INTERNAL                     false
set_module_property OPAQUE_ADDRESS_MAP           true
set_module_property GROUP                        ikwzm
set_module_property AUTHOR                       "ikwzm"
set_module_property DISPLAY_NAME                 fibonacci_server
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE                     true
set_module_property REPORT_TO_TALKBACK           false
set_module_property ALLOW_GREYBOX_GENERATION     false
set_module_property REPORT_HIERARCHY             false
set_module_property ELABORATION_CALLBACK         elaborate

# 
# file sets
# 
add_fileset          QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL                     Fibonacci_Server
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE    false
add_fileset_file fibonacci_server.vhd       VHDL PATH fibonacci_server.vhd TOP_LEVEL_FILE
add_fileset_file fib_interface.vhd          VHDL PATH fib_interface.vhd
add_fileset_file fib.vhd                    VHDL PATH fib.vhd

# 
# parameters
# 
add_parameter          I_BYTES      POSITIVE            4
set_parameter_property I_BYTES      DEFAULT_VALUE       4
set_parameter_property I_BYTES      DISPLAY_NAME        INTAKE_BYTES
set_parameter_property I_BYTES      TYPE                POSITIVE
set_parameter_property I_BYTES      UNITS               "bytes"
set_parameter_property I_BYTES      HDL_PARAMETER       true
set_parameter_property I_BYTES      AFFECTS_ELABORATION true
set_parameter_property I_BYTES      ALLOWED_RANGES      "1,2,4,8,16,32,64,128"

add_parameter          O_BYTES      POSITIVE            4
set_parameter_property O_BYTES      DEFAULT_VALUE       4
set_parameter_property O_BYTES      DISPLAY_NAME        OUTLET_BYTES
set_parameter_property O_BYTES      TYPE                POSITIVE
set_parameter_property O_BYTES      UNITS               "bytes"
set_parameter_property O_BYTES      HDL_PARAMETER       true
set_parameter_property O_BYTES      AFFECTS_ELABORATION true
set_parameter_property O_BYTES      ALLOWED_RANGES      "1,2,4,8,16,32,64,128"

#
#
#

# 
# display items
# 

# 
# connection point CLK
# 
add_interface          CLK     clock               sink
set_interface_property CLK     clockRate           0
set_interface_property CLK     ENABLED             true
set_interface_property CLK     EXPORT_OF           ""
set_interface_property CLK     PORT_NAME_MAP       ""
set_interface_property CLK     CMSIS_SVD_VARIABLES ""
set_interface_property CLK     SVD_ADDRESS_GROUP   ""
add_interface_port     CLK     CLK clk Input 1
# 
# connection point ARESETn
# 
add_interface          ARESETn reset               sink
set_interface_property ARESETn associatedClock     CLK
set_interface_property ARESETn synchronousEdges    DEASSERT
set_interface_property ARESETn ENABLED             true
set_interface_property ARESETn EXPORT_OF           ""
set_interface_property ARESETn PORT_NAME_MAP       ""
set_interface_property ARESETn CMSIS_SVD_VARIABLES ""
set_interface_property ARESETn SVD_ADDRESS_GROUP   ""
add_interface_port     ARESETn ARESETn reset_n Input 1
# 
# Elaboration callback
#
proc elaborate {} {
    # 
    # connection point O
    # 
    add_interface          O       axi4stream          start
    set_interface_property O       associatedClock     CLK
    set_interface_property O       associatedReset     ARESETn
    set_interface_property O       ENABLED             true
    set_interface_property O       EXPORT_OF           ""
    set_interface_property O       PORT_NAME_MAP       ""
    set_interface_property O       CMSIS_SVD_VARIABLES ""
    set_interface_property O       SVD_ADDRESS_GROUP   ""

    set o_bytes [ get_parameter_value O_BYTES ]

    add_interface_port     O       O_TDATA     tdata   Output $o_bytes*8
    add_interface_port     O       O_TKEEP     tkeep   Output $o_bytes
    add_interface_port     O       O_TLAST     tlast   Output 1
    add_interface_port     O       O_TREADY    tready  Input  1
    add_interface_port     O       O_TVALID    tvalid  Output 1
    # 
    # connection point I
    # 
    add_interface          I       axi4stream          end
    set_interface_property I       associatedClock     CLK
    set_interface_property I       associatedReset     ARESETn
    set_interface_property I       ENABLED             true
    set_interface_property I       EXPORT_OF           ""
    set_interface_property I       PORT_NAME_MAP       ""
    set_interface_property I       CMSIS_SVD_VARIABLES ""
    set_interface_property I       SVD_ADDRESS_GROUP   ""

    set i_bytes [ get_parameter_value I_BYTES ]

    add_interface_port     I       I_TDATA     tdata   Input  $i_bytes*8
    add_interface_port     I       I_TKEEP     tkeep   Input  $i_bytes
    add_interface_port     I       I_TLAST     tlast   Input  1
    add_interface_port     I       I_TREADY    tready  Output 1
    add_interface_port     I       I_TVALID    tvalid  Input  1
}
