/* this is based off code from https://www.asic-world.com/examples/verilog/uart.html */
module rxtx_uart(
    input logic txclk,
    input logic reset,
    input logic ldtxdata,
    input logic [7:0] txdata,
    input logic txenable,
    output logic txout,
    output logic txempty,
    input logic rxclk,
    input logic uldrxdata,
    input logic rxin,
    input logic rxenable,
    output logic [7:0] rxdata,
    output logic rxempty
);

    logic rxd1, rxd2, rxbusy;
    logic [3:0] rxcount, rxsamplecount;
    logic [7:0] rxreg;
    logic [3:0] txcount;
    logic [7:0] txreg;

    always @(posedge rxclk) begin
        if (!reset) begin
            rxreg <= 0;
            rxdata <= 0;
            rxsamplecount <= 0;
            rxempty <= 1;
            rxcount <= 0;
            rxd1 <= 1;
            rxd2 <= 1;
            rxbusy <= 0;
        end else begin
            rxd1 <= rxin;
            rxd2 <= rxd1;
            if (uldrxdata) begin
                rxdata <= rxreg;
                rxempty <= 1;
            end
            if (rxenable) begin
                if (!rxbusy && !rxd2) begin
                    rxbusy <= 1;
                    rxsamplecount <= 1;
                    rxcount <= 0;
                end
                if (rxbusy) begin
                    rxsamplecount <= rxsamplecount + 4'd1;
                    if (rxsamplecount == 7) begin
                        if (rxd2 && rxcount == 0) begin
                            rxbusy <= 0;
                        end else begin
                            rxcount <= rxcount + 4'd1;
                            if (rxcount > 0 && rxcount < 9) begin rxreg[rxcount - 1] <= rxd2; end
                            if (rxcount == 9) begin rxbusy <= 0;
                                if (rxd2) begin rxempty <= 0; end
                            end
                        end
                    end
                end
            end
            if (!rxenable) begin
                rxbusy <= 0;
            end
        end
    end

    always @(posedge txclk) begin
        if (!reset) begin
            txreg <= 0;
            txempty <= 1;
            txout <= 1;
            txcount <= 0;
        end else begin
            if (ldtxdata && txempty) begin
                txreg <= txdata;
                txempty <= 0;
                txcount <= 0;
                txout <= 1;
            end
            if (txenable && !txempty) begin
                txcount <= txcount + 4'd1;
                if (txcount == 0) begin txout <= 0; end
                if (txcount > 0 && txcount < 9) begin txout <= txreg[txcount - 1]; end
                if (txcount == 9) begin txout <= 1; txcount <= 0; txempty <= 1; end
            end
            if (!txenable) begin
                txcount <= 0;
            end
        end
    end

endmodule
