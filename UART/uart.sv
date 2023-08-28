/* this is based off code from https://www.asic-world.com/examples/verilog/uart.html */
module uart(
    input logic txclk,
    input logic reset,
    input logic ldtxdata,
    input logic [7:0] txdata,
    input logic txenable,
    output logic txout,
    output logic txempty
);

    logic [3:0] txcount;
    logic [7:0] txreg;

    always @(posedge txclk) begin
        if (!reset) begin
            txempty <= 0;
            txout <= 1;
            txcount <= 0;
        end else begin
            if (ldtxdata && txempty) begin // if load enable and tx bus is empty set initial state
                txreg <= txdata;
                txempty <= 0;
                txcount <= 0;
                txout <= 1;
            end
            if (txenable && !txempty) begin // if load enable and tx bus is processing
                txcount <= txcount + 4'd1;
                if (txcount == 0) begin txout <= 0; end // if count is 0 then begin data transfer
                if (txcount > 0 && txcount < 9) begin txout <= txreg[txcount - 1]; end // for the 8 bits of data transfer one by one to bus
                if (txcount == 9) begin txout <= 1; txcount <= 0; txempty <= 1; end // if count is 9 then end the transfer
            end
            if (!txenable) begin // if ~txenable, no transfer can occur
                txcount <= 0;
            end
        end
    end

endmodule
