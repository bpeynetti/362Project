# ========== Copyright Header Begin ==========================================
# 
# OpenSPARC T1 Processor File: user_cfg.scr
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
source -echo -verbose project_sparc_cfg.tcl

set rtl_files { /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/lib/adder.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/lib/alu.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/lib/and.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/lib/check_branch.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/lib/control.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/lib/decoder.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/lib/dff.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/lib/extend_1to32.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/lib/extender.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/lib/mux.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/lib/not.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/lib/or.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/lib/outData.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/lib/pipeline_reg.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/lib/register.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/lib/setter.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/lib/shift.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/lib/xor.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/lib/zero.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/execute.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/ex_mem_reg.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/id_ex_reg.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/if_id_reg.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/instruction_decode.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/instruction_fetch.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/load_stall.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/mem_ex_hazard.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/memory_stage.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/mem_wb_reg.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/register_file.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/top_level.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/wb_ex_hazard.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/wb_id_hazard.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/wb_mem_hazard.v /home/bpv512/EECS362/SYNTH_ALU/Pipeline_files/src/write_back.v }

set mix_files {}
set top_module pipeline_processor
set include_paths { design/sys/iop/include }

set black_box_libs {}
set black_box_designs {}
set mem_libs {}

set compile_effort   "high"
set area_effort "low"

set compile_flatten_all 1

set compile_no_new_cells_at_top_level false

set default_clk clk
set default_clk_freq 800
set default_setup_skew  0.00
set default_hold_skew  0.00
set default_clk_transition  0.00
set clk_list {                        \
        {clk     800.0    0.0    0.0    0.0}        \
}
set ideal_net_list {}
set false_path_list {}
set enforce_input_fanout_one     0
set allow_outport_drive_innodes  1
set skip_scan            0
set add_lockup_latch     false
set chain_count          1
set scanin_port_list     {}
set scanout_port_list    {}
set scanenable_port      global_shift_enable
set has_test_stub        1
set scanenable_pin       test_stub_no_bist/se
set long_chain_so_0_net  long_chain_so_0
set short_chain_so_0_net short_chain_so_0
set so_0_net             so_0
set insert_extra_lockup_latch 0
set extra_lockup_latch_clk_list {}
set dont_use_cells 0
set dont_touch_modules []
