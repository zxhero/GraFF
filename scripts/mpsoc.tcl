#========================================================
# Vivado BD design auto run script for mpsoc
# in mpsoc_nf_platform
# Based on Vivado 2019.1
# Author: Yisong Chang (changyisong@ict.ac.cn)
# Date: 19/05/2020
#========================================================

namespace eval mpsoc_bd_val {
	set design_name mpsoc
	set bd_prefix ${mpsoc_bd_val::design_name}_

	set mig_csv fidus_pl_ddr4_sodimm.csv

	set mig_csv_src ${::script_dir}/../sources/ip_catalog/ddr4_mig/${mig_csv}
	set mig_csv_dest ./${::project_name}/${::project_name}.srcs/sources_1/bd/${mpsoc_bd_val::design_name}/ip/${mpsoc_bd_val::bd_prefix}ddr4_mig_0/${mig_csv}
}


# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${mpsoc_bd_val::design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne ${mpsoc_bd_val::design_name} } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <${mpsoc_bd_val::design_name}> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq ${mpsoc_bd_val::design_name} } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <${mpsoc_bd_val::design_name}> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${mpsoc_bd_val::design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <${mpsoc_bd_val::design_name}> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <${mpsoc_bd_val::design_name}> in project, so creating one..."

   create_bd_design ${mpsoc_bd_val::design_name}

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <${mpsoc_bd_val::design_name}> as current_bd_design."
   current_bd_design ${mpsoc_bd_val::design_name}

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"${mpsoc_bd_val::design_name}\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
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
xilinx.com:ip:axi_dwidth_converter:2.1\
xilinx.com:ip:axis_data_fifo:2.0\
xilinx.com:ip:xlconstant:1.1\
xilinx.com:ip:axis_dwidth_converter:1.1\
xilinx.com:ip:cmac_usplus:3.1\
xilinx.com:ip:ddr4:2.2\
xilinx.com:ip:util_ds_buf:2.1\
user.org:user:doce_top:1.0\
xilinx.com:ip:ila:6.2\
user.org:user:mac_addr_reg:1.0\
xilinx.com:ip:util_vector_logic:2.0\
xilinx.com:ip:proc_sys_reset:5.0\
user.org:user:rx_reset_cnt:1.0\
user.org:user:tx_padding:1.0\
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

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

