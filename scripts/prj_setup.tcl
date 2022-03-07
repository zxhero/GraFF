# add source files
#add_files ${script_dir}/../sources/hdl/${project_name}.v

# Set IP repository paths
set obj [get_filesets sources_1]
if { $obj != {} } {
   set_property "ip_repo_paths" "[file normalize "${script_dir}/../design/${prj}/ip_repo/bfs_ps"]" $obj

   # Rebuild user ip_repo's index before adding any source files
   update_ip_catalog -rebuild
}

# setup block design
set bd_design mpsoc
source ${script_dir}/../design/${prj}/scripts/${bd_design}.tcl
		
set_property synth_checkpoint_mode None [get_files ./${project_name}/${project_name}.srcs/sources_1/bd/${bd_design}/${bd_design}.bd]
generate_target all [get_files ./${project_name}/${project_name}.srcs/sources_1/bd/${bd_design}/${bd_design}.bd]
		
make_wrapper -files [get_files ./${project_name}/${project_name}.srcs/sources_1/bd/${bd_design}/${bd_design}.bd] -top
import_files -force -norecurse -fileset sources_1 ./${project_name}/${project_name}.srcs/sources_1/bd/${bd_design}/hdl/${bd_design}_wrapper.v

validate_bd_design
save_bd_design
close_bd_design ${bd_design}

# setup top module
#set_property "top" ${project_name} [get_filesets sources_1]
	
# add constraints files
set main_constraints ${script_dir}/../design/${prj}/constrains/top.xdc
add_files -fileset constrs_1 -norecurse ${main_constraints}

set ddr_constraints ${script_dir}/../design/${prj}/constrains/ddr4_mig_phy_loc.xdc
add_files -fileset constrs_1 -norecurse ${ddr_constraints}

