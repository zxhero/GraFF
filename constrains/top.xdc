#========================================================
# Vivado constraint file
# Based on Vivado 2019.1
# Author: Yisong Chang (changyisong@ict.ac.cn)
# Date: 02/01/2021
#========================================================


# PL DDR reference clock
create_clock -period 10.000 -name ddr4_mig_sys_clk -waveform {0.000 5.000} [get_ports ddr4_mig_sys_clk_clk_p]

set_property IOSTANDARD DIFF_SSTL12 [get_ports {ddr4_mig_sys_clk_clk_n[0]}]
set_property IOSTANDARD DIFF_SSTL12 [get_ports {ddr4_mig_sys_clk_clk_p[0]}]

set_property PACKAGE_PIN AU21 [get_ports {ddr4_mig_sys_clk_clk_p[0]}]
set_property PACKAGE_PIN AV21 [get_ports {ddr4_mig_sys_clk_clk_n[0]}]

set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_pins -hier -filter {NAME =~ */u_ddr4_infrastructure/gen_mmcme4.u_mmcme_adv_inst/CLKIN1}]




