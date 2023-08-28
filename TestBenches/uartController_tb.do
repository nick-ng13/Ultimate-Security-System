onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /uartController_tb/clk
add wave -noupdate /uartController_tb/reset
add wave -noupdate /uartController_tb/start
add wave -noupdate /uartController_tb/noMoreDone
add wave -noupdate /uartController_tb/beginFSM0
add wave -noupdate /uartController_tb/doneFSM0
add wave -noupdate /uartController_tb/beginFSM1
add wave -noupdate /uartController_tb/doneFSM1
add wave -noupdate /uartController_tb/beginFSM2
add wave -noupdate /uartController_tb/doneFSM2
add wave -noupdate /uartController_tb/beginFSM3
add wave -noupdate /uartController_tb/doneFSM3
add wave -noupdate /uartController_tb/beginFSM4
add wave -noupdate /uartController_tb/doneFSM4
add wave -noupdate /uartController_tb/done
add wave -noupdate /uartController_tb/uartsel
add wave -noupdate /uartController_tb/arraypos
add wave -noupdate /uartController_tb/state
add wave -noupdate /uartController_tb/DUT/MAX_COUNT
add wave -noupdate /uartController_tb/DUT/count
add wave -noupdate /uartController_tb/DUT/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3278470 ps} 0}
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
WaveRestoreZoom {3359430 ps} {3360430 ps}