#=============================================
# Create IP blocks
#=============================================

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
   CONFIG.S00_HAS_DATA_FIFO {2} \
 ] $axi_interconnect_1

  # Create instance: axi_interconnect_2, and set properties
  set axi_interconnect_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_2 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
 ] $axi_interconnect_2

  # Create instance: axis_data_fifo_c2d, and set properties
  set axis_data_fifo_c2d [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_c2d ]
  set_property -dict [ list \
   CONFIG.FIFO_MODE {1} \
   CONFIG.HAS_TKEEP {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.TDATA_NUM_BYTES {64} \
 ] $axis_data_fifo_c2d

  # Create instance: axis_data_fifo_d2c, and set properties
  set axis_data_fifo_d2c [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_d2c ]
  set_property -dict [ list \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_TKEEP {1} \
   CONFIG.TDATA_NUM_BYTES {64} \
 ] $axis_data_fifo_d2c

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

  # Create instance: cmac_to_doce, and set properties
  set cmac_to_doce [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 cmac_to_doce ]
  set_property -dict [ list \
   CONFIG.HAS_TKEEP {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M_TDATA_NUM_BYTES {16} \
   CONFIG.S_TDATA_NUM_BYTES {64} \
 ] $cmac_to_doce

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

  # Create instance: doce_to_cmac, and set properties
  set doce_to_cmac [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 doce_to_cmac ]
  set_property -dict [ list \
   CONFIG.M_TDATA_NUM_BYTES {64} \
 ] $doce_to_cmac

  # Create instance: doce_top_0, and set properties
  set doce_top_0 [ create_bd_cell -type ip -vlnv user.org:user:doce_top:1.0 doce_top_0 ]
  set_property -dict [ list \
   CONFIG.AXI_ADDR_WIDTH {32} \
 ] $doce_top_0

  # Create instance: ila_1, and set properties
  set ila_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ila:6.2 ila_1 ]

  # Create instance: ila_3, and set properties
  set ila_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ila:6.2 ila_3 ]

  # Create instance: mac_addr_reg_0, and set properties
  set mac_addr_reg_0 [ create_bd_cell -type ip -vlnv user.org:user:mac_addr_reg:1.0 mac_addr_reg_0 ]

  # Create instance: pl_reset_gen, and set properties
  set pl_reset_gen [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 pl_reset_gen ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
 ] $pl_reset_gen

  # Create instance: rst_cmac_usplus_0_322M, and set properties
  set rst_cmac_usplus_0_322M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_cmac_usplus_0_322M ]

  # Create instance: rst_ddr4_mig_200M, and set properties
  set rst_ddr4_mig_200M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_ddr4_mig_200M ]

  # Create instance: rst_ddr4_mig_266M, and set properties
  set rst_ddr4_mig_266M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_ddr4_mig_266M ]

  # Create instance: rst_zynq_mpsoc_100M, and set properties
  set rst_zynq_mpsoc_100M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_zynq_mpsoc_100M ]

  # Create instance: rst_zynq_mpsoc_100M_to_cmac, and set properties
  set rst_zynq_mpsoc_100M_to_cmac [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_zynq_mpsoc_100M_to_cmac ]

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

  # Create instance: tx_padding_0, and set properties
  set tx_padding_0 [ create_bd_cell -type ip -vlnv user.org:user:tx_padding:1.0 tx_padding_0 ]

  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_HIGH} \
 ] [get_bd_pins /tx_padding_0/reset]

  # Create instance: Zynq MPSoC
  set zynq_mpsoc [ create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e:3.3 zynq_mpsoc ]
  apply_bd_automation -rule xilinx.com:bd_rule:zynq_ultra_ps_e -config {apply_board_preset "1"} $zynq_mpsoc
  set_property -dict [ \
   list CONFIG.PSU__USE__M_AXI_GP2 {1} \
   CONFIG.PSU__MAXIGP2__DATA_WIDTH {32} \
   CONFIG.PSU__USE__S_AXI_GP2 {1} \
   CONFIG.PSU__USE__S_AXI_GP3 {1} \
   CONFIG.PSU__USE__S_AXI_GP4 {1} \
   CONFIG.PSU__USE__S_AXI_GP5 {1} \
   CONFIG.PSU__NUM_FABRIC_RESETS {2} \
   CONFIG.PSU__FPGA_PL1_ENABLE {1} \
   CONFIG.PSU__CRL_APB__PL1_REF_CTRL__SRCSEL {DPLL} \
  ] $zynq_mpsoc
  
  # Create interface connections
  connect_bd_intf_net -intf_net BFS_0_maxi_0 [get_bd_intf_pins BFS_0/maxi_0] [get_bd_intf_pins axi_crossbar_0/S00_AXI]
  connect_bd_intf_net -intf_net BFS_0_maxi_2 [get_bd_intf_pins BFS_0/maxi_1] [get_bd_intf_pins axi_crossbar_0/S01_AXI]
  connect_bd_intf_net -intf_net BFS_0_maxi_3 [get_bd_intf_pins BFS_0/maxi_2] [get_bd_intf_pins zynq_mpsoc/S_AXI_HP0_FPD]
