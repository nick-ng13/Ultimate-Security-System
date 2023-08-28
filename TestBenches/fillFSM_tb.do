onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fillFSM_tb/clk
add wave -noupdate /fillFSM_tb/start
add wave -noupdate /fillFSM_tb/txempty
add wave -noupdate /fillFSM_tb/done
add wave -noupdate /fillFSM_tb/ldtxdata
add wave -noupdate /fillFSM_tb/r
add wave -noupdate /fillFSM_tb/g
add wave -noupdate /fillFSM_tb/b
add wave -noupdate /fillFSM_tb/txdata
add wave -noupdate /fillFSM_tb/state
add wave -noupdate /fillFSM_tb/DUT/rHigh
add wave -noupdate /fillFSM_tb/DUT/rLow
add wave -noupdate /fillFSM_tb/DUT/gHigh
add wave -noupdate /fillFSM_tb/DUT/gLow
add wave -noupdate /fillFSM_tb/DUT/bHigh
add wave -noupdate /fillFSM_tb/DUT/bLow
add wave -noupdate /fillFSM_tb/DUT/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {220 ps} 0}
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
