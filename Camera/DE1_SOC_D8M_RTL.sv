
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module DE1_SOC_D8M_RTL(

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

	//////////// SW //////////
	input 		     [9:0]		SW,

	//////////// VGA //////////
	output		          		VGA_BLANK_N,
	output		     [7:0]		VGA_B,
	output		          		VGA_CLK,
	output		     [7:0]		VGA_G,
	output		          		VGA_HS,
	output		     [7:0]		VGA_R,
	output		          		VGA_SYNC_N,
	output		          		VGA_VS,

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
	inout 		logic    [35:0]		GPIO,
	output 						camera_unlock,
	output 		logic			complete

);
//=============================================================================
// REG/WIRE declarations
//=============================================================================

wire	[15:0]UART_SDRAM_RD_DATA;
wire 					RD2_LOAD;

wire	[15:0]SDRAM_RD_DATA;
wire			DLY_RST_0;
wire			DLY_RST_1;
wire			DLY_RST_2;

wire			SDRAM_CTRL_CLK;
wire        D8M_CK_HZ ; 
wire        D8M_CK_HZ2 ; 
wire        D8M_CK_HZ3 ; 

wire [7:0] RED   ; 
wire [7:0] GREEN  ; 
wire [7:0] BLUE 		 ; 
wire [12:0] VGA_H_CNT;			
wire [12:0] VGA_V_CNT;	

wire        READ_Request ;
wire 	[7:0] B_AUTO;
wire 	[7:0] G_AUTO;
wire 	[7:0] R_AUTO;
wire        RESET_N  ; 

wire        I2C_RELEASE ;  
wire        AUTO_FOC ; 
wire        CAMERA_I2C_SCL_MIPI ; 
wire        CAMERA_I2C_SCL_AF;
wire        CAMERA_MIPI_RELAESE ;
wire        MIPI_BRIDGE_RELEASE ;  
 
wire        LUT_MIPI_PIXEL_HS;
wire        LUT_MIPI_PIXEL_VS;
wire [9:0]  LUT_MIPI_PIXEL_D  ;
wire        MIPI_PIXEL_CLK_; 
wire [9:0]  PCK;

//=======================================================
// Structural coding
//=======================================================
//--INPU MIPI-PIXEL-CLOCK DELAY
CLOCK_DELAY  del1(  .iCLK (MIPI_PIXEL_CLK),  .oCLK (MIPI_PIXEL_CLK_ ) );


assign LUT_MIPI_PIXEL_HS=MIPI_PIXEL_HS;
assign LUT_MIPI_PIXEL_VS=MIPI_PIXEL_VS;
assign LUT_MIPI_PIXEL_D =MIPI_PIXEL_D ;

//------UART OFF --
assign UART_RTS =0; 
assign UART_TXD =0; 

//------ MIPI BRIGE & CAMERA RESET  --
assign CAMERA_PWDN_n  = 1; 
assign MIPI_CS_n      = 0; 
assign MIPI_RESET_n   = RESET_N ;

//------ CAMERA MODULE I2C SWITCH  --
assign I2C_RELEASE    = CAMERA_MIPI_RELAESE & MIPI_BRIDGE_RELEASE; 
assign CAMERA_I2C_SCL =( I2C_RELEASE  )?  CAMERA_I2C_SCL_AF  : CAMERA_I2C_SCL_MIPI ;   
 
//----- RESET RELAY  --		
RESET_DELAY			u2	(	
							.iRST  ( KEY[0] ),
                     .iCLK  ( CLOCK2_50 ),
							.oRST_0( DLY_RST_0 ),
							.oRST_1( DLY_RST_1 ),
							.oRST_2( DLY_RST_2 ),					
						   .oREADY( RESET_N)  
							
						);
 
//------ MIPI BRIGE & CAMERA SETTING  --  
MIPI_BRIDGE_CAMERA_Config    cfin(
                      .RESET_N           ( RESET_N ), 
                      .CLK_50            ( CLOCK2_50 ), 
                      .MIPI_I2C_SCL      ( MIPI_I2C_SCL ), 
                      .MIPI_I2C_SDA      ( MIPI_I2C_SDA ), 
                      .MIPI_I2C_RELEASE  ( MIPI_BRIDGE_RELEASE ),  
                      .CAMERA_I2C_SCL    ( CAMERA_I2C_SCL_MIPI ),
                      .CAMERA_I2C_SDA    ( CAMERA_I2C_SDA ),
                      .CAMERA_I2C_RELAESE( CAMERA_MIPI_RELAESE )
             );
				 
//------MIPI / VGA REF CLOCK  --
pll_test pll_ref(
	                   .inclk0 ( CLOCK3_50 ),
	                   .areset ( ~KEY[0]   ),
	                   .c0( MIPI_REFCLK    ) //20Mhz

    );
	 
