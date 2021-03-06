# 
# Synthesis run script generated by Vivado
# 

namespace eval rt {
    variable rc
}
set rt::rc [catch {
  uplevel #0 {
    set ::env(BUILTIN_SYNTH) true
    source $::env(HRT_TCL_PATH)/rtSynthPrep.tcl
    rt::HARTNDb_resetJobStats
    rt::HARTNDb_resetSystemStats
    rt::HARTNDb_startSystemStats
    rt::HARTNDb_startJobStats
    set rt::cmdEcho 0
    rt::set_parameter writeXmsg true
    rt::set_parameter enableParallelHelperSpawn true
    set ::env(RT_TMP) "./.Xil/Vivado-23026-lt2/realtime/tmp"
    if { [ info exists ::env(RT_TMP) ] } {
      file delete -force $::env(RT_TMP)
      file mkdir $::env(RT_TMP)
    }

    rt::delete_design

    set rt::partid xc7vx485tffg1761-2
    source $::env(HRT_TCL_PATH)/rtSynthParallelPrep.tcl
     file delete -force synth_hints.os

    set rt::multiChipSynthesisFlow false
    source $::env(SYNTH_COMMON)/common_vhdl.tcl
    set rt::defaultWorkLibName xil_defaultlib

    set rt::enableVHDL2008 1
    set rt::useElabCache false
    if {$rt::useElabCache == false} {
      rt::read_verilog -sv -include {
    /home/nate/projects/duneWireTension/firmware/source/cores/ip/clk_sysclk_mmcm
    /home/nate/projects/duneWireTension/firmware/source/cores/ip/vio_ctrl/hdl/verilog
    /home/nate/projects/duneWireTension/firmware/source/cores/ip/vio_ctrl/hdl
    /home/nate/projects/duneWireTension/firmware/source/cores/ip/ila_xadc/hdl/verilog
  } -define USE_DEBUG {
      /home/nate/opt/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv
      /home/nate/opt/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv
    }
      rt::read_verilog -include {
    /home/nate/projects/duneWireTension/firmware/source/cores/ip/clk_sysclk_mmcm
    /home/nate/projects/duneWireTension/firmware/source/cores/ip/vio_ctrl/hdl/verilog
    /home/nate/projects/duneWireTension/firmware/source/cores/ip/vio_ctrl/hdl
    /home/nate/projects/duneWireTension/firmware/source/cores/ip/ila_xadc/hdl/verilog
  } -define USE_DEBUG {
      ./.Xil/Vivado-23026-lt2/realtime/clk_sysclk_mmcm_stub.v
      ./.Xil/Vivado-23026-lt2/realtime/vio_ctrl_stub.v
      ./.Xil/Vivado-23026-lt2/realtime/fifo_autoDatacollection_stub.v
      ./.Xil/Vivado-23026-lt2/realtime/fifo_adcData_stub.v
      ./.Xil/Vivado-23026-lt2/realtime/ila_xadc_stub.v
      ./.Xil/Vivado-23026-lt2/realtime/xadc_senseWire_stub.v
    }
      rt::read_vhdl -lib xpm /home/nate/opt/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd
      rt::read_vhdl -vhdl2008 -lib duneWta {
      /home/nate/projects/duneWireTension/firmware/source/hdl/wtaController.vhd
      /home/nate/projects/duneWireTension/firmware/source/hdl/top_tension_analyzer_vc707.vhd
    }
      rt::filesetChecksum
    }
    rt::set_parameter usePostFindUniquification false
    set rt::top top_tension_analyzer_vc707
    rt::set_parameter enableIncremental true
    set rt::reportTiming false
    rt::set_parameter elaborateOnly true
    rt::set_parameter elaborateRtl true
    rt::set_parameter eliminateRedundantBitOperator false
    rt::set_parameter elaborateRtlOnlyFlow false
    rt::set_parameter writeBlackboxInterface true
    rt::set_parameter merge_flipflops true
    rt::set_parameter srlDepthThreshold 3
    rt::set_parameter rstSrlDepthThreshold 4
# MODE: 
    rt::set_parameter webTalkPath {}
    rt::set_parameter enableSplitFlowPath "./.Xil/Vivado-23026-lt2/"
    set ok_to_delete_rt_tmp true 
    if { [rt::get_parameter parallelDebug] } { 
       set ok_to_delete_rt_tmp false 
    } 
    if {$rt::useElabCache == false} {
        set oldMIITMVal [rt::get_parameter maxInputIncreaseToMerge]; rt::set_parameter maxInputIncreaseToMerge 1000
        set oldCDPCRL [rt::get_parameter createDfgPartConstrRecurLimit]; rt::set_parameter createDfgPartConstrRecurLimit 1
        $rt::db readXRFFile
      rt::run_rtlelab -module $rt::top
        rt::set_parameter maxInputIncreaseToMerge $oldMIITMVal
        rt::set_parameter createDfgPartConstrRecurLimit $oldCDPCRL
    }

    set rt::flowresult [ source $::env(SYNTH_COMMON)/flow.tcl ]
    rt::HARTNDb_stopJobStats
    if { $rt::flowresult == 1 } { return -code error }


    if { [ info exists ::env(RT_TMP) ] } {
      if { [info exists ok_to_delete_rt_tmp] && $ok_to_delete_rt_tmp } { 
        file delete -force $::env(RT_TMP)
      }
    }

    source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  } ; #end uplevel
} rt::result]

if { $rt::rc } {
  $rt::db resetHdlParse
  set hsKey [rt::get_parameter helper_shm_key] 
  if { $hsKey != "" && [info exists ::env(BUILTIN_SYNTH)] && [rt::get_parameter enableParallelHelperSpawn] } { 
     $rt::db killSynthHelper $hsKey
  } 
  source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  return -code "error" $rt::result
}
