module hexled ( input logic clk, input logic [31:0] trigger,
					 output logic [6:0] HEX0, output logic [6:0] HEX1, output logic [6:0] HEX2,
					 output logic [6:0] HEX3, output logic [6:0] HEX4, output logic [6:0] HEX5 , output logic [9:0] LEDR 
				  );
			 
			always @ (posedge clk) begin
				
				case (trigger[1:0])
					
						2'b00: begin // LOCKED and LED OFF
										HEX0[6:0] <= 7'b0001111;   
										HEX1[6:0] <= 7'b1000110; 	
										HEX2[6:0] <= 7'b1000000; 
										HEX3[6:0] <= 7'b1000111;
										HEX4[6:0] <= 7'b1111111; 
										HEX5[6:0] <= 7'b1111111;
										LEDR [9:0] <= 10'b0000000000; 
								 end
								 
						2'b01: begin  // LOCKED and LED ON
										HEX0[6:0] <= 7'b0001111; 
										HEX1[6:0] <= 7'b1000110; 
										HEX2[6:0] <= 7'b1000000; 
										HEX3[6:0] <= 7'b1000111;
										HEX4[6:0] <= 7'b1111111; 
										HEX5[6:0] <= 7'b1111111; 
										LEDR [9:0] <= 10'b1111111111; 
								 end
								 
						2'b10: begin //UNLOCKED and LED OFF
										HEX0[6:0] <= 7'b0001111; 
										HEX1[6:0] <= 7'b1000110; 
										HEX2[6:0] <= 7'b1000000; 
										HEX3[6:0] <= 7'b1000111;
										HEX4[6:0] <= 7'b1001000; 
										HEX5[6:0] <= 7'b1000001;  
										LEDR [9:0] <= 10'b0000000000; 
								 end
								 
						2'b11: begin //UNLOCKED and LED ON
										HEX0[6:0] <= 7'b0001111; 
										HEX1[6:0] <= 7'b1000110; 
										HEX2[6:0] <= 7'b1000000; 
										HEX3[6:0] <= 7'b1000111;
										HEX4[6:0] <= 7'b1001000; 
										HEX5[6:0] <= 7'b1000001; 
										LEDR [9:0] <= 10'b1111111111; 
								 end
								 
						default:  begin
										HEX0[6:0] <= 7'b1; 
										HEX1[6:0] <= 7'b1; 
										HEX2[6:0] <= 7'b1; 
										HEX3[6:0] <= 7'b1; 
										HEX4[6:0] <= 7'b1; 
										HEX5[6:0] <= 7'b1; 
										LEDR [9:0] <= 10'b1; 
								    end
					endcase			
						
		end
				
				
endmodule