//------MIPI / VGA REF CLOCK  -
VIDEO_PLL pll_ref1(
	                   .inclk0 ( CLOCK2_50 ),
	                   .areset ( ~KEY[0] ),
	                   .c0( VGA_CLK )        //25 Mhz	
    );	 
//------SDRAM CLOCK GENNERATER  --
sdram_pll u6(
		               .areset( 0 ) ,     
		               .inclk0( CLOCK_50 ),              
		               .c1    ( DRAM_CLK ),       //100MHZ   -90 degree
		               .c0    ( SDRAM_CTRL_CLK )  //100MHZ     0 degree 							
		              
	               );		
						
//------SDRAM CONTROLLER --
Sdram_Control	   u7	(	//	HOST Side						
						   .RESET_N     ( KEY[0] ),
							.CLK         ( SDRAM_CTRL_CLK ) , 
							//	FIFO Write Side 1s
							.WR1_DATA    ( LUT_MIPI_PIXEL_D[9:0] ),
							// Only write to SRAM when the freeze_screen signal is not set
							.WR1         ( LUT_MIPI_PIXEL_HS & LUT_MIPI_PIXEL_VS & ~freeze_screen) ,
							
							.WR1_ADDR    ( 0 ),
                     .WR1_MAX_ADDR( 640*480 ),
						   .WR1_LENGTH  ( 256 ) , 
		               .WR1_LOAD    ( !DLY_RST_0 ),
							.WR1_CLK     ( MIPI_PIXEL_CLK_),

                     //	FIFO Read Side 1
						   .RD1_DATA    ( SDRAM_RD_DATA[9:0] ),
				        	.RD1         ( READ_Request ),
				        	.RD1_ADDR    (0 ),
                     .RD1_MAX_ADDR( 640*480 ),
							.RD1_LENGTH  ( 256  ),
							.RD1_LOAD    ( !DLY_RST_1),
							.RD1_CLK     ( VGA_CLK ),

						// FIFO Read Side 2
						   .RD2_DATA    ( UART_SDRAM_RD_DATA[9:0] ),
				        	.RD2         ( READ_Request_UART ),
				        	.RD2_ADDR    (0 ),
                     .RD2_MAX_ADDR( 640*480 ),
							.RD2_LENGTH  ( 256  ),
							.RD2_LOAD    ( !DLY_RST_1),
							.RD2_CLK     ( ADDR_CLK ),
											
							//	SDRAM Side
						   .SA          ( DRAM_ADDR ),
							.BA          ( DRAM_BA ),
							.CS_N        ( DRAM_CS_N ),
							.CKE         ( DRAM_CKE ),
							.RAS_N       ( DRAM_RAS_N ),
							.CAS_N       ( DRAM_CAS_N ),
							.WE_N        ( DRAM_WE_N ),
							.DQ          ( DRAM_DQ ),
							.DQM         ( DRAM_DQM  )
						   );	 	 

//------ CMOS CCD_DATA TO RGB_DATA for UART -- 

RAW2RGB_J				uart_RAW2RGB	(	
							.RST          ( VGA_VS_UART ),
							.iDATA        ( UART_SDRAM_RD_DATA[9:0] ),

							//-----------------------------------
                     .VGA_CLK      ( ADDR_CLK ),
                     .READ_Request ( READ_Request_UART ),
                     .VGA_VS       ( VGA_VS_UART ),	
							.VGA_HS       ( VGA_HS_UART ) , 
	                  			
							.oRed         ( RED_UART  ),
							.oGreen       ( GREEN_UART),
							.oBlue        ( BLUE_UART )
							);		

//------VGA Controller for UART --

VGA_Controller		uart_VGA_Controller	(	//	Host Side
							 .oRequest( READ_Request_UART ),
							 .iRed    ( RED_UART    ),
							 .iGreen  ( GREEN_UART 	),
							 .iBlue   ( BLUE_UART   ),
							 
							 //	VGA Side
							 .oVGA_R  ( R_AUTO_UART[7:0] ),
							 .oVGA_G  ( G_AUTO_UART[7:0] ),
							 .oVGA_B  ( B_AUTO_UART[7:0] ),
							 .oVGA_H_SYNC( VGA_HS_UART ),
							 .oVGA_V_SYNC( VGA_VS_UART ),
							 .oVGA_SYNC  ( VGA_SYNC_N_UART ),
							 .oVGA_BLANK ( VGA_BLANK_N_UART ),
							 //	Control Signal
							 .iCLK       ( ADDR_CLK ),
							 .iRST_N     ( DLY_RST_2 ),
							 .H_Cont     ( VGA_H_CNT_UART ),						
						    .V_Cont     ( VGA_V_CNT_UART )								
		);	

// --------- UART send module
module2_uart uart_module(
	.CLOCK_50(CLOCK_50),
	.start(uart_start),  
	.KEY(KEY), 
	.tx(send_tx), 
	.r(R_AUTO_UART), 
	.g(G_AUTO_UART), 
	.b(B_AUTO_UART), 
	.grey(data_out),
	.newData(uart_new_data_inputted), 
	.noMore(done_image), 
	.done(uart_finished), 
	.wantData(uart_ready),
	.tx_clk(baudCLK)
);

// --------- UART recieve module	
uart_read uart_read(
	.CLOCK_50(CLOCK_50),
	.KEY(KEY),
	.rx(GPIO[2]),
	.tx(get_tx),
    .LEDR(LEDR),
	.start(start_get),
	.data_out(camera_unlock),
	.complete(complete)
);

// --------- STATE DEFINITIONS -- 
parameter SLEEP = 4'b0000;
parameter RESET = 4'b0001;
parameter WAIT = 4'b0110;
parameter WAIT_FOR_IN_BOX = 4'b1000;
parameter READ_RGB = 4'b0010;
parameter CONVERT_GS = 4'b0011;
parameter WAIT_UART = 4'b0100;
parameter INC_ADDR = 4'b0101;
parameter DONE_SEND = 4'b0111;
parameter DELAY = 4'b1001;
parameter SG = 4'b1010;
parameter FULL_DONE = 4'b1011;

logic [3:0] state;

// ------- CLOCKS --
logic ADDR_CLK = 0;	
logic baudCLK;
	
logic [9:0] data_out;

// --------- VGA SIGNALS FOR UART PURPOSES ONLY -- 
logic [7:0] RED_UART;
logic [7:0] GREEN_UART;
logic [7:0] BLUE_UART;

wire [12:0] VGA_H_CNT_UART;			
wire [12:0] VGA_V_CNT_UART;	

wire 	[7:0] B_AUTO_UART;
wire 	[7:0] G_AUTO_UART;
wire 	[7:0] R_AUTO_UART;
	
logic VGA_HS_UART = 1;
logic VGA_VS_UART = 1; 
logic READ_Request_UART = 1;

wire VGA_SYNC_N_UART;
wire VGA_BLANK_N_UART;

// -------- UART FSM CONTROL SIGNALS -- 
logic uart_start = 0;
logic uart_ready = 0;
logic uart_new_data_inputted = 0;
logic uart_finished;

// -------- DONE IMAGE FLAG
logic done_image = 0;

logic [23:0] delay_count = 0;
logic start_get = 0;

logic [31:0] pixel_count;

// -------- GPIO TX --
logic send_tx;
logic get_tx;

logic tx;
assign tx = uart_finished ? get_tx : send_tx;

assign GPIO[1] = tx;


// --------- STATE MACHINE LOGIC --
always@(posedge baudCLK)
begin
	// --------- RESET LOGIC --
	if(~KEY[0]) begin
		state <= SLEEP;
		done_image <= 0;
		pixel_count <= 0;
		delay_count <= 0;
		start_get <= 0;
		uart_start <= 0;
	end  else begin
		// --------- STATE TRANSISTION TABLE --
		case(state)
			SLEEP: begin
				// stay asleep until the freeze frame is taken
				if(freeze_screen) state <= RESET;
				else state <= SLEEP; 
			end
			RESET: begin
				// only begin logic when the send button is pressed 
				pixel_count = 0;
				if(~KEY[2])
					state <= WAIT;
				else
					state <= RESET;
			end
			WAIT: begin
				// signal UART send FSM to start
				uart_start = 1;
				// toggle SRAM clock to do complete logic
				ADDR_CLK <= ~ADDR_CLK;
				// jump states once data is valid
				if(B_AUTO_UART || G_AUTO_UART || R_AUTO_UART)
					state <= WAIT_FOR_IN_BOX;
				else
					state <= WAIT;
			end
			WAIT_FOR_IN_BOX: begin
				// While we are not in the send box range, continue through memory
				if(VGA_H_CNT_UART < 425 || VGA_H_CNT_UART > 525 || VGA_V_CNT_UART < 200 || VGA_V_CNT_UART > 340) begin
					ADDR_CLK <= ~ADDR_CLK;
					state <= WAIT_FOR_IN_BOX;
				// If we are in the box, move to receiving the data
				end else
					state <= READ_RGB;
			end
			READ_RGB: begin
				// Disable the SRAM clock, and tell UART data is valid
				ADDR_CLK <= 0;
				uart_new_data_inputted <= 1;
				data_out <= (R_AUTO_UART + G_AUTO_UART + B_AUTO_UART);
				// Wait here until UART is ready
				if(uart_ready) state <= WAIT_UART;
				else state <= READ_RGB;
			end
			WAIT_UART: begin
				// Wait for UART to finish before cycling back to get new data
				uart_new_data_inputted <= 0;
				if(uart_ready) state <= INC_ADDR;
				else state <= WAIT_UART;
			end
			INC_ADDR: begin
				// If we are at the end of our send window, we are done the image
				if(VGA_H_CNT_UART == 525 && VGA_V_CNT_UART == 340)
					state <= DONE_SEND;
				// Increment our address in memory by setting the ADDR_CLOCK to one
				else begin
					ADDR_CLK <= 1;
					pixel_count <= pixel_count + 1;
					state <= WAIT_FOR_IN_BOX;
				end
			end
			DONE_SEND: begin
				state <= DELAY;
				done_image <= 1;
				delay_count <= 0;
			end
			DELAY: begin
				// Sit in hardcoded delay to wait for get request result
				if(delay_count === 23'd115200 * 15)
					state <= SG;
				else begin
					delay_count += 1;
					state <= DELAY;
				end
			end
			SG: begin
				// Send the get request by starting the UART get FSM
				start_get <= 1;
				state <= FULL_DONE;
			end
			FULL_DONE: begin
				state <= FULL_DONE;
			end
			default: begin
				state <= SLEEP;
			end
		endcase	
	end
end

// ------- FREEZE_SCREEN LOGIC --
logic freeze_screen = 0;

always_ff@(posedge CLOCK_50) begin
	if(~KEY[0])
		freeze_screen <= 0;
	else begin
		if(~KEY[1])
			freeze_screen <= 1;
		else
			freeze_screen <= freeze_screen;
	end
end

//------ CMOS CCD_DATA TO RGB_DATA -- 

RAW2RGB_J				u4	(	
							.RST          ( VGA_VS ),
							.iDATA        ( SDRAM_RD_DATA[9:0] ),

							//-----------------------------------
                     .VGA_CLK      ( VGA_CLK ),
                     .READ_Request ( READ_Request ),
                     .VGA_VS       ( VGA_VS ),	
							.VGA_HS       ( VGA_HS ) , 
	                  			
							.oRed         ( RED  ),
							.oGreen       ( GREEN),
							.oBlue        ( BLUE )


							);		
 
//------AOTO FOCUS ENABLE  --
AUTO_FOCUS_ON  vd( 
                      .CLK_50      ( CLOCK2_50 ), 
                      .I2C_RELEASE ( I2C_RELEASE ), 
                      .AUTO_FOC    ( AUTO_FOC )
               ) ;
					

//------AOTO FOCUS ADJ  --
FOCUS_ADJ adl(
                      .CLK_50        ( CLOCK2_50 ) , 
                      .RESET_N       ( I2C_RELEASE ), 
                      .RESET_SUB_N   ( I2C_RELEASE ), 
                      .AUTO_FOC      ( KEY[3] & AUTO_FOC ), 
                      .SW_Y          ( 0 ),
                      .SW_H_FREQ     ( 0 ),   
                      .SW_FUC_LINE   ( SW[3] ),   
                      .SW_FUC_ALL_CEN( SW[3] ),
                      .VIDEO_HS      ( VGA_HS ),
                      .VIDEO_VS      ( VGA_VS ),
                      .VIDEO_CLK     ( VGA_CLK ),
		                .VIDEO_DE      (READ_Request) ,
                      .iR            ( R_AUTO ), 
                      .iG            ( G_AUTO ), 
                      .iB            ( B_AUTO ), 
                      .oR            ( VGA_R ) , 
                      .oG            ( VGA_G ) , 
                      .oB            ( VGA_B ) , 
                      
                      .READY         ( READY ),
                      .SCL           ( CAMERA_I2C_SCL_AF ), 
                      .SDA           ( CAMERA_I2C_SDA )
);

//------VGA Controller  --

VGA_Controller		u1	(	//	Host Side
							 .oRequest( READ_Request ),
							 .iRed    ( RED    ),
							 .iGreen  ( GREEN  ),
							 .iBlue   ( BLUE   ),
							 
							 //	VGA Side
							 .oVGA_R  ( R_AUTO[7:0] ),
							 .oVGA_G  ( G_AUTO[7:0] ),
							 .oVGA_B  ( B_AUTO[7:0] ),
							 .oVGA_H_SYNC( VGA_HS ),
							 .oVGA_V_SYNC( VGA_VS ),
							 .oVGA_SYNC  ( VGA_SYNC_N ),
							 .oVGA_BLANK ( VGA_BLANK_N ),
							 //	Control Signal
							 .iCLK       ( VGA_CLK ),
							 .iRST_N     ( DLY_RST_2 ),
							 .H_Cont     ( VGA_H_CNT ),						
						    .V_Cont     ( VGA_V_CNT )								
		);	


endmodule
