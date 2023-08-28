module mainvga_tb;

logic clk;
logic [31:0] trigger = 4'b1000;
logic [9:0] SW;
logic [9:0] LEDR;
logic [6:0] HEX0;
logic [6:0] HEX1;
logic [6:0] HEX2;
logic [6:0] HEX3;
logic [6:0] HEX4;
logic [6:0] HEX5;
logic [7:0] VGA_R;
logic [7:0] VGA_G;
logic [7:0] VGA_B;
logic VGA_HS;
logic VGA_VS;
logic VGA_CLK;
logic [7:0] VGA_X;
logic [6:0] VGA_Y;
logic [2:0] VGA_COLOUR;
logic VGA_PLOT;

mainvga DUT(clk,SW,VGA_R,VGA_G,VGA_B,VGA_HS,VGA_VS,VGA_CLK,VGA_X,VGA_Y,VGA_COLOUR,VGA_PLOT,trigger);
initial begin
	
	forever begin
		clk = 1'b0;
		#1;
		clk = 1'b1;
		#1;
	end

end
initial begin
	SW[9] = 0;
	SW[8] = 0;
	#200;
	SW[9] = 1;	
	SW[8] = 0;
	#500;
	SW[9] = 0;
	SW[8] = 1;
	#200;
	SW[9] = 1;	
	SW[8] = 0;
	#200;


	$stop;
end

endmodule

