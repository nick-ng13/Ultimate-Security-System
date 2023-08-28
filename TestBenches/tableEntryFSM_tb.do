onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tableEntryFSM_tb/clk
add wave -noupdate /tableEntryFSM_tb/start
add wave -noupdate /tableEntryFSM_tb/txempty
add wave -noupdate /tableEntryFSM_tb/done
add wave -noupdate /tableEntryFSM_tb/ldtxdata
add wave -noupdate /tableEntryFSM_tb/arraypos
add wave -noupdate /tableEntryFSM_tb/txdata
add wave -noupdate /tableEntryFSM_tb/state
add wave -noupdate /tableEntryFSM_tb/DUT/firstnum
add wave -noupdate /tableEntryFSM_tb/DUT/secondnum
add wave -noupdate /tableEntryFSM_tb/DUT/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 147
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
WaveRestoreZoom {0 ps} {1004 ps}
