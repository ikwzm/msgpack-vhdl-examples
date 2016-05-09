# 
# LED8_AXI "LED8_AXI" v1.0
#  2016.01.29.17:06:41
# 

# 
# request TCL package from ACDS 15.1
# 
package require -exact qsys 15.1

# 
# module PTTY_AXI
# 
set_module_property DESCRIPTION                  "Pseudo TeleTYpe writer interface"
set_module_property NAME                         LED8_AXI
set_module_property VERSION                      1.0
set_module_property INTERNAL                     false
set_module_property OPAQUE_ADDRESS_MAP           true
set_module_property GROUP                        ikwzm
set_module_property AUTHOR                       "ikwzm"
set_module_property DISPLAY_NAME                 LED8_AXI
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
set_fileset_property QUARTUS_SYNTH TOP_LEVEL                     LED8_AXI
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE    false
add_fileset_file led8_axi.vhd      VHDL PATH led8_axi.vhd TOP_LEVEL_FILE
add_fileset_file led_csr.vhd       VHDL PATH led_csr.vhd

# 
# parameters
# 
add_parameter          C_ADDR_WIDTH      INTEGER               12
set_parameter_property C_ADDR_WIDTH      DISPLAY_NAME          CSR_ADDR_WIDTH
set_parameter_property C_ADDR_WIDTH      UNITS                 "bits"
set_parameter_property C_ADDR_WIDTH      HDL_PARAMETER         true
set_parameter_property C_ADDR_WIDTH      AFFECTS_ELABORATION   true
set_parameter_property C_ADDR_WIDTH      ALLOWED_RANGES        4:64

add_parameter          C_DATA_WIDTH      INTEGER               32
set_parameter_property C_DATA_WIDTH      DISPLAY_NAME          CSR_DATA_WIDTH
set_parameter_property C_DATA_WIDTH      UNITS                 "bits"
set_parameter_property C_DATA_WIDTH      HDL_PARAMETER         true
set_parameter_property C_DATA_WIDTH      AFFECTS_ELABORATION   true
set_parameter_property C_DATA_WIDTH      ALLOWED_RANGES        "32,64,128,256"

add_parameter          C_ID_WIDTH        INTEGER               12
set_parameter_property C_ID_WIDTH        DISPLAY_NAME          CSR_ID_WIDTH
set_parameter_property C_ID_WIDTH        UNITS                 "bits"
set_parameter_property C_ID_WIDTH        HDL_PARAMETER         true
set_parameter_property C_ID_WIDTH        AFFECTS_ELABORATION   true

add_parameter          AUTO_START        BOOLEAN               true
set_parameter_property AUTO_START        DISPLAY_NAME          AUTO_START
set_parameter_property AUTO_START        AFFECTS_ELABORATION   false
set_parameter_property AUTO_START        HDL_PARAMETER         true

add_parameter          DEFAULT_TIMER     INTEGER               100000000
set_parameter_property DEFAULT_TIMER     DISPLAY_NAME          DEFAULT_TIMER
set_parameter_property DEFAULT_TIMER     UNITS                 "cycles"
set_parameter_property DEFAULT_TIMER     AFFECTS_ELABORATION   false
set_parameter_property DEFAULT_TIMER     HDL_PARAMETER         true

add_parameter          DEFAULT_SEQ_0     INTEGER               0x18
set_parameter_property DEFAULT_SEQ_0     DISPLAY_NAME          DEFAULT_SEQ_0
set_parameter_property DEFAULT_SEQ_0     DISPLAY_HINT          hexadecimal
set_parameter_property DEFAULT_SEQ_0     ALLOWED_RANGES        0x00:0xFF
set_parameter_property DEFAULT_SEQ_0     AFFECTS_ELABORATION   false
set_parameter_property DEFAULT_SEQ_0     HDL_PARAMETER         true

add_parameter          DEFAULT_SEQ_1     INTEGER               0x24
set_parameter_property DEFAULT_SEQ_1     DISPLAY_NAME          DEFAULT_SEQ_1
set_parameter_property DEFAULT_SEQ_1     DISPLAY_HINT          hexadecimal
set_parameter_property DEFAULT_SEQ_1     ALLOWED_RANGES        0x00:0xFF
set_parameter_property DEFAULT_SEQ_1     AFFECTS_ELABORATION   false
set_parameter_property DEFAULT_SEQ_1     HDL_PARAMETER         true

