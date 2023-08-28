module top (

	//////////// CLOCK //////////
	input 		          		CLOCK2_50,
	input 		          		CLOCK3_50,
	input 		          		CLOCK4_50,
	input 		          		CLOCK_50,

	//////////// SDRAM //////////
	output		    [12:0]		DRAM_ADDR,
	output		    [1:0]		DRAM_BA,
	output		          		DRAM_CAS_N,
	output		          		DRAM_CKE,
	output		          		DRAM_CLK,
	output		          		DRAM_CS_N,
	inout 		    [15:0]		DRAM_DQ,
	output		          		DRAM_LDQM,
	output		          		DRAM_RAS_N,
	output		          		DRAM_UDQM,
	output		          		DRAM_WE_N,

	//////////// KEY //////////
	input 		     [3:0]		KEY,
	
	//////////// HEX //////////
	output 			  [6:0] HEX0, 
	output 			  [6:0] HEX1,
	output 			  [6:0] HEX2,
	output 			  [6:0] HEX3,
	output 			  [6:0] HEX4,
	output 			  [6:0] HEX5,
	
	//////////// LED //////////
	output			  [9:0] LEDR,
	
	//////////// SW //////////
	input 		     [9:0]		SW,

	//////////// VGA //////////
	output	reg          		VGA_BLANK_N,
	output	reg     [7:0]		VGA_B,
	output	reg          		VGA_CLK,
	output	reg     [7:0]		VGA_G,
	output	reg          		VGA_HS,
	output	reg     [7:0]		VGA_R,
	output	reg          		VGA_SYNC_N,
	output	reg          		VGA_VS,

	//////////// GPIO_1, GPIO_1 connect to D8M-GPIO //////////
	output 		          		CAMERA_I2C_SCL,
	inout 		          		CAMERA_I2C_SDA,
	output		          		CAMERA_PWDN_n,
	output		          		MIPI_CS_n,
	inout 		          		MIPI_I2C_SCL,
	inout 		          		MIPI_I2C_SDA,
	output		          		MIPI_MCLK,
	input 		          		MIPI_PIXEL_CLK,
	input 		     [9:0]		MIPI_PIXEL_D,
	input 		          		MIPI_PIXEL_HS,
	input 		          		MIPI_PIXEL_VS,
	output		          		MIPI_REFCLK,
	output		          		MIPI_RESET_n,
	
	//////////// GPIO_0, GPIO_0 connect to GPIO Default //////////
	inout 		    [35:0]		GPIO,
	
	input  wire        touchscreen_rxd, 
	output wire        touchscreen_txd
);
		
		wire [31:0] slave_out;
		wire unlock;
		wire cam_done;
		
		wire D8M_VGA_CLK;
		wire D8M_VGA_HS;
		wire D8M_VGA_VS;
		wire D8M_VGA_SYNC_N;
		wire D8M_VGA_BLANK_N;
		wire [7:0] D8M_VGA_R;
		wire [7:0] D8M_VGA_G;
		wire [7:0] D8M_VGA_B;
		
		wire GUI_VGA_CLK;
		wire GUI_VGA_HS;
		wire GUI_VGA_VS; 
		wire [7:0] GUI_VGA_R;
		wire [7:0] GUI_VGA_G; 
		wire [7:0] GUI_VGA_B;
		wire [7:0] GUI_VGA_X; 
		wire [6:0] GUI_VGA_Y;
		wire [2:0] GUI_VGA_COLOUR;
		wire GUI_VGA_SYNC_N;
		assign GUI_VGA_SYNC_N = 0;
		wire GUI_VGA_BLANK_N;
		assign GUI_VGA_BLANK_N = 1;
		wire GUI_VGA_PLOT;
		
		touchscreen t0 (CLOCK_50, KEY[0], IN_C_SIG, slave_out, touchscreen_rxd, touchscreen_txd);
		
		mainvga screen (CLOCK_50, SW, GUI_VGA_R, GUI_VGA_G, GUI_VGA_B, GUI_VGA_HS, GUI_VGA_VS, GUI_VGA_CLK,
						GUI_VGA_X,  GUI_VGA_Y, GUI_VGA_COLOUR, GUI_VGA_PLOT, slave_out);
	
		hexled hl (CLOCK_50, slave_out, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR);

		Motor m (GPIO[0], slave_out, CLOCK_50);
		
		DE1_SOC_D8M_RTL camera ( CLOCK2_50, CLOCK3_50, CLOCK4_50, CLOCK_50,
				DRAM_ADDR, DRAM_BA, DRAM_CAS_N, DRAM_CKE, DRAM_CLK, 
				DRAM_CS_N, DRAM_DQ, DRAM_LDQM, DRAM_RAS_N, DRAM_UDQM, DRAM_WE_N, 
				KEY, SW, D8M_VGA_BLANK_N, D8M_VGA_B, D8M_VGA_CLK,
				D8M_VGA_G, D8M_VGA_HS, D8M_VGA_R, D8M_VGA_SYNC_N, D8M_VGA_VS, CAMERA_I2C_SCL, CAMERA_I2C_SDA, 
				CAMERA_PWDN_n, MIPI_CS_n, MIPI_I2C_SCL, 
				MIPI_I2C_SDA, MIPI_MCLK, MIPI_PIXEL_CLK,
				MIPI_PIXEL_D, MIPI_PIXEL_HS, MIPI_PIXEL_VS, MIPI_REFCLK, MIPI_RESET_n, GPIO, unlock, cam_done
			);

		
		wire D8M = 1'b0;
		wire GUI = 1'b1;
		reg state;
		reg GUI_select;
		
		wire [2:0] IN_C_SIG; 
		
		assign IN_C_SIG = {cam_done, unlock, GUI_select};
		
		
		always @(posedge CLOCK_50) begin
			if (!KEY[0]) begin
				state <= D8M;
				GUI_select <= 0;
			end
			else begin
				case(state)
					D8M: begin  
								if (!KEY[2]) begin 
									state <= GUI;
									GUI_select <= 1;
								end
								else 
									state <= D8M;
							end
							
					GUI: begin 
								if (slave_out[4]) begin
									state <= D8M;
									GUI_select <= 0;
								end 
								else 
									state <= GUI;
							end
									
					default: state <= D8M;
				endcase
			end		
		end
		
		always @(*) begin
		
			if (GUI_select) begin
				VGA_R = GUI_VGA_R;
			   VGA_G = GUI_VGA_G;
			 	VGA_B = GUI_VGA_B;
			 	VGA_HS = GUI_VGA_HS;
			 	VGA_VS = GUI_VGA_VS;
			 	VGA_CLK = GUI_VGA_CLK;
			 	VGA_BLANK_N = GUI_VGA_BLANK_N;
			 	VGA_SYNC_N = GUI_VGA_SYNC_N;
			end
			
			else begin
				VGA_R = D8M_VGA_R;
				VGA_G = D8M_VGA_G;
				VGA_B = D8M_VGA_B;
				VGA_HS = D8M_VGA_HS;
				VGA_VS = D8M_VGA_VS;
				VGA_CLK = D8M_VGA_CLK;
				VGA_BLANK_N = D8M_VGA_BLANK_N;
				VGA_SYNC_N = D8M_VGA_SYNC_N;
			end
		end
		
endmodule
