module fillFSM(
    input logic clk,
    input logic start,
    input logic [7:0] r,
    input logic [7:0] g,
    input logic [7:0] b,
    input logic txempty,
    output logic done,
    output logic [7:0] txdata,
    output logic ldtxdata
);

    // parameter SIZE = 6;

    // logic [2:0] count = 0;
    // logic [7:0] data [SIZE-1:0];
    logic [7:0] rHigh, rLow, gHigh, gLow, bHigh, bLow;

    encode redHigh(r[7:4], rHigh);
    encode redLow(r[3:0], rLow);
    encode greenHigh(g[7:4], gHigh);
    encode greenLow(g[3:0], gLow);
    encode blueHigh(b[7:4], bHigh);
    encode blueLow(b[3:0], bLow);

    enum {init, load0, waitload0, waitsend0, load1, waitload1, waitsend1, load2, waitload2, waitsend2, load3, waitload3, waitsend3,
          load4, waitload4, waitsend4, load5, waitload5, waitsend5, buffer, finish} state;

    // always @(posedge clk) begin
    //     case (state)
    //         init: begin if (start) begin state <= load; txdata <= 0; ldtxdata <= 0; count <= count; done <= 0;
    //                     data[0] <= rHigh;
    //                     data[1] <= rLow;
    //                     data[2] <= gHigh;
    //                     data[3] <= gLow;
    //                     data[4] <= bHigh;
    //                     data[5] <= bLow;
    //                     end
    //                     else begin state <= init; txdata <= 0; ldtxdata <= 0; count <= count; done <= 0; end end
    //         load: begin state <= waitload; txdata <= data[count]; ldtxdata <= 1; count <= count+3'd1; done <= 0; end
    //         waitload: begin state <= waitsend; txdata <= 0; ldtxdata <= 0; count <= count; done <= 0; end
    //         waitsend: begin if (txempty) begin state <= load; txdata <= 0; ldtxdata <= 0; count <= count; done <= 0; end
    //                         else if (count == SIZE) begin state <= buffer; txdata <= 0; ldtxdata <= 0; count <= count; done <= 0; end
    //                         else begin state <= waitsend; txdata <= 0; ldtxdata <= 0; count <= count; done <= 0; end end
    //         buffer: begin if (txempty) begin state <= finish; txdata <= 0; ldtxdata <= 0; count <= count; done <= 0; end // i  changed this
    //                       else begin state <= buffer; txdata <= 0; ldtxdata <= 0; count <= count; done <= 0; end end
    //         finish: begin state <= init; txdata <= 0; ldtxdata <= 0; count <= count; done <= 1; end
    //         default: begin state <= init; txdata <= 0; ldtxdata <= 0; count <= count; done <= 0; end
    //     endcase
    // end

    always @(posedge clk) begin
        case (state)
            init: begin if (start) begin state <= load0; txdata <= 0; ldtxdata <= 0; done <= 0; end
                        else begin state <= init; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load0: begin state <= waitload0; txdata <= rHigh; ldtxdata <= 1; done <= 0; end
            waitload0: begin state <= waitsend0; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend0: begin if (txempty) begin state <= load1; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend0; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load1: begin state <= waitload1; txdata <= rLow; ldtxdata <= 1; done <= 0; end
            waitload1: begin state <= waitsend1; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend1: begin if (txempty) begin state <= load2; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend1; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load2: begin state <= waitload2; txdata <= gHigh; ldtxdata <= 1; done <= 0; end
            waitload2: begin state <= waitsend2; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend2: begin if (txempty) begin state <= load3; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend2; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load3: begin state <= waitload3; txdata <= gLow; ldtxdata <= 1; done <= 0; end
            waitload3: begin state <= waitsend3; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend3: begin if (txempty) begin state <= load4; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend3; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load4: begin state <= waitload4; txdata <= bHigh; ldtxdata <= 1; done <= 0; end
            waitload4: begin state <= waitsend4; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend4: begin if (txempty) begin state <= load5; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend4; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            load5: begin state <= waitload5; txdata <= bLow; ldtxdata <= 1; done <= 0; end
            waitload5: begin state <= waitsend5; txdata <= 0; ldtxdata <= 0; done <= 0; end
            waitsend5: begin if (txempty) begin state <= finish; txdata <= 0; ldtxdata <= 0; done <= 0; end
                            else begin state <= waitsend5; txdata <= 0; ldtxdata <= 0; done <= 0; end end
            finish: begin state <= init; txdata <= 0; ldtxdata <= 0; done <= 1; end
            default: begin state <= init; txdata <= 0; ldtxdata <= 0; done <= 0; end
        endcase
    end

endmodule

module encode(
    input [3:0] binary,
    output logic [7:0] hex
);

    always @(*) begin
        case (binary)
            4'b0000: hex = 8'b00110000; // 0
            4'b0001: hex = 8'b00110001; // 1
            4'b0010: hex = 8'b00110010; // 2
            4'b0011: hex = 8'b00110011; // 3
            4'b0100: hex = 8'b00110100; // 4
            4'b0101: hex = 8'b00110101; // 5
            4'b0110: hex = 8'b00110110; // 6
            4'b0111: hex = 8'b00110111; // 7
            4'b1000: hex = 8'b00111000; // 8
            4'b1001: hex = 8'b00111001; // 9
            4'b1010: hex = 8'b01000001; // A
            4'b1011: hex = 8'b01000010; // B
            4'b1100: hex = 8'b01000011; // C
            4'b1101: hex = 8'b01000100; // D
            4'b1110: hex = 8'b01000101; // E
            4'b1111: hex = 8'b01000110; // F
            default: hex = 8'b00101101; // -
        endcase
    end

endmodule