add_parameter          DEFAULT_SEQ_2     INTEGER               0x42
set_parameter_property DEFAULT_SEQ_2     DISPLAY_NAME          DEFAULT_SEQ_2
set_parameter_property DEFAULT_SEQ_2     DISPLAY_HINT          hexadecimal
set_parameter_property DEFAULT_SEQ_2     ALLOWED_RANGES        0x00:0xFF
set_parameter_property DEFAULT_SEQ_2     AFFECTS_ELABORATION   false
set_parameter_property DEFAULT_SEQ_2     HDL_PARAMETER         true

add_parameter          DEFAULT_SEQ_3     INTEGER               0x81
set_parameter_property DEFAULT_SEQ_3     DISPLAY_NAME          DEFAULT_SEQ_3
set_parameter_property DEFAULT_SEQ_3     DISPLAY_HINT          hexadecimal
set_parameter_property DEFAULT_SEQ_3     ALLOWED_RANGES        0x00:0xFF
set_parameter_property DEFAULT_SEQ_3     AFFECTS_ELABORATION   false
set_parameter_property DEFAULT_SEQ_3     HDL_PARAMETER         true

add_parameter          DEFAULT_SEQ_4     INTEGER               0x42
set_parameter_property DEFAULT_SEQ_4     DISPLAY_NAME          DEFAULT_SEQ_4
set_parameter_property DEFAULT_SEQ_4     DISPLAY_HINT          hexadecimal
set_parameter_property DEFAULT_SEQ_4     ALLOWED_RANGES        0x00:0xFF
set_parameter_property DEFAULT_SEQ_4     AFFECTS_ELABORATION   false
set_parameter_property DEFAULT_SEQ_4     HDL_PARAMETER         true

add_parameter          DEFAULT_SEQ_5     INTEGER               0x24
set_parameter_property DEFAULT_SEQ_5     DISPLAY_NAME          DEFAULT_SEQ_5
set_parameter_property DEFAULT_SEQ_5     DISPLAY_HINT          hexadecimal
set_parameter_property DEFAULT_SEQ_5     ALLOWED_RANGES        0x00:0xFF
set_parameter_property DEFAULT_SEQ_5     AFFECTS_ELABORATION   false
set_parameter_property DEFAULT_SEQ_5     HDL_PARAMETER         true

add_parameter          DEFAULT_SEQ_6     INTEGER               0x00
set_parameter_property DEFAULT_SEQ_6     DISPLAY_NAME          DEFAULT_SEQ_6
set_parameter_property DEFAULT_SEQ_6     DISPLAY_HINT          hexadecimal
set_parameter_property DEFAULT_SEQ_6     ALLOWED_RANGES        0x00:0xFF
set_parameter_property DEFAULT_SEQ_6     AFFECTS_ELABORATION   false
set_parameter_property DEFAULT_SEQ_6     HDL_PARAMETER         true

add_parameter          DEFAULT_SEQ_7     INTEGER               0x00
set_parameter_property DEFAULT_SEQ_7     DISPLAY_NAME          DEFAULT_SEQ_7
set_parameter_property DEFAULT_SEQ_7     DISPLAY_HINT          hexadecimal
set_parameter_property DEFAULT_SEQ_7     ALLOWED_RANGES        0x00:0xFF
set_parameter_property DEFAULT_SEQ_7     AFFECTS_ELABORATION   false
set_parameter_property DEFAULT_SEQ_7     HDL_PARAMETER         true

add_parameter          DEFAULT_SEQ_LAST  INTEGER               5
set_parameter_property DEFAULT_SEQ_LAST  DISPLAY_NAME          DEFAULT_SEQ_LAST
set_parameter_property DEFAULT_SEQ_LAST  AFFECTS_ELABORATION   false
set_parameter_property DEFAULT_SEQ_LAST  ALLOWED_RANGES        0:7
set_parameter_property DEFAULT_SEQ_LAST  HDL_PARAMETER         true

#
#
#

# 
# display items
# 

