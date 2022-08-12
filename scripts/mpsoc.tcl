
################################################################
# This is a generated script based on design: mpsoc
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2020.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source mpsoc_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xczu19eg-ffvc1760-2-e
   set_property BOARD_PART sugon:nf_card:part0:2.0 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name mpsoc

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
user.org:user:BFS:1.0\
xilinx.com:ip:axi_clock_converter:2.1\
xilinx.com:ip:axi_crossbar:2.1\
xilinx.com:ip:axis_clock_converter:1.1\
xilinx.com:ip:axis_data_fifo:2.0\
xilinx.com:ip:clk_wiz:6.0\
xilinx.com:ip:xlconstant:1.1\
xilinx.com:ip:cmac_usplus:3.1\
xilinx.com:ip:ddr4:2.2\
xilinx.com:ip:util_ds_buf:2.1\
user.org:user:doce_top:1.0\
user.org:user:mac_addr_reg:1.0\
xilinx.com:ip:util_vector_logic:2.0\
xilinx.com:ip:proc_sys_reset:5.0\
user.org:user:rx_reset_cnt:1.0\
xilinx.com:ip:zynq_ultra_ps_e:3.3\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set c0_ddr4 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddr4_rtl:1.0 c0_ddr4 ]

  set ddr4_mig_sys_clk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 ddr4_mig_sys_clk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {100000000} \
   ] $ddr4_mig_sys_clk

  set gt_ref_clk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 gt_ref_clk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {156250000} \
   ] $gt_ref_clk


  # Create ports
  set gt_rxn_in [ create_bd_port -dir I -from 3 -to 0 gt_rxn_in ]
  set gt_rxp_in [ create_bd_port -dir I -from 3 -to 0 gt_rxp_in ]
  set gt_txn_out [ create_bd_port -dir O -from 3 -to 0 gt_txn_out ]
  set gt_txp_out [ create_bd_port -dir O -from 3 -to 0 gt_txp_out ]

  # Create instance: BFS_0, and set properties
  set BFS_0 [ create_bd_cell -type ip -vlnv user.org:user:BFS:1.0 BFS_0 ]

  # Create instance: axi_clock_converter_0, and set properties
  set axi_clock_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_clock_converter:2.1 axi_clock_converter_0 ]

  # Create instance: axi_clock_converter_b2z0, and set properties
  set axi_clock_converter_b2z0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_clock_converter:2.1 axi_clock_converter_b2z0 ]

  # Create instance: axi_clock_converter_b2z1, and set properties
  set axi_clock_converter_b2z1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_clock_converter:2.1 axi_clock_converter_b2z1 ]

  # Create instance: axi_clock_converter_b2z2, and set properties
  set axi_clock_converter_b2z2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_clock_converter:2.1 axi_clock_converter_b2z2 ]

  # Create instance: axi_clock_converter_b2z3, and set properties
  set axi_clock_converter_b2z3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_clock_converter:2.1 axi_clock_converter_b2z3 ]

  # Create instance: axi_crossbar_0, and set properties
  set axi_crossbar_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_crossbar:2.1 axi_crossbar_0 ]
  set_property -dict [ list \
   CONFIG.M00_READ_ISSUING {32} \
   CONFIG.M00_WRITE_ISSUING {32} \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {2} \
   CONFIG.S00_READ_ACCEPTANCE {32} \
   CONFIG.S00_WRITE_ACCEPTANCE {32} \
   CONFIG.S01_READ_ACCEPTANCE {32} \
   CONFIG.S01_WRITE_ACCEPTANCE {32} \
 ] $axi_crossbar_0

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {2} \
   CONFIG.S00_HAS_DATA_FIFO {2} \
   CONFIG.STRATEGY {2} \
 ] $axi_interconnect_0

  # Create instance: axi_interconnect_1, and set properties
  set axi_interconnect_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_1 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
   CONFIG.S00_HAS_DATA_FIFO {0} \
 ] $axi_interconnect_1

  # Create instance: axi_interconnect_2, and set properties
  set axi_interconnect_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_2 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
 ] $axi_interconnect_2

  # Create instance: axis_clock_converter_0, and set properties
  set axis_clock_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter:1.1 axis_clock_converter_0 ]

  # Create instance: axis_data_fifo_c2d1, and set properties
  set axis_data_fifo_c2d1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_c2d1 ]
  set_property -dict [ list \
   CONFIG.FIFO_MODE {1} \
   CONFIG.HAS_TKEEP {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.IS_ACLK_ASYNC {0} \
   CONFIG.TDATA_NUM_BYTES {64} \
 ] $axis_data_fifo_c2d1

  # Create instance: axis_interconnect_d2c, and set properties
  set axis_interconnect_d2c [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 axis_interconnect_d2c ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
   CONFIG.S00_FIFO_DEPTH {512} \
   CONFIG.S00_FIFO_MODE {1} \
 ] $axis_interconnect_d2c

  # Create instance: clk_wiz_bfs, and set properties
  set clk_wiz_bfs [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_bfs ]
  set_property -dict [ list \
   CONFIG.CLKIN1_JITTER_PS {37.519999999999996} \
   CONFIG.CLKOUT1_JITTER {128.370} \
   CONFIG.CLKOUT1_PHASE_ERROR {244.600} \
   CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {150} \
   CONFIG.MMCM_CLKFBOUT_MULT_F {75.000} \
   CONFIG.MMCM_CLKIN1_PERIOD {3.752} \
   CONFIG.MMCM_CLKIN2_PERIOD {10.0} \
   CONFIG.MMCM_CLKOUT0_DIVIDE_F {10.250} \
   CONFIG.MMCM_DIVCLK_DIVIDE {13} \
 ] $clk_wiz_bfs

  # Create instance: clk_wiz_doce, and set properties
  set clk_wiz_doce [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_doce ]
  set_property -dict [ list \
   CONFIG.CLKIN1_JITTER_PS {31.03} \
   CONFIG.CLKOUT1_JITTER {336.421} \
   CONFIG.CLKOUT1_PHASE_ERROR {621.748} \
   CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {300} \
   CONFIG.MMCM_CLKFBOUT_MULT_F {64.000} \
   CONFIG.MMCM_CLKIN1_PERIOD {3.103} \
   CONFIG.MMCM_CLKIN2_PERIOD {10.0} \
   CONFIG.MMCM_CLKOUT0_DIVIDE_F {2.750} \
   CONFIG.MMCM_DIVCLK_DIVIDE {25} \
 ] $clk_wiz_doce

  # Create instance: cmac_const_0, and set properties
  set cmac_const_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 cmac_const_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $cmac_const_0

  # Create instance: cmac_const_1, and set properties
  set cmac_const_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 cmac_const_1 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {1} \
 ] $cmac_const_1

  # Create instance: cmac_const_gt_loopback_in, and set properties
  set cmac_const_gt_loopback_in [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 cmac_const_gt_loopback_in ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {12} \
 ] $cmac_const_gt_loopback_in

  # Create instance: cmac_usplus_0, and set properties
  set cmac_usplus_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:cmac_usplus:3.1 cmac_usplus_0 ]
  set_property -dict [ list \
   CONFIG.CMAC_CAUI4_MODE {1} \
   CONFIG.CMAC_CORE_SELECT {CMACE4_X0Y1} \
   CONFIG.ENABLE_AXI_INTERFACE {0} \
   CONFIG.GT_GROUP_SELECT {X0Y12~X0Y15} \
   CONFIG.GT_REF_CLK_FREQ {156.25} \
   CONFIG.INCLUDE_STATISTICS_COUNTERS {0} \
   CONFIG.LANE10_GT_LOC {NA} \
   CONFIG.LANE1_GT_LOC {X0Y12} \
   CONFIG.LANE2_GT_LOC {X0Y13} \
   CONFIG.LANE3_GT_LOC {X0Y14} \
   CONFIG.LANE4_GT_LOC {X0Y15} \
   CONFIG.NUM_LANES {4x25} \
   CONFIG.RX_FLOW_CONTROL {0} \
   CONFIG.RX_FRAME_CRC_CHECKING {Enable FCS Stripping} \
   CONFIG.TX_FLOW_CONTROL {0} \
   CONFIG.TX_FRAME_CRC_CHECKING {Enable FCS Insertion} \
   CONFIG.USER_INTERFACE {AXIS} \
 ] $cmac_usplus_0

  # Create instance: ddr4_mig, and set properties
  set ddr4_mig [ create_bd_cell -type ip -vlnv xilinx.com:ip:ddr4:2.2 ddr4_mig ]
  set_property -dict [ list \
   CONFIG.ADDN_UI_CLKOUT1_FREQ_HZ {200} \
   CONFIG.C0.DDR4_AUTO_AP_COL_A3 {true} \
   CONFIG.C0.DDR4_AxiDataWidth {512} \
   CONFIG.C0.DDR4_CLKOUT0_DIVIDE {6} \
   CONFIG.C0.DDR4_CasLatency {15} \
   CONFIG.C0.DDR4_CasWriteLatency {11} \
   CONFIG.C0.DDR4_InputClockPeriod {10005} \
   CONFIG.C0.DDR4_Mem_Add_Map {ROW_BANK_COLUMN} \
   CONFIG.C0.DDR4_MemoryPart {MTA16ATF2G64HZ-2G3} \
   CONFIG.C0.DDR4_MemoryType {SODIMMs} \
   CONFIG.C0.DDR4_TimePeriod {938} \
   CONFIG.C0.DDR4_isCustom {false} \
   CONFIG.System_Clock {No_Buffer} \
 ] $ddr4_mig

  # Create instance: ddr4_mig_sys_clk_bufg, and set properties
  set ddr4_mig_sys_clk_bufg [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.1 ddr4_mig_sys_clk_bufg ]
  set_property -dict [ list \
   CONFIG.C_BUF_TYPE {BUFG} \
 ] $ddr4_mig_sys_clk_bufg

  # Create instance: ddr4_mig_sys_clk_ibuf, and set properties
  set ddr4_mig_sys_clk_ibuf [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.1 ddr4_mig_sys_clk_ibuf ]
  set_property -dict [ list \
   CONFIG.C_BUF_TYPE {IBUFDS} \
 ] $ddr4_mig_sys_clk_ibuf

  # Create instance: doce_top_0, and set properties
  set doce_top_0 [ create_bd_cell -type ip -vlnv user.org:user:doce_top:1.0 doce_top_0 ]
  set_property -dict [ list \
   CONFIG.AXI_ADDR_WIDTH {32} \
   CONFIG.AXI_ID_WIDTH {6} \
   CONFIG.DATA_WIDTH {64} \
 ] $doce_top_0

  # Create instance: mac_addr_reg_0, and set properties
  set mac_addr_reg_0 [ create_bd_cell -type ip -vlnv user.org:user:mac_addr_reg:1.0 mac_addr_reg_0 ]

  # Create instance: pl_reset_gen, and set properties
  set pl_reset_gen [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 pl_reset_gen ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
 ] $pl_reset_gen

  # Create instance: rst_bfs_200M, and set properties
  set rst_bfs_200M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_bfs_200M ]

  # Create instance: rst_clk_wiz_300M, and set properties
  set rst_clk_wiz_300M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_clk_wiz_300M ]

  # Create instance: rst_cmac_usplus_0_322M, and set properties
  set rst_cmac_usplus_0_322M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_cmac_usplus_0_322M ]

  # Create instance: rst_ddr4_mig_266M, and set properties
  set rst_ddr4_mig_266M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_ddr4_mig_266M ]

  # Create instance: rst_zynq_mpsoc_100M, and set properties
  set rst_zynq_mpsoc_100M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_zynq_mpsoc_100M ]

  # Create instance: rst_zynq_mpsoc_100M_to_cmac, and set properties
  set rst_zynq_mpsoc_100M_to_cmac [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_zynq_mpsoc_100M_to_cmac ]

  # Create instance: rst_zynq_mpsoc_200M, and set properties
  set rst_zynq_mpsoc_200M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_zynq_mpsoc_200M ]

  # Create instance: rx_reset, and set properties
  set rx_reset [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rx_reset ]

  # Create instance: rx_reset_cnt_0, and set properties
  set rx_reset_cnt_0 [ create_bd_cell -type ip -vlnv user.org:user:rx_reset_cnt:1.0 rx_reset_cnt_0 ]

  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_HIGH} \
 ] [get_bd_pins /rx_reset_cnt_0/gtwiz_rx_reset]

  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_HIGH} \
 ] [get_bd_pins /rx_reset_cnt_0/reset]

  # Create instance: zynq_mpsoc, and set properties
  set zynq_mpsoc [ create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e:3.3 zynq_mpsoc ]
  set_property -dict [ list \
   CONFIG.PSU_BANK_0_IO_STANDARD {LVCMOS33} \
   CONFIG.PSU_BANK_1_IO_STANDARD {LVCMOS33} \
   CONFIG.PSU_BANK_2_IO_STANDARD {LVCMOS33} \
   CONFIG.PSU_DDR_RAM_HIGHADDR {0x3FFFFFFFF} \
   CONFIG.PSU_DDR_RAM_HIGHADDR_OFFSET {0x800000000} \
   CONFIG.PSU_DDR_RAM_LOWADDR_OFFSET {0x80000000} \
   CONFIG.PSU_DYNAMIC_DDR_CONFIG_EN {0} \
   CONFIG.PSU_MIO_0_DIRECTION {out} \
   CONFIG.PSU_MIO_0_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_0_POLARITY {Default} \
   CONFIG.PSU_MIO_10_DIRECTION {inout} \
   CONFIG.PSU_MIO_10_POLARITY {Default} \
   CONFIG.PSU_MIO_11_DIRECTION {inout} \
   CONFIG.PSU_MIO_11_POLARITY {Default} \
   CONFIG.PSU_MIO_12_DIRECTION {out} \
   CONFIG.PSU_MIO_12_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_12_POLARITY {Default} \
   CONFIG.PSU_MIO_13_DIRECTION {inout} \
   CONFIG.PSU_MIO_13_POLARITY {Default} \
   CONFIG.PSU_MIO_14_DIRECTION {inout} \
   CONFIG.PSU_MIO_14_POLARITY {Default} \
   CONFIG.PSU_MIO_15_DIRECTION {inout} \
   CONFIG.PSU_MIO_15_POLARITY {Default} \
   CONFIG.PSU_MIO_16_DIRECTION {inout} \
   CONFIG.PSU_MIO_16_POLARITY {Default} \
   CONFIG.PSU_MIO_1_DIRECTION {inout} \
   CONFIG.PSU_MIO_1_POLARITY {Default} \
   CONFIG.PSU_MIO_21_DIRECTION {inout} \
   CONFIG.PSU_MIO_21_POLARITY {Default} \
   CONFIG.PSU_MIO_22_DIRECTION {out} \
   CONFIG.PSU_MIO_22_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_22_POLARITY {Default} \
   CONFIG.PSU_MIO_26_DIRECTION {out} \
   CONFIG.PSU_MIO_26_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_26_POLARITY {Default} \
   CONFIG.PSU_MIO_27_DIRECTION {out} \
   CONFIG.PSU_MIO_27_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_27_POLARITY {Default} \
   CONFIG.PSU_MIO_28_DIRECTION {out} \
   CONFIG.PSU_MIO_28_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_28_POLARITY {Default} \
   CONFIG.PSU_MIO_29_DIRECTION {out} \
   CONFIG.PSU_MIO_29_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_29_POLARITY {Default} \
   CONFIG.PSU_MIO_2_DIRECTION {inout} \
   CONFIG.PSU_MIO_2_POLARITY {Default} \
   CONFIG.PSU_MIO_30_DIRECTION {out} \
   CONFIG.PSU_MIO_30_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_30_POLARITY {Default} \
   CONFIG.PSU_MIO_31_DIRECTION {out} \
   CONFIG.PSU_MIO_31_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_31_POLARITY {Default} \
   CONFIG.PSU_MIO_32_DIRECTION {in} \
   CONFIG.PSU_MIO_32_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_32_POLARITY {Default} \
   CONFIG.PSU_MIO_32_SLEW {fast} \
   CONFIG.PSU_MIO_33_DIRECTION {in} \
   CONFIG.PSU_MIO_33_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_33_POLARITY {Default} \
   CONFIG.PSU_MIO_33_SLEW {fast} \
   CONFIG.PSU_MIO_34_DIRECTION {in} \
   CONFIG.PSU_MIO_34_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_34_POLARITY {Default} \
   CONFIG.PSU_MIO_34_SLEW {fast} \
   CONFIG.PSU_MIO_35_DIRECTION {in} \
   CONFIG.PSU_MIO_35_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_35_POLARITY {Default} \
   CONFIG.PSU_MIO_35_SLEW {fast} \
   CONFIG.PSU_MIO_36_DIRECTION {in} \
   CONFIG.PSU_MIO_36_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_36_POLARITY {Default} \
   CONFIG.PSU_MIO_36_SLEW {fast} \
   CONFIG.PSU_MIO_37_DIRECTION {in} \
   CONFIG.PSU_MIO_37_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_37_POLARITY {Default} \
   CONFIG.PSU_MIO_37_SLEW {fast} \
   CONFIG.PSU_MIO_3_DIRECTION {inout} \
   CONFIG.PSU_MIO_3_POLARITY {Default} \
   CONFIG.PSU_MIO_46_DIRECTION {in} \
   CONFIG.PSU_MIO_46_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_46_POLARITY {Default} \
   CONFIG.PSU_MIO_46_SLEW {fast} \
   CONFIG.PSU_MIO_47_DIRECTION {out} \
   CONFIG.PSU_MIO_47_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_47_POLARITY {Default} \
   CONFIG.PSU_MIO_4_DIRECTION {inout} \
   CONFIG.PSU_MIO_4_POLARITY {Default} \
   CONFIG.PSU_MIO_5_DIRECTION {out} \
   CONFIG.PSU_MIO_5_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_5_POLARITY {Default} \
   CONFIG.PSU_MIO_76_DIRECTION {out} \
   CONFIG.PSU_MIO_76_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_76_POLARITY {Default} \
   CONFIG.PSU_MIO_77_DIRECTION {inout} \
   CONFIG.PSU_MIO_77_POLARITY {Default} \
   CONFIG.PSU_MIO_7_DIRECTION {out} \
   CONFIG.PSU_MIO_7_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_7_POLARITY {Default} \
   CONFIG.PSU_MIO_8_DIRECTION {inout} \
   CONFIG.PSU_MIO_8_POLARITY {Default} \
   CONFIG.PSU_MIO_9_DIRECTION {inout} \
   CONFIG.PSU_MIO_9_POLARITY {Default} \
   CONFIG.PSU_MIO_TREE_PERIPHERALS {Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash##Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#SD 0#SD 0#SD 0#SD 0#####SD 0#SD 0####Gem 0#Gem 0#Gem 0#Gem 0#Gem 0#Gem 0#Gem 0#Gem 0#Gem 0#Gem 0#Gem 0#Gem 0#########UART 0#UART 0#############################MDIO 0#MDIO 0} \
   CONFIG.PSU_MIO_TREE_SIGNALS {sclk_out#miso_mo1#mo2#mo3#mosi_mi0#n_ss_out##n_ss_out_upper#mo_upper[0]#mo_upper[1]#mo_upper[2]#mo_upper[3]#sclk_out_upper#sdio0_data_out[0]#sdio0_data_out[1]#sdio0_data_out[2]#sdio0_data_out[3]#####sdio0_cmd_out#sdio0_clk_out####rgmii_tx_clk#rgmii_txd[0]#rgmii_txd[1]#rgmii_txd[2]#rgmii_txd[3]#rgmii_tx_ctl#rgmii_rx_clk#rgmii_rxd[0]#rgmii_rxd[1]#rgmii_rxd[2]#rgmii_rxd[3]#rgmii_rx_ctl#########rxd#txd#############################gem0_mdc#gem0_mdio_out} \
   CONFIG.PSU_SD0_INTERNAL_BUS_WIDTH {4} \
   CONFIG.PSU__ACT_DDR_FREQ_MHZ {800.000000} \
   CONFIG.PSU__CRF_APB__ACPU_CTRL__ACT_FREQMHZ {1325.000000} \
   CONFIG.PSU__CRF_APB__ACPU_CTRL__DIVISOR0 {1} \
   CONFIG.PSU__CRF_APB__APLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRF_APB__APLL_CTRL__FBDIV {53} \
   CONFIG.PSU__CRF_APB__APLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRF_APB__APLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRF_APB__APLL_TO_LPD_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__ACT_FREQMHZ {250.000000} \
   CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__ACT_FREQMHZ {250.000000} \
   CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DDR_CTRL__ACT_FREQMHZ {400.000000} \
   CONFIG.PSU__CRF_APB__DDR_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRF_APB__DDR_CTRL__FREQMHZ {1067} \
   CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__ACT_FREQMHZ {600.000000} \
   CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DPLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRF_APB__DPLL_CTRL__FBDIV {48} \
   CONFIG.PSU__CRF_APB__DPLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRF_APB__DPLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRF_APB__DPLL_TO_LPD_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__DIVISOR0 {63} \
   CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__DIVISOR1 {10} \
   CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__ACT_FREQMHZ {600.000000} \
   CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__GPU_REF_CTRL__ACT_FREQMHZ {600.000000} \
   CONFIG.PSU__CRF_APB__GPU_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRF_APB__SATA_REF_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__ACT_FREQMHZ {525.000000} \
   CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__VPLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRF_APB__VPLL_CTRL__FBDIV {42} \
   CONFIG.PSU__CRF_APB__VPLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRF_APB__VPLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRF_APB__VPLL_TO_LPD_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__ACT_FREQMHZ {500.000000} \
   CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRL_APB__AFI6_REF_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__AMS_REF_CTRL__ACT_FREQMHZ {50.000000} \
   CONFIG.PSU__CRL_APB__AMS_REF_CTRL__DIVISOR0 {30} \
   CONFIG.PSU__CRL_APB__AMS_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__CPU_R5_CTRL__ACT_FREQMHZ {500.000000} \
   CONFIG.PSU__CRL_APB__CPU_R5_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__ACT_FREQMHZ {250.000000} \
   CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__DLL_REF_CTRL__ACT_FREQMHZ {1500.000000} \
   CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__ACT_FREQMHZ {125.000000} \
   CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__ACT_FREQMHZ {125.000000} \
   CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__ACT_FREQMHZ {250.000000} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__IOPLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRL_APB__IOPLL_CTRL__FBDIV {60} \
   CONFIG.PSU__CRL_APB__IOPLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRL_APB__IOPLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRL_APB__IOPLL_TO_FPD_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__ACT_FREQMHZ {250.000000} \
   CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__DIVISOR0 {4} \
   CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__ACT_FREQMHZ {500.000000} \
   CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRL_APB__NAND_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__NAND_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__PCAP_CTRL__ACT_FREQMHZ {187.500000} \
   CONFIG.PSU__CRL_APB__PCAP_CTRL__DIVISOR0 {8} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__PL1_REF_CTRL__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__CRL_APB__PL1_REF_CTRL__DIVISOR0 {4} \
   CONFIG.PSU__CRL_APB__PL1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__PL1_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__PL1_REF_CTRL__SRCSEL {DPLL} \
   CONFIG.PSU__CRL_APB__PL2_REF_CTRL__ACT_FREQMHZ {200.000000} \
   CONFIG.PSU__CRL_APB__PL2_REF_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRL_APB__PL2_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__PL2_REF_CTRL__FREQMHZ {200} \
   CONFIG.PSU__CRL_APB__PL2_REF_CTRL__SRCSEL {RPLL} \
   CONFIG.PSU__CRL_APB__PL3_REF_CTRL__DIVISOR0 {4} \
   CONFIG.PSU__CRL_APB__PL3_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__ACT_FREQMHZ {300.000000} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__RPLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRL_APB__RPLL_CTRL__FBDIV {40} \
   CONFIG.PSU__CRL_APB__RPLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRL_APB__RPLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRL_APB__RPLL_TO_FPD_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__ACT_FREQMHZ {200.000000} \
   CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__DIVISOR0 {7} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__DIVISOR0 {7} \
   CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__DIVISOR0 {7} \
   CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__ACT_FREQMHZ {50.000000} \
   CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__DIVISOR0 {1} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__DIVISOR1 {15} \
   CONFIG.PSU__DDRC__CL {11} \
   CONFIG.PSU__DDRC__COMPONENTS {UDIMM} \
   CONFIG.PSU__DDRC__CWL {11} \
   CONFIG.PSU__DDRC__DEVICE_CAPACITY {8192 MBits} \
   CONFIG.PSU__DDRC__DIMM_ADDR_MIRROR {1} \
   CONFIG.PSU__DDRC__RANK_ADDR_COUNT {1} \
   CONFIG.PSU__DDRC__ROW_ADDR_COUNT {16} \
   CONFIG.PSU__DDRC__SB_TARGET {15-15-15} \
   CONFIG.PSU__DDRC__SPEED_BIN {DDR4_2133P} \
   CONFIG.PSU__DDRC__T_FAW {21} \
   CONFIG.PSU__DDRC__T_RAS_MIN {33} \
   CONFIG.PSU__DDRC__T_RC {46.5} \
   CONFIG.PSU__DDRC__T_RCD {15} \
   CONFIG.PSU__DDRC__T_RP {15} \
   CONFIG.PSU__DDR_HIGH_ADDRESS_GUI_ENABLE {1} \
   CONFIG.PSU__DDR__INTERFACE__FREQMHZ {533.500} \
   CONFIG.PSU__DLL__ISUSED {1} \
   CONFIG.PSU__ENET0__FIFO__ENABLE {0} \
   CONFIG.PSU__ENET0__GRP_MDIO__ENABLE {1} \
   CONFIG.PSU__ENET0__GRP_MDIO__IO {MIO 76 .. 77} \
   CONFIG.PSU__ENET0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__ENET0__PERIPHERAL__IO {MIO 26 .. 37} \
   CONFIG.PSU__ENET0__PTP__ENABLE {0} \
   CONFIG.PSU__ENET0__TSU__ENABLE {0} \
   CONFIG.PSU__ENET1__FIFO__ENABLE {0} \
   CONFIG.PSU__ENET1__GRP_MDIO__ENABLE {0} \
   CONFIG.PSU__ENET1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__ENET1__PERIPHERAL__IO {GT Lane1} \
   CONFIG.PSU__ENET1__PTP__ENABLE {0} \
   CONFIG.PSU__ENET1__TSU__ENABLE {0} \
   CONFIG.PSU__EXPAND__LOWER_LPS_SLAVES {1} \
   CONFIG.PSU__FPGA_PL1_ENABLE {1} \
   CONFIG.PSU__FPGA_PL2_ENABLE {1} \
   CONFIG.PSU__GEM0_COHERENCY {0} \
   CONFIG.PSU__GEM0_ROUTE_THROUGH_FPD {0} \
   CONFIG.PSU__GEM1_COHERENCY {0} \
   CONFIG.PSU__GEM1_ROUTE_THROUGH_FPD {0} \
   CONFIG.PSU__GEM1__REF_CLK_FREQ {125} \
   CONFIG.PSU__GEM1__REF_CLK_SEL {Ref Clk1} \
   CONFIG.PSU__GEM__TSU__ENABLE {0} \
   CONFIG.PSU__GPIO_EMIO_WIDTH {1} \
   CONFIG.PSU__GPIO_EMIO__WIDTH {[93:0]} \
   CONFIG.PSU__HIGH_ADDRESS__ENABLE {1} \
   CONFIG.PSU__MAXIGP2__DATA_WIDTH {32} \
   CONFIG.PSU__NUM_FABRIC_RESETS {2} \
   CONFIG.PSU__OVERRIDE__BASIC_CLOCK {0} \
   CONFIG.PSU__PL_CLK1_BUF {TRUE} \
   CONFIG.PSU__PL_CLK2_BUF {TRUE} \
   CONFIG.PSU__PROTECTION__MASTERS {USB1:NonSecure;0|USB0:NonSecure;0|S_AXI_LPD:NA;0|S_AXI_HPC1_FPD:NA;0|S_AXI_HPC0_FPD:NA;0|S_AXI_HP3_FPD:NA;1|S_AXI_HP2_FPD:NA;1|S_AXI_HP1_FPD:NA;1|S_AXI_HP0_FPD:NA;1|S_AXI_ACP:NA;0|S_AXI_ACE:NA;0|SD1:NonSecure;0|SD0:NonSecure;1|SATA1:NonSecure;0|SATA0:NonSecure;0|RPU1:Secure;1|RPU0:Secure;1|QSPI:NonSecure;1|PMU:NA;1|PCIe:NonSecure;0|NAND:NonSecure;0|LDMA:NonSecure;1|GPU:NonSecure;1|GEM3:NonSecure;0|GEM2:NonSecure;0|GEM1:NonSecure;1|GEM0:NonSecure;1|FDMA:NonSecure;1|DP:NonSecure;0|DAP:NA;1|Coresight:NA;1|CSU:NA;1|APU:NA;1} \
   CONFIG.PSU__PROTECTION__SLAVES { \
     LPD;USB3_1_XHCI;FE300000;FE3FFFFF;0|LPD;USB3_1;FF9E0000;FF9EFFFF;0|LPD;USB3_0_XHCI;FE200000;FE2FFFFF;0|LPD;USB3_0;FF9D0000;FF9DFFFF;0|LPD;UART1;FF010000;FF01FFFF;0|LPD;UART0;FF000000;FF00FFFF;1|LPD;TTC3;FF140000;FF14FFFF;0|LPD;TTC2;FF130000;FF13FFFF;0|LPD;TTC1;FF120000;FF12FFFF;0|LPD;TTC0;FF110000;FF11FFFF;0|FPD;SWDT1;FD4D0000;FD4DFFFF;0|LPD;SWDT0;FF150000;FF15FFFF;0|LPD;SPI1;FF050000;FF05FFFF;0|LPD;SPI0;FF040000;FF04FFFF;0|FPD;SMMU_REG;FD5F0000;FD5FFFFF;1|FPD;SMMU;FD800000;FDFFFFFF;1|FPD;SIOU;FD3D0000;FD3DFFFF;1|FPD;SERDES;FD400000;FD47FFFF;1|LPD;SD1;FF170000;FF17FFFF;0|LPD;SD0;FF160000;FF16FFFF;1|FPD;SATA;FD0C0000;FD0CFFFF;0|LPD;RTC;FFA60000;FFA6FFFF;1|LPD;RSA_CORE;FFCE0000;FFCEFFFF;1|LPD;RPU;FF9A0000;FF9AFFFF;1|LPD;R5_TCM_RAM_GLOBAL;FFE00000;FFE3FFFF;1|LPD;R5_1_Instruction_Cache;FFEC0000;FFECFFFF;1|LPD;R5_1_Data_Cache;FFED0000;FFEDFFFF;1|LPD;R5_1_BTCM_GLOBAL;FFEB0000;FFEBFFFF;1|LPD;R5_1_ATCM_GLOBAL;FFE90000;FFE9FFFF;1|LPD;R5_0_Instruction_Cache;FFE40000;FFE4FFFF;1|LPD;R5_0_Data_Cache;FFE50000;FFE5FFFF;1|LPD;R5_0_BTCM_GLOBAL;FFE20000;FFE2FFFF;1|LPD;R5_0_ATCM_GLOBAL;FFE00000;FFE0FFFF;1|LPD;QSPI_Linear_Address;C0000000;DFFFFFFF;1|LPD;QSPI;FF0F0000;FF0FFFFF;1|LPD;PMU_RAM;FFDC0000;FFDDFFFF;1|LPD;PMU_GLOBAL;FFD80000;FFDBFFFF;1|FPD;PCIE_MAIN;FD0E0000;FD0EFFFF;0|FPD;PCIE_LOW;E0000000;EFFFFFFF;0|FPD;PCIE_HIGH2;8000000000;BFFFFFFFFF;0|FPD;PCIE_HIGH1;600000000;7FFFFFFFF;0|FPD;PCIE_DMA;FD0F0000;FD0FFFFF;0|FPD;PCIE_ATTRIB;FD480000;FD48FFFF;0|LPD;OCM_XMPU_CFG;FFA70000;FFA7FFFF;1|LPD;OCM_SLCR;FF960000;FF96FFFF;1|OCM;OCM;FFFC0000;FFFFFFFF;1|LPD;NAND;FF100000;FF10FFFF;0|LPD;MBISTJTAG;FFCF0000;FFCFFFFF;1|LPD;LPD_XPPU_SINK;FF9C0000;FF9CFFFF;1|LPD;LPD_XPPU;FF980000;FF98FFFF;1|LPD;LPD_SLCR_SECURE;FF4B0000;FF4DFFFF;1|LPD;LPD_SLCR;FF410000;FF4AFFFF;1|LPD;LPD_GPV;FE100000;FE1FFFFF;1|LPD;LPD_DMA_7;FFAF0000;FFAFFFFF;1|LPD;LPD_DMA_6;FFAE0000;FFAEFFFF;1|LPD;LPD_DMA_5;FFAD0000;FFADFFFF;1|LPD;LPD_DMA_4;FFAC0000;FFACFFFF;1|LPD;LPD_DMA_3;FFAB0000;FFABFFFF;1|LPD;LPD_DMA_2;FFAA0000;FFAAFFFF;1|LPD;LPD_DMA_1;FFA90000;FFA9FFFF;1|LPD;LPD_DMA_0;FFA80000;FFA8FFFF;1|LPD;IPI_CTRL;FF380000;FF3FFFFF;1|LPD;IOU_SLCR;FF180000;FF23FFFF;1|LPD;IOU_SECURE_SLCR;FF240000;FF24FFFF;1|LPD;IOU_SCNTRS;FF260000;FF26FFFF;1|LPD;IOU_SCNTR;FF250000;FF25FFFF;1|LPD;IOU_GPV;FE000000;FE0FFFFF;1|LPD;I2C1;FF030000;FF03FFFF;0|LPD;I2C0;FF020000;FF02FFFF;0|FPD;GPU;FD4B0000;FD4BFFFF;1|LPD;GPIO;FF0A0000;FF0AFFFF;1|LPD;GEM3;FF0E0000;FF0EFFFF;0|LPD;GEM2;FF0D0000;FF0DFFFF;0|LPD;GEM1;FF0C0000;FF0CFFFF;1|LPD;GEM0;FF0B0000;FF0BFFFF;1|FPD;FPD_XMPU_SINK;FD4F0000;FD4FFFFF;1|FPD;FPD_XMPU_CFG;FD5D0000;FD5DFFFF;1|FPD;FPD_SLCR_SECURE;FD690000;FD6CFFFF;1|FPD;FPD_SLCR;FD610000;FD68FFFF;1|FPD;FPD_DMA_CH7;FD570000;FD57FFFF;1|FPD;FPD_DMA_CH6;FD560000;FD56FFFF;1|FPD;FPD_DMA_CH5;FD550000;FD55FFFF;1|FPD;FPD_DMA_CH4;FD540000;FD54FFFF;1|FPD;FPD_DMA_CH3;FD530000;FD53FFFF;1|FPD;FPD_DMA_CH2;FD520000;FD52FFFF;1|FPD;FPD_DMA_CH1;FD510000;FD51FFFF;1|FPD;FPD_DMA_CH0;FD500000;FD50FFFF;1|LPD;EFUSE;FFCC0000;FFCCFFFF;1|FPD;Display Port;FD4A0000;FD4AFFFF;0|FPD;DPDMA;FD4C0000;FD4CFFFF;0|FPD;DDR_XMPU5_CFG;FD050000;FD05FFFF;1|FPD;DDR_XMPU4_CFG;FD040000;FD04FFFF;1|FPD;DDR_XMPU3_CFG;FD030000;FD03FFFF;1|FPD;DDR_XMPU2_CFG;FD020000;FD02FFFF;1|FPD;DDR_XMPU1_CFG;FD010000;FD01FFFF;1|FPD;DDR_XMPU0_CFG;FD000000;FD00FFFF;1|FPD;DDR_QOS_CTRL;FD090000;FD09FFFF;1|FPD;DDR_PHY;FD080000;FD08FFFF;1|DDR;DDR_LOW;0;7FFFFFFF;1|DDR;DDR_HIGH;800000000;B7FFFFFFF;1|FPD;DDDR_CTRL;FD070000;FD070FFF;1|LPD;Coresight;FE800000;FEFFFFFF;1|LPD;CSU_DMA;FFC80000;FFC9FFFF;1|LPD;CSU;FFCA0000;FFCAFFFF;1|LPD;CRL_APB;FF5E0000;FF85FFFF;1|FPD;CRF_APB;FD1A0000;FD2DFFFF;1|FPD;CCI_REG;FD5E0000;FD5EFFFF;1|LPD;CAN1;FF070000;FF07FFFF;0|LPD;CAN0;FF060000;FF06FFFF;0|FPD;APU;FD5C0000;FD5CFFFF;1|LPD;APM_INTC_IOU;FFA20000;FFA2FFFF;1|LPD;APM_FPD_LPD;FFA30000;FFA3FFFF;1|FPD;APM_5;FD490000;FD49FFFF;1|FPD;APM_0;FD0B0000;FD0BFFFF;1|LPD;APM2;FFA10000;FFA1FFFF;1|LPD;APM1;FFA00000;FFA0FFFF;1|LPD;AMS;FFA50000;FFA5FFFF;1|FPD;AFI_5;FD3B0000;FD3BFFFF;1|FPD;AFI_4;FD3A0000;FD3AFFFF;1|FPD;AFI_3;FD390000;FD39FFFF;1|FPD;AFI_2;FD380000;FD38FFFF;1|FPD;AFI_1;FD370000;FD37FFFF;1|FPD;AFI_0;FD360000;FD36FFFF;1|LPD;AFIFM6;FF9B0000;FF9BFFFF;1|FPD;ACPU_GIC;F9010000;F907FFFF;1 \
   } \
   CONFIG.PSU__PSS_REF_CLK__FREQMHZ {50} \
   CONFIG.PSU__QSPI_COHERENCY {0} \
   CONFIG.PSU__QSPI_ROUTE_THROUGH_FPD {0} \
   CONFIG.PSU__QSPI__GRP_FBCLK__ENABLE {0} \
   CONFIG.PSU__QSPI__PERIPHERAL__DATA_MODE {x4} \
   CONFIG.PSU__QSPI__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__QSPI__PERIPHERAL__IO {MIO 0 .. 12} \
   CONFIG.PSU__QSPI__PERIPHERAL__MODE {Dual Parallel} \
   CONFIG.PSU__SAXIGP2__DATA_WIDTH {128} \
   CONFIG.PSU__SAXIGP3__DATA_WIDTH {128} \
   CONFIG.PSU__SAXIGP4__DATA_WIDTH {128} \
   CONFIG.PSU__SAXIGP5__DATA_WIDTH {128} \
   CONFIG.PSU__SD0_COHERENCY {0} \
   CONFIG.PSU__SD0_ROUTE_THROUGH_FPD {0} \
   CONFIG.PSU__SD0__DATA_TRANSFER_MODE {4Bit} \
   CONFIG.PSU__SD0__GRP_CD__ENABLE {0} \
   CONFIG.PSU__SD0__GRP_POW__ENABLE {0} \
   CONFIG.PSU__SD0__GRP_WP__ENABLE {0} \
   CONFIG.PSU__SD0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__SD0__PERIPHERAL__IO {MIO 13 .. 16 21 22} \
   CONFIG.PSU__SD0__RESET__ENABLE {0} \
   CONFIG.PSU__SD0__SLOT_TYPE {SD 2.0} \
   CONFIG.PSU__TSU__BUFG_PORT_PAIR {0} \
   CONFIG.PSU__UART0__BAUD_RATE {115200} \
   CONFIG.PSU__UART0__MODEM__ENABLE {0} \
   CONFIG.PSU__UART0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__UART0__PERIPHERAL__IO {MIO 46 .. 47} \
   CONFIG.PSU__USE__M_AXI_GP2 {1} \
   CONFIG.PSU__USE__S_AXI_GP2 {1} \
   CONFIG.PSU__USE__S_AXI_GP3 {1} \
   CONFIG.PSU__USE__S_AXI_GP4 {1} \
   CONFIG.PSU__USE__S_AXI_GP5 {1} \
   CONFIG.SUBPRESET1 {Custom} \
 ] $zynq_mpsoc

  # Create interface connections
  connect_bd_intf_net -intf_net BFS_0_maxi_0 [get_bd_intf_pins BFS_0/maxi_0] [get_bd_intf_pins axi_crossbar_0/S00_AXI]
  connect_bd_intf_net -intf_net BFS_0_maxi_2 [get_bd_intf_pins BFS_0/maxi_1] [get_bd_intf_pins axi_crossbar_0/S01_AXI]
  connect_bd_intf_net -intf_net BFS_0_maxi_3 [get_bd_intf_pins BFS_0/maxi_2] [get_bd_intf_pins axi_clock_converter_b2z0/S_AXI]
  connect_bd_intf_net -intf_net BFS_0_maxi_4 [get_bd_intf_pins BFS_0/maxi_3] [get_bd_intf_pins axi_clock_converter_b2z1/S_AXI]
  connect_bd_intf_net -intf_net BFS_0_maxi_5 [get_bd_intf_pins BFS_0/maxi_4] [get_bd_intf_pins axi_clock_converter_b2z2/S_AXI]
  connect_bd_intf_net -intf_net BFS_0_maxi_6 [get_bd_intf_pins BFS_0/maxi_5] [get_bd_intf_pins axi_clock_converter_b2z3/S_AXI]
  connect_bd_intf_net -intf_net BFS_0_remote_out [get_bd_intf_pins BFS_0/remote_out] [get_bd_intf_pins axi_interconnect_2/S00_AXI]
  connect_bd_intf_net -intf_net Conn [get_bd_intf_pins axi_clock_converter_0/M_AXI] [get_bd_intf_pins ddr4_mig/C0_DDR4_S_AXI]
  connect_bd_intf_net -intf_net S00_AXIS_1 [get_bd_intf_pins axis_interconnect_d2c/S00_AXIS] [get_bd_intf_pins doce_top_0/doce_axis_txd]
  connect_bd_intf_net -intf_net axi_clock_converter_b2z0_M_AXI [get_bd_intf_pins axi_clock_converter_b2z0/M_AXI] [get_bd_intf_pins zynq_mpsoc/S_AXI_HP0_FPD]
  connect_bd_intf_net -intf_net axi_clock_converter_b2z1_M_AXI [get_bd_intf_pins axi_clock_converter_b2z1/M_AXI] [get_bd_intf_pins zynq_mpsoc/S_AXI_HP1_FPD]
  connect_bd_intf_net -intf_net axi_clock_converter_b2z2_M_AXI [get_bd_intf_pins axi_clock_converter_b2z2/M_AXI] [get_bd_intf_pins zynq_mpsoc/S_AXI_HP2_FPD]
  connect_bd_intf_net -intf_net axi_clock_converter_b2z3_M_AXI [get_bd_intf_pins axi_clock_converter_b2z3/M_AXI] [get_bd_intf_pins zynq_mpsoc/S_AXI_HP3_FPD]
  connect_bd_intf_net -intf_net axi_crossbar_0_M00_AXI [get_bd_intf_pins axi_clock_converter_0/S_AXI] [get_bd_intf_pins axi_crossbar_0/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins BFS_0/io_config] [get_bd_intf_pins axi_interconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M01_AXI [get_bd_intf_pins axi_interconnect_0/M01_AXI] [get_bd_intf_pins doce_top_0/doce_axi_lite_slave]
  connect_bd_intf_net -intf_net axi_interconnect_1_M00_AXI [get_bd_intf_pins BFS_0/remote_in] [get_bd_intf_pins axi_interconnect_1/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_2_M00_AXI [get_bd_intf_pins axi_interconnect_2/M00_AXI] [get_bd_intf_pins doce_top_0/doce_axi_slave]
  connect_bd_intf_net -intf_net axis_clock_converter_0_M_AXIS [get_bd_intf_pins axis_clock_converter_0/M_AXIS] [get_bd_intf_pins doce_top_0/doce_axis_rxd]
  connect_bd_intf_net -intf_net axis_data_fifo_c2d1_M_AXIS [get_bd_intf_pins axis_clock_converter_0/S_AXIS] [get_bd_intf_pins axis_data_fifo_c2d1/M_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_d2c_M00_AXIS [get_bd_intf_pins axis_interconnect_d2c/M00_AXIS] [get_bd_intf_pins cmac_usplus_0/axis_tx]
  connect_bd_intf_net -intf_net cmac_usplus_0_axis_rx [get_bd_intf_pins axis_data_fifo_c2d1/S_AXIS] [get_bd_intf_pins cmac_usplus_0/axis_rx]
  connect_bd_intf_net -intf_net ddr4_mig_C0_DDR4 [get_bd_intf_ports c0_ddr4] [get_bd_intf_pins ddr4_mig/C0_DDR4]
  connect_bd_intf_net -intf_net ddr4_mig_sys_clk_in [get_bd_intf_ports ddr4_mig_sys_clk] [get_bd_intf_pins ddr4_mig_sys_clk_ibuf/CLK_IN_D]
  connect_bd_intf_net -intf_net doce_top_0_doce_axi_master [get_bd_intf_pins axi_interconnect_1/S00_AXI] [get_bd_intf_pins doce_top_0/doce_axi_master]
  connect_bd_intf_net -intf_net doce_top_0_m_axi_doce_mac [get_bd_intf_pins doce_top_0/m_axi_doce_mac] [get_bd_intf_pins mac_addr_reg_0/s_axi_lite]
  connect_bd_intf_net -intf_net gt_ref_clk_1 [get_bd_intf_ports gt_ref_clk] [get_bd_intf_pins cmac_usplus_0/gt_ref_clk]
  connect_bd_intf_net -intf_net zynq_mpsoc_M_AXI_HPM0_LPD [get_bd_intf_pins axi_interconnect_0/S00_AXI] [get_bd_intf_pins zynq_mpsoc/M_AXI_HPM0_LPD]

  # Create port connections
  connect_bd_net -net clk_wiz_0_locked [get_bd_pins clk_wiz_doce/locked] [get_bd_pins rst_clk_wiz_300M/dcm_locked]
  connect_bd_net -net clk_wiz_bfs_locked [get_bd_pins clk_wiz_bfs/locked] [get_bd_pins rst_bfs_200M/dcm_locked]
  connect_bd_net -net clk_wiz_clk_out1 [get_bd_pins axi_interconnect_0/M01_ACLK] [get_bd_pins axi_interconnect_1/ACLK] [get_bd_pins axi_interconnect_1/S00_ACLK] [get_bd_pins axi_interconnect_2/ACLK] [get_bd_pins axi_interconnect_2/M00_ACLK] [get_bd_pins axis_clock_converter_0/m_axis_aclk] [get_bd_pins axis_interconnect_d2c/S00_AXIS_ACLK] [get_bd_pins clk_wiz_doce/clk_out1] [get_bd_pins doce_top_0/clk] [get_bd_pins mac_addr_reg_0/axi_lite_aclk] [get_bd_pins rst_clk_wiz_300M/slowest_sync_clk]
  connect_bd_net -net cmac_const_0_dout [get_bd_pins cmac_const_0/dout] [get_bd_pins cmac_usplus_0/ctl_rx_force_resync] [get_bd_pins cmac_usplus_0/ctl_rx_test_pattern] [get_bd_pins cmac_usplus_0/ctl_tx_send_idle] [get_bd_pins cmac_usplus_0/ctl_tx_send_lfi] [get_bd_pins cmac_usplus_0/ctl_tx_send_rfi] [get_bd_pins cmac_usplus_0/ctl_tx_test_pattern]
  connect_bd_net -net cmac_const_1_dout [get_bd_pins cmac_const_1/dout] [get_bd_pins cmac_usplus_0/ctl_rx_enable] [get_bd_pins cmac_usplus_0/ctl_tx_enable]
  connect_bd_net -net cmac_const_gt_loopback_in_dout [get_bd_pins cmac_const_gt_loopback_in/dout] [get_bd_pins cmac_usplus_0/gt_loopback_in]
  connect_bd_net -net cmac_usplus_0_gt_txn_out [get_bd_ports gt_txn_out] [get_bd_pins cmac_usplus_0/gt_txn_out]
  connect_bd_net -net cmac_usplus_0_gt_txp_out [get_bd_ports gt_txp_out] [get_bd_pins cmac_usplus_0/gt_txp_out]
  connect_bd_net -net cmac_usplus_0_gt_txusrclk2 [get_bd_pins axis_clock_converter_0/s_axis_aclk] [get_bd_pins axis_data_fifo_c2d1/s_axis_aclk] [get_bd_pins axis_interconnect_d2c/ACLK] [get_bd_pins axis_interconnect_d2c/M00_AXIS_ACLK] [get_bd_pins clk_wiz_doce/clk_in1] [get_bd_pins cmac_usplus_0/gt_txusrclk2] [get_bd_pins cmac_usplus_0/rx_clk] [get_bd_pins rst_cmac_usplus_0_322M/slowest_sync_clk] [get_bd_pins rx_reset/slowest_sync_clk] [get_bd_pins rx_reset_cnt_0/clk]
  connect_bd_net -net cmac_usplus_0_stat_rx_status [get_bd_pins cmac_usplus_0/stat_rx_status] [get_bd_pins rx_reset_cnt_0/rx_status]
  connect_bd_net -net cmac_usplus_0_usr_rx_reset [get_bd_pins cmac_usplus_0/usr_rx_reset] [get_bd_pins rst_clk_wiz_300M/ext_reset_in] [get_bd_pins rst_cmac_usplus_0_322M/ext_reset_in]
  connect_bd_net -net ddr4_mig_c0_ddr4_ui_clk [get_bd_pins axi_clock_converter_0/m_axi_aclk] [get_bd_pins clk_wiz_bfs/clk_in1] [get_bd_pins ddr4_mig/c0_ddr4_ui_clk] [get_bd_pins rst_ddr4_mig_266M/slowest_sync_clk]
  connect_bd_net -net ddr4_mig_c0_ddr4_ui_clk_sync_rst [get_bd_pins clk_wiz_bfs/reset] [get_bd_pins ddr4_mig/c0_ddr4_ui_clk_sync_rst] [get_bd_pins rst_bfs_200M/ext_reset_in] [get_bd_pins rst_ddr4_mig_266M/ext_reset_in]
  connect_bd_net -net ddr4_mig_sys_clk_bufg_out [get_bd_pins ddr4_mig/c0_sys_clk_i] [get_bd_pins ddr4_mig_sys_clk_bufg/BUFG_O]
  connect_bd_net -net ddr4_mig_sys_clk_ibuf_out [get_bd_pins ddr4_mig_sys_clk_bufg/BUFG_I] [get_bd_pins ddr4_mig_sys_clk_ibuf/IBUF_OUT]
  connect_bd_net -net ddr4_ui_clk [get_bd_pins BFS_0/clock] [get_bd_pins axi_clock_converter_0/s_axi_aclk] [get_bd_pins axi_clock_converter_b2z0/s_axi_aclk] [get_bd_pins axi_clock_converter_b2z1/s_axi_aclk] [get_bd_pins axi_clock_converter_b2z2/s_axi_aclk] [get_bd_pins axi_clock_converter_b2z3/s_axi_aclk] [get_bd_pins axi_crossbar_0/aclk] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_1/M00_ACLK] [get_bd_pins axi_interconnect_2/S00_ACLK] [get_bd_pins clk_wiz_bfs/clk_out1] [get_bd_pins rst_bfs_200M/slowest_sync_clk]
  connect_bd_net -net gt_rxn_in_1 [get_bd_ports gt_rxn_in] [get_bd_pins cmac_usplus_0/gt_rxn_in]
  connect_bd_net -net gt_rxp_in_1 [get_bd_ports gt_rxp_in] [get_bd_pins cmac_usplus_0/gt_rxp_in]
  connect_bd_net -net mac_addr_reg_0_doce_ip_addr [get_bd_pins doce_top_0/doce_ip_addr] [get_bd_pins mac_addr_reg_0/doce_ip_addr]
  connect_bd_net -net mac_addr_reg_0_doce_mac_id [get_bd_pins doce_top_0/doce_mac_addr] [get_bd_pins mac_addr_reg_0/doce_mac_id]
  connect_bd_net -net pl_reset [get_bd_pins ddr4_mig/sys_rst] [get_bd_pins pl_reset_gen/Res]
  connect_bd_net -net pl_resetn0 [get_bd_pins pl_reset_gen/Op1] [get_bd_pins rst_zynq_mpsoc_100M/ext_reset_in] [get_bd_pins rst_zynq_mpsoc_200M/ext_reset_in] [get_bd_pins zynq_mpsoc/pl_resetn0]
  connect_bd_net -net rst_clk_wiz_100M_peripheral_reset [get_bd_pins doce_top_0/reset] [get_bd_pins rst_clk_wiz_300M/peripheral_reset]
  connect_bd_net -net rst_clk_wiz_300M_peripheral_aresetn [get_bd_pins axi_interconnect_0/M01_ARESETN] [get_bd_pins axi_interconnect_1/ARESETN] [get_bd_pins axi_interconnect_1/S00_ARESETN] [get_bd_pins axi_interconnect_2/ARESETN] [get_bd_pins axi_interconnect_2/M00_ARESETN] [get_bd_pins axis_clock_converter_0/m_axis_aresetn] [get_bd_pins axis_interconnect_d2c/S00_AXIS_ARESETN] [get_bd_pins mac_addr_reg_0/axi_lite_aresetn] [get_bd_pins rst_clk_wiz_300M/peripheral_aresetn]
  connect_bd_net -net rst_cmac_usplus_0_322M_peripheral_aresetn [get_bd_pins axis_clock_converter_0/s_axis_aresetn] [get_bd_pins axis_data_fifo_c2d1/s_axis_aresetn] [get_bd_pins axis_interconnect_d2c/ARESETN] [get_bd_pins axis_interconnect_d2c/M00_AXIS_ARESETN] [get_bd_pins rst_cmac_usplus_0_322M/peripheral_aresetn]
  connect_bd_net -net rst_ddr4_mig_266M_peripheral_aresetn [get_bd_pins axi_clock_converter_0/s_axi_aresetn] [get_bd_pins axi_clock_converter_b2z0/s_axi_aresetn] [get_bd_pins axi_clock_converter_b2z1/s_axi_aresetn] [get_bd_pins axi_clock_converter_b2z2/s_axi_aresetn] [get_bd_pins axi_clock_converter_b2z3/s_axi_aresetn] [get_bd_pins axi_crossbar_0/aresetn] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_1/M00_ARESETN] [get_bd_pins axi_interconnect_2/S00_ARESETN] [get_bd_pins rst_bfs_200M/peripheral_aresetn]
  connect_bd_net -net rst_ddr4_mig_266M_peripheral_aresetn1 [get_bd_pins axi_clock_converter_0/m_axi_aresetn] [get_bd_pins ddr4_mig/c0_ddr4_aresetn] [get_bd_pins rst_ddr4_mig_266M/peripheral_aresetn]
  connect_bd_net -net rst_ddr4_mig_266M_peripheral_reset [get_bd_pins BFS_0/reset] [get_bd_pins rst_bfs_200M/peripheral_reset]
  connect_bd_net -net rst_zynq_mpsoc_100M_peripheral_aresetn [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins rst_zynq_mpsoc_100M/peripheral_aresetn]
  connect_bd_net -net rst_zynq_mpsoc_100M_to_cmac_peripheral_reset [get_bd_pins cmac_usplus_0/core_drp_reset] [get_bd_pins cmac_usplus_0/core_rx_reset] [get_bd_pins cmac_usplus_0/core_tx_reset] [get_bd_pins cmac_usplus_0/gtwiz_reset_tx_datapath] [get_bd_pins cmac_usplus_0/sys_reset] [get_bd_pins rst_zynq_mpsoc_100M_to_cmac/peripheral_reset]
  connect_bd_net -net rst_zynq_mpsoc_200M_peripheral_aresetn [get_bd_pins axi_clock_converter_b2z0/m_axi_aresetn] [get_bd_pins axi_clock_converter_b2z1/m_axi_aresetn] [get_bd_pins axi_clock_converter_b2z2/m_axi_aresetn] [get_bd_pins axi_clock_converter_b2z3/m_axi_aresetn] [get_bd_pins rst_zynq_mpsoc_200M/peripheral_aresetn]
  connect_bd_net -net rx_reset_cnt_0_gtwiz_rx_reset [get_bd_pins cmac_usplus_0/gtwiz_reset_rx_datapath] [get_bd_pins rx_reset_cnt_0/gtwiz_rx_reset]
  connect_bd_net -net rx_reset_peripheral_reset [get_bd_pins clk_wiz_doce/reset] [get_bd_pins rx_reset/peripheral_reset] [get_bd_pins rx_reset_cnt_0/reset]
  connect_bd_net -net s_axis_tready [get_bd_pins axis_data_fifo_c2d1/s_axis_tready]
  set_property HDL_ATTRIBUTE.DEBUG {true} [get_bd_nets s_axis_tready]
  connect_bd_net -net zynq_mpsoc_pl_clk0 [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins rst_zynq_mpsoc_100M/slowest_sync_clk] [get_bd_pins zynq_mpsoc/maxihpm0_lpd_aclk] [get_bd_pins zynq_mpsoc/pl_clk0]
  connect_bd_net -net zynq_mpsoc_pl_clk1 [get_bd_pins cmac_usplus_0/drp_clk] [get_bd_pins cmac_usplus_0/init_clk] [get_bd_pins rst_zynq_mpsoc_100M_to_cmac/slowest_sync_clk] [get_bd_pins zynq_mpsoc/pl_clk1]
  connect_bd_net -net zynq_mpsoc_pl_clk2 [get_bd_pins axi_clock_converter_b2z0/m_axi_aclk] [get_bd_pins axi_clock_converter_b2z1/m_axi_aclk] [get_bd_pins axi_clock_converter_b2z2/m_axi_aclk] [get_bd_pins axi_clock_converter_b2z3/m_axi_aclk] [get_bd_pins rst_zynq_mpsoc_200M/slowest_sync_clk] [get_bd_pins zynq_mpsoc/pl_clk2] [get_bd_pins zynq_mpsoc/saxihp0_fpd_aclk] [get_bd_pins zynq_mpsoc/saxihp1_fpd_aclk] [get_bd_pins zynq_mpsoc/saxihp2_fpd_aclk] [get_bd_pins zynq_mpsoc/saxihp3_fpd_aclk]
  connect_bd_net -net zynq_mpsoc_pl_resetn1 [get_bd_pins rst_zynq_mpsoc_100M_to_cmac/ext_reset_in] [get_bd_pins rx_reset/ext_reset_in] [get_bd_pins zynq_mpsoc/pl_resetn1]

  # Create address segments
  assign_bd_address -offset 0x000400000000 -range 0x000100000000 -target_address_space [get_bd_addr_spaces BFS_0/maxi_0] [get_bd_addr_segs ddr4_mig/C0_DDR4_MEMORY_MAP/C0_DDR4_ADDRESS_BLOCK] -force
  assign_bd_address -offset 0x000400000000 -range 0x000100000000 -target_address_space [get_bd_addr_spaces BFS_0/maxi_1] [get_bd_addr_segs ddr4_mig/C0_DDR4_MEMORY_MAP/C0_DDR4_ADDRESS_BLOCK] -force
  assign_bd_address -offset 0x000800000000 -range 0x000200000000 -target_address_space [get_bd_addr_spaces BFS_0/maxi_2] [get_bd_addr_segs zynq_mpsoc/SAXIGP2/HP0_DDR_HIGH] -force
  assign_bd_address -offset 0x000800000000 -range 0x000200000000 -target_address_space [get_bd_addr_spaces BFS_0/maxi_3] [get_bd_addr_segs zynq_mpsoc/SAXIGP3/HP1_DDR_HIGH] -force
  assign_bd_address -offset 0x000800000000 -range 0x000200000000 -target_address_space [get_bd_addr_spaces BFS_0/maxi_4] [get_bd_addr_segs zynq_mpsoc/SAXIGP4/HP2_DDR_HIGH] -force
  assign_bd_address -offset 0x000800000000 -range 0x000200000000 -target_address_space [get_bd_addr_spaces BFS_0/maxi_5] [get_bd_addr_segs zynq_mpsoc/SAXIGP5/HP3_DDR_HIGH] -force
  assign_bd_address -offset 0x00000000 -range 0x00000080 -target_address_space [get_bd_addr_spaces doce_top_0/m_axi_doce_mac] [get_bd_addr_segs mac_addr_reg_0/s_axi_lite/reg0] -force
  assign_bd_address -offset 0x90000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_mpsoc/Data] [get_bd_addr_segs BFS_0/io_config/reg0] -force
  assign_bd_address -offset 0x80000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_mpsoc/Data] [get_bd_addr_segs doce_top_0/doce_axi_lite_slave/reg0] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


