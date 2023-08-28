onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /getReqFSM_tb/clk
add wave -noupdate /getReqFSM_tb/start
add wave -noupdate /getReqFSM_tb/txempty
add wave -noupdate /getReqFSM_tb/done
add wave -noupdate /getReqFSM_tb/ldtxdata
add wave -noupdate /getReqFSM_tb/txdata
add wave -noupdate /getReqFSM_tb/state
add wave -noupdate /getReqFSM_tb/DUT/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {1015 ps} {2013 ps}
