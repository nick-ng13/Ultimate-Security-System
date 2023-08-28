module slave(input csi_clk,
             input rsi_reset_n,
             input [2:0] coe_c1_IN_C_SIG,
             input avs_s0_write, input [31:0] avs_s0_writedata,
             input avs_s0_read, output reg [31:0] avs_s0_readdata,
             output reg [31:0] coe_c0_conduit);

reg [31:0] toVerilog;


always_ff @(posedge csi_clk or negedge rsi_reset_n) begin
    if(!rsi_reset_n) begin
        toVerilog <= 0;
    end else begin
        if(avs_s0_write) begin
            toVerilog <= avs_s0_writedata;
        end

    end

end

always_ff @(posedge csi_clk) begin
    if(avs_s0_read) begin
        avs_s0_readdata <= {29'b0,coe_c1_IN_C_SIG};
    end else begin
        avs_s0_readdata <= 32'b0;
    end
end

always_ff @(posedge csi_clk) begin
    coe_c0_conduit <= toVerilog;
end

endmodule