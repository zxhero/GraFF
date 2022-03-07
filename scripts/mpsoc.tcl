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
xilinx.com:ip:axi_crossbar:2.1\
xilinx.com:ip:axi_perf_mon:5.0\
xilinx.com:ip:ddr4:2.2\
xilinx.com:ip:util_ds_buf:2.1\
xilinx.com:ip:ila:6.2\
xilinx.com:ip:util_vector_logic:2.0\
xilinx.com:ip:proc_sys_reset:5.0\
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
    # Create interface ports
  set c0_ddr4 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddr4_rtl:1.0 c0_ddr4 ]

  set ddr4_mig_sys_clk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 ddr4_mig_sys_clk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {100000000} \
   ] $ddr4_mig_sys_clk


  # Create ports

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
   CONFIG.NUM_MI {1} \
 ] $axi_interconnect_0

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

  # Create instance: ila_1, and set properties
  set ila_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ila:6.2 ila_1 ]

  # Create instance: ila_3, and set properties
  set ila_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ila:6.2 ila_3 ]

  # Create instance: pl_reset_gen, and set properties
  set pl_reset_gen [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 pl_reset_gen ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
 ] $pl_reset_gen

  # Create instance: rst_ddr4_mig_200M, and set properties
  set rst_ddr4_mig_200M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_ddr4_mig_200M ]

  # Create instance: rst_ddr4_mig_266M, and set properties
  set rst_ddr4_mig_266M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_ddr4_mig_266M ]

  # Create instance: rst_zynq_mpsoc_100M, and set properties
  set rst_zynq_mpsoc_100M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_zynq_mpsoc_100M ]

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
  ] $zynq_mpsoc
  
  # Create interface connections
  connect_bd_intf_net -intf_net BFS_0_maxi_0 [get_bd_intf_pins BFS_0/maxi_0] [get_bd_intf_pins axi_crossbar_0/S00_AXI]
  connect_bd_intf_net -intf_net BFS_0_maxi_2 [get_bd_intf_pins BFS_0/maxi_1] [get_bd_intf_pins axi_crossbar_0/S01_AXI]
  connect_bd_intf_net -intf_net BFS_0_maxi_3 [get_bd_intf_pins BFS_0/maxi_2] [get_bd_intf_pins zynq_mpsoc/S_AXI_HP0_FPD]
connect_bd_intf_net -intf_net [get_bd_intf_nets BFS_0_maxi_3] [get_bd_intf_pins ila_1/SLOT_0_AXI] [get_bd_intf_pins zynq_mpsoc/S_AXI_HP0_FPD]
  connect_bd_intf_net -intf_net BFS_0_maxi_4 [get_bd_intf_pins BFS_0/maxi_3] [get_bd_intf_pins zynq_mpsoc/S_AXI_HP1_FPD]
  connect_bd_intf_net -intf_net BFS_0_maxi_5 [get_bd_intf_pins BFS_0/maxi_4] [get_bd_intf_pins zynq_mpsoc/S_AXI_HP2_FPD]
  connect_bd_intf_net -intf_net BFS_0_maxi_6 [get_bd_intf_pins BFS_0/maxi_5] [get_bd_intf_pins zynq_mpsoc/S_AXI_HP3_FPD]
  connect_bd_intf_net -intf_net Conn [get_bd_intf_pins axi_clock_converter_0/M_AXI] [get_bd_intf_pins ddr4_mig/C0_DDR4_S_AXI]
  connect_bd_intf_net -intf_net axi_crossbar_0_M00_AXI [get_bd_intf_pins axi_clock_converter_0/S_AXI] [get_bd_intf_pins axi_crossbar_0/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins BFS_0/io_config] [get_bd_intf_pins axi_interconnect_0/M00_AXI]
