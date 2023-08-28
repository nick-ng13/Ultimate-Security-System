onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /readFSM_tb/clk
add wave -noupdate /readFSM_tb/start
add wave -noupdate /readFSM_tb/reset
add wave -noupdate /readFSM_tb/rxempty
add wave -noupdate /readFSM_tb/done
add wave -noupdate /readFSM_tb/uldrxdata
add wave -noupdate /readFSM_tb/rxdata
add wave -noupdate /readFSM_tb/dataout
add wave -noupdate /readFSM_tb/state
add wave -noupdate /readFSM_tb/DUT/count
add wave -noupdate /readFSM_tb/DUT/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {458 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1 ns}
