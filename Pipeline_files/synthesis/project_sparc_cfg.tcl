# ========== Copyright Header Begin ==========================================
# 
# OpenSPARC T1 Processor File: project_sparc_cfg.scr
# Copyright (c) 2006 Sun Microsystems, Inc.  All Rights Reserved.
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES.
# 
# The above named program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public
# License version 2 as published by the Free Software Foundation.
# 
# The above named program is distributed in the hope that it will be 
# useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
# 
# You should have received a copy of the GNU General Public
# License along with this work; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
# 
# ========== Copyright Header End ============================================
###########################################################################
# Need to define in this file
###########################################################################
# Include target library
# Include Synopsys Designware
#
# clk_list (name + freq/MHz)
# default_clk
#
# setup_skew  (all timing in ns)
# hold_skew
# clk_transition
# max_transition
# max_fanout
#

# This variable indicates we are synthesizing cmp blocks
set project_sparc_cfg	1

###########################################################################
# Specify target library specific variables
###########################################################################

#source $dv_root/design/sys/synopsys/script/target_lib.tcl

###########################################################################
# Include Synopsys Designware library
###########################################################################
# Designware will not be used in sparc control blocks
set synthetic_library {}
set link_path [concat  $link_library $synthetic_library]

###########################################################################
# Sparc/IO clocks
###########################################################################
# Name				Freq	Comment
# cpu_clk			1400.0	CPU clock
# cmp_gclk			1400.0	CPU clock
# clk				240.0   BSC clock 200 + 20%

# The script will NOT automatically pad 20% (1.2x) to these
# frequencies  mhz,setup_skew  ns,hold_skew  ns,clk_transition  ns
set clk_list {                          \
                {cpu_clk   1204.82   0.130   0.130   0.040}     \
                {cmp_gclk  1204.82   0.130   0.130   0.040}     \
                {clk       1204.82   0.086   0.086   0.040}     \
                {rclk      1204.82   0.086   0.086   0.040}     \
}

# setup_skew = local skew (60ps) + jitter (36ps)
set default_clk rclk
set default_clk_freq 1204.82
set default_setup_skew       0.086
set default_hold_skew        0.086
set default_clock_transition 0.040

# More parameters

# setup_skew = local skew (125ps) + jitter (250ps)
set default_clk clk
set default_clk_freq	240
set default_setup_skew       0.375
set default_hold_skew        0.080
set default_clock_transition 0.050

set max_transition   0.110
set max_fanout         6

# default input/output delays
#set default_input_delay  0.15
#set default_output_delay 0.2 
#set critical_range       0.30

set default_input_delay  0.001
set default_output_delay 0.001 
set critical_range       0.30

# default number of worst path reported
set num_of_path 1000

#default compile style for io is to not flatten the whole design
set compile_flatten_all 0
