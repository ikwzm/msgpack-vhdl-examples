
################################################################
# This is a generated script based on design: design_1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

################################################################
# Check if script is running in correct Vivado version.
################################################################
array set available_vivado_version_list {"2014.2"   "ok"}
array set available_vivado_version_list {"2014.3"   "ok"}
array set available_vivado_version_list {"2014.3.1" "ok"}
array set available_vivado_version_list {"2014.4"   "ok"}
array set available_vivado_version_list {"2015.1"   "ok"}
array set available_vivado_version_list {"2015.2"   "ok"}
array set available_vivado_version_list {"2015.3"   "ok"}
set available_vivado_version [array names available_vivado_version_list]
set current_vivado_version   [version -short]

if { [string first [lindex [array get available_vivado_version_list $current_vivado_version] 1] "ok"] == -1 } {
   puts ""
   puts "ERROR: This script was generated using Vivado <$available_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$available_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_1_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7z010clg400-1


# CHANGE DESIGN NAME HERE
set design_name design_1

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}


# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} ne "" && ${cur_design} eq ${design_name} } {

   # Checks if design is empty or not
   if { $list_cells ne "" } {
      set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
      set nRet 1
   } else {
      puts "INFO: Constructing design in IPI design <$design_name>..."
   }
} elseif { ${cur_design} ne "" && ${cur_design} ne ${design_name} } {

   if { $list_cells eq "" } {
      puts "INFO: You have an empty design <${cur_design}>. Will go ahead and create design..."
   } else {
      set errMsg "ERROR: Design <${cur_design}> is not empty! Please do not source this script on non-empty designs."
      set nRet 1
   }
} else {

   if { [get_files -quiet ${design_name}.bd] eq "" } {
      puts "INFO: Currently there is no design <$design_name> in project, so creating one..."

      create_bd_design $design_name

      puts "INFO: Making design <$design_name> as current_bd_design."
      current_bd_design $design_name

   } else {
      set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
      set nRet 3
   }

}

