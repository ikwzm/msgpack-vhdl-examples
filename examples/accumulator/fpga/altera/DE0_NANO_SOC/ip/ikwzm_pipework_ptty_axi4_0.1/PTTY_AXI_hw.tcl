# 
# PTTY_AXI "PTTY_AXI" v1.0
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
set_module_property NAME                         PTTY_AXI
set_module_property VERSION                      1.0
set_module_property INTERNAL                     false
set_module_property OPAQUE_ADDRESS_MAP           true
set_module_property GROUP                        ikwzm
set_module_property AUTHOR                       "ikwzm"
set_module_property DISPLAY_NAME                 PTTY_AXI
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
set_fileset_property QUARTUS_SYNTH TOP_LEVEL                     PTTY_AXI4
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE    false
add_fileset_file ptty_axi4.vhd     VHDL PATH ptty_axi4.vhd TOP_LEVEL_FILE
add_fileset_file ptty_rx.vhd       VHDL PATH ptty_rx.vhd
add_fileset_file ptty_rxd_buf.vhd  VHDL PATH ptty_rxd_buf.vhd
add_fileset_file ptty_tx.vhd       VHDL PATH ptty_tx.vhd
add_fileset_file ptty_txd_buf.vhd  VHDL PATH ptty_txd_buf.vhd

# 
# parameters
# 
add_parameter          TXD_BUF_DEPTH  INTEGER             7
set_parameter_property TXD_BUF_DEPTH  DEFAULT_VALUE       7
set_parameter_property TXD_BUF_DEPTH  DISPLAY_NAME        TXD_BUF_DEPTH
set_parameter_property TXD_BUF_DEPTH  TYPE                INTEGER
set_parameter_property TXD_BUF_DEPTH  UNITS               None
set_parameter_property TXD_BUF_DEPTH  HDL_PARAMETER       true
set_parameter_property TXD_BUF_DEPTH  AFFECTS_ELABORATION true
set_parameter_property TXD_BUF_DEPTH  ALLOWED_RANGES      4:9

add_parameter          TXD_BYTES      POSITIVE            1
set_parameter_property TXD_BYTES      DEFAULT_VALUE       1
set_parameter_property TXD_BYTES      DISPLAY_NAME        TXD_BYTES
set_parameter_property TXD_BYTES      TYPE                POSITIVE
set_parameter_property TXD_BYTES      UNITS               "bytes"
set_parameter_property TXD_BYTES      HDL_PARAMETER       true
set_parameter_property TXD_BYTES      AFFECTS_ELABORATION true
set_parameter_property TXD_BYTES      ALLOWED_RANGES      "1,2,4,8,16,32,64,128"

add_parameter          RXD_BUF_DEPTH  INTEGER             7
set_parameter_property RXD_BUF_DEPTH  DEFAULT_VALUE       7
set_parameter_property RXD_BUF_DEPTH  DISPLAY_NAME        RXD_BUF_DEPTH
set_parameter_property RXD_BUF_DEPTH  TYPE                INTEGER
set_parameter_property RXD_BUF_DEPTH  UNITS               None
set_parameter_property RXD_BUF_DEPTH  HDL_PARAMETER       true
set_parameter_property RXD_BUF_DEPTH  AFFECTS_ELABORATION true
set_parameter_property TXD_BUF_DEPTH  ALLOWED_RANGES      4:9

add_parameter          RXD_BYTES      POSITIVE            1
set_parameter_property RXD_BYTES      DEFAULT_VALUE       1
set_parameter_property RXD_BYTES      DISPLAY_NAME        RXD_BYTES
set_parameter_property RXD_BYTES      TYPE                POSITIVE
set_parameter_property RXD_BYTES      UNITS               "bytes"
set_parameter_property RXD_BYTES      HDL_PARAMETER       true
set_parameter_property RXD_BYTES      AFFECTS_ELABORATION true
set_parameter_property RXD_BYTES      ALLOWED_RANGES      "1,2,4,8,16,32,64,128"

add_parameter          CSR_ADDR_WIDTH INTEGER             12
set_parameter_property CSR_ADDR_WIDTH DEFAULT_VALUE       12
set_parameter_property CSR_ADDR_WIDTH DISPLAY_NAME        CSR_ADDR_WIDTH
set_parameter_property CSR_ADDR_WIDTH TYPE                INTEGER
set_parameter_property CSR_ADDR_WIDTH UNITS               "bits"
set_parameter_property CSR_ADDR_WIDTH HDL_PARAMETER       true
set_parameter_property CSR_ADDR_WIDTH AFFECTS_ELABORATION true
set_parameter_property CSR_ADDR_WIDTH ALLOWED_RANGES      12:64

