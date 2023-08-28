module getReqFSM(
    input logic clk,
    input logic start,
    input logic txempty,
    output logic done,
    output logic [7:0] txdata,
    output logic ldtxdata
);

    enum {init, load0, waitload0, waitsend0, load1, waitload1, waitsend1, load2, waitload2, waitsend2, load3, waitload3, waitsend3,
          load4, waitload4, waitsend4, load5, waitload5, waitsend5, load6, waitload6, waitsend6,
          load7, waitload7, waitsend7, load8, waitload8, waitsend8, load9, waitload9, waitsend9,
          load10, waitload10, waitsend10, load11, waitload11, waitsend11, load12, waitload12, waitsend12,
          load13, waitload13, waitsend13, load14, waitload14, waitsend14, load15, waitload15, waitsend15,
          load16, waitload16, waitsend16, load17, waitload17, waitsend17, load18, waitload18, waitsend18, finish} state;

    always @(posedge clk) begin
        case (state)
            init: begin if (start) begin state <= load0; txdata <= 0; ldtxdata <= 0; done <= 0; end
                        else begin state <= init; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load0: begin state <= waitload0; txdata <= 8'b01100100; ldtxdata <= 1; done <= 0; end   //load d
            waitload0: begin state <= waitsend0; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend0: begin if (txempty) begin state <= load1; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend0; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load1: begin state <= waitload1; txdata <= 8'b01101111; ldtxdata <= 1; done <= 0; end   // load o
            waitload1: begin state <= waitsend1; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend1: begin if (txempty) begin state <= load2; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend1; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load2: begin state <= waitload2; txdata <= 8'b01100110; ldtxdata <= 1; done <= 0; end   // load f
            waitload2: begin state <= waitsend2; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend2: begin if (txempty) begin state <= load3; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend2; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load3: begin state <= waitload3; txdata <= 8'b01101001; ldtxdata <= 1; done <= 0; end   // load i
            waitload3: begin state <= waitsend3; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend3: begin if (txempty) begin state <= load4; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend3; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load4: begin state <= waitload4; txdata <= 8'b01101100; ldtxdata <= 1; done <= 0; end   // load l
            waitload4: begin state <= waitsend4; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend4: begin if (txempty) begin state <= load5; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend4; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load5: begin state <= waitload5; txdata <= 8'b01100101; ldtxdata <= 1; done <= 0; end   // load e
            waitload5: begin state <= waitsend5; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend5: begin if (txempty) begin state <= load6; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend5; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load6: begin state <= waitload6; txdata <= 8'b00101000; ldtxdata <= 1; done <= 0; end   // load (
            waitload6: begin state <= waitsend6; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend6: begin if (txempty) begin state <= load7; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend6; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load7: begin state <= waitload7; txdata <= 8'b00100010; ldtxdata <= 1; done <= 0; end   // load "
            waitload7: begin state <= waitsend7; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend7: begin if (txempty) begin state <= load8; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend7; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load8: begin state <= waitload8; txdata <= 8'b01100111; ldtxdata <= 1; done <= 0; end   // load g
            waitload8: begin state <= waitsend8; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend8: begin if (txempty) begin state <= load9; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend8; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load9: begin state <= waitload9; txdata <= 8'b01100101; ldtxdata <= 1; done <= 0; end   // load e
            waitload9: begin state <= waitsend9; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend9: begin if (txempty) begin state <= load10; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend9; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load10: begin state <= waitload10; txdata <= 8'b01110100; ldtxdata <= 1; done <= 0; end // load t
            waitload10: begin state <= waitsend10; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend10: begin if (txempty) begin state <= load11; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend10; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load11: begin state <= waitload11; txdata <= 8'b00101110; ldtxdata <= 1; done <= 0; end // load .
            waitload11: begin state <= waitsend11; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend11: begin if (txempty) begin state <= load12; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend11; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load12: begin state <= waitload12; txdata <= 8'b01101100; ldtxdata <= 1; done <= 0; end // load l
            waitload12: begin state <= waitsend12; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend12: begin if (txempty) begin state <= load13; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend12; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load13: begin state <= waitload13; txdata <= 8'b01110101; ldtxdata <= 1; done <= 0; end // load u
            waitload13: begin state <= waitsend13; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend13: begin if (txempty) begin state <= load14; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend13; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load14: begin state <= waitload14; txdata <= 8'b01100001; ldtxdata <= 1; done <= 0; end // load a
            waitload14: begin state <= waitsend14; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend14: begin if (txempty) begin state <= load15; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend14; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load15: begin state <= waitload15; txdata <= 8'b00100010; ldtxdata <= 1; done <= 0; end // load "
            waitload15: begin state <= waitsend15; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend15: begin if (txempty) begin state <= load16; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend15; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load16: begin state <= waitload16; txdata <= 8'b00101001; ldtxdata <= 1; done <= 0; end // load )
            waitload16: begin state <= waitsend16; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend16: begin if (txempty) begin state <= load17; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend16; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load17: begin state <= waitload17; txdata <= 8'b00001101; ldtxdata <= 1; done <= 0; end // load \r
            waitload17: begin state <= waitsend17; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend17: begin if (txempty) begin state <= load18; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend17; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load18: begin state <= waitload18; txdata <= 8'b00001010; ldtxdata <= 1; done <= 0; end //load \n
            waitload18: begin state <= waitsend18; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend18: begin if (txempty) begin state <= finish; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend18; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            finish: begin state <= init; txdata <= 0; ldtxdata <= 0; done <= 1; end
            default: begin state <= init; txdata <= 0; ldtxdata <= 0; done <= 0; end
        endcase
    end

endmodule