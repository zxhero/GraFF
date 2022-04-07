# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  ipgui::add_param $IPINST -name "AXI_ADDR_WIDTH"
  ipgui::add_param $IPINST -name "AXI_ID_WIDTH"
  ipgui::add_param $IPINST -name "AXI_SIZE_WIDTH"
  ipgui::add_param $IPINST -name "AXI_BASE_ADDR"
  ipgui::add_param $IPINST -name "AXI_LITE_BASE_ADDR"
  ipgui::add_param $IPINST -name "DATA_WIDTH"

}

proc update_PARAM_VALUE.AXI_ADDR_WIDTH { PARAM_VALUE.AXI_ADDR_WIDTH } {
	# Procedure called to update AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AXI_ADDR_WIDTH { PARAM_VALUE.AXI_ADDR_WIDTH } {
	# Procedure called to validate AXI_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.AXI_BASE_ADDR { PARAM_VALUE.AXI_BASE_ADDR } {
	# Procedure called to update AXI_BASE_ADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AXI_BASE_ADDR { PARAM_VALUE.AXI_BASE_ADDR } {
	# Procedure called to validate AXI_BASE_ADDR
	return true
}

proc update_PARAM_VALUE.AXI_ID_WIDTH { PARAM_VALUE.AXI_ID_WIDTH } {
	# Procedure called to update AXI_ID_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AXI_ID_WIDTH { PARAM_VALUE.AXI_ID_WIDTH } {
	# Procedure called to validate AXI_ID_WIDTH
	return true
}

proc update_PARAM_VALUE.AXI_LITE_BASE_ADDR { PARAM_VALUE.AXI_LITE_BASE_ADDR } {
	# Procedure called to update AXI_LITE_BASE_ADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AXI_LITE_BASE_ADDR { PARAM_VALUE.AXI_LITE_BASE_ADDR } {
	# Procedure called to validate AXI_LITE_BASE_ADDR
	return true
}

proc update_PARAM_VALUE.AXI_SIZE_WIDTH { PARAM_VALUE.AXI_SIZE_WIDTH } {
	# Procedure called to update AXI_SIZE_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AXI_SIZE_WIDTH { PARAM_VALUE.AXI_SIZE_WIDTH } {
	# Procedure called to validate AXI_SIZE_WIDTH
	return true
}

proc update_PARAM_VALUE.DATA_WIDTH { PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to update DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DATA_WIDTH { PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to validate DATA_WIDTH
	return true
}


proc update_MODELPARAM_VALUE.AXI_ADDR_WIDTH { MODELPARAM_VALUE.AXI_ADDR_WIDTH PARAM_VALUE.AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.AXI_ID_WIDTH { MODELPARAM_VALUE.AXI_ID_WIDTH PARAM_VALUE.AXI_ID_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AXI_ID_WIDTH}] ${MODELPARAM_VALUE.AXI_ID_WIDTH}
}

proc update_MODELPARAM_VALUE.AXI_SIZE_WIDTH { MODELPARAM_VALUE.AXI_SIZE_WIDTH PARAM_VALUE.AXI_SIZE_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AXI_SIZE_WIDTH}] ${MODELPARAM_VALUE.AXI_SIZE_WIDTH}
}

proc update_MODELPARAM_VALUE.AXI_BASE_ADDR { MODELPARAM_VALUE.AXI_BASE_ADDR PARAM_VALUE.AXI_BASE_ADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AXI_BASE_ADDR}] ${MODELPARAM_VALUE.AXI_BASE_ADDR}
}

proc update_MODELPARAM_VALUE.AXI_LITE_BASE_ADDR { MODELPARAM_VALUE.AXI_LITE_BASE_ADDR PARAM_VALUE.AXI_LITE_BASE_ADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AXI_LITE_BASE_ADDR}] ${MODELPARAM_VALUE.AXI_LITE_BASE_ADDR}
}

proc update_MODELPARAM_VALUE.DATA_WIDTH { MODELPARAM_VALUE.DATA_WIDTH PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DATA_WIDTH}] ${MODELPARAM_VALUE.DATA_WIDTH}
}

