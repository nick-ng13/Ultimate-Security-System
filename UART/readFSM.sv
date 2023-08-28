module readFSM(
    input logic clk,
    input logic start,
    input logic reset,
    input logic rxempty,
    output logic done,
    input logic [7:0] rxdata,
    output logic uldrxdata,
    output logic [7:0] dataout
);

    logic [3:0] count;

    enum {init, load0, waitload0, waitsend0, finish} state;

    always @(posedge clk) begin
        if (~reset) begin
            state <= init;
            dataout <= 0;
            uldrxdata <= 0;
            done <= 0;
            count <= 0;
        end else begin
            case (state)
                init: begin if (start) begin state <= load0; dataout <= 0; uldrxdata <= 0; done <= 0; end
                            else begin state <= init; dataout <= dataout; uldrxdata <= 0; done <= 0; end end

                load0: begin state <= waitload0; dataout <= dataout; uldrxdata <= 1; done <= 0; end

                waitload0: begin state <= waitsend0; dataout <= dataout; uldrxdata <= 0; done <= 0; end

                waitsend0: begin if (~rxempty && count == 4) begin state <= finish; dataout <= rxdata; uldrxdata <= 0; done <= 0; end
                                else if (~rxempty) begin state <= load0; dataout <= dataout; uldrxdata <= 0; done <= 0; count <= count + 4'd1; end
                                else begin state <= waitsend0; dataout <= 0; uldrxdata <= 0; done <= 0; end end

                finish: begin state <= finish; dataout <= dataout; uldrxdata <= 0; done <= 1; end

                default: begin state <= init; dataout <= dataout; uldrxdata <= 0; done <= 0; end
            endcase
        end
    end

endmodule