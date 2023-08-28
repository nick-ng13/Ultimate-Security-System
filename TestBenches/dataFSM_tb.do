onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dataFSM_tb/clk
add wave -noupdate /dataFSM_tb/start
add wave -noupdate /dataFSM_tb/noMore
add wave -noupdate /dataFSM_tb/sendDone
add wave -noupdate /dataFSM_tb/newData
add wave -noupdate /dataFSM_tb/startSend
add wave -noupdate /dataFSM_tb/wantData
add wave -noupdate /dataFSM_tb/noMoreDone
add wave -noupdate /dataFSM_tb/done
add wave -noupdate /dataFSM_tb/state
add wave -noupdate /dataFSM_tb/DUT/charCount
add wave -noupdate /dataFSM_tb/DUT/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1175 ps} 0}
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
WaveRestoreZoom {1285 ps} {2280 ps}
