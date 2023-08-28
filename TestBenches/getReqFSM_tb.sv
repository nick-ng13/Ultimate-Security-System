module getReqFSM_tb();

    logic clk, start, txempty, done, ldtxdata;
    logic [7:0] txdata;

    enum {init, load0, waitload0, waitsend0, load1, waitload1, waitsend1, load2, waitload2, waitsend2, load3, waitload3, waitsend3,
          load4, waitload4, waitsend4, load5, waitload5, waitsend5, load6, waitload6, waitsend6,
          load7, waitload7, waitsend7, load8, waitload8, waitsend8, load9, waitload9, waitsend9,
          load10, waitload10, waitsend10, load11, waitload11, waitsend11, load12, waitload12, waitsend12,
          load13, waitload13, waitsend13, load14, waitload14, waitsend14, load15, waitload15, waitsend15,
          load16, waitload16, waitsend16, load17, waitload17, waitsend17, load18, waitload18, waitsend18, finish} state;

    getReqFSM DUT(clk, start, txempty, done, txdata, ldtxdata);

    initial begin
        clk = 0; #5;
        forever begin
            clk = 1; #5;
            clk = 0; #5;
        end
    end

    initial begin
        txempty = 0;
        $display("testing initial state");
        #10;
        assert (getReqFSM_tb.DUT.state == init);
        #10;
        
        $display("testing load0 state");
        start = 1;
        #10;
        assert (getReqFSM_tb.DUT.state == load0);
        start = 0;
        #10;

        $display("testing waitload0 state");
        assert (getReqFSM_tb.DUT.state == waitload0);
        #10;

        $display("testing waitsend0 state");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend0);
        #10;

        $display("testing waitsend0 cycle");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend0);
        #10;

        $display("testing load1 state");
        txempty = 1;
        #10;
        assert (getReqFSM_tb.DUT.state == load1);
        txempty = 0;
        #10;

        $display("testing waitload1 state");
        assert (getReqFSM_tb.DUT.state == waitload1);
        #10;

        $display("testing waitsend1 state");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend1);
        #10;

        $display("testing waitsend1 cycle");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend1);
        #10;

        $display("testing load2 state");
        txempty = 1;
        #10;
        assert (getReqFSM_tb.DUT.state == load2);
        txempty = 0;
        #10;

        $display("testing waitload2 state");
        assert (getReqFSM_tb.DUT.state == waitload2);
        #10;

        $display("testing waitsend2 state");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend2);
        #10;

        $display("testing waitsend2 cycle");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend2);
        #10;

        $display("testing load3 state");
        txempty = 1;
        #10;
        assert (getReqFSM_tb.DUT.state == load3);
        txempty = 0;
        #10;

        $display("testing waitload3 state");
        assert (getReqFSM_tb.DUT.state == waitload3);
        #10;

        $display("testing waitsend3 state");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend3);
        #10;

        $display("testing waitsend3 cycle");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend3);
        #10;

        $display("testing load4 state");
        txempty = 1;
        #10;
        assert (getReqFSM_tb.DUT.state == load4);
        txempty = 0;
        #10;

        $display("testing waitload4 state");
        assert (getReqFSM_tb.DUT.state == waitload4);
        #10;

        $display("testing waitsend4 state");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend4);
        #10;

        $display("testing waitsend4 cycle");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend4);
        #10;

        $display("testing load5 state");
        txempty = 1;
        #10;
        assert (getReqFSM_tb.DUT.state == load5);
        txempty = 0;
        #10;

        $display("testing waitload5 state");
        assert (getReqFSM_tb.DUT.state == waitload5);
        #10;

        $display("testing waitsend5 state");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend5);
        #10;

        $display("testing waitsend5 cycle");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend5);
        #10;

        $display("testing load6 state");
        txempty = 1;
        #10;
        assert (getReqFSM_tb.DUT.state == load6);
        txempty = 0;
        #10;

        $display("testing waitload6 state");
        assert (getReqFSM_tb.DUT.state == waitload6);
        #10;

        $display("testing waitsend6 state");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend6);
        #10;

        $display("testing waitsend6 cycle");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend6);
        #10;

        $display("testing load7 state");
        txempty = 1;
        #10;
        assert (getReqFSM_tb.DUT.state == load7);
        txempty = 0;
        #10;

        $display("testing waitload7 state");
        assert (getReqFSM_tb.DUT.state == waitload7);
        #10;

        $display("testing waitsend7 state");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend7);
        #10;

        $display("testing waitsend7 cycle");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend7);
        #10;

        $display("testing load8 state");
        txempty = 1;
        #10;
        assert (getReqFSM_tb.DUT.state == load8);
        txempty = 0;
        #10;

        $display("testing waitload8 state");
        assert (getReqFSM_tb.DUT.state == waitload8);
        #10;

        $display("testing waitsend8 state");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend8);
        #10;

        $display("testing waitsend8 cycle");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend8);
        #10;

        $display("testing load9 state");
        txempty = 1;
        #10;
        assert (getReqFSM_tb.DUT.state == load9);
        txempty = 0;
        #10;

        $display("testing waitload9 state");
        assert (getReqFSM_tb.DUT.state == waitload9);
        #10;

        $display("testing waitsend9 state");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend9);
        #10;

        $display("testing waitsend9 cycle");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend9);
        #10;

        $display("testing load10 state");
        txempty = 1;
        #10;
        assert (getReqFSM_tb.DUT.state == load10);
        txempty = 0;
        #10;

        $display("testing waitload10 state");
        assert (getReqFSM_tb.DUT.state == waitload10);
        #10;

        $display("testing waitsend10 state");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend10);
        #10;

        $display("testing waitsend10 cycle");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend10);
        #10;

        $display("testing load11 state");
        txempty = 1;
        #10;
        assert (getReqFSM_tb.DUT.state == load11);
        txempty = 0;
        #10;

        $display("testing waitload11 state");
        assert (getReqFSM_tb.DUT.state == waitload11);
        #10;

        $display("testing waitsend11 state");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend11);
        #10;

        $display("testing waitsend11 cycle");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend11);
        #10;

        $display("testing load12 state");
        txempty = 1;
        #10;
        assert (getReqFSM_tb.DUT.state == load12);
        txempty = 0;
        #10;

        $display("testing waitload12 state");
        assert (getReqFSM_tb.DUT.state == waitload12);
        #10;

        $display("testing waitsend12 state");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend12);
        #10;

        $display("testing waitsend12 cycle");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend12);
        #10;

        $display("testing load13 state");
        txempty = 1;
        #10;
        assert (getReqFSM_tb.DUT.state == load13);
        txempty = 0;
        #10;

        $display("testing waitload13 state");
        assert (getReqFSM_tb.DUT.state == waitload13);
        #10;

        $display("testing waitsend13 state");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend13);
        #10;

        $display("testing waitsend13 cycle");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend13);
        #10;

        $display("testing load14 state");
        txempty = 1;
        #10;
        assert (getReqFSM_tb.DUT.state == load14);
        txempty = 0;
        #10;

        $display("testing waitload14 state");
        assert (getReqFSM_tb.DUT.state == waitload14);
        #10;

        $display("testing waitsend14 state");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend14);
        #10;

        $display("testing waitsend14 cycle");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend14);
        #10;

        $display("testing load15 state");
        txempty = 1;
        #10;
        assert (getReqFSM_tb.DUT.state == load15);
        txempty = 0;
        #10;

        $display("testing waitload15 state");
        assert (getReqFSM_tb.DUT.state == waitload15);
        #10;

        $display("testing waitsend15 state");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend15);
        #10;

        $display("testing waitsend15 cycle");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend15);
        #10;

        $display("testing load16 state");
        txempty = 1;
        #10;
        assert (getReqFSM_tb.DUT.state == load16);
        txempty = 0;
        #10;

        $display("testing waitload16 state");
        assert (getReqFSM_tb.DUT.state == waitload16);
        #10;

        $display("testing waitsend16 state");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend16);
        #10;

        $display("testing waitsend16 cycle");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend16);
        #10;

        $display("testing load17 state");
        txempty = 1;
        #10;
        assert (getReqFSM_tb.DUT.state == load17);
        txempty = 0;
        #10;

        $display("testing waitload17 state");
        assert (getReqFSM_tb.DUT.state == waitload17);
        #10;

        $display("testing waitsend17 state");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend17);
        #10;

        $display("testing waitsend17 cycle");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend17);
        #10;

        $display("testing load18 state");
        txempty = 1;
        #10;
        assert (getReqFSM_tb.DUT.state == load18);
        txempty = 0;
        #10;

        $display("testing waitload18 state");
        assert (getReqFSM_tb.DUT.state == waitload18);
        #10;

        $display("testing waitsend18 state");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend18);
        #10;

        $display("testing waitsend18 cycle");
        #10;
        assert (getReqFSM_tb.DUT.state == waitsend18);
        #10;

        $display("testing finish state");
        txempty = 1;
        #10;
        assert (getReqFSM_tb.DUT.state == finish);
        txempty = 0;
        #10;

        $display("testing full run");
        start = 1;
        txempty = 1;
        #10;
        start = 0;
        $display("run time start time (%0dps)", $time);
        wait (done) $display("done at time (%0dps)", $time);
        assert (getReqFSM_tb.DUT.state == init);
        #10;

        $stop;
    end

endmodule