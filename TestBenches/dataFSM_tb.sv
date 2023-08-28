module dataFSM_tb();

    logic clk, start, noMore, sendDone, newData, startSend, wantData, noMoreDone, done;

    dataFSM DUT(clk, start, noMore, sendDone, newData, startSend, wantData, noMoreDone, done);

    enum {idle, ask, send, waitsend, full, nodata} state;

    initial begin
        clk = 0; #5;
        forever begin
            clk = 1; #5;
            clk = 0; #5;
        end
    end

    initial begin
        noMore = 0;
        sendDone = 0;
        newData = 0;
        $display("testing initial state");
        #10;
        assert (dataFSM_tb.DUT.state == idle);
        #10;

        $display("testing ask state");
        start = 1;
        #10;
        assert (dataFSM_tb.DUT.state == ask);
        start = 0;
        #10;

        $display("testing ask cycle");
        #10;
        assert (dataFSM_tb.DUT.state == ask);
        #10;

        $display("testing noMore state");
        noMore = 1;
        #10;
        assert (dataFSM_tb.DUT.state == nodata);
        noMore = 0;
        #10;

        $display("testing back to initial state");
        #10;
        assert (dataFSM_tb.DUT.state == idle);
        #10;

        $display("testing start agian");
        start = 1;
        #10;
        assert (dataFSM_tb.DUT.state == ask);
        start = 0;
        #10;

        $display("testing send state");
        newData = 1;
        #10;
        assert (dataFSM_tb.DUT.state == send);
        #10;

        $display("testing waitsend state");
        #10;
        assert (dataFSM_tb.DUT.state == waitsend);
        #10;

        $display("testing waitsend cycle");
        #10;
        assert (dataFSM_tb.DUT.state == waitsend);
        #10;

        $display("testing ask loopback");
        sendDone = 1;
        #10;
        assert (dataFSM_tb.DUT.state == ask);
        #10;

        $display("testing full state");
        #10;
        wait (dataFSM_tb.DUT.charCount == 8'd198);
        #15;
        assert (dataFSM_tb.DUT.state == full);
        #10;

        $display("testing back to initial state");
        newData = 0;
        #10;
        assert (dataFSM_tb.DUT.state == idle);
        #10;

        $display("testing full run with noMore");
        start = 1;
        noMore = 1;
        #10;
        start = 0;
        $display("run time start time (%0dps)", $time);
        wait (noMoreDone) $display("done at time (%0dps)", $time);
        assert (dataFSM_tb.DUT.state == nodata);
        #15;

        $display("testing full run with newData");
        noMore = 0;
        start = 1;
        newData = 1;
        sendDone = 1;
        #10;
        start = 0;
        $display("run time start time (%0dps)", $time);
        wait (done) $display("done at time (%0dps)", $time);
        assert (dataFSM_tb.DUT.state == full);
        #10;

        $stop;
    end

endmodule