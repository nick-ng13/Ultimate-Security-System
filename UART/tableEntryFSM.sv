module tableEntryFSM(
    input logic clk,
    input logic start,
    input logic txempty,
    input logic [4:0] arraypos,
    output logic done,
    output logic [7:0] txdata,
    output logic ldtxdata
);

    logic [7:0] firstnum, secondnum;

    enum {init, load0, waitload0, waitsend0, load1, waitload1, waitsend1, load2, waitload2, waitsend2, load3, waitload3, waitsend3,
          load4, waitload4, waitsend4, load5, waitload5, waitsend5, load6, waitload6, waitsend6, buffer, finish} state;

    always @(posedge clk) begin
        case (state)
            init: begin if (start) begin state <= load0; txdata <= 0; ldtxdata <= 0; done <= 0; end
                        else begin state <= init; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load0: begin state <= waitload0; txdata <= 8'b01110100; ldtxdata <= 1; done <= 0; end // load t
            waitload0: begin state <= waitsend0; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend0: begin if (txempty) begin state <= load1; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend0; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load1: begin state <= waitload1; txdata <= 8'b01011011; ldtxdata <= 1; done <= 0; end // load [
            waitload1: begin state <= waitsend1; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend1: begin if (txempty) begin state <= load2; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend1; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load2: begin state <= waitload2; txdata <= firstnum; ldtxdata <= 1; done <= 0; end // load first number based on arraypos
            waitload2: begin state <= waitsend2; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend2: begin if (txempty) begin state <= load3; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend2; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load3: begin state <= waitload3; txdata <= secondnum; ldtxdata <= 1; done <= 0; end // load second number based on arraypos
            waitload3: begin state <= waitsend3; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend3: begin if (txempty) begin state <= load4; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend3; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load4: begin state <= waitload4; txdata <= 8'b01011101; ldtxdata <= 1; done <= 0; end // load ]
            waitload4: begin state <= waitsend4; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend4: begin if (txempty) begin state <= load5; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend4; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load5: begin state <= waitload5; txdata <= 8'b00111101; ldtxdata <= 1; done <= 0; end // load =
            waitload5: begin state <= waitsend5; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend5: begin if (txempty) begin state <= load6; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend5; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load6: begin state <= waitload6; txdata <= 8'b00100010; ldtxdata <= 1; done <= 0; end // load "
            waitload6: begin state <= waitsend6; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend6: begin if (txempty) begin state <= finish; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend6; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            finish: begin state <= init; txdata <= 0; ldtxdata <= 0; done <= 1; end
            default: begin state <= init; txdata <= 0; ldtxdata <= 0; done <= 0; end
        endcase
    end
    
    // conbinational logic that assigns firstnum and secondnum based on arraypos
    always @(*) begin
        case (arraypos)
            1: begin firstnum = 8'b00110000; secondnum = 8'b00110001; end         // 01
            2: begin firstnum = 8'b00110000; secondnum = 8'b00110010; end         // 02
            3: begin firstnum = 8'b00110000; secondnum = 8'b00110011; end         // 03
            4: begin firstnum = 8'b00110000; secondnum = 8'b00110100; end         // 04
            5: begin firstnum = 8'b00110000; secondnum = 8'b00110101; end         // 05
            6: begin firstnum = 8'b00110000; secondnum = 8'b00110110; end         // 06
            7: begin firstnum = 8'b00110000; secondnum = 8'b00110111; end         // 07
            8: begin firstnum = 8'b00110000; secondnum = 8'b00111000; end         // 08
            9: begin firstnum = 8'b00110000; secondnum = 8'b00111001; end         // 09
            10: begin firstnum = 8'b00110001; secondnum = 8'b00110000; end        // 10
            11: begin firstnum = 8'b00110001; secondnum = 8'b00110001; end        // 11
            12: begin firstnum = 8'b00110001; secondnum = 8'b00110010; end        // 12
            13: begin firstnum = 8'b00110001; secondnum = 8'b00110011; end        // 13
            14: begin firstnum = 8'b00110001; secondnum = 8'b00110100; end        // 14
            15: begin firstnum = 8'b00110001; secondnum = 8'b00110101; end        // 15
            16: begin firstnum = 8'b00110001; secondnum = 8'b00110110; end        // 16
            17: begin firstnum = 8'b00110001; secondnum = 8'b00110111; end        // 17
            18: begin firstnum = 8'b00110001; secondnum = 8'b00111000; end        // 18
            19: begin firstnum = 8'b00110001; secondnum = 8'b00111001; end        // 19
            20: begin firstnum = 8'b00110010; secondnum = 8'b00110000; end        // 20
            default: begin firstnum = 8'b00101101; secondnum = 8'b00101101; end   // --
        endcase
    end

endmodule
