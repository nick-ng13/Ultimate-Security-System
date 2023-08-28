onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tableFSM_tb/clk
add wave -noupdate /tableFSM_tb/start
add wave -noupdate /tableFSM_tb/txempty
add wave -noupdate /tableFSM_tb/done
add wave -noupdate /tableFSM_tb/ldtxdata
add wave -noupdate /tableFSM_tb/txdata
add wave -noupdate /tableFSM_tb/state
add wave -noupdate /tableFSM_tb/DUT/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {50 ps} 0}
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
WaveRestoreZoom {0 ps} {632 ps}
