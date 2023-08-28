module readFSM_tb();

    logic clk, start, reset, rxempty, done, uldrxdata;
    logic [7:0] rxdata, dataout;

    enum {init, load0, waitload0, waitsend0, finish} state;

    readFSM DUT(clk, start, reset, rxempty, done, rxdata, uldrxdata, dataout);

    initial begin
        clk = 0; #5;
        forever begin
            clk = 1; #5;
            clk = 0; #5;
        end
    end

    initial begin
        rxdata = 8'b01110100;
        rxempty = 1;
        reset = 1;
        $display("testing initial state");
        #10;
        assert(readFSM_tb.DUT.state == init);
        #10;

        $display("testing reset before start");
        reset = 0;
        #10;
        reset = 1;
        assert(readFSM_tb.DUT.state == init);
        #10;

        $display("testing load0 state");
        start = 1;
        #10;
        assert (readFSM_tb.DUT.state == load0);
        start = 0;
        #10;

        $display("testing waitload0 state");
        assert (readFSM_tb.DUT.state == waitload0);
        #10;

        $display("testing waitsend0 state");
        #10;
        assert (readFSM_tb.DUT.state == waitsend0);
        #10;

        $display("testing waitsend0 cycle");
        #10;
        assert (readFSM_tb.DUT.state == waitsend0);
        #10;

        $display("testing finish state");
        rxempty = 0;
        #10;
        wait (readFSM_tb.DUT.count == 4 && done == 1);
        #15;
        assert(readFSM_tb.DUT.state == finish);
        #10;

        $display("testing reset");
        reset = 0;
        #10;
        reset = 1;
        assert(readFSM_tb.DUT.state == init);
        #10;

        $display("testing full run");
        start = 1;
        rxempty = 0;
        #10;
        start = 0;
        $display("run time start time (%0dps)", $time);
        wait (done) $display("done at time (%0dps)", $time);
        assert (readFSM_tb.DUT.state == finish);
        #10;

        $stop;
    end

endmodule