connect_bd_intf_net -intf_net [get_bd_intf_nets BFS_0_maxi_3] [get_bd_intf_pins ila_1/SLOT_0_AXI] [get_bd_intf_pins zynq_mpsoc/S_AXI_HP0_FPD]
  connect_bd_intf_net -intf_net BFS_0_maxi_4 [get_bd_intf_pins BFS_0/maxi_3] [get_bd_intf_pins zynq_mpsoc/S_AXI_HP1_FPD]
  connect_bd_intf_net -intf_net BFS_0_maxi_5 [get_bd_intf_pins BFS_0/maxi_4] [get_bd_intf_pins zynq_mpsoc/S_AXI_HP2_FPD]
  connect_bd_intf_net -intf_net BFS_0_maxi_6 [get_bd_intf_pins BFS_0/maxi_5] [get_bd_intf_pins zynq_mpsoc/S_AXI_HP3_FPD]
  connect_bd_intf_net -intf_net BFS_0_remote_out [get_bd_intf_pins BFS_0/remote_out] [get_bd_intf_pins axi_interconnect_2/S00_AXI]
  connect_bd_intf_net -intf_net Conn [get_bd_intf_pins axi_clock_converter_0/M_AXI] [get_bd_intf_pins ddr4_mig/C0_DDR4_S_AXI]
  connect_bd_intf_net -intf_net axi_crossbar_0_M00_AXI [get_bd_intf_pins axi_clock_converter_0/S_AXI] [get_bd_intf_pins axi_crossbar_0/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins BFS_0/io_config] [get_bd_intf_pins axi_interconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M01_AXI [get_bd_intf_pins axi_interconnect_0/M01_AXI] [get_bd_intf_pins doce_top_0/doce_axi_lite_slave]
  connect_bd_intf_net -intf_net axi_interconnect_1_M00_AXI [get_bd_intf_pins BFS_0/remote_in] [get_bd_intf_pins axi_interconnect_1/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_2_M00_AXI [get_bd_intf_pins axi_interconnect_2/M00_AXI] [get_bd_intf_pins doce_top_0/doce_axi_slave]
  connect_bd_intf_net -intf_net axis_data_fifo_c2d_M_AXIS [get_bd_intf_pins axis_data_fifo_c2d/M_AXIS] [get_bd_intf_pins cmac_to_doce/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_d2c_M_AXIS [get_bd_intf_pins axis_data_fifo_d2c/M_AXIS] [get_bd_intf_pins tx_padding_0/deoi_axis]
  connect_bd_intf_net -intf_net cmac_to_doce_M_AXIS [get_bd_intf_pins cmac_to_doce/M_AXIS] [get_bd_intf_pins doce_top_0/doce_axis_rxd]
  connect_bd_intf_net -intf_net cmac_usplus_0_axis_rx [get_bd_intf_pins axis_data_fifo_c2d/S_AXIS] [get_bd_intf_pins cmac_usplus_0/axis_rx]
  connect_bd_intf_net -intf_net ddr4_mig_C0_DDR4 [get_bd_intf_ports c0_ddr4] [get_bd_intf_pins ddr4_mig/C0_DDR4]
  connect_bd_intf_net -intf_net ddr4_mig_sys_clk_in [get_bd_intf_ports ddr4_mig_sys_clk] [get_bd_intf_pins ddr4_mig_sys_clk_ibuf/CLK_IN_D]
  connect_bd_intf_net -intf_net doce_to_cmac_M_AXIS [get_bd_intf_pins axis_data_fifo_d2c/S_AXIS] [get_bd_intf_pins doce_to_cmac/M_AXIS]
  connect_bd_intf_net -intf_net doce_top_0_doce_axi_master [get_bd_intf_pins axi_interconnect_1/S00_AXI] [get_bd_intf_pins doce_top_0/doce_axi_master]
  connect_bd_intf_net -intf_net doce_top_0_doce_axis_txd [get_bd_intf_pins doce_to_cmac/S_AXIS] [get_bd_intf_pins doce_top_0/doce_axis_txd]
  connect_bd_intf_net -intf_net doce_top_0_m_axi_doce_mac [get_bd_intf_pins doce_top_0/m_axi_doce_mac] [get_bd_intf_pins mac_addr_reg_0/s_axi_lite]
  connect_bd_intf_net -intf_net gt_ref_clk_1 [get_bd_intf_ports gt_ref_clk] [get_bd_intf_pins cmac_usplus_0/gt_ref_clk]
  connect_bd_intf_net -intf_net tx_padding_0_eth_axis [get_bd_intf_pins cmac_usplus_0/axis_tx] [get_bd_intf_pins tx_padding_0/eth_axis]
  connect_bd_intf_net -intf_net zynq_mpsoc_M_AXI_HPM0_LPD [get_bd_intf_pins axi_interconnect_0/S00_AXI] [get_bd_intf_pins zynq_mpsoc/M_AXI_HPM0_LPD]
connect_bd_intf_net -intf_net [get_bd_intf_nets zynq_mpsoc_M_AXI_HPM0_LPD] [get_bd_intf_pins ila_3/SLOT_0_AXI] [get_bd_intf_pins zynq_mpsoc/M_AXI_HPM0_LPD]

  # Create port connections
  connect_bd_net -net cmac_const_0_dout [get_bd_pins cmac_const_0/dout] [get_bd_pins cmac_usplus_0/ctl_rx_force_resync] [get_bd_pins cmac_usplus_0/ctl_rx_test_pattern] [get_bd_pins cmac_usplus_0/ctl_tx_send_idle] [get_bd_pins cmac_usplus_0/ctl_tx_send_lfi] [get_bd_pins cmac_usplus_0/ctl_tx_send_rfi] [get_bd_pins cmac_usplus_0/ctl_tx_test_pattern]
  connect_bd_net -net cmac_const_1_dout [get_bd_pins cmac_const_1/dout] [get_bd_pins cmac_usplus_0/ctl_rx_enable] [get_bd_pins cmac_usplus_0/ctl_tx_enable]
  connect_bd_net -net cmac_const_gt_loopback_in_dout [get_bd_pins cmac_const_gt_loopback_in/dout] [get_bd_pins cmac_usplus_0/gt_loopback_in]
  connect_bd_net -net cmac_usplus_0_gt_txn_out [get_bd_ports gt_txn_out] [get_bd_pins cmac_usplus_0/gt_txn_out]
  connect_bd_net -net cmac_usplus_0_gt_txp_out [get_bd_ports gt_txp_out] [get_bd_pins cmac_usplus_0/gt_txp_out]
  connect_bd_net -net cmac_usplus_0_gt_txusrclk2 [get_bd_pins axi_interconnect_0/M01_ACLK] [get_bd_pins axi_interconnect_1/ACLK] [get_bd_pins axi_interconnect_1/S00_ACLK] [get_bd_pins axi_interconnect_2/ACLK] [get_bd_pins axi_interconnect_2/M00_ACLK] [get_bd_pins axis_data_fifo_c2d/s_axis_aclk] [get_bd_pins axis_data_fifo_d2c/s_axis_aclk] [get_bd_pins cmac_to_doce/aclk] [get_bd_pins cmac_usplus_0/gt_txusrclk2] [get_bd_pins cmac_usplus_0/rx_clk] [get_bd_pins doce_to_cmac/aclk] [get_bd_pins doce_top_0/clk] [get_bd_pins mac_addr_reg_0/axi_lite_aclk] [get_bd_pins rst_cmac_usplus_0_322M/slowest_sync_clk] [get_bd_pins rx_reset/slowest_sync_clk] [get_bd_pins rx_reset_cnt_0/clk] [get_bd_pins tx_padding_0/aclk]
  connect_bd_net -net cmac_usplus_0_stat_rx_status [get_bd_pins cmac_usplus_0/stat_rx_status] [get_bd_pins rx_reset_cnt_0/rx_status]
  connect_bd_net -net cmac_usplus_0_usr_rx_reset [get_bd_pins cmac_usplus_0/usr_rx_reset] [get_bd_pins rst_cmac_usplus_0_322M/ext_reset_in]
  connect_bd_net -net ddr4_mig_c0_ddr4_ui_clk [get_bd_pins axi_clock_converter_0/m_axi_aclk] [get_bd_pins ddr4_mig/c0_ddr4_ui_clk] [get_bd_pins rst_ddr4_mig_266M/slowest_sync_clk]
  connect_bd_net -net ddr4_mig_c0_ddr4_ui_clk_sync_rst [get_bd_pins ddr4_mig/c0_ddr4_ui_clk_sync_rst] [get_bd_pins rst_ddr4_mig_200M/ext_reset_in] [get_bd_pins rst_ddr4_mig_266M/ext_reset_in]
  connect_bd_net -net ddr4_mig_sys_clk_bufg_out [get_bd_pins ddr4_mig/c0_sys_clk_i] [get_bd_pins ddr4_mig_sys_clk_bufg/BUFG_O]
  connect_bd_net -net ddr4_mig_sys_clk_ibuf_out [get_bd_pins ddr4_mig_sys_clk_bufg/BUFG_I] [get_bd_pins ddr4_mig_sys_clk_ibuf/IBUF_OUT]
  connect_bd_net -net ddr4_ui_clk [get_bd_pins BFS_0/clock] [get_bd_pins axi_clock_converter_0/s_axi_aclk] [get_bd_pins axi_crossbar_0/aclk] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_1/M00_ACLK] [get_bd_pins axi_interconnect_2/S00_ACLK] [get_bd_pins ddr4_mig/addn_ui_clkout1] [get_bd_pins ila_1/clk] [get_bd_pins rst_ddr4_mig_200M/slowest_sync_clk] [get_bd_pins zynq_mpsoc/saxihp0_fpd_aclk] [get_bd_pins zynq_mpsoc/saxihp1_fpd_aclk] [get_bd_pins zynq_mpsoc/saxihp2_fpd_aclk] [get_bd_pins zynq_mpsoc/saxihp3_fpd_aclk]
  connect_bd_net -net gt_rxn_in_1 [get_bd_ports gt_rxn_in] [get_bd_pins cmac_usplus_0/gt_rxn_in]
  connect_bd_net -net gt_rxp_in_1 [get_bd_ports gt_rxp_in] [get_bd_pins cmac_usplus_0/gt_rxp_in]
  connect_bd_net -net mac_addr_reg_0_doce_ip_addr [get_bd_pins doce_top_0/doce_ip_addr] [get_bd_pins mac_addr_reg_0/doce_ip_addr]
  connect_bd_net -net mac_addr_reg_0_doce_mac_id [get_bd_pins doce_top_0/doce_mac_addr] [get_bd_pins mac_addr_reg_0/doce_mac_id]
  connect_bd_net -net pl_reset [get_bd_pins ddr4_mig/sys_rst] [get_bd_pins pl_reset_gen/Res]
  connect_bd_net -net pl_resetn0 [get_bd_pins pl_reset_gen/Op1] [get_bd_pins rst_zynq_mpsoc_100M/ext_reset_in] [get_bd_pins zynq_mpsoc/pl_resetn0]
  connect_bd_net -net rst_cmac_usplus_0_322M_peripheral_aresetn [get_bd_pins axi_interconnect_0/M01_ARESETN] [get_bd_pins axi_interconnect_1/ARESETN] [get_bd_pins axi_interconnect_1/S00_ARESETN] [get_bd_pins axi_interconnect_2/ARESETN] [get_bd_pins axi_interconnect_2/M00_ARESETN] [get_bd_pins axis_data_fifo_c2d/s_axis_aresetn] [get_bd_pins axis_data_fifo_d2c/s_axis_aresetn] [get_bd_pins cmac_to_doce/aresetn] [get_bd_pins doce_to_cmac/aresetn] [get_bd_pins mac_addr_reg_0/axi_lite_aresetn] [get_bd_pins rst_cmac_usplus_0_322M/peripheral_aresetn]
  connect_bd_net -net rst_cmac_usplus_0_322M_peripheral_reset [get_bd_pins doce_top_0/reset] [get_bd_pins rst_cmac_usplus_0_322M/peripheral_reset] [get_bd_pins tx_padding_0/reset]
  connect_bd_net -net rst_ddr4_mig_266M_peripheral_aresetn [get_bd_pins axi_clock_converter_0/s_axi_aresetn] [get_bd_pins axi_crossbar_0/aresetn] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_1/M00_ARESETN] [get_bd_pins axi_interconnect_2/S00_ARESETN] [get_bd_pins rst_ddr4_mig_200M/peripheral_aresetn]
  connect_bd_net -net rst_ddr4_mig_266M_peripheral_aresetn1 [get_bd_pins axi_clock_converter_0/m_axi_aresetn] [get_bd_pins ddr4_mig/c0_ddr4_aresetn] [get_bd_pins rst_ddr4_mig_266M/peripheral_aresetn]
  connect_bd_net -net rst_ddr4_mig_266M_peripheral_reset [get_bd_pins BFS_0/reset] [get_bd_pins rst_ddr4_mig_200M/peripheral_reset]
  connect_bd_net -net rst_zynq_mpsoc_100M_peripheral_aresetn [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins rst_zynq_mpsoc_100M/peripheral_aresetn]
  connect_bd_net -net rst_zynq_mpsoc_100M_to_cmac_peripheral_reset [get_bd_pins cmac_usplus_0/core_drp_reset] [get_bd_pins cmac_usplus_0/core_rx_reset] [get_bd_pins cmac_usplus_0/core_tx_reset] [get_bd_pins cmac_usplus_0/gtwiz_reset_tx_datapath] [get_bd_pins cmac_usplus_0/sys_reset] [get_bd_pins rst_zynq_mpsoc_100M_to_cmac/peripheral_reset]
  connect_bd_net -net rx_reset_cnt_0_gtwiz_rx_reset [get_bd_pins cmac_usplus_0/gtwiz_reset_rx_datapath] [get_bd_pins rx_reset_cnt_0/gtwiz_rx_reset]
  connect_bd_net -net rx_reset_peripheral_reset [get_bd_pins rx_reset/peripheral_reset] [get_bd_pins rx_reset_cnt_0/reset]
  connect_bd_net -net zynq_mpsoc_pl_clk0 [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins ila_3/clk] [get_bd_pins rst_zynq_mpsoc_100M/slowest_sync_clk] [get_bd_pins zynq_mpsoc/maxihpm0_lpd_aclk] [get_bd_pins zynq_mpsoc/pl_clk0]
  connect_bd_net -net zynq_mpsoc_pl_clk1 [get_bd_pins cmac_usplus_0/drp_clk] [get_bd_pins cmac_usplus_0/init_clk] [get_bd_pins rst_zynq_mpsoc_100M_to_cmac/slowest_sync_clk] [get_bd_pins zynq_mpsoc/pl_clk1]
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


#=============================================
# Finish BD creation 
#=============================================

  # Restore current instance
  current_bd_instance $oldCurInst

  #validate_bd_design
  save_bd_design

  common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" " Finish BD creation."
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""

