#######################################################################
# Example with Synopsys
#
#######################################################################
# Variables

# Project-specific stuff
LIB_DIR = ../src/lib/
SC_DIR = ../src/
#VERILOG_FILES = ../adder.v ../counter.v
#VERILOG_FILES = ${SC_DIR}memory_stage.v
VERILOG_FILES = ${LIB_DIR}adder.v ${LIB_DIR}alu.v ${LIB_DIR}and.v ${LIB_DIR}check_branch.v ${LIB_DIR}control.v ${LIB_DIR}decoder.v ${LIB_DIR}dff.v ${LIB_DIR}extend_1to32.v ${LIB_DIR}extender.v ${LIB_DIR}mux.v ${LIB_DIR}not.v ${LIB_DIR}or.v ${LIB_DIR}outData.v ${LIB_DIR}pipeline_reg.v ${LIB_DIR}register.v ${LIB_DIR}setter.v ${LIB_DIR}shift.v ${LIB_DIR}xor.v ${LIB_DIR}zero.v ${LIB_DIR}multiplier.v ${SC_DIR}register_file_fp.v ${SC_DIR}execute.v ${SC_DIR}ex_mem_reg.v ${SC_DIR}id_ex_reg.v ${SC_DIR}if_id_reg.v ${SC_DIR}instruction_decode.v ${SC_DIR}instruction_fetch.v ${SC_DIR}load_stall.v ${SC_DIR}mem_ex_hazard.v ${SC_DIR}memory_stage.v ${SC_DIR}mem_wb_reg.v ${SC_DIR}register_file.v ${SC_DIR}top_level.v ${SC_DIR}wb_ex_hazard.v ${SC_DIR}wb_id_hazard.v ${SC_DIR}wb_mem_hazard.v ${SC_DIR}write_back.v 
#VERILOG_FILES = ${ALU_DIR}adder.v ${ALU_DIR}and.v ${ALU_DIR}alu.v ${ALU_DIR}extend_1to32.v ${ALU_DIR}mux.v ${ALU_DIR}not.v ${ALU_DIR}or.v ${ALU_DIR}setter.v ${ALU_DIR}shift.v ${ALU_DIR}xor.v ${ALU_DIR}zero.v ${ALU_DIR}alu.v ${SC_DIR}check_branch.v ${SC_DIR}control.v ${SC_DIR}decoder.v ${SC_DIR}dff.v ${SC_DIR}extender.v  ${SC_DIR}multiplier.v ${SC_DIR}outData.v ${SC_DIR}pc_logic.v ${SC_DIR}register_file.v ${SC_DIR}register.v ${SC_DIR}single_cycle.v 
#VERILOG_FILES = ${SC_DIR}control.v
#VERILOG_FILES = ${LIB_DIR}multiplier.v
#VERILOG_FILES = ${LIB_DIR}mux.v ${LIB_DIR}dff.v ${LIB_DIR}decoder.v ${LIB_DIR}register.v ${SC_DIR}register_file.v
#VERILOG_FILES = ${LIB_DIR}or.v ${LIB_DIR}zero.v ${LIB_DIR}control.v ${LIB_DIR}decoder.v
TOPLEVEL = mem_ex_hazard
# Freq in MHz
CLKFREQ = 1000

# Constants
SYNTHESIS_DIR = /vol/eecs362/synthesis/
SYNTHESIS_SCRIPTS = user_cfg.tcl run.tcl project_sparc_cfg.tcl NangateOpenCellLibrary.db

# Synopsis Environment Variables
# By adding 'export', the values of these will be exported to the
# environment of shell commands. These are copied from:
#     /vol/eecs362/eecs362.env

export SNPSLMD_LICENSE_FILE = 27000@synopsyslm.eecs.northwestern.edu
export SYNOPSYS = /vol/synopsys2012
export DC_HOME = /vol/eecs362/synopsys/dc
export DC_EXE = ${DC_HOME}/bin
export VCS_HOME = ${SYNOPSYS}/vcs_vF-2011.12
export VCS_EXE = ${VCS_HOME}/bin

DC_SHELL = ${DC_EXE}/dc_shell

# This uses a function to get the real path of files.
# For more filename functions, see:
# http://www.gnu.org/software/make/manual/make.html#File-Name-Functions

REAL_VERILOG_FILES = $(realpath ${VERILOG_FILES})

GENERATED_FILES = command.log default.svf gate log template .template synth_results.txt user_cfg.tcl

#######################################################################
.PHONY: synthesis

# 'synthesis' is the default Make command.
# It requires the file generated below ('synth_results.txt').
#
# The command contents ("! cat .... | grep -i error") will print
# out any errors from the synth_results.txt file, and give the
# corresponding error code to Make.
synthesis: synth_results.txt ;
	! cat synth_results.txt | grep -vE "^[ 	]*#" | grep -vE "^[ 	]*echo" | grep -i error

.PHONY: clean
clean: ;
	rm -rf ${GENERATED_FILES}

synth_results.txt: ${SYNTHESIS_SCRIPTS} ${VERILOG_FILES} ;
	@echo "Synthesis"
	${DC_SHELL} -f run.tcl > synth_results.txt

# 'user_cfg.tcl' represents the configuration options for Synopsis.
# Here, the custom options will be entered automatically from options
# above.
# Since this may change, the Makefile itself is included in the list of
# prerequisites.
user_cfg.tcl : ${SYNTHESIS_DIR}user_cfg.tcl Makefile ;
	@echo "Generating user_cfg.tcl"
	# Copy the config; use 'sed' to modify pertinent fields.
	# Sed find/replace can use any delineating character;
	#   '#' is unlikely in file paths, so that's used here.
	# "$$" expands to a single '$' when executed from 'make'.
	cat $< | \
	    sed 's#^set rtl_files {.*}$$#set rtl_files { ${REAL_VERILOG_FILES} }#' | \
	    sed 's#^set top_module .*$$#set top_module ${TOPLEVEL}#' | \
	    sed 's#^set default_clk_freq .*$$#set default_clk_freq ${CLKFREQ}#' | \
	    sed 's#^ *{clk .*}#        {clk     ${CLKFREQ}.0    0.0    0.0    0.0}#' \
	    > $@
	echo "set dont_use_cells 0" >> $@
	echo "set dont_touch_modules []" >> $@

# Pattern rule for files to copy from synthesis directory
% : ${SYNTHESIS_DIR}% ;
	cp $< $@ ;
