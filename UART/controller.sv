module controller(
    input logic clk,
    input logic reset,
    input logic start,
    output logic beginFSM0,
    input logic doneFSM0,
    output logic beginFSM1,
    input logic doneFSM1,
    output logic [2:0] uartsel,
    output logic done
);

    logic [12:0] MAX_COUNT = 13'b1_1111_1111_1111;
    logic [12:0] count;

    enum {init, startFSM0, waitFSM0, waituart0, startFSM1, waitFSM1, waituart1, finish} state;

    always @(posedge clk) begin
        if (!reset) begin
            state <= init;
            done <= 0;
        end else begin
            case (state)
                init: begin if (start) begin state <= startFSM0; done <= 0; end
                            else begin state <= init; done <= 0; end end
                startFSM0: begin state <= waitFSM0; done <= 0; end
                waitFSM0: begin done <= 0;
                                if (doneFSM0) begin state <= waituart0; end
                                else begin state <= waitFSM0; end end
                waituart0: begin done <= 0;
                                 if (count == MAX_COUNT) begin state <= startFSM1; end
                                 else begin state <= waituart0; end end
                startFSM1: begin state <= waitFSM1; done <= 0; end
                waitFSM1: begin done <= 0;
                                if (doneFSM1) begin state <= finish; end
                                else begin state <= waitFSM1; end end
                finish: begin state <= finish; done <= 1; end
                default: begin state <= init; done <= 0; end
            endcase
        end
    end

    always @(*) begin
        case (state)
            init: begin uartsel = 0; beginFSM0 = 0; beginFSM1 = 0; end
            startFSM0: begin uartsel = 0; beginFSM0 = 1; beginFSM1 = 0; end
            waitFSM0: begin uartsel = 0; beginFSM0 = 0; beginFSM1 = 0; end
            startFSM1: begin uartsel = 1; beginFSM0 = 1; beginFSM1 = 1; end
            waitFSM1: begin uartsel = 1; beginFSM0 = 0; beginFSM1 = 0; end
            finish: begin uartsel = 0; beginFSM0 = 0; beginFSM1 = 0; end
            default: begin uartsel = 0; beginFSM0 = 0; beginFSM1 = 0; end
        endcase
    end

    always_ff@(posedge clk) begin
        case(state)
        waituart0: count <= count + 13'd1;
        default: count <= 13'b0;
        endcase
    end

endmodule