add_parameter          CSR_DATA_WIDTH INTEGER             32
set_parameter_property CSR_DATA_WIDTH DEFAULT_VALUE       32
set_parameter_property CSR_DATA_WIDTH DISPLAY_NAME        CSR_DATA_WIDTH
set_parameter_property CSR_DATA_WIDTH TYPE                INTEGER
set_parameter_property CSR_DATA_WIDTH UNITS               "bits"
set_parameter_property CSR_DATA_WIDTH HDL_PARAMETER       true
set_parameter_property CSR_DATA_WIDTH AFFECTS_ELABORATION true
set_parameter_property CSR_DATA_WIDTH ALLOWED_RANGES      "32,64,128,256"

add_parameter          CSR_ID_WIDTH   INTEGER             12
set_parameter_property CSR_ID_WIDTH   DEFAULT_VALUE       12
set_parameter_property CSR_ID_WIDTH   DISPLAY_NAME        CSR_ID_WIDTH
set_parameter_property CSR_ID_WIDTH   TYPE                INTEGER
set_parameter_property CSR_ID_WIDTH   UNITS               "bits"
set_parameter_property CSR_ID_WIDTH   HDL_PARAMETER       true
set_parameter_property CSR_ID_WIDTH   AFFECTS_ELABORATION true

#
#
#

# 
# display items
# 

