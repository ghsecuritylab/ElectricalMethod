
##
## Create Clock Constraints on BSCAN ports TCK & UPDATE
##
create_clock -period 33 [get_pins -filter {REF_PIN_NAME=~TCK} -of_objects [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/SWITCH_N_EXT_BSCAN.bscan_inst/SERIES7_BSCAN.bscan_inst*"}]]

set wr_clock          [get_clocks -of_objects [get_pins -filter {REF_PIN_NAME=~wr_clk} -of_objects [get_cells -hierarchical -filter {NAME =~ "*SUBCORE_FIFO.*rdfifo_inst"}]]]
set_false_path -from [filter [all_fanout -from [get_pins -filter {REF_PIN_NAME=~wr_clk} -of_objects [get_cells -hierarchical -filter {NAME =~ "*SUBCORE_FIFO.*rdfifo_inst"}]] -flat -endpoints_only] {IS_LEAF}] -to [get_cells -hierarchical -filter {NAME =~ *U_RD_FIFO*gdm.dm_gen.dm*/gpr1.dout_i_reg*}]
set rd_clock_2          [get_clocks -of_objects [get_pins -filter {REF_PIN_NAME=~rd_clk} -of_objects [get_cells -hierarchical -filter {NAME =~ "*SUBCORE_FIFO.*wrfifo_inst"}]]]
set rd_clock          [get_clocks -of_objects [get_pins -filter {REF_PIN_NAME=~TCK} -of_objects [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/SWITCH_N_EXT_BSCAN.bscan_inst/SERIES7_BSCAN.bscan_inst*"}]]]
set wr_clk_period     [get_property -min PERIOD $wr_clock]
set rd_clk_period     [get_property -min PERIOD $rd_clock]
set skew_value [expr {(($wr_clk_period < $rd_clk_period) ? $wr_clk_period : $rd_clk_period)} ]

# Set max delay on cross clock domain path for Block/Distributed RAM based FIFO

set_max_delay -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD6_RD/U_RD_FIFO/SUBCORE_FIFO.xsdbm_v3_0_0_rdfifo_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/*rd_pntr_gc_reg[*]"}] -to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD6_RD/U_RD_FIFO/SUBCORE_FIFO.xsdbm_v3_0_0_rdfifo_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/*gsync_stage[1].wr_stg_inst/Q_reg_reg[*]"}] -datapath_only [get_property -min PERIOD $rd_clock]
set_bus_skew -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD6_RD/U_RD_FIFO/SUBCORE_FIFO.xsdbm_v3_0_0_rdfifo_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/*rd_pntr_gc_reg[*]"}] -to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD6_RD/U_RD_FIFO/SUBCORE_FIFO.xsdbm_v3_0_0_rdfifo_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/*gsync_stage[1].wr_stg_inst/Q_reg_reg[*]"}] $skew_value

set_max_delay -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD6_RD/U_RD_FIFO/SUBCORE_FIFO.xsdbm_v3_0_0_rdfifo_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/*wr_pntr_gc_reg[*]"}] -to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD6_RD/U_RD_FIFO/SUBCORE_FIFO.xsdbm_v3_0_0_rdfifo_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/*gsync_stage[1].rd_stg_inst/Q_reg_reg[*]"}] -datapath_only [get_property -min PERIOD $wr_clock]
set_bus_skew -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD6_RD/U_RD_FIFO/SUBCORE_FIFO.xsdbm_v3_0_0_rdfifo_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/*wr_pntr_gc_reg[*]"}] -to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD6_RD/U_RD_FIFO/SUBCORE_FIFO.xsdbm_v3_0_0_rdfifo_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/*gsync_stage[1].rd_stg_inst/Q_reg_reg[*]"}] $skew_value

set wr_clock_2          [get_clocks -of_objects [get_pins -filter {REF_PIN_NAME=~TCK} -of_objects [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/SWITCH_N_EXT_BSCAN.bscan_inst/SERIES7_BSCAN.bscan_inst*"}]]]
set wr_clk_period_2     [get_property -min PERIOD $wr_clock_2]
set rd_clk_period_2     [get_property -min PERIOD $rd_clock_2]
set skew_value_2 [expr {(($wr_clk_period_2 < $rd_clk_period_2) ? $wr_clk_period_2 : $rd_clk_period_2)} ]

# Ignore paths from the write clock to the read data registers for Asynchronous Distributed RAM based FIFO
set_false_path -from [filter [all_fanout -from [get_pins -filter {REF_PIN_NAME=~wr_clk} -of_objects [get_cells -hierarchical -filter {NAME =~ "*SUBCORE_FIFO.*wrfifo_inst"}]] -flat -endpoints_only] {IS_LEAF}] -to [get_cells -hierarchical -filter {NAME =~ *U_WR_FIFO*gdm.dm_gen.dm*/gpr1.dout_i_reg*}]

# Set max delay on cross clock domain path for Block/Distributed RAM based FIFO

set_max_delay -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD6_WR/U_WR_FIFO/SUBCORE_FIFO.xsdbm_v3_0_0_wrfifo_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/*rd_pntr_gc_reg[*]"}] -to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD6_WR/U_WR_FIFO/SUBCORE_FIFO.xsdbm_v3_0_0_wrfifo_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/*gsync_stage[1].wr_stg_inst/Q_reg_reg[*]"}] -datapath_only [get_property -min PERIOD $rd_clock_2]
set_bus_skew -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD6_WR/U_WR_FIFO/SUBCORE_FIFO.xsdbm_v3_0_0_wrfifo_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/*rd_pntr_gc_reg[*]"}] -to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD6_WR/U_WR_FIFO/SUBCORE_FIFO.xsdbm_v3_0_0_wrfifo_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/*gsync_stage[1].wr_stg_inst/Q_reg_reg[*]"}] $skew_value_2

set_max_delay -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD6_WR/U_WR_FIFO/SUBCORE_FIFO.xsdbm_v3_0_0_wrfifo_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/*wr_pntr_gc_reg[*]"}] -to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD6_WR/U_WR_FIFO/SUBCORE_FIFO.xsdbm_v3_0_0_wrfifo_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/*gsync_stage[1].rd_stg_inst/Q_reg_reg[*]"}] -datapath_only [get_property -min PERIOD $wr_clock_2]
set_bus_skew -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD6_WR/U_WR_FIFO/SUBCORE_FIFO.xsdbm_v3_0_0_wrfifo_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/*wr_pntr_gc_reg[*]"}] -to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD6_WR/U_WR_FIFO/SUBCORE_FIFO.xsdbm_v3_0_0_wrfifo_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/*gsync_stage[1].rd_stg_inst/Q_reg_reg[*]"}] $skew_value_2

##
## Timing Exceptions on TCK & UPDATE clocks
##
#TCK 2 CLK
set_false_path -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/icn_cmd_en_reg[5]"}]           	-to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/icn_cmd_en_5_temp_reg"}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD1/icn_cmd_en_temp_reg"}]      	-to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD1/ctl_reg_en_1_reg[0]"}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD2/icn_cmd_en_temp_reg"}]      	-to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD2/stat_reg_ld_reg[0]"}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD3/icn_cmd_en_temp_reg"}]      	-to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD3/stat_reg_ld_reg[0]"}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD4/icn_cmd_en_temp_reg"}]      	-to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD4/ctl_reg_en_1_reg[0]"}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD5/icn_cmd_en_temp_reg"}]      	-to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD5/ctl_reg_en_1_reg[0]"}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD7_CTL/icn_cmd_en_temp_reg"}]  	-to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD7_CTL/ctl_reg_en_1_reg[0]"}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD7_CTL/shift_reg_in_reg[*]"}]  	-to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD7_CTL/ctl_reg_reg[*]"}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD7_CTL/shift_reg_in_reg[0]"}]  	-to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD7_STAT/stat_reg_reg[0]"}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD7_STAT/icn_cmd_en_temp_reg"}]    -to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD7_STAT/stat_reg_ld_reg[0]"}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/wrdata_rst_reg"}]          		-to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD6_WR/U_WR_FIFO/SUBCORE_FIFO.xsdbm_v3_0_0_wrfifo_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.rst_rd_reg1_reg"}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/wrdata_rst_reg"}]          		-to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD6_WR/U_WR_FIFO/SUBCORE_FIFO.xsdbm_v3_0_0_wrfifo_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.rst_rd_reg2_reg"}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD4/shift_reg_in_reg[*]"}]      	-to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD4/ctl_reg_reg[*]"}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD1/shift_reg_in_reg[*]"}]      	-to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD1/ctl_reg_reg[*]"}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD5/shift_reg_in_reg[*]"}]      	-to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD5/ctl_reg_reg[*]"}]
#CLK 2 TCK
set_false_path -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD1/ctl_reg_reg[0]"}]       	-to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/ma_rst_1_reg"}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD2/stat_reg_reg[*]"}]      	-to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD2/stat_reg_1_reg[*]"}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD3/stat_reg_reg[*]"}]      	-to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD3/stat_reg_1_reg[*]"}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD7_STAT/stat_reg_reg[*]"}]     	-to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD7_STAT/stat_reg_1_reg[*]"}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/rddata_rst_reg"}]          		-to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD6_RD/U_RD_FIFO/SUBCORE_FIFO.xsdbm_v3_0_0_rdfifo_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.rst_rd_reg1_reg"}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/rddata_rst_reg"}]          		-to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD6_RD/U_RD_FIFO/SUBCORE_FIFO.xsdbm_v3_0_0_rdfifo_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.rst_rd_reg2_reg"}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/rddata_rst_reg"}]           		-to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD6_RD/shift_reg_in_reg[*]"}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD1/ctl_reg_reg[0]"}]       	-to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD4/shift_reg_in_reg[*]"}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD1/ctl_reg_reg[0]"}]       	-to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD5/shift_reg_in_reg[*]"}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD1/ctl_reg_reg[0]"}]       	-to [get_cells -hierarchical -filter {NAME =~ "*BSCANID.u_xsdbm_id/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD7_CTL/shift_reg_in_reg[*]"}]