connect_bd_intf_net -intf_net [get_bd_intf_nets axi_interconnect_0_M00_AXI] [get_bd_intf_pins axi_interconnect_0/M00_AXI] [get_bd_intf_pins ila_3/SLOT_0_AXI]
  connect_bd_intf_net -intf_net ddr4_mig_C0_DDR4 [get_bd_intf_ports c0_ddr4] [get_bd_intf_pins ddr4_mig/C0_DDR4]
  connect_bd_intf_net -intf_net ddr4_mig_sys_clk_in [get_bd_intf_ports ddr4_mig_sys_clk] [get_bd_intf_pins ddr4_mig_sys_clk_ibuf/CLK_IN_D]
  connect_bd_intf_net -intf_net zynq_mpsoc_M_AXI_HPM0_LPD [get_bd_intf_pins axi_interconnect_0/S00_AXI] [get_bd_intf_pins zynq_mpsoc/M_AXI_HPM0_LPD]

  # Create port connections
  connect_bd_net -net ddr4_mig_c0_ddr4_ui_clk [get_bd_pins axi_clock_converter_0/m_axi_aclk] [get_bd_pins ddr4_mig/c0_ddr4_ui_clk] [get_bd_pins rst_ddr4_mig_266M/slowest_sync_clk]
  connect_bd_net -net ddr4_mig_c0_ddr4_ui_clk_sync_rst [get_bd_pins ddr4_mig/c0_ddr4_ui_clk_sync_rst] [get_bd_pins rst_ddr4_mig_200M/ext_reset_in] [get_bd_pins rst_ddr4_mig_266M/ext_reset_in]
  connect_bd_net -net ddr4_mig_sys_clk_bufg_out [get_bd_pins ddr4_mig/c0_sys_clk_i] [get_bd_pins ddr4_mig_sys_clk_bufg/BUFG_O]
  connect_bd_net -net ddr4_mig_sys_clk_ibuf_out [get_bd_pins ddr4_mig_sys_clk_bufg/BUFG_I] [get_bd_pins ddr4_mig_sys_clk_ibuf/IBUF_OUT]
  connect_bd_net -net ddr4_ui_clk [get_bd_pins BFS_0/clock] [get_bd_pins axi_clock_converter_0/s_axi_aclk] [get_bd_pins axi_crossbar_0/aclk] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins ddr4_mig/addn_ui_clkout1] [get_bd_pins ila_1/clk] [get_bd_pins ila_3/clk] [get_bd_pins rst_ddr4_mig_200M/slowest_sync_clk] [get_bd_pins zynq_mpsoc/saxihp0_fpd_aclk] [get_bd_pins zynq_mpsoc/saxihp1_fpd_aclk] [get_bd_pins zynq_mpsoc/saxihp2_fpd_aclk] [get_bd_pins zynq_mpsoc/saxihp3_fpd_aclk]
  connect_bd_net -net pl_reset [get_bd_pins ddr4_mig/sys_rst] [get_bd_pins pl_reset_gen/Res]
  connect_bd_net -net pl_resetn0 [get_bd_pins pl_reset_gen/Op1] [get_bd_pins rst_zynq_mpsoc_100M/ext_reset_in] [get_bd_pins zynq_mpsoc/pl_resetn0]
  connect_bd_net -net rst_ddr4_mig_266M_peripheral_aresetn [get_bd_pins axi_clock_converter_0/s_axi_aresetn] [get_bd_pins axi_crossbar_0/aresetn] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins rst_ddr4_mig_200M/peripheral_aresetn]
  connect_bd_net -net rst_ddr4_mig_266M_peripheral_aresetn1 [get_bd_pins axi_clock_converter_0/m_axi_aresetn] [get_bd_pins ddr4_mig/c0_ddr4_aresetn] [get_bd_pins rst_ddr4_mig_266M/peripheral_aresetn]
  connect_bd_net -net rst_ddr4_mig_266M_peripheral_reset [get_bd_pins BFS_0/reset] [get_bd_pins rst_ddr4_mig_200M/peripheral_reset]
  connect_bd_net -net rst_zynq_mpsoc_100M_peripheral_aresetn [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins rst_zynq_mpsoc_100M/peripheral_aresetn]
  connect_bd_net -net zynq_mpsoc_pl_clk0 [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins rst_zynq_mpsoc_100M/slowest_sync_clk] [get_bd_pins zynq_mpsoc/maxihpm0_lpd_aclk] [get_bd_pins zynq_mpsoc/pl_clk0]

  # Create address segments
  assign_bd_address -offset 0x000400000000 -range 0x000100000000 -target_address_space [get_bd_addr_spaces BFS_0/maxi_0] [get_bd_addr_segs ddr4_mig/C0_DDR4_MEMORY_MAP/C0_DDR4_ADDRESS_BLOCK] -force
  assign_bd_address -offset 0x000400000000 -range 0x000100000000 -target_address_space [get_bd_addr_spaces BFS_0/maxi_1] [get_bd_addr_segs ddr4_mig/C0_DDR4_MEMORY_MAP/C0_DDR4_ADDRESS_BLOCK] -force
  assign_bd_address -offset 0x000800000000 -range 0x000200000000 -target_address_space [get_bd_addr_spaces BFS_0/maxi_2] [get_bd_addr_segs zynq_mpsoc/SAXIGP2/HP0_DDR_HIGH] -force
  assign_bd_address -offset 0x000800000000 -range 0x000200000000 -target_address_space [get_bd_addr_spaces BFS_0/maxi_3] [get_bd_addr_segs zynq_mpsoc/SAXIGP3/HP1_DDR_HIGH] -force
  assign_bd_address -offset 0x000800000000 -range 0x000200000000 -target_address_space [get_bd_addr_spaces BFS_0/maxi_4] [get_bd_addr_segs zynq_mpsoc/SAXIGP4/HP2_DDR_HIGH] -force
  assign_bd_address -offset 0x000800000000 -range 0x000200000000 -target_address_space [get_bd_addr_spaces BFS_0/maxi_5] [get_bd_addr_segs zynq_mpsoc/SAXIGP5/HP3_DDR_HIGH] -force
  assign_bd_address -offset 0x90000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces zynq_mpsoc/Data] [get_bd_addr_segs BFS_0/io_config/reg0] -force


#=============================================
# Finish BD creation 
#=============================================

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