# 
# connection point CSR_CLK
# 
add_interface          CSR_CLK clock               sink
set_interface_property CSR_CLK clockRate           0
set_interface_property CSR_CLK ENABLED             true
set_interface_property CSR_CLK EXPORT_OF           ""
set_interface_property CSR_CLK PORT_NAME_MAP       ""
set_interface_property CSR_CLK CMSIS_SVD_VARIABLES ""
set_interface_property CSR_CLK SVD_ADDRESS_GROUP   ""
add_interface_port     CSR_CLK CSR_CLK clk Input 1
# 
# connection point ARESETn
# 
add_interface          ARESETn reset               sink
set_interface_property ARESETn associatedClock     CSR_CLK
set_interface_property ARESETn synchronousEdges    DEASSERT
set_interface_property ARESETn ENABLED             true
set_interface_property ARESETn EXPORT_OF           ""
set_interface_property ARESETn PORT_NAME_MAP       ""
set_interface_property ARESETn CMSIS_SVD_VARIABLES ""
set_interface_property ARESETn SVD_ADDRESS_GROUP   ""
add_interface_port     ARESETn ARESETn reset_n Input 1
# 
# connection point RXD_CLK
# 
add_interface          RXD_CLK clock               sink
set_interface_property RXD_CLK clockRate           0
set_interface_property RXD_CLK ENABLED             true
set_interface_property RXD_CLK EXPORT_OF           ""
set_interface_property RXD_CLK PORT_NAME_MAP       ""
set_interface_property RXD_CLK CMSIS_SVD_VARIABLES ""
set_interface_property RXD_CLK SVD_ADDRESS_GROUP   ""
add_interface_port     RXD_CLK RXD_CLK clk Input 1
# 
# connection point TXD_CLK
# 
add_interface          TXD_CLK clock               sink
set_interface_property TXD_CLK clockRate           0
set_interface_property TXD_CLK ENABLED             true
set_interface_property TXD_CLK EXPORT_OF           ""
set_interface_property TXD_CLK PORT_NAME_MAP       ""
set_interface_property TXD_CLK CMSIS_SVD_VARIABLES ""
set_interface_property TXD_CLK SVD_ADDRESS_GROUP   ""
add_interface_port     TXD_CLK TXD_CLK clk Input 1
# 
# connection point CSR_IRQ
# 
add_interface          CSR_IRQ interrupt                  sender
set_interface_property CSR_IRQ associatedAddressablePoint ""
set_interface_property CSR_IRQ associatedClock            CSR_CLK
set_interface_property CSR_IRQ bridgedReceiverOffset      ""
set_interface_property CSR_IRQ bridgesToReceiver          ""
set_interface_property CSR_IRQ ENABLED                    true
set_interface_property CSR_IRQ EXPORT_OF                  ""
set_interface_property CSR_IRQ PORT_NAME_MAP              ""
set_interface_property CSR_IRQ CMSIS_SVD_VARIABLES        ""
set_interface_property CSR_IRQ SVD_ADDRESS_GROUP          ""
add_interface_port     CSR_IRQ CSR_IRQ irq Output 1
#
# for sopc2dts(SOPC to Device Tree File)
#
set_module_assignment embeddedsw.dts.vendor "ikwzm"
set_module_assignment embeddedsw.dts.name   "zptty-0.10.a"
set_module_assignment embeddedsw.dts.group  "zptty"
# 
# Elaboration callback
#
proc elaborate {} {
    #
    # connection point CSR
    #
    add_interface          CSR     axi4                         end
    set_interface_property CSR     associatedClock              CSR_CLK
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

    set csr_id_width       [ get_parameter_value CSR_ID_WIDTH   ]
    set csr_addr_width     [ get_parameter_value CSR_ADDR_WIDTH ]
    set csr_data_width     [ get_parameter_value CSR_DATA_WIDTH ]
    
    add_interface_port     CSR     CSR_ARID    arid    Input  $csr_id_width
    add_interface_port     CSR     CSR_ARADDR  araddr  Input  $csr_addr_width
    add_interface_port     CSR     CSR_ARLEN   arlen   Input  8
    add_interface_port     CSR     CSR_ARSIZE  arsize  Input  3
    add_interface_port     CSR     CSR_ARBURST arburst Input  2
    add_interface_port     CSR     CSR_ARVALID arvalid Input  1
    add_interface_port     CSR     CSR_ARREADY arready Output 1
    add_interface_port     CSR     CSR_RID     rid     Output $csr_id_width
    add_interface_port     CSR     CSR_RDATA   rdata   Output $csr_data_width
    add_interface_port     CSR     CSR_RRESP   rresp   Output 2
    add_interface_port     CSR     CSR_RLAST   rlast   Output 1
    add_interface_port     CSR     CSR_RVALID  rvalid  Output 1
    add_interface_port     CSR     CSR_RREADY  rready  Input  1
    add_interface_port     CSR     CSR_AWID    awid    Input  $csr_id_width
    add_interface_port     CSR     CSR_AWADDR  awaddr  Input  $csr_addr_width
    add_interface_port     CSR     CSR_AWLEN   awlen   Input  8
    add_interface_port     CSR     CSR_AWSIZE  awsize  Input  3
    add_interface_port     CSR     CSR_AWBURST awburst Input  2
    add_interface_port     CSR     CSR_AWVALID awvalid Input  1
    add_interface_port     CSR     CSR_AWREADY awready Output 1
    add_interface_port     CSR     CSR_WDATA   wdata   Input  $csr_data_width
    add_interface_port     CSR     CSR_WSTRB   wstrb   Input  $csr_data_width/8
    add_interface_port     CSR     CSR_WLAST   wlast   Input  1
    add_interface_port     CSR     CSR_WVALID  wvalid  Input  1
    add_interface_port     CSR     CSR_WREADY  wready  Output 1
    add_interface_port     CSR     CSR_BID     bid     Output $csr_id_width
    add_interface_port     CSR     CSR_BRESP   bresp   Output 2
    add_interface_port     CSR     CSR_BVALID  bvalid  Output 1
    add_interface_port     CSR     CSR_BREADY  bready  Input  1
    # 
    # connection point TXD
    # 
    add_interface          TXD     axi4stream          start
    set_interface_property TXD     associatedClock     TXD_CLK
    set_interface_property TXD     associatedReset     ARESETn
    set_interface_property TXD     ENABLED             true
    set_interface_property TXD     EXPORT_OF           ""
    set_interface_property TXD     PORT_NAME_MAP       ""
    set_interface_property TXD     CMSIS_SVD_VARIABLES ""
    set_interface_property TXD     SVD_ADDRESS_GROUP   ""

    set txd_bytes [ get_parameter_value TXD_BYTES ]

    add_interface_port     TXD     TXD_TDATA   tdata   Output $txd_bytes*8
    add_interface_port     TXD     TXD_TKEEP   tkeep   Output $txd_bytes
    add_interface_port     TXD     TXD_TLAST   tlast   Output 1
    add_interface_port     TXD     TXD_TREADY  tready  Input  1
    add_interface_port     TXD     TXD_TVALID  tvalid  Output 1
    # 
    # connection point RXD
    # 
    add_interface          RXD     axi4stream          end
    set_interface_property RXD     associatedClock     RXD_CLK
    set_interface_property RXD     associatedReset     ARESETn
    set_interface_property RXD     ENABLED             true
    set_interface_property RXD     EXPORT_OF           ""
    set_interface_property RXD     PORT_NAME_MAP       ""
    set_interface_property RXD     CMSIS_SVD_VARIABLES ""
    set_interface_property RXD     SVD_ADDRESS_GROUP   ""

    set rxd_bytes [ get_parameter_value rXD_BYTES ]

    add_interface_port     RXD     RXD_TDATA   tdata   Input  $rxd_bytes*8
    add_interface_port     RXD     RXD_TKEEP   tkeep   Input  $rxd_bytes
    add_interface_port     RXD     RXD_TLAST   tlast   Input  1
    add_interface_port     RXD     RXD_TREADY  tready  Output 1
    add_interface_port     RXD     RXD_TVALID  tvalid  Input  1
}
