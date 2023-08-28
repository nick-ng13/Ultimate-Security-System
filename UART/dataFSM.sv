module dataFSM(
    input logic clk,
    input logic start,
    input logic noMore,
    input logic sendDone,
    input logic newData,
    output logic startSend,
    output logic wantData,
    output logic noMoreDone,
    output logic done
);

    logic [7:0] charCount;

    enum {idle, ask, send, waitsend, full, nodata} state;

    always @(posedge clk) begin
        case (state)
            idle: begin charCount <= 8'd0;
                        if (start) begin state <= ask; end
                        else begin state <= idle; end end
            ask: begin charCount <= charCount;
                       if (noMore) begin state <= nodata; end
                       else if (charCount == 8'd198) begin state <= full; end
                       else if (newData) begin state <= send; end
                       else begin state <= ask; end end
            send: begin state <= waitsend; charCount <= charCount; end
            waitsend: begin if (sendDone) begin state <= ask; charCount <= charCount+8'd6; end
                            else begin state <= waitsend; charCount <= charCount; end end
            full: begin state <= idle; charCount <= charCount; end
            nodata: begin state <= idle; charCount <= charCount; end
            default: begin state <= idle; charCount <= charCount; end
        endcase
    end

    always @(*) begin
        case (state)
            idle: begin startSend = 0; wantData = 0; noMoreDone = 0; done = 0; end
            ask: begin startSend = 0; wantData = 1; noMoreDone = 0; done = 0; end
            send: begin startSend = 1; wantData = 0; noMoreDone = 0; done = 0; end
            waitsend: begin startSend = 0; wantData = 0; noMoreDone = 0; done = 0; end
            full: begin startSend = 0; wantData = 0; noMoreDone = 0; done = 1; end
            nodata: begin startSend = 0; wantData = 0; noMoreDone = 1; done = 0; end
            default: begin startSend = 0; wantData = 0; noMoreDone = 0; done = 0; end
        endcase
    end

endmodule