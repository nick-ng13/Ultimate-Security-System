module controller_tb();

    logic clk, reset, start, beginFSM0, doneFSM0, beginFSM1, doneFSM1, done;
    logic [2:0] uartsel;

    enum {init, startFSM0, waitFSM0, waituart0, startFSM1, waitFSM1, waituart1, finish} state;

    controller DUT(clk, reset, start, beginFSM0, doneFSM0, beginFSM1, doneFSM1, uartsel, done);

    initial begin
        clk = 0; #5;
        forever begin
            clk = 1; #5;
            clk = 0; #5;
        end
    end

    initial begin
        reset = 1;
        $display("testing initial state");
        #10;
        assert(controller_tb.DUT.state == init);
        #10;

        $display("testing reset before start");
        reset = 0;
        #10;
        reset = 1;
        assert(controller_tb.DUT.state == init);
        #10;

        $display("testing startFSM0 state");
        start = 1;
        #10;
        start = 0;
        assert(controller_tb.DUT.state == startFSM0);
        #10;

        $display("testing reset in a state");
        reset = 0;
        #10;
        reset = 1;
        assert(controller_tb.DUT.state == init);
        #10;

        $display("testing startFSM0 state");
        start = 1;
        #10;
        start = 0;
        assert(controller_tb.DUT.state == startFSM0);
        #10;

        $display("testing waitFSM0 state");
        #10;
        assert(controller_tb.DUT.state == waitFSM0);
        #10;

        $display("testing waitFSM0 cycle");
        #10;
        assert(controller_tb.DUT.state == waitFSM0);
        #10;

        $display("testing waituart0 state");
        doneFSM0 = 1;
        #10;
        doneFSM0 = 0;
        assert(controller_tb.DUT.state == waituart0);
        #10;

        $display("testing startFSM1 state");
        #10;
        wait (controller_tb.DUT.count == 13'b1_1111_1111_1111);
        #15;
        assert(controller_tb.DUT.state == startFSM1);
        #10;

        $display("testing waitFSM1 state");
        #10;
        assert(controller_tb.DUT.state == waitFSM1);
        #10;

        $display("testing waitFSM1 cycle");
        #10;
        assert(controller_tb.DUT.state == waitFSM1);
        #10;

        $display("testing finish state");
        doneFSM1 = 1;
        #10;
        doneFSM1 = 0;
        assert(controller_tb.DUT.state == finish);
        #10;

        $stop;
    end

endmodule