onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /controller_tb/clk
add wave -noupdate /controller_tb/reset
add wave -noupdate /controller_tb/start
add wave -noupdate /controller_tb/beginFSM0
add wave -noupdate /controller_tb/doneFSM0
add wave -noupdate /controller_tb/beginFSM1
add wave -noupdate /controller_tb/doneFSM1
add wave -noupdate /controller_tb/done
add wave -noupdate /controller_tb/uartsel
add wave -noupdate /controller_tb/state
add wave -noupdate /controller_tb/DUT/MAX_COUNT
add wave -noupdate /controller_tb/DUT/count
add wave -noupdate /controller_tb/DUT/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {82138 ps} 0}
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
WaveRestoreZoom {81190 ps} {82190 ps}
