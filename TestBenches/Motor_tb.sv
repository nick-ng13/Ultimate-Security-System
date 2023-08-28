module Motor_test;

logic clk = 1'b0;
logic GPIO;
logic [31:0] trigger= 32'b1000;

Motor DUT(GPIO, trigger, clk);

initial begin
	
	forever begin
		clk = 1'b0;
		#1;
		clk = 1'b1;
		#1;
	end

end
initial begin
	#50;
	trigger= 32'b0;
	#50;
	$stop;
end

endmodule