# 
# connection point ACLOCK
# 
add_interface          ACLOCK  clock               sink
set_interface_property ACLOCK  clockRate           0
set_interface_property ACLOCK  ENABLED             true
set_interface_property ACLOCK  EXPORT_OF           ""
set_interface_property ACLOCK  PORT_NAME_MAP       ""
set_interface_property ACLOCK  CMSIS_SVD_VARIABLES ""
set_interface_property ACLOCK  SVD_ADDRESS_GROUP   ""
add_interface_port     ACLOCK  ACLOCK clk Input 1
# 
# connection point ARESETn
# 
add_interface          ARESETn reset               sink
set_interface_property ARESETn associatedClock     ACLOCK
set_interface_property ARESETn synchronousEdges    DEASSERT
set_interface_property ARESETn ENABLED             true
set_interface_property ARESETn EXPORT_OF           ""
set_interface_property ARESETn PORT_NAME_MAP       ""
set_interface_property ARESETn CMSIS_SVD_VARIABLES ""
set_interface_property ARESETn SVD_ADDRESS_GROUP   ""
add_interface_port     ARESETn ARESETn reset_n Input 1
# 
# connection point LED
# 
add_interface          LED     conduit             end
set_interface_property LED     associatedClock     ACLOCK
set_interface_property LED     ENABLED             true
set_interface_property LED     EXPORT_OF           ""
add_interface_port     LED     LED OUT Output 8

#
# for sopc2dts(SOPC to Device Tree File)
#
set_module_assignment embeddedsw.dts.vendor "ikwzm"
set_module_assignment embeddedsw.dts.name   "zled-0.10.a"
set_module_assignment embeddedsw.dts.group  "zled"

# 
# Elaboration callback
#
proc elaborate {} {
    #
    # connection point CSR
    #
    add_interface          CSR     axi4                         end
    set_interface_property CSR     associatedClock              ACLOCK
    set_interface_property CSR     associatedReset              ARESETn
    set_interface_property CSR     readAcceptanceCapability     1
    set_interface_property CSR     writeAcceptanceCapability    1
    set_interface_property CSR     combinedAcceptanceCapability 1
    set_interface_property CSR     readDataReorderingDepth      1
    set_interface_property CSR     bridgesToMaster              ""
    set_interface_property CSR     ENABLED                      true
    set_interface_property CSR     EXPORT_OF                    ""
    set_interface_property CSR     PORT_NAME_MAP                ""
    set_interface_property CSR     CMSIS_SVD_VARIABLES          ""
    set_interface_property CSR     SVD_ADDRESS_GROUP            ""

    set csr_id_width       [ get_parameter_value C_ID_WIDTH   ]
    set csr_addr_width     [ get_parameter_value C_ADDR_WIDTH ]
    set csr_data_width     [ get_parameter_value C_DATA_WIDTH ]
    
    add_interface_port     CSR     C_ARID      arid    Input  $csr_id_width
    add_interface_port     CSR     C_ARADDR    araddr  Input  $csr_addr_width
    add_interface_port     CSR     C_ARLEN     arlen   Input  8
    add_interface_port     CSR     C_ARSIZE    arsize  Input  3
    add_interface_port     CSR     C_ARBURST   arburst Input  2
    add_interface_port     CSR     C_ARVALID   arvalid Input  1
    add_interface_port     CSR     C_ARREADY   arready Output 1
    add_interface_port     CSR     C_RID       rid     Output $csr_id_width
    add_interface_port     CSR     C_RDATA     rdata   Output $csr_data_width
    add_interface_port     CSR     C_RRESP     rresp   Output 2
    add_interface_port     CSR     C_RLAST     rlast   Output 1
    add_interface_port     CSR     C_RVALID    rvalid  Output 1
    add_interface_port     CSR     C_RREADY    rready  Input  1
    add_interface_port     CSR     C_AWID      awid    Input  $csr_id_width
    add_interface_port     CSR     C_AWADDR    awaddr  Input  $csr_addr_width
    add_interface_port     CSR     C_AWLEN     awlen   Input  8
    add_interface_port     CSR     C_AWSIZE    awsize  Input  3
    add_interface_port     CSR     C_AWBURST   awburst Input  2
    add_interface_port     CSR     C_AWVALID   awvalid Input  1
    add_interface_port     CSR     C_AWREADY   awready Output 1
    add_interface_port     CSR     C_WDATA     wdata   Input  $csr_data_width
    add_interface_port     CSR     C_WSTRB     wstrb   Input  $csr_data_width/8
    add_interface_port     CSR     C_WLAST     wlast   Input  1
    add_interface_port     CSR     C_WVALID    wvalid  Input  1
    add_interface_port     CSR     C_WREADY    wready  Output 1
    add_interface_port     CSR     C_BID       bid     Output $csr_id_width
    add_interface_port     CSR     C_BRESP     bresp   Output 2
    add_interface_port     CSR     C_BVALID    bvalid  Output 1
    add_interface_port     CSR     C_BREADY    bready  Input  1
}