puts "INFO: Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   puts $errMsg
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]
  set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]

  # Create ports
  set LED [ create_bd_port -dir O -from 3 -to 0 LED ]

  # Create instance: LED4_AXI_0, and set properties
  set LED4_AXI_0   [ create_bd_cell -type ip -vlnv ikwzm:pipework:LED4_AXI:1.0 LED4_AXI_0 ]

  # Create instance: PTTY_AXI4_0, and set properties
  set PTTY_AXI4_0  [ create_bd_cell -type ip -vlnv ikwzm:pipework:PTTY_AXI4:1.0 PTTY_AXI4_0 ]
  set_property -dict [ list CONFIG.RXD_BYTES {4} CONFIG.TXD_BYTES {4} ] [get_bd_cells PTTY_AXI4_0 ]

  # Create instance: RPC_SERVER_0, and set properties
  set RPC_SERVER_0 [ create_bd_cell -type ip -vlnv ikwzm:msgpack:Fibonacci_Server:1.0 RPC_SERVER_0 ]
  set_property -dict [ list CONFIG.I_BYTES {4} CONFIG.O_BYTES {4} ] [get_bd_cells RPC_SERVER_0 ]

  # Create instance: axi_interconnect_csr, and set properties
  set axi_interconnect_csr [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_csr ]

  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0 ]

  # 
  set import_board_preset [file join [file dirname [info script]] "ZYBO_zynq_def.xml"]

  # Create instance: processing_system7_0, and set properties
  if { [string equal "2014.2"  [version -short] ] == 1 } {
    set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.4 processing_system7_0 ]
    set_property -dict [ list CONFIG.PCW_IMPORT_BOARD_PRESET $import_board_preset CONFIG.PCW_IRQ_F2P_INTR {1} CONFIG.PCW_USE_FABRIC_INTERRUPT {1} CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100.0} ] $processing_system7_0
  }
  if { [string match "2014.[34]*" [version -short] ] == 1 } {
    set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]
    set_property -dict [ list CONFIG.PCW_IMPORT_BOARD_PRESET $import_board_preset CONFIG.PCW_IRQ_F2P_INTR {1} CONFIG.PCW_USE_FABRIC_INTERRUPT {1} CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100.0} ] $processing_system7_0
  }
  if { [string match "2015.[123]*" [version -short] ] == 1 } {
    set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]
    set_property -dict [ list CONFIG.PCW_IMPORT_BOARD_PRESET $import_board_preset CONFIG.PCW_IRQ_F2P_INTR {1} CONFIG.PCW_USE_FABRIC_INTERRUPT {1} CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100.0} ] $processing_system7_0
  }


  # Create interface connections
  connect_bd_intf_net -intf_net PTTY_AXI4_0_TXD [get_bd_intf_pins PTTY_AXI4_0/TXD] [get_bd_intf_pins RPC_SERVER_0/I]
  connect_bd_intf_net -intf_net axi_interconnect_csr_M00_AXI [get_bd_intf_pins LED4_AXI_0/CSR] [get_bd_intf_pins axi_interconnect_csr/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_csr_M01_AXI [get_bd_intf_pins PTTY_AXI4_0/CSR] [get_bd_intf_pins axi_interconnect_csr/M01_AXI]
  connect_bd_intf_net -intf_net PTTY_AXI4_0_RXD [get_bd_intf_pins PTTY_AXI4_0/RXD] [get_bd_intf_pins RPC_SERVER_0/O]
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_0/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_0/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins axi_interconnect_csr/S00_AXI] [get_bd_intf_pins processing_system7_0/M_AXI_GP0]

  # Create port connections
  connect_bd_net -net LED4_AXI_0_LED [get_bd_ports LED] [get_bd_pins LED4_AXI_0/LED]
  connect_bd_net -net PTTY_AXI4_0_CSR_IRQ [get_bd_pins PTTY_AXI4_0/CSR_IRQ] [get_bd_pins processing_system7_0/IRQ_F2P]
  connect_bd_net -net proc_sys_reset_0_interconnect_aresetn [get_bd_pins axi_interconnect_csr/ARESETN] [get_bd_pins axi_interconnect_csr/M00_ARESETN] [get_bd_pins axi_interconnect_csr/M01_ARESETN] [get_bd_pins axi_interconnect_csr/S00_ARESETN] [get_bd_pins proc_sys_reset_0/interconnect_aresetn]
  connect_bd_net -net proc_sys_reset_0_peripheral_aresetn [get_bd_pins LED4_AXI_0/ARESETn] [get_bd_pins PTTY_AXI4_0/ARESETn] [get_bd_pins RPC_SERVER_0/ARESETn] [get_bd_pins proc_sys_reset_0/peripheral_aresetn]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins LED4_AXI_0/ACLOCK] [get_bd_pins PTTY_AXI4_0/CSR_CLK] [get_bd_pins PTTY_AXI4_0/RXD_CLK] [get_bd_pins PTTY_AXI4_0/TXD_CLK] [get_bd_pins axi_interconnect_csr/ACLK] [get_bd_pins axi_interconnect_csr/M00_ACLK] [get_bd_pins axi_interconnect_csr/M01_ACLK] [get_bd_pins axi_interconnect_csr/S00_ACLK] [get_bd_pins RPC_SERVER_0/CLK] [get_bd_pins proc_sys_reset_0/slowest_sync_clk] [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins proc_sys_reset_0/ext_reset_in] [get_bd_pins processing_system7_0/FCLK_RESET0_N]

  # Create address segments
  create_bd_addr_seg -range 0x10000 -offset 0x43C00000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs LED4_AXI_0/CSR/CSR] SEG_LED4_AXI_0_CSR
  create_bd_addr_seg -range 0x10000 -offset 0x43C10000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs PTTY_AXI4_0/CSR/reg0] SEG_PTTY_AXI4_0_reg0
  

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


