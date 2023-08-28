module uartController(
    input logic clk,
    input logic reset,
    input logic start,
    input logic noMoreDone,
    output logic beginFSM0,
    input logic doneFSM0,
    output logic beginFSM1,
    input logic doneFSM1,
    output logic beginFSM2,
    input logic doneFSM2,
    output logic beginFSM3,
    input logic doneFSM3,
    output logic beginFSM4,
    input logic doneFSM4,
    output logic [2:0] uartsel,
    output logic [4:0] arraypos,
    output logic done
);

    logic [12:0] MAX_COUNT = 13'b1_1111_1111_1111;
    logic [12:0] count;

    enum {init, startFSM0, waitFSM0, waituart0, startFSM1, waitFSM1, waituart1, startFSM2, waitFSM2, startFSM3, waitFSM3, waituart3, startFSM4, waitFSM4,
          loopback, startFSM3_2, waitFSM3_2, waituart3_2, startFSM4_2, waitFSM4_2, waituart4_2, finish} state;

    always @(posedge clk) begin
        if (!reset) begin
            state <= init;
            arraypos <= 1;
            done <= 0;
        end else begin
            case (state)
                init: begin if (start) begin state <= startFSM0; arraypos <= 1; done <= 0; end // start when signal goes high
                            else begin state <= init; arraypos <= 1; done <= 0; end end        // else stay idle
                startFSM0: begin state <= waitFSM0;  arraypos <= arraypos; done <= 0; end
                waitFSM0: begin arraypos <= arraypos; done <= 0;
                                if (doneFSM0) begin state <= waituart0; end 
                                else begin state <= waitFSM0; end end
                waituart0: begin arraypos <= arraypos; done <= 0;
                                 if (count == MAX_COUNT) begin state <= startFSM1; end  // wait uart state to ensure wifi chip executes command
                                 else begin state <= waituart0; end end
                startFSM1: begin state <= waitFSM1; arraypos <= arraypos; done <= 0; end // starts tableEntryFSM
                waitFSM1: begin arraypos <= arraypos;
                                if (doneFSM1) begin state <= waituart1; done <= 0; end
                                else begin state <= waitFSM1; done <= 0; end end
                waituart1: begin arraypos <= arraypos; done <= 0;
                                 if (count == MAX_COUNT) begin state <= startFSM2; end
                                 else begin state <= waituart1; end end
                startFSM2: begin state <= waitFSM2; arraypos <= arraypos; done <= 0; end // starts dataFSM
                waitFSM2: begin if (noMoreDone) begin state <= startFSM3_2; arraypos <= arraypos; done <= 0; end // if not more data, exit and send last request
                                else if (doneFSM2) begin state <= startFSM3; arraypos <= arraypos+5'd1; done <= 0; end // increment arraypos to keep track of post limit
                                else begin state <= waitFSM2; arraypos <= arraypos; done <= 0; end end
                startFSM3: begin state <= waitFSM3; arraypos <= arraypos; done <= 0; end // starts postEntryFSM
                waitFSM3: begin arraypos <= arraypos;
                                if (doneFSM3) begin state <= waituart3; done <= 0; end
                                else begin state <= waitFSM3; done <= 0; end end
                waituart3: begin if (count == MAX_COUNT) begin
                                if (arraypos == 5'd19) begin state <= startFSM4; end // if reach max string count for post limit, exit
                                     else begin state <= startFSM1; end              // otherwise load another table variable
                                 end else begin state <= waituart3; end end
                startFSM4: begin state <= waitFSM4; arraypos <= 1; done <= 0; end    // starts postReqFSM
                waitFSM4: begin arraypos <= arraypos;                               // loops back to beginning to fill table again
                                if (doneFSM4) begin state <= loopback; done <= 0; end
                                else begin state <= waitFSM4; done <= 0; end end
                loopback: begin arraypos <= arraypos; done <= 0;
                                if (count == MAX_COUNT) begin state <= startFSM1; end
                                else begin state <= loopback; end end

                startFSM3_2: begin state <= waitFSM3_2; arraypos <= arraypos; done <= 0; end // starts postEntryFSM after there is no more data
                waitFSM3_2: begin arraypos <= arraypos;
                                  if (doneFSM3) begin state <= waituart3_2; done <= 0; end
                                  else begin state <= waitFSM3_2; done <= 0; end end
                waituart3_2: begin arraypos <= arraypos; done <= 0;
                                   if (count == MAX_COUNT) begin state <= startFSM4_2; end
                                   else begin state <= waituart3_2; end end

                startFSM4_2: begin state <= waitFSM4_2; arraypos <= 1; done <= 0; end // starts postReqFSM for last time
                waitFSM4_2: begin arraypos <= arraypos;
                                if (doneFSM4) begin state <= waituart4_2; done <= 0; end
                                else begin state <= waitFSM4_2; done <= 0; end end
                waituart4_2: begin arraypos <= arraypos; done <= 0;
                                if (count == MAX_COUNT) begin state <= finish; end
                                else begin state <= waituart4_2; end end

                finish: begin state <= finish; arraypos <= arraypos; done <= 1; end
                default: begin state <= init; arraypos <= 1; done <= 0; end
            endcase
        end
    end

    // combinational logic block to control uart input bus as well as when to start each FSM
    always @(*) begin
        case (state)
            init: begin uartsel = 0; beginFSM0 = 0; beginFSM1 = 0; beginFSM2 = 0; beginFSM3 = 0; beginFSM4 = 0; end
            startFSM0: begin uartsel = 0; beginFSM0 = 1; beginFSM1 = 0; beginFSM2 = 0; beginFSM3 = 0; beginFSM4 = 0; end
            waitFSM0: begin uartsel = 0; beginFSM0 = 0; beginFSM1 = 0; beginFSM2 = 0; beginFSM3 = 0; beginFSM4 = 0; end
            startFSM1: begin uartsel = 1; beginFSM0 = 0; beginFSM1 = 1; beginFSM2 = 0; beginFSM3 = 0; beginFSM4 = 0; end
            waitFSM1: begin uartsel = 1; beginFSM0 = 0; beginFSM1 = 0; beginFSM2 = 0; beginFSM3 = 0; beginFSM4 = 0; end
            startFSM2: begin uartsel = 2; beginFSM0 = 0; beginFSM1 = 0; beginFSM2 = 1; beginFSM3 = 0; beginFSM4 = 0; end
            waitFSM2: begin uartsel = 2; beginFSM0 = 0; beginFSM1 = 0; beginFSM2 = 0; beginFSM3 = 0; beginFSM4 = 0; end
            startFSM3: begin uartsel = 3; beginFSM0 = 0; beginFSM1 = 0; beginFSM2 = 0; beginFSM3 = 1; beginFSM4 = 0; end
            waitFSM3: begin uartsel = 3; beginFSM0 = 0; beginFSM1 = 0; beginFSM2 = 0; beginFSM3 = 0; beginFSM4 = 0; end
            startFSM4: begin uartsel = 4; beginFSM0 = 0; beginFSM1 = 0; beginFSM2 = 0; beginFSM3 = 0; beginFSM4 = 1; end
            waitFSM4: begin uartsel = 4; beginFSM0 = 0; beginFSM1 = 0; beginFSM2 = 0; beginFSM3 = 0; beginFSM4 = 0; end
            startFSM3_2: begin uartsel = 3; beginFSM0 = 0; beginFSM1 = 0; beginFSM2 = 0; beginFSM3 = 1; beginFSM4 = 0; end
            waitFSM3_2: begin uartsel = 3; beginFSM0 = 0; beginFSM1 = 0; beginFSM2 = 0; beginFSM3 = 0; beginFSM4 = 0; end
            startFSM4_2: begin uartsel = 4; beginFSM0 = 0; beginFSM1 = 0; beginFSM2 = 0; beginFSM3 = 0; beginFSM4 = 1; end
            waitFSM4_2: begin uartsel = 4; beginFSM0 = 0; beginFSM1 = 0; beginFSM2 = 0; beginFSM3 = 0; beginFSM4 = 0; end
            finish: begin uartsel = 0; beginFSM0 = 0; beginFSM1 = 0; beginFSM2 = 0; beginFSM3 = 0; beginFSM4 = 0; end
            default: begin uartsel = 0; beginFSM0 = 0; beginFSM1 = 0; beginFSM2 = 0; beginFSM3 = 0; beginFSM4 = 0; end
        endcase
    end

    // count incrementer for when in waituart states
    always_ff@(posedge clk) begin
        case(state)
        waituart0: count <= count + 13'd1;
        waituart1: count <= count + 13'd1;
        waituart3: count <= count + 13'd1;
        loopback: count <= count + 13'd1;
        waituart3_2: count <= count + 13'd1;
        waituart4_2: count <= count + 13'd1;
        default: count <= 13'b0;
        endcase
    end

endmodule
