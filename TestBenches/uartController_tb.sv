module uartController_tb();

    logic clk, reset, start, noMoreDone, beginFSM0, doneFSM0, beginFSM1, doneFSM1, beginFSM2, doneFSM2, beginFSM3, doneFSM3, beginFSM4, doneFSM4, done;
    logic [2:0] uartsel;
    logic [4:0] arraypos;

    enum {init, startFSM0, waitFSM0, waituart0, startFSM1, waitFSM1, waituart1, startFSM2, waitFSM2, startFSM3, waitFSM3, waituart3, startFSM4, waitFSM4,
          loopback, startFSM3_2, waitFSM3_2, waituart3_2, startFSM4_2, waitFSM4_2, waituart4_2, finish} state;

    uartController DUT(clk, reset, start, noMoreDone, beginFSM0, doneFSM0, beginFSM1, doneFSM1, beginFSM2, doneFSM2,
                    beginFSM3, doneFSM3, beginFSM4, doneFSM4, uartsel, arraypos, done);

    initial begin
        clk = 0; #5;
        forever begin
            clk = 1; #5;
            clk = 0; #5;
        end
    end

    initial begin
        noMoreDone = 0;
        reset = 1;
        $display("testing initial state");
        #10;
        assert(uartController_tb.DUT.state == init);
        #10;

        $display("testing reset before start");
        reset = 0;
        #10;
        reset = 1;
        assert(uartController_tb.DUT.state == init);
        #10;

        $display("testing startFSM0 state");
        start = 1;
        #10;
        start = 0;
        assert(uartController_tb.DUT.state == startFSM0);
        #10;

        $display("testing reset in a state");
        reset = 0;
        #10;
        reset = 1;
        assert(uartController_tb.DUT.state == init);
        #10;

        $display("testing startFSM0 state");
        start = 1;
        #10;
        start = 0;
        assert(uartController_tb.DUT.state == startFSM0);
        #10;

        $display("testing waitFSM0 state");
        #10;
        assert(uartController_tb.DUT.state == waitFSM0);
        #10;

        $display("testing waitFSM0 cycle");
        #10;
        assert(uartController_tb.DUT.state == waitFSM0);
        #10;

        $display("testing waituart0 state");
        doneFSM0 = 1;
        #10;
        doneFSM0 = 0;
        assert(uartController_tb.DUT.state == waituart0);
        #10;

        $display("testing startFSM1 state");
        #10;
        wait (uartController_tb.DUT.count == 13'b1_1111_1111_1111);
        #15;
        assert(uartController_tb.DUT.state == startFSM1);
        #10;

        $display("testing waitFSM1 state");
        #10;
        assert(uartController_tb.DUT.state == waitFSM1);
        #10;

        $display("testing waitFSM1 cycle");
        #10;
        assert(uartController_tb.DUT.state == waitFSM1);
        #10;

        $display("testing waituart1 state");
        doneFSM1 = 1;
        #10;
        doneFSM1 = 0;
        assert(uartController_tb.DUT.state == waituart1);
        #10;

        $display("testing startFSM2 state");
        #10;
        wait (uartController_tb.DUT.count == 13'b1_1111_1111_1111);
        #15;
        assert(uartController_tb.DUT.state == startFSM2);
        #10;

        $display("testing waitFSM2 state");
        #10;
        assert(uartController_tb.DUT.state == waitFSM2);
        #10;

        $display("testing waitFSM2 cycle");
        #10;
        assert(uartController_tb.DUT.state == waitFSM2);
        #10;

        $display("testing startFSM3 state");
        doneFSM2 = 1;
        #10;
        doneFSM2 = 0;
        assert(uartController_tb.DUT.state == startFSM3);
        #10;

        $display("testing waitFSM3 state");
        #10;
        assert(uartController_tb.DUT.state == waitFSM3);
        #10;

        $display("testing waitFSM3 cycle");
        #10;
        assert(uartController_tb.DUT.state == waitFSM3);
        #10;

        $display("testing waituart3 state");
        doneFSM3 = 1;
        #10;
        doneFSM3 = 0;
        assert(uartController_tb.DUT.state == waituart3);
        #10;

        $display("testing startFSM1 state");
        #10;
        wait (uartController_tb.DUT.count == 13'b1_1111_1111_1111);
        #15;
        assert(uartController_tb.DUT.state == startFSM1);
        #10;

        $display("testing startFSM4 state");
        doneFSM1 = 1;
        doneFSM2 = 1;
        doneFSM3 = 1;
        #10;
        wait (uartController_tb.DUT.arraypos == 5'd19 && uartController_tb.DUT.count == 13'b1_1111_1111_1111);
        #15;
        doneFSM1 = 0;
        doneFSM2 = 0;
        doneFSM3 = 0;
        assert(uartController_tb.DUT.state == startFSM4);
        #10;

        $display("testing waitFSM4 state");
        #10;
        assert(uartController_tb.DUT.state == waitFSM4);
        #10;

        $display("testing waitFSM4 cycle");
        #10;
        assert(uartController_tb.DUT.state == waitFSM4);
        #10;

        $display("testing loopback state");
        doneFSM4 = 1;
        #10;
        doneFSM4 = 0;
        assert(uartController_tb.DUT.state == loopback);
        #10;

        $display("testing startFSM1 state");
        #10;
        wait (uartController_tb.DUT.count == 13'b1_1111_1111_1111);
        #15;
        assert(uartController_tb.DUT.state == startFSM1);
        #10;

        $display("testing waitFSM1 state");
        #10;
        assert(uartController_tb.DUT.state == waitFSM1);
        #10;

        $display("testing waitFSM1 cycle");
        #10;
        assert(uartController_tb.DUT.state == waitFSM1);
        #10;

        $display("testing waituart1 state");
        doneFSM1 = 1;
        #10;
        doneFSM1 = 0;
        assert(uartController_tb.DUT.state == waituart1);
        #10;

        $display("testing startFSM2 state");
        #10;
        wait (uartController_tb.DUT.count == 13'b1_1111_1111_1111);
        #15;
        assert(uartController_tb.DUT.state == startFSM2);
        #10;

        $display("testing waitFSM2 state");
        #10;
        assert(uartController_tb.DUT.state == waitFSM2);
        #10;

        $display("testing waitFSM2 cycle");
        #10;
        assert(uartController_tb.DUT.state == waitFSM2);
        #10;

        $display("testing startFSM3_2 state");
        noMoreDone = 1;
        #10;
        noMoreDone = 0;
        assert(uartController_tb.DUT.state == startFSM3_2);
        #10;

        $display("testing waitFSM3_2 state");
        #10;
        assert(uartController_tb.DUT.state == waitFSM3_2);
        #10;

        $display("testing waitFSM3_2 cycle");
        #10;
        assert(uartController_tb.DUT.state == waitFSM3_2);
        #10;

        $display("testing waituart3_2 state");
        doneFSM3 = 1;
        #10;
        doneFSM3 = 0;
        assert(uartController_tb.DUT.state == waituart3_2);
        #10;

        $display("testing startFSM4_2 state");
        #10;
        wait (uartController_tb.DUT.count == 13'b1_1111_1111_1111);
        #15;
        assert(uartController_tb.DUT.state == startFSM4_2);
        #10;

        $display("testing waitFSM4_2 state");
        #10;
        assert(uartController_tb.DUT.state == waitFSM4_2);
        #10;

        $display("testing waitFSM4_2 cycle");
        #10;
        assert(uartController_tb.DUT.state == waitFSM4_2);
        #10;

        $display("testing waituart4_2 state");
        doneFSM4 = 1;
        #10;
        doneFSM4 = 0;
        assert(uartController_tb.DUT.state == waituart4_2);
        #10;

        $display("testing finish cycle");
        #10;
        wait (uartController_tb.DUT.count == 13'b1_1111_1111_1111);
        #15;
        assert(uartController_tb.DUT.state == finish);
        #10;

        $stop;
    end

endmodule