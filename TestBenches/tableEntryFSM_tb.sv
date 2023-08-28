module tableEntryFSM_tb();

    logic clk, start, txempty, done, ldtxdata;
    logic [4:0] arraypos;
    logic [7:0] txdata;

    enum {init, load0, waitload0, waitsend0, load1, waitload1, waitsend1, load2, waitload2, waitsend2, load3, waitload3, waitsend3,
          load4, waitload4, waitsend4, load5, waitload5, waitsend5, load6, waitload6, waitsend6, finish} state;

    tableEntryFSM DUT(clk, start, txempty, arraypos, done, txdata, ldtxdata);

    initial begin
        clk = 0; #5;
        forever begin
            clk = 1; #5;
            clk = 0; #5;
        end
    end

    initial begin
        txempty = 0;
        arraypos = 1;
        $display("testing initial state");
        #10;
        assert (tableEntryFSM_tb.DUT.state == init);
        #10;
        
        $display("testing load0 state");
        start = 1;
        #10;
        assert (tableEntryFSM_tb.DUT.state == load0);
        start = 0;
        #10;

        $display("testing waitload0 state");
        assert (tableEntryFSM_tb.DUT.state == waitload0);
        #10;

        $display("testing waitsend0 state");
        #10;
        assert (tableEntryFSM_tb.DUT.state == waitsend0);
        #10;

        $display("testing waitsend0 cycle");
        #10;
        assert (tableEntryFSM_tb.DUT.state == waitsend0);
        #10;

        $display("testing load1 state");
        txempty = 1;
        #10;
        assert (tableEntryFSM_tb.DUT.state == load1);
        txempty = 0;
        #10;

        $display("testing waitload1 state");
        assert (tableEntryFSM_tb.DUT.state == waitload1);
        #10;

        $display("testing waitsend1 state");
        #10;
        assert (tableEntryFSM_tb.DUT.state == waitsend1);
        #10;

        $display("testing waitsend1 cycle");
        #10;
        assert (tableEntryFSM_tb.DUT.state == waitsend1);
        #10;

        $display("testing load2 state");
        txempty = 1;
        #10;
        assert (tableEntryFSM_tb.DUT.state == load2);
        txempty = 0;
        #10;

        $display("testing waitload2 state");
        assert (tableEntryFSM_tb.DUT.state == waitload2);
        #10;

        $display("testing waitsend2 state");
        #10;
        assert (tableEntryFSM_tb.DUT.state == waitsend2);
        #10;

        $display("testing waitsend2 cycle");
        #10;
        assert (tableEntryFSM_tb.DUT.state == waitsend2);
        #10;

        $display("testing load3 state");
        txempty = 1;
        #10;
        assert (tableEntryFSM_tb.DUT.state == load3);
        txempty = 0;
        #10;

        $display("testing waitload3 state");
        assert (tableEntryFSM_tb.DUT.state == waitload3);
        #10;

        $display("testing waitsend3 state");
        #10;
        assert (tableEntryFSM_tb.DUT.state == waitsend3);
        #10;

        $display("testing waitsend3 cycle");
        #10;
        assert (tableEntryFSM_tb.DUT.state == waitsend3);
        #10;

        $display("testing load4 state");
        txempty = 1;
        #10;
        assert (tableEntryFSM_tb.DUT.state == load4);
        txempty = 0;
        #10;

        $display("testing waitload4 state");
        assert (tableEntryFSM_tb.DUT.state == waitload4);
        #10;

        $display("testing waitsend4 state");
        #10;
        assert (tableEntryFSM_tb.DUT.state == waitsend4);
        #10;

        $display("testing waitsend4 cycle");
        #10;
        assert (tableEntryFSM_tb.DUT.state == waitsend4);
        #10;

        $display("testing load5 state");
        txempty = 1;
        #10;
        assert (tableEntryFSM_tb.DUT.state == load5);
        txempty = 0;
        #10;

        $display("testing waitload5 state");
        assert (tableEntryFSM_tb.DUT.state == waitload5);
        #10;

        $display("testing waitsend5 state");
        #10;
        assert (tableEntryFSM_tb.DUT.state == waitsend5);
        #10;

        $display("testing waitsend5 cycle");
        #10;
        assert (tableEntryFSM_tb.DUT.state == waitsend5);
        #10;

        $display("testing load6 state");
        txempty = 1;
        #10;
        assert (tableEntryFSM_tb.DUT.state == load6);
        txempty = 0;
        #10;

        $display("testing waitload6 state");
        assert (tableEntryFSM_tb.DUT.state == waitload6);
        #10;

        $display("testing waitsend6 state");
        #10;
        assert (tableEntryFSM_tb.DUT.state == waitsend6);
        #10;

        $display("testing waitsend6 cycle");
        #10;
        assert (tableEntryFSM_tb.DUT.state == waitsend6);
        #10;

        $display("testing finish state");
        txempty = 1;
        #10;
        assert (tableEntryFSM_tb.DUT.state == finish);
        txempty = 0;
        #10;

        $display("testing full run");
        start = 1;
        txempty = 1;
        #10;
        start = 0;
        $display("run time start time (%0dps)", $time);
        wait (done) $display("done at time (%0dps)", $time);
        assert (tableEntryFSM_tb.DUT.state == init);
        #10;

        $stop;
    end

endmodule