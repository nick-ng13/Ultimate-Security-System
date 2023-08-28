module module2_uart(
	input logic CLOCK_50,
    input logic start,
	input logic [3:0] KEY,
    input logic [7:0] r,
    input logic [7:0] g,
    input logic [7:0] b,
	 input logic [9:0] grey,
    input logic newData,
    input logic noMore,
	input logic rx,
	output logic tx,
    output logic wantData,
    output logic done,
    output logic tx_clk
);
    // logic wires to connect modules
    logic rx_clk, /*tx_clk,*/ ldtx_data, tx_empty/*, done*/;
    logic [2:0] uart_sel;
    logic [4:0] arr_pos;
    logic [7:0] tx_data, data0, data1, data2, data3, data4;
    logic startFSM0, doneFSM0, load0;
    logic startFSM1, doneFSM1, load1;
    logic startFSM2, doneFSM2, load2;
    logic startFSM3, doneFSM3, load3;
    logic startFSM4, doneFSM4, load4;
    logic startFill, noMoreDone, sendDone/*, noMore, newData, wantData*/;
	
    BaudRateGenerator baudgen(.clk(CLOCK_50), /*.rxClk(rx_clk),*/ .txClk(tx_clk));
    uart uartsend(.txclk(tx_clk), .reset(KEY[0]), .ldtxdata(ldtx_data), .txdata(tx_data), .txenable(~done), .txout(tx), .txempty(tx_empty));

    uartController control(.clk(tx_clk), .reset(KEY[0]), .start(start), .beginFSM0(startFSM0), .doneFSM0(doneFSM0), .beginFSM1(startFSM1), .doneFSM1(doneFSM1),
                           .beginFSM2(startFSM2), .doneFSM2(doneFSM2), .beginFSM3(startFSM3), .doneFSM3(doneFSM3), .beginFSM4(startFSM4), .doneFSM4(doneFSM4),
                           .uartsel(uart_sel), .arraypos(arr_pos), .done(done), .noMoreDone(noMoreDone));

    tableFSM createt(.clk(tx_clk), .start(startFSM0), .txempty(tx_empty), .done(doneFSM0), .txdata(data0), .ldtxdata(load0));

    tableEntryFSM createtentry(.clk(tx_clk), .start(startFSM1), .txempty(tx_empty), .arraypos(arr_pos), .done(doneFSM1), .txdata(data1), .ldtxdata(load1));

    dataFSM getData(.clk(tx_clk), .start(startFSM2), .noMore(noMore), .sendDone(sendDone), .newData(newData), .startSend(startFill), .wantData(wantData), .noMoreDone(noMoreDone), .done(doneFSM2));
    fillFSM addData(.clk(tx_clk), .start(startFill), .r(r), .g(g), .b(b), .txempty(tx_empty), .done(sendDone), .txdata(data2), .ldtxdata(load2));

    postEntryFSM createend(.clk(tx_clk), .start(startFSM3), .txempty(tx_empty), .done(doneFSM3), .txdata(data3), .ldtxdata(load3));

    postReqFSM createpost(.clk(tx_clk), .start(startFSM4), .txempty(tx_empty), .done(doneFSM4), .txdata(data4), .ldtxdata(load4));
    
    // uart select controls this mux for output into uart
    always @(*) begin
        case (uart_sel)
            0: begin tx_data = data0; ldtx_data = load0; end
            1: begin tx_data = data1; ldtx_data = load1; end
            2: begin tx_data = data2; ldtx_data = load2; end
            3: begin tx_data = data3; ldtx_data = load3; end
            4: begin tx_data = data4; ldtx_data = load4; end
            default: begin tx_data = data0; ldtx_data = load0; end
        endcase
    end

endmodule
