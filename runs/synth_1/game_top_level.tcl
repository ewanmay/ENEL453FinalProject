# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param xicom.use_bs_reader 1
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir {C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.cache/wt} [current_project]
set_property parent.project_path {C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.xpr} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property ip_output_repo f:/UofC2018-2019/ENEL_453/Lab3/ENEL453_LAB4_EWANMAY_ADAMHERK/ENEL453_LAB4_EWANMAY_ADAMHERK.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  {C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.srcs/sources_1/new/COUNTDOWN_TIME_MUX.vhd}
  {C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.srcs/sources_1/new/HIGHSCORE_STORE.vhd}
  {C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.srcs/sources_1/new/RANDOM_CLK.vhd}
  {C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.srcs/sources_1/new/SCORE_KEEP.vhd}
  {C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.srcs/sources_1/new/TIME_SCORE_MUX.vhd}
  {C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.srcs/sources_1/new/WIN_DISP.vhd}
  {C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.srcs/sources_1/new/background.vhd}
  {C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.srcs/sources_1/new/bouncing_box.vhd}
  {C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.srcs/sources_1/new/comparator.vhd}
  {C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.srcs/sources_1/new/debounce.vhd}
  {C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.srcs/sources_1/new/decimal_number.vhd}
  {C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.srcs/sources_1/new/digit_multiplexor.vhd}
  {C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.srcs/sources_1/new/game_clk_divider.vhd}
  {C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.srcs/sources_1/new/game_clock_divider_2.vhd}
  {C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.srcs/sources_1/new/game_downcounter.vhd}
  {C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.srcs/sources_1/new/highscore_mux.vhd}
  {C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.srcs/sources_1/new/music_box.vhd}
  {C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.srcs/sources_1/new/randomizer.vhd}
  {C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.srcs/sources_1/new/seven_segment_decoder.vhd}
  {C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.srcs/sources_1/new/seven_segment_digit_selector.vhd}
  {C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.srcs/sources_1/new/sliding_display.vhd}
  {C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.srcs/sources_1/new/sliding_mux.vhd}
  {C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.srcs/sources_1/new/sync_signal_generator.vhd}
  {C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.srcs/sources_1/new/text_unit.vhd}
  {C:/Users/Daniel/Desktop/Work/ENEL 453/top_10.vhd}
  {C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.srcs/sources_1/new/upcounter.vhd}
  {C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.srcs/sources_1/new/vga_clock_divider.vhd}
  {C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.srcs/sources_1/new/vga_downcounter.vhd}
  {C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.srcs/sources_1/new/vga_module.vhd}
  {C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.srcs/sources_1/new/word_unit.vhd}
  {C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.srcs/sources_1/new/GAME_TOP_LEVEL.vhd}
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc {{C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.srcs/constrs_1/new/LAB4.xdc}}
set_property used_in_implementation false [get_files {{C:/Users/Daniel/Desktop/Work/ENEL 453/Working_ENEL453_LAB5_EWANMAY-20181207T154006Z-001/ENEL453_LAB5_EWANMAY/ENEL453_LAB5_EWANMAY_DANIELFLOYD.srcs/constrs_1/new/LAB4.xdc}}]

set_param ips.enableIPCacheLiteLoad 0
close [open __synthesis_is_running__ w]

synth_design -top game_top_level -part xc7a35tcpg236-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef game_top_level.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file game_top_level_utilization_synth.rpt -pb game_top_level_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]