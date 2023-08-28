module Motor (inout logic GPIO, input logic [31:0] trigger, input logic CLOCK_50);

logic CLOCK_1000Hz;
divider divider(CLOCK_50, CLOCK_1000Hz);
logic [5:0] counter = 0;
logic [1:0] max;

assign max = trigger[3] ? 2'd2 : 2'd1;
// Generate a PWM to drive the Servo Motor
always @(posedge CLOCK_1000Hz)
begin
    if (counter < max) 
    begin
        GPIO <= 1'b1;
        counter <= counter + 1'b1;
    end
    else 
    begin
        GPIO <= 1'b0;
        if (counter >= 6'd19)
            counter <= 0;
        else
            counter <= counter + 1'b1;
    end
end


endmodule
