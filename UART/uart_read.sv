module uart_read(
	input logic CLOCK_50,
	input logic [3:0] KEY,
	input logic rx,
	output logic tx,
   output logic [9:0] LEDR,
   input logic start,
   output logic data_out,
	output logic complete
);

    logic rx_clk, tx_clk, uldrx_data, rx_empty, done, tx_enable, rx_enable, doneFSM;
    logic [7:0] rx_data;
    logic [7:0] out;

    logic ldtx_data, tx_empty;
    logic [2:0] uart_sel;
    logic [7:0] tx_data, data0, data1;
    logic startFSM0, doneFSM0, load0;
    logic startFSM1, doneFSM1, load1;

    BaudRateGenerator baudgen2(.clk(CLOCK_50), .rxClk(rx_clk), .txClk(tx_clk));
	 
    rxtx_uart uartread(.txclk(tx_clk), .reset(KEY[0]), .ldtxdata(ldtx_data), .txdata(tx_data), .txenable(~done), .txout(tx), .txempty(tx_empty),
                    .rxclk(rx_clk), .uldrxdata(uldrx_data), .rxin(rx), .rxenable(done), .rxdata(rx_data), .rxempty(rx_empty));

    controller main(.clk(tx_clk), .reset(KEY[0]), .start(start), .beginFSM0(startFSM0), .doneFSM0(doneFSM0),
                    .beginFSM1(startFSM1), .doneFSM1(doneFSM1), .uartsel(uart_sel), .done(done));

    tableFSM buffer(.clk(tx_clk), .start(startFSM0), .txempty(tx_empty), .done(doneFSM0), .txdata(data0), .ldtxdata(load0));

    getReqFSM createget(.clk(tx_clk), .start(startFSM1), .txempty(tx_empty), .done(doneFSM1), .txdata(data1), .ldtxdata(load1));

    readFSM read(.clk(rx_clk), .start(done), .reset(KEY[0]), .rxempty(rx_empty), .done(doneFSM), .rxdata(rx_data), .uldrxdata(uldrx_data), .dataout(out));

    always @(*) begin
        case (uart_sel)
            0: begin tx_data = data0; ldtx_data = load0; end
            1: begin tx_data = data1; ldtx_data = load1; end
            default: begin tx_data = data0; ldtx_data = load0; end
        endcase
    end

//     assign LEDR[0] = out[0];
//     assign LEDR[1] = out[1];
//     assign LEDR[2] = out[2];
//     assign LEDR[3] = out[3];
//     assign LEDR[4] = out[4];
//     assign LEDR[5] = out[5];
//     assign LEDR[6] = out[6];
//     assign LEDR[7] = out[7];
//
//     assign LEDR[8] = (out == 8'b01110100);
//
//     assign LEDR[9] = (out == 8'b01100110);

	 assign complete = doneFSM;

    assign data_out = (out == 8'b01110100);

endmodule