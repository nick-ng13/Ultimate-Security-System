module tableFSM(
    input logic clk,
    input logic start,
    input logic txempty,
    output logic done,
    output logic [7:0] txdata,
    output logic ldtxdata
);

    enum {init, load0, waitload0, waitsend0, load1, waitload1, waitsend1, buffer, finish} state;

    always @(posedge clk) begin
        case (state)
            init: begin if (start) begin state <= load0; txdata <= 0; ldtxdata <= 0; done <= 0; end
                        else begin state <= init; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load0: begin state <= waitload0; txdata <= 8'b00001101; ldtxdata <= 1; done <= 0; end // load \r
            waitload0: begin state <= waitsend0; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend0: begin if (txempty) begin state <= load1; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend0; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load1: begin state <= waitload1; txdata <= 8'b00001010; ldtxdata <= 1; done <= 0; end // load \n
            waitload1: begin state <= waitsend1; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend1: begin if (txempty) begin state <= finish; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend1; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            finish: begin state <= init; txdata <= 0; ldtxdata <= 0; done <= 1; end
            default: begin state <= init; txdata <= 0; ldtxdata <= 0; done <= 0; end
        endcase
    end

endmodule
