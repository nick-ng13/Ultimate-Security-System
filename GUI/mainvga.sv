module mainvga(input logic CLOCK_50, input  wire [9:0] SW, output logic [7:0] VGA_R, output logic [7:0] VGA_G, 
				 output logic [7:0] VGA_B, output logic VGA_HS, output logic VGA_VS, 
				 output logic VGA_CLK, output logic [7:0] VGA_X, output logic [6:0] VGA_Y,
             output logic [2:0] VGA_COLOUR, output logic VGA_PLOT, input logic [31:0] trigger
					);

    // instantiate and connect the VGA adapter and your module
        logic VGA_BLANK, VGA_SYNC;
        logic [9:0] VGA_R_10;
        logic [9:0] VGA_G_10;
        logic [9:0] VGA_B_10;
        logic [2:0] red = 3'b100;
        logic [2:0] green = 3'b010;
        logic [2:0] blue = 3'b001;
        logic [2:0] cyan = 3'b011;
        logic [2:0] black = 3'b000;
        assign VGA_R = VGA_R_10[9:2];   // take significant bits to match DE1 SoC
        assign VGA_G = VGA_G_10[9:2];
        assign VGA_B = VGA_B_10[9:2];

        logic [6:0] ctry_1,ctry_2,ctry_3,ctry_4;
        logic [7:0] ctrx_1,ctrx_2,ctrx_3;
        logic [7:0] rad;

        assign rad = 10;
        assign ctrx_1 = 55;
        assign ctrx_2 = 80;
        assign ctrx_3 = 105;
        assign ctry_1 = 24;
        assign ctry_2 = 48;
        assign ctry_3 = 72;
        assign ctry_4 = 96;

        logic [6:0] ltry_1, ltry_2, ltry_3, ltry_4;
        logic [7:0] ltrx_1, ltrx_2, ltrx_3;
        
        assign ltrx_1 = ctrx_1-7;
        assign ltrx_2 = ctrx_2-7;
        assign ltrx_3 = ctrx_3-7;
        assign ltry_1 = ctry_1-7;
        assign ltry_2 = ctry_2-7;
        assign ltry_3 = ctry_3-7;
        assign ltry_4 = ctry_4-7;
        
        logic [7:0] x,x_fill, x_cir_1, x_cir_2, x_cir_3, x_cir_4, x_cir_5, x_cir_6, x_cir_7, x_cir_8, x_cir_9, x_cir_0, x_ltr_1, x_ltr_2, x_ltr_3, x_ltr_4, x_ltr_5, x_ltr_6, x_ltr_7, x_ltr_8, x_ltr_9, x_ltr_0, x_ltr_X, x_ltr_check;
        logic [6:0] y,y_fill,y_cir_1, y_cir_2, y_cir_3, y_cir_4, y_cir_5, y_cir_6, y_cir_7, y_cir_8, y_cir_9, y_cir_0, y_ltr_1, y_ltr_2, y_ltr_3, y_ltr_4, y_ltr_5, y_ltr_6, y_ltr_7, y_ltr_8, y_ltr_9, y_ltr_0, y_ltr_X, y_ltr_check;
        logic [2:0] colour,colour_fill, colour_cir_1, colour_cir_2, colour_cir_3, colour_cir_4, colour_cir_5, colour_cir_6, colour_cir_7, colour_cir_8, colour_cir_9, colour_cir_0,colour_ltr_1,colour_ltr_2,colour_ltr_3,colour_ltr_4,colour_ltr_5,colour_ltr_6,colour_ltr_7,colour_ltr_8,colour_ltr_9,colour_ltr_0, colour_ltr_X, colour_ltr_check;
        logic plot, plot_fill, plot_cir_1,plot_cir_2,plot_cir_3,plot_cir_4,plot_cir_5,plot_cir_6,plot_cir_7,plot_cir_8,plot_cir_9,plot_cir_0, plot_ltr_1,plot_ltr_2,plot_ltr_3,plot_ltr_4,plot_ltr_5,plot_ltr_6,plot_ltr_7,plot_ltr_8,plot_ltr_9,plot_ltr_0, plot_ltr_X, plot_ltr_check;
        
        logic [6:0] ltry_0_WELCOME;
        logic [7:0] ltrx_0_WELCOME, ltrx_1_WELCOME, ltrx_2_WELCOME, ltrx_3_WELCOME, ltrx_4_WELCOME, ltrx_5_WELCOME, ltrx_6_WELCOME;
        
        assign ltrx_0_WELCOME = 48;
        assign ltrx_1_WELCOME = 60;
        assign ltrx_2_WELCOME = 72;
        assign ltrx_3_WELCOME = 84;
        assign ltrx_4_WELCOME = 96;
        assign ltrx_5_WELCOME = 108;
        assign ltrx_6_WELCOME = 120;
        assign ltry_0_WELCOME = 52;

        logic [7:0] x_ltr_0_WELCOME, x_ltr_1_WELCOME, x_ltr_2_WELCOME, x_ltr_3_WELCOME, x_ltr_4_WELCOME, x_ltr_5_WELCOME, x_ltr_6_WELCOME;
        logic [6:0] y_ltr_0_WELCOME, y_ltr_1_WELCOME, y_ltr_2_WELCOME, y_ltr_3_WELCOME, y_ltr_4_WELCOME, y_ltr_5_WELCOME, y_ltr_6_WELCOME;
        logic [2:0] colour_ltr_0_WELCOME,colour_ltr_1_WELCOME,colour_ltr_2_WELCOME,colour_ltr_3_WELCOME,colour_ltr_4_WELCOME,colour_ltr_5_WELCOME,colour_ltr_6_WELCOME;
        logic plot_ltr_0_WELCOME,plot_ltr_1_WELCOME,plot_ltr_2_WELCOME,plot_ltr_3_WELCOME,plot_ltr_4_WELCOME,plot_ltr_5_WELCOME,plot_ltr_6_WELCOME;
		  
		  logic [6:0] ltry_0_UNLOCKED;
        logic [7:0] ltrx_0_UNLOCKED, ltrx_1_UNLOCKED, ltrx_2_UNLOCKED, ltrx_3_UNLOCKED, ltrx_4_UNLOCKED, ltrx_5_UNLOCKED, ltrx_6_UNLOCKED, ltrx_7_UNLOCKED;
        
        assign ltrx_0_UNLOCKED = 42;
        assign ltrx_1_UNLOCKED = 54;
        assign ltrx_2_UNLOCKED = 66;
        assign ltrx_3_UNLOCKED = 78;
        assign ltrx_4_UNLOCKED = 90;
        assign ltrx_5_UNLOCKED = 102;
        assign ltrx_6_UNLOCKED = 114;
	   assign ltrx_7_UNLOCKED = 126;
        assign ltry_0_UNLOCKED = 52;
		  
		  
	   logic [7:0] x_ltr_0_UNLOCKED, x_ltr_1_UNLOCKED, x_ltr_2_UNLOCKED, x_ltr_3_UNLOCKED, x_ltr_4_UNLOCKED, x_ltr_5_UNLOCKED, x_ltr_6_UNLOCKED, x_ltr_7_UNLOCKED;
        logic [6:0] y_ltr_0_UNLOCKED, y_ltr_1_UNLOCKED, y_ltr_2_UNLOCKED, y_ltr_3_UNLOCKED, y_ltr_4_UNLOCKED, y_ltr_5_UNLOCKED, y_ltr_6_UNLOCKED, y_ltr_7_UNLOCKED;
        logic [2:0] colour_ltr_0_UNLOCKED,colour_ltr_1_UNLOCKED,colour_ltr_2_UNLOCKED,colour_ltr_3_UNLOCKED,colour_ltr_4_UNLOCKED,colour_ltr_5_UNLOCKED,colour_ltr_6_UNLOCKED,colour_ltr_7_UNLOCKED;
        logic plot_ltr_0_UNLOCKED,plot_ltr_1_UNLOCKED,plot_ltr_2_UNLOCKED,plot_ltr_3_UNLOCKED,plot_ltr_4_UNLOCKED,plot_ltr_5_UNLOCKED,plot_ltr_6_UNLOCKED,plot_ltr_7_UNLOCKED;
        
        assign VGA_X = x;
        assign VGA_Y = y;
        assign VGA_PLOT = plot;
        assign VGA_COLOUR = colour;
        

        logic [27:0][15:0][11:0] letters;
        assign letters[0] = {12'h0F8,12'h3FE,12'h306,12'h607,12'h60F,12'h61B,12'h633,12'h663,12'h6C3,12'h783,12'h703,12'h306,12'h3FE,12'h0F8,12'h000,12'h000};
        assign letters[1] = {12'h030,12'h070,12'h1F0,12'h1F0,12'h030,12'h030,12'h030,12'h030,12'h030,12'h030,12'h030,12'h030,12'h1FE,12'h1FE,12'h000,12'h000};
        assign letters[2] = {12'h1FC,12'h3FE,12'h707,12'h603,12'h607,12'h00E,12'h01C,12'h038,12'h070,12'h0E0,12'h1C0,12'h380,12'h7FF,12'h7FF,12'h000,12'h000};
	   assign letters[3] = {12'h1FC,12'h3FE,12'h707,12'h603,12'h003,12'h007,12'h0FE,12'h0FC,12'h006,12'h003,12'h603,12'h707,12'h3FE,12'h1FC,12'h000,12'h000};
	   assign letters[4] = {12'h01C,12'h03C,12'h07C,12'h0EC,12'h1CC,12'h38C,12'h70C,12'h60C,12'h7FF,12'h7FF,12'h00C,12'h00C,12'h00C,12'h00C,12'h000,12'h000};
	   assign letters[5] = {12'h7FF,12'h7FF,12'h600,12'h600,12'h600,12'h7FC,12'h3FE,12'h007,12'h003,12'h003,12'h603,12'h707,12'h3FE,12'h1FC,12'h000,12'h000};
	   assign letters[6] = {12'h03C,12'h07C,12'h0E0,12'h1C0,12'h380,12'h300,12'h7FC,12'h7FE,12'h707,12'h603,12'h603,12'h707,12'h3FE,12'h1FC,12'h000,12'h000};
	   assign letters[7] = {12'h7FF,12'h7FF,12'h006,12'h006,12'h00C,12'h00C,12'h018,12'h018,12'h030,12'h030,12'h060,12'h060,12'h0C0,12'h0C0,12'h000,12'h000};
	   assign letters[8] = {12'h0F8,12'h1FC,12'h38E,12'h306,12'h306,12'h38E,12'h1FC,12'h3FE,12'h707,12'h603,12'h603,12'h707,12'h3FE,12'h1FC,12'h000,12'h000};
	   assign letters[9] = {12'h1FC,12'h3FE,12'h707,12'h603,12'h603,12'h707,12'h3FF,12'h1FF,12'h006,12'h00E,12'h01C,12'h038,12'h1F0,12'h1E0,12'h000,12'h000};
        // X
        assign letters[10] = {12'h606,12'h606,12'h30C,12'h30C,12'h198,12'h0F0,12'h060,12'h060,12'h0F0,12'h198,12'h30C,12'h30C,12'h606,12'h606,12'h000,12'h000};
        // Checkmark
        assign letters[11] = {12'h006,12'h006,12'h006,12'h00C,12'h00C,12'h00C,12'h60C,12'h60C,12'h60C,12'h318,12'h318,12'h318,12'h1B0,12'h1B0,12'h0E0,12'h000};

        //L
        assign letters[12] = {12'h600,12'h600,12'h600,12'h600,12'h600,12'h600,12'h600,12'h600,12'h600,12'h600,12'h600,12'h600,12'h7FE,12'h7FE,12'h000,12'h000};
        //O
        assign letters[13] = {12'h0F0,12'h1F8,12'h39C,12'h30C,12'h606,12'h606,12'h606,12'h606,12'h606,12'h606,12'h30C,12'h39C,12'h1F8,12'h0F0,12'h000,12'h000};
        //A
        assign letters[14] = {12'h060,12'h060,12'h0F0,12'h0F0,12'h0F0,12'h198,12'h198,12'h198,12'h30C,12'h3FC,12'h3FC,12'h606,12'h606,12'h606,12'h000,12'h000};
	     //D
        assign letters[15] = {12'h7F0,12'h7F8,12'h61C,12'h60C,12'h606,12'h606,12'h606,12'h606,12'h606,12'h606,12'h60C,12'h61C,12'h7F8,12'h7F0,12'h000,12'h000};
	     //I
        assign letters[16] = {12'h1F8,12'h1F8,12'h060,12'h060,12'h060,12'h060,12'h060,12'h060,12'h060,12'h060,12'h060,12'h060,12'h1F8,12'h1F8,12'h000,12'h000};
	     //N
        assign letters[17] = {12'h606,12'h706,12'h706,12'h786,12'h6C6,12'h6C6,12'h666,12'h666,12'h636,12'h636,12'h61E,12'h60E,12'h60E,12'h606,12'h000,12'h000};
	     //G
        assign letters[18] = {12'h0FC,12'h1FE,12'h386,12'h300,12'h600,12'h600,12'h63E,12'h63E,12'h606,12'h606,12'h306,12'h386,12'h1FE,12'h0FE,12'h000,12'h000};

        // U
        assign letters[19] = {12'h606,12'h606,12'h606,12'h606,12'h606,12'h606,12'h606,12'h606,12'h606,12'h606,12'h606,12'h30C,12'h3FC,12'h1F8,12'h000,12'h000};
        // N
        assign letters[20] = {12'h606,12'h706,12'h706,12'h786,12'h6C6,12'h6C6,12'h666,12'h666,12'h636,12'h636,12'h61E,12'h60E,12'h60E,12'h606,12'h000,12'h000};
        // L
        assign letters[21] = {12'h600,12'h600,12'h600,12'h600,12'h600,12'h600,12'h600,12'h600,12'h600,12'h600,12'h600,12'h600,12'h7FE,12'h7FE,12'h000,12'h000};
        // O
        assign letters[22] = {12'h0F0,12'h1F8,12'h39C,12'h30C,12'h606,12'h606,12'h606,12'h606,12'h606,12'h606,12'h30C,12'h39C,12'h1F8,12'h0F0,12'h000,12'h000};
        // C
        assign letters[23] = {12'h0F8,12'h1FC,12'h38E,12'h306,12'h600,12'h600,12'h600,12'h600,12'h600,12'h600,12'h306,12'h38E,12'h1FC,12'h0F8,12'h000,12'h000};
        // K
        assign letters[24] = {12'h606,12'h60E,12'h61C,12'h638,12'h670,12'h6E0,12'h7C0,12'h7C0,12'h6E0,12'h670,12'h638,12'h61C,12'h60E,12'h606,12'h000,12'h000};
        // E
        assign letters[25] = {12'h7FE,12'h7FE,12'h600,12'h600,12'h600,12'h600,12'h7F8,12'h7F8,12'h600,12'h600,12'h600,12'h600,12'h7FE,12'h7FE,12'h000,12'h000};
        // D
        assign letters[26] = {12'h7F0,12'h7F8,12'h61C,12'h60C,12'h606,12'h606,12'h606,12'h606,12'h606,12'h606,12'h60C,12'h61C,12'h7F8,12'h7F0,12'h000,12'h000};
		  
        logic [37:0] reset = 38'b0;
        logic [37:0] start = {38{1'b1}};
        logic [37:0] DONE = 38'b0;
        logic [1:0] screen_select;
        //assign screen_select = trigger;
        parameter WELCOME = 2'b00;
        parameter NUMPAD = 2'b01;
        parameter UNLOCKED = 2'b11;
        parameter NOTHING = 2'b10;
        assign screen_select = trigger[3:2];
        always_comb begin
               if (
                    ((screen_select!=NUMPAD) && (|DONE[29:8])) || 
                    ((screen_select!=WELCOME) && (|DONE[7:1])) || 
                    ((screen_select!=UNLOCKED) && (|DONE[37:30]))
                    ) begin
                    
                    x = x_fill;
                    y = y_fill;
                    colour = colour_fill;
                    plot = plot_fill;
                    reset = 38'b000_00000_00000_00000_00000_00000_00000_00000;
               end
               else if((screen_select === NOTHING) || DONE[0]===1'bx || DONE[0]===1'b0) begin
                    reset = 38'b000_00000_00000_00000_00000_00000_00000_00001;
                    x = x_fill;
                    y = y_fill;
                    colour = colour_fill;
                    plot = plot_fill;
               end else if((screen_select==NUMPAD) && (DONE[8]===1'bx || DONE[8]===1'b0)) begin
                    reset = 38'b000_00000_00000_00000_00000_00000_01000_00001;
                    x = x_cir_1;
                    y = y_cir_1;
                    colour = colour_cir_1;
                    plot = plot_cir_1;
               end else if((screen_select==NUMPAD) && (DONE[9]===1'bx|| DONE[9]===1'b0)) begin
                    reset = 38'b000_00000_00000_00000_00000_00000_11000_00001;
                    x = x_cir_2;
                    y = y_cir_2;
                    colour = colour_cir_2;
                    plot = plot_cir_2;
               end else if((screen_select==NUMPAD) && (DONE[10]===1'bx || DONE[10]===1'b0)) begin
                    reset = 38'b000_00000_00000_00000_00000_00001_11000_00001;
                    x = x_cir_3;
                    y = y_cir_3;
                    colour = colour_cir_3;
                    plot = plot_cir_3;
               end else if((screen_select==NUMPAD) && (DONE[11]===1'bx || DONE[11]===1'b0)) begin
                    reset = 38'b000_00000_00000_00000_00000_00011_11000_00001;
                    x = x_cir_4;
                    y = y_cir_4;
                    colour = colour_cir_4;
                    plot = plot_cir_4;
               end else if((screen_select==NUMPAD) && (DONE[12]===1'bx|| DONE[12]===1'b0)) begin
                    reset = 38'b000_00000_00000_00000_00000_00111_11000_00001;
                    x = x_cir_5;
                    y = y_cir_5;
                    colour = colour_cir_5;
                    plot = plot_cir_5;
               end else if((screen_select==NUMPAD) && (DONE[13]===1'bx|| DONE[13]===1'b0)) begin
                    reset = 38'b000_00000_00000_00000_00000_01111_11000_00001;
                    x = x_cir_6;
                    y = y_cir_6;
                    colour = colour_cir_6;
                    plot = plot_cir_6;
               end else if((screen_select==NUMPAD) && (DONE[14]===1'bx|| DONE[14]===1'b0)) begin
                    reset = 38'b000_00000_00000_00000_00000_11111_11000_00001;
                    x = x_cir_7;
                    y = y_cir_7;
                    colour = colour_cir_7;
                    plot = plot_cir_7;
               end else if((screen_select==NUMPAD) && (DONE[15]===1'bx|| DONE[15]===1'b0)) begin
                    reset = 38'b000_00000_00000_00000_00001_11111_11000_00001;
                    x = x_cir_8;
                    y = y_cir_8;
                    colour = colour_cir_8;
                    plot = plot_cir_8;
               end else if((screen_select==NUMPAD) && (DONE[16]===1'bx|| DONE[16]===1'b0)) begin
                    reset = 38'b000_00000_00000_00000_00011_11111_11000_00001;
                    x = x_cir_9;
                    y = y_cir_9;
                    colour = colour_cir_9;
                    plot = plot_cir_9;
               end else if((screen_select==NUMPAD) && (DONE[17]===1'bx|| DONE[17]===1'b0))begin
                    reset = 38'b000_00000_00000_00000_00111_11111_11000_00001;
                    x = x_cir_0;
                    y = y_cir_0;
                    colour = colour_cir_0;
                    plot = plot_cir_0;
               end
               else if((screen_select==NUMPAD) &&  (DONE[18]===1'bx|| DONE[18]===1'b0))begin
                    reset = 38'b000_00000_00000_00000_01111_11111_11000_00001;
                    x = x_ltr_1;
                    y = y_ltr_1;
                    colour = colour_ltr_1;
                    plot = plot_ltr_1;
               end
               else if((screen_select==NUMPAD) && (DONE[19]===1'bx|| DONE[19]===1'b0)) begin
                    reset = 38'b000_00000_00000_00000_11111_11111_11000_00001;
                    x = x_ltr_2;
                    y = y_ltr_2;
                    colour = colour_ltr_2;
                    plot = plot_ltr_2;
               end
               else if((screen_select==NUMPAD) && (DONE[20]===1'bx|| DONE[20]===1'b0))begin
                    reset = 38'b000_00000_00000_00001_11111_11111_11000_00001;
                    x = x_ltr_3;
                    y = y_ltr_3;
                    colour = colour_ltr_3;
                    plot = plot_ltr_3;
               end
               else if((screen_select==NUMPAD) && (DONE[21]===1'bx|| DONE[21]===1'b0))begin
                    reset = 38'b000_00000_00000_00011_11111_11111_11000_00001;
                    x = x_ltr_4;
                    y = y_ltr_4;
                    colour = colour_ltr_4;
                    plot = plot_ltr_4;
               end
               else if((screen_select==NUMPAD) && (DONE[22]===1'bx|| DONE[22]===1'b0))begin
                    reset = 38'b000_00000_00000_00111_11111_11111_11000_00001;
                    x = x_ltr_5;
                    y = y_ltr_5;
                    colour = colour_ltr_5;
                    plot = plot_ltr_5;
               end
               else if((screen_select==NUMPAD) && (DONE[23]===1'bx|| DONE[23]===1'b0)) begin
                    reset = 38'b000_00000_00000_01111_11111_11111_11000_00001;
                    x = x_ltr_6;
                    y = y_ltr_6;
                    colour = colour_ltr_6;
                    plot = plot_ltr_6;
               end
               else if((screen_select==NUMPAD) && (DONE[24]===1'bx|| DONE[24]===1'b0))begin
                    reset = 38'b000_00000_00000_11111_11111_11111_11000_00001;
                    x = x_ltr_7;
                    y = y_ltr_7;
                    colour = colour_ltr_7;
                    plot = plot_ltr_7;
               end
               else if((screen_select==NUMPAD) && (DONE[25]===1'bx|| DONE[25]===1'b0))begin
                    reset = 38'b000_00000_00001_11111_11111_11111_11000_00001;
                    x = x_ltr_8;
                    y = y_ltr_8;
                    colour = colour_ltr_8;
                    plot = plot_ltr_8;
               end
               else if((screen_select==NUMPAD) && (DONE[26]===1'bx|| DONE[26]===1'b0))begin
                    reset = 38'b000_00000_00011_11111_11111_11111_11000_00001;
                    x = x_ltr_9;
                    y = y_ltr_9;
                    colour = colour_ltr_9;
                    plot = plot_ltr_9;
               end
               else if((screen_select==NUMPAD) && (DONE[27]===1'bx|| DONE[27]===1'b0))begin
                    reset = 38'b000_00000_00111_11111_11111_11111_11000_00001;
                    x = x_ltr_0;
                    y = y_ltr_0;
                    colour = colour_ltr_0;
                    plot = plot_ltr_0;
               end
               else if((screen_select==NUMPAD) && (DONE[28]===1'bx|| DONE[28]===1'b0))begin
                    reset = 38'b000_00000_01111_11111_11111_11111_11000_00001;
                    x = x_ltr_X;
                    y = y_ltr_X;
                    colour = colour_ltr_X;
                    plot = plot_ltr_X;
               end
               else if((screen_select==NUMPAD)) begin
                    reset = 38'b000_00000_11111_11111_11111_11111_11000_00001;
                    x = x_ltr_check;
                    y = y_ltr_check;
                    colour = colour_ltr_check;
                    plot = plot_ltr_check;
               end

                //WELCOME
            else if((screen_select==WELCOME) && (DONE[1]===1'bx|| DONE[1]===1'b0)) begin
                    reset = 38'b000_00000_00000_00000_00000_00000_00000_00011;
                    x = x_ltr_0_WELCOME;
                    y = y_ltr_0_WELCOME;
                    colour = colour_ltr_0_WELCOME;
                    plot = plot_ltr_0_WELCOME;
               end

               else if((screen_select==WELCOME) && (DONE[2]===1'bx|| DONE[2]===1'b0)) begin
                    reset = 38'b000_00000_00000_00000_00000_00000_00000_00111;
                    x = x_ltr_1_WELCOME;
                    y = y_ltr_1_WELCOME;
                    colour = colour_ltr_1_WELCOME;
                    plot = plot_ltr_1_WELCOME;
               end

               else if((screen_select==WELCOME) && (DONE[3]===1'bx|| DONE[3]===1'b0)) begin
                    reset = 38'b000_00000_00000_00000_00000_00000_00000_01111;
                    x = x_ltr_2_WELCOME;
                    y = y_ltr_2_WELCOME;
                    colour = colour_ltr_2_WELCOME;
                    plot = plot_ltr_2_WELCOME;
               end

               else if ((screen_select==WELCOME) && (DONE[4]===1'bx|| DONE[4]===1'b0)) begin
                    reset = 38'b000_00000_00000_00000_00000_00000_00000_11111;
                    x = x_ltr_3_WELCOME;
                    y = y_ltr_3_WELCOME;
                    colour = colour_ltr_3_WELCOME;
                    plot = plot_ltr_3_WELCOME;
               end

               else if ((screen_select==WELCOME) && (DONE[5]===1'bx|| DONE[5]===1'b0)) begin
                    reset = 38'b000_00000_00000_00000_00000_00000_00001_11111;
                    x = x_ltr_4_WELCOME;
                    y = y_ltr_4_WELCOME;
                    colour = colour_ltr_4_WELCOME;
                    plot = plot_ltr_4_WELCOME;
               end
                else if ((screen_select==WELCOME) && (DONE[6]===1'bx|| DONE[6]===1'b0)) begin
                    reset = 38'b000_00000_00000_00000_00000_00000_00011_11111;
                    x = x_ltr_5_WELCOME;
                    y = y_ltr_5_WELCOME;
                    colour = colour_ltr_5_WELCOME;
                    plot = plot_ltr_5_WELCOME;
               end
               else if (screen_select==WELCOME) begin
                    reset = 38'b000_00000_00000_00000_00000_00000_00111_11111;
                    x = x_ltr_6_WELCOME;
                    y = y_ltr_6_WELCOME;
                    colour = colour_ltr_6_WELCOME;
                    plot = plot_ltr_6_WELCOME;
               end
               //UNLOCKED
               else if((screen_select==UNLOCKED) && (DONE[30]===1'bx|| DONE[30]===1'b0)) begin
                    reset = 38'b000_00001_00000_00000_00000_00000_00000_00001;
                    x = x_ltr_0_UNLOCKED;
                    y = y_ltr_0_UNLOCKED;
                    colour = colour_ltr_0_UNLOCKED;
                    plot = plot_ltr_0_UNLOCKED;
               end
               else if((screen_select==UNLOCKED) && (DONE[31]===1'bx|| DONE[31]===1'b0)) begin
                    reset = 38'b000_00011_00000_00000_00000_00000_00000_00001;
                    x = x_ltr_1_UNLOCKED;
                    y = y_ltr_1_UNLOCKED;
                    colour = colour_ltr_1_UNLOCKED;
                    plot = plot_ltr_1_UNLOCKED;
               end
               else if((screen_select==UNLOCKED) && (DONE[32]===1'bx|| DONE[32]===1'b0)) begin
                    reset = 38'b000_00111_00000_00000_00000_00000_00000_00001;
                    x = x_ltr_2_UNLOCKED;
                    y = y_ltr_2_UNLOCKED;
                    colour = colour_ltr_2_UNLOCKED;
                    plot = plot_ltr_2_UNLOCKED;
               end
               else if((screen_select==UNLOCKED) && (DONE[33]===1'bx|| DONE[33]===1'b0)) begin
                    reset = 38'b000_01111_00000_00000_00000_00000_00000_00001;
                    x = x_ltr_3_UNLOCKED;
                    y = y_ltr_3_UNLOCKED;
                    colour = colour_ltr_3_UNLOCKED;
                    plot = plot_ltr_3_UNLOCKED;
               end
               else if((screen_select==UNLOCKED) && (DONE[34]===1'bx|| DONE[34]===1'b0)) begin
                    reset = 38'b000_11111_00000_00000_00000_00000_00000_00001;
                    x = x_ltr_4_UNLOCKED;
                    y = y_ltr_4_UNLOCKED;
                    colour = colour_ltr_4_UNLOCKED;
                    plot = plot_ltr_4_UNLOCKED;
               end
               else if((screen_select==UNLOCKED) && (DONE[35]===1'bx|| DONE[35]===1'b0)) begin
                    reset = 38'b001_11111_00000_00000_00000_00000_00000_00001;
                    x = x_ltr_5_UNLOCKED;
                    y = y_ltr_5_UNLOCKED;
                    colour = colour_ltr_5_UNLOCKED;
                    plot = plot_ltr_5_UNLOCKED;
               end
               else if((screen_select==UNLOCKED) && (DONE[36]===1'bx|| DONE[36]===1'b0)) begin
                    reset = 38'b011_11111_00000_00000_00000_00000_00000_00001;
                    x = x_ltr_6_UNLOCKED;
                    y = y_ltr_6_UNLOCKED;
                    colour = colour_ltr_6_UNLOCKED;
                    plot = plot_ltr_6_UNLOCKED;
               end
               else if(screen_select==UNLOCKED) begin
                    reset = 38'b111_11111_00000_00000_00000_00000_00000_00001;
                    x = x_ltr_7_UNLOCKED;
                    y = y_ltr_7_UNLOCKED;
                    colour = colour_ltr_7_UNLOCKED;
                    plot = plot_ltr_7_UNLOCKED;
               end
          
               else begin
                   reset = 38'b000_00000_00000_00000_00000_00000_00000_00001;
                    x = x_fill;
                    y = y_fill;
                    colour = colour_fill;
                    plot = plot_fill;
                 
               end
        end

        fillascreen fill(.clk(CLOCK_50), .rst_n(reset[0]), .colour(black), .start(start[0]), .done(DONE[0]), .vga_x(x_fill), .vga_y(y_fill), .vga_colour(colour_fill), .vga_plot(plot_fill));
     
        letter let0_W(.clk(CLOCK_50),.rst_n(reset[1]), .colour(cyan), .start(start[1]),.x(ltrx_0_WELCOME),.y(ltry_0_WELCOME), .letter(letters[12]), .done(DONE[1]), .vga_x(x_ltr_0_WELCOME), .vga_y(y_ltr_0_WELCOME), .vga_colour(colour_ltr_0_WELCOME), .vga_plot(plot_ltr_0_WELCOME));
        letter let1_E(.clk(CLOCK_50),.rst_n(reset[2]), .colour(cyan), .start(start[2]),.x(ltrx_1_WELCOME),.y(ltry_0_WELCOME), .letter(letters[13]), .done(DONE[2]), .vga_x(x_ltr_1_WELCOME), .vga_y(y_ltr_1_WELCOME), .vga_colour(colour_ltr_1_WELCOME), .vga_plot(plot_ltr_1_WELCOME));
        letter let2_L(.clk(CLOCK_50),.rst_n(reset[3]), .colour(cyan), .start(start[3]),.x(ltrx_2_WELCOME),.y(ltry_0_WELCOME), .letter(letters[14]), .done(DONE[3]), .vga_x(x_ltr_2_WELCOME), .vga_y(y_ltr_2_WELCOME), .vga_colour(colour_ltr_2_WELCOME), .vga_plot(plot_ltr_2_WELCOME));
        letter let3_C(.clk(CLOCK_50),.rst_n(reset[4]), .colour(cyan), .start(start[4]),.x(ltrx_3_WELCOME),.y(ltry_0_WELCOME), .letter(letters[15]), .done(DONE[4]), .vga_x(x_ltr_3_WELCOME), .vga_y(y_ltr_3_WELCOME), .vga_colour(colour_ltr_3_WELCOME), .vga_plot(plot_ltr_3_WELCOME));
        letter let4_O(.clk(CLOCK_50),.rst_n(reset[5]), .colour(cyan), .start(start[5]),.x(ltrx_4_WELCOME),.y(ltry_0_WELCOME), .letter(letters[16]), .done(DONE[5]), .vga_x(x_ltr_4_WELCOME), .vga_y(y_ltr_4_WELCOME), .vga_colour(colour_ltr_4_WELCOME), .vga_plot(plot_ltr_4_WELCOME));
        letter let5_M(.clk(CLOCK_50),.rst_n(reset[6]), .colour(cyan), .start(start[6]),.x(ltrx_5_WELCOME),.y(ltry_0_WELCOME), .letter(letters[17]), .done(DONE[6]), .vga_x(x_ltr_5_WELCOME), .vga_y(y_ltr_5_WELCOME), .vga_colour(colour_ltr_5_WELCOME), .vga_plot(plot_ltr_5_WELCOME));
        letter let6_E(.clk(CLOCK_50),.rst_n(reset[7]), .colour(cyan), .start(start[7]),.x(ltrx_6_WELCOME),.y(ltry_0_WELCOME), .letter(letters[18]), .done(DONE[7]), .vga_x(x_ltr_6_WELCOME), .vga_y(y_ltr_6_WELCOME), .vga_colour(colour_ltr_6_WELCOME), .vga_plot(plot_ltr_6_WELCOME));


        circle cir1(.clk(CLOCK_50), .rst_n(reset[8]), .colour(cyan), .centre_x(ctrx_1), .centre_y(ctry_1), .radius(rad), .start(start[8]), .done(DONE[8]), .vga_x(x_cir_1), .vga_y(y_cir_1), .vga_colour(colour_cir_1), .vga_plot(plot_cir_1));
        circle cir2(.clk(CLOCK_50), .rst_n(reset[9]), .colour(cyan), .centre_x(ctrx_2), .centre_y(ctry_1), .radius(rad), .start(start[9]), .done(DONE[9]), .vga_x(x_cir_2), .vga_y(y_cir_2), .vga_colour(colour_cir_2), .vga_plot(plot_cir_2));
        circle cir3(.clk(CLOCK_50), .rst_n(reset[10]), .colour(cyan), .centre_x(ctrx_3), .centre_y(ctry_1), .radius(rad), .start(start[10]), .done(DONE[10]), .vga_x(x_cir_3), .vga_y(y_cir_3), .vga_colour(colour_cir_3), .vga_plot(plot_cir_3));
        circle cir4(.clk(CLOCK_50), .rst_n(reset[11]), .colour(cyan), .centre_x(ctrx_1), .centre_y(ctry_2), .radius(rad), .start(start[11]), .done(DONE[11]), .vga_x(x_cir_4), .vga_y(y_cir_4), .vga_colour(colour_cir_4), .vga_plot(plot_cir_4));
        circle cir5(.clk(CLOCK_50), .rst_n(reset[12]), .colour(cyan), .centre_x(ctrx_2), .centre_y(ctry_2), .radius(rad), .start(start[12]), .done(DONE[12]), .vga_x(x_cir_5), .vga_y(y_cir_5), .vga_colour(colour_cir_5), .vga_plot(plot_cir_5));
        circle cir6(.clk(CLOCK_50), .rst_n(reset[13]), .colour(cyan), .centre_x(ctrx_3), .centre_y(ctry_2), .radius(rad), .start(start[13]), .done(DONE[13]), .vga_x(x_cir_6), .vga_y(y_cir_6), .vga_colour(colour_cir_6), .vga_plot(plot_cir_6));
        circle cir7(.clk(CLOCK_50), .rst_n(reset[14]), .colour(cyan), .centre_x(ctrx_1), .centre_y(ctry_3), .radius(rad), .start(start[14]), .done(DONE[14]), .vga_x(x_cir_7), .vga_y(y_cir_7), .vga_colour(colour_cir_7), .vga_plot(plot_cir_7));
        circle cir8(.clk(CLOCK_50), .rst_n(reset[15]), .colour(cyan), .centre_x(ctrx_2), .centre_y(ctry_3), .radius(rad), .start(start[15]), .done(DONE[15]), .vga_x(x_cir_8), .vga_y(y_cir_8), .vga_colour(colour_cir_8), .vga_plot(plot_cir_8));
        circle cir9(.clk(CLOCK_50), .rst_n(reset[16]), .colour(cyan), .centre_x(ctrx_3), .centre_y(ctry_3), .radius(rad), .start(start[16]), .done(DONE[16]), .vga_x(x_cir_9), .vga_y(y_cir_9), .vga_colour(colour_cir_9), .vga_plot(plot_cir_9));
        circle cir0(.clk(CLOCK_50), .rst_n(reset[17]), .colour(cyan), .centre_x(ctrx_2), .centre_y(ctry_4), .radius(rad), .start(start[17]), .done(DONE[17]), .vga_x(x_cir_0), .vga_y(y_cir_0), .vga_colour(colour_cir_0), .vga_plot(plot_cir_0));

        letter let1(.clk(CLOCK_50),.rst_n(reset[18]), .colour(cyan), .start(start[18]),.x(ltrx_1),.y(ltry_1), .letter(letters[1]), .done(DONE[18]), .vga_x(x_ltr_1), .vga_y(y_ltr_1), .vga_colour(colour_ltr_1), .vga_plot(plot_ltr_1));
        letter let2(.clk(CLOCK_50),.rst_n(reset[19]), .colour(cyan), .start(start[19]),.x(ltrx_2),.y(ltry_1), .letter(letters[2]), .done(DONE[19]), .vga_x(x_ltr_2), .vga_y(y_ltr_2), .vga_colour(colour_ltr_2), .vga_plot(plot_ltr_2));
        letter let3(.clk(CLOCK_50),.rst_n(reset[20]), .colour(cyan), .start(start[20]),.x(ltrx_3),.y(ltry_1), .letter(letters[3]), .done(DONE[20]), .vga_x(x_ltr_3), .vga_y(y_ltr_3), .vga_colour(colour_ltr_3), .vga_plot(plot_ltr_3));
        letter let4(.clk(CLOCK_50),.rst_n(reset[21]), .colour(cyan), .start(start[21]),.x(ltrx_1),.y(ltry_2), .letter(letters[4]), .done(DONE[21]), .vga_x(x_ltr_4), .vga_y(y_ltr_4), .vga_colour(colour_ltr_4), .vga_plot(plot_ltr_4));
        letter let5(.clk(CLOCK_50),.rst_n(reset[22]), .colour(cyan), .start(start[22]),.x(ltrx_2),.y(ltry_2), .letter(letters[5]), .done(DONE[22]), .vga_x(x_ltr_5), .vga_y(y_ltr_5), .vga_colour(colour_ltr_5), .vga_plot(plot_ltr_5));
        letter let6(.clk(CLOCK_50),.rst_n(reset[23]), .colour(cyan), .start(start[23]),.x(ltrx_3),.y(ltry_2), .letter(letters[6]), .done(DONE[23]), .vga_x(x_ltr_6), .vga_y(y_ltr_6), .vga_colour(colour_ltr_6), .vga_plot(plot_ltr_6));
        letter let7(.clk(CLOCK_50),.rst_n(reset[24]), .colour(cyan), .start(start[24]),.x(ltrx_1),.y(ltry_3), .letter(letters[7]), .done(DONE[24]), .vga_x(x_ltr_7), .vga_y(y_ltr_7), .vga_colour(colour_ltr_7), .vga_plot(plot_ltr_7));
        letter let8(.clk(CLOCK_50),.rst_n(reset[25]), .colour(cyan), .start(start[25]),.x(ltrx_2),.y(ltry_3), .letter(letters[8]), .done(DONE[25]), .vga_x(x_ltr_8), .vga_y(y_ltr_8), .vga_colour(colour_ltr_8), .vga_plot(plot_ltr_8));
        letter let9(.clk(CLOCK_50),.rst_n(reset[26]), .colour(cyan), .start(start[26]),.x(ltrx_3),.y(ltry_3), .letter(letters[9]), .done(DONE[26]), .vga_x(x_ltr_9), .vga_y(y_ltr_9), .vga_colour(colour_ltr_9), .vga_plot(plot_ltr_9));
        letter let0(.clk(CLOCK_50),.rst_n(reset[27]), .colour(cyan), .start(start[27]),.x(ltrx_2),.y(ltry_4), .letter(letters[0]), .done(DONE[27]), .vga_x(x_ltr_0), .vga_y(y_ltr_0), .vga_colour(colour_ltr_0), .vga_plot(plot_ltr_0));
        letter letX(.clk(CLOCK_50),.rst_n(reset[28]), .colour(red), .start(start[28]),.x(ltrx_1),.y(ltry_4), .letter(letters[10]), .done(DONE[28]), .vga_x(x_ltr_X), .vga_y(y_ltr_X), .vga_colour(colour_ltr_X), .vga_plot(plot_ltr_X));
        letter letCheck(.clk(CLOCK_50),.rst_n(reset[29]), .colour(green), .start(start[29]),.x(ltrx_3),.y(ltry_4), .letter(letters[11]), .done(DONE[29]), .vga_x(x_ltr_check), .vga_y(y_ltr_check), .vga_colour(colour_ltr_check), .vga_plot(plot_ltr_check));

        letter let_U(.clk(CLOCK_50),.rst_n(reset[30]), .colour(green), .start(start[30]),.x(ltrx_0_UNLOCKED),.y(ltry_0_UNLOCKED), .letter(letters[19]), .done(DONE[30]), .vga_x(x_ltr_0_UNLOCKED), .vga_y(y_ltr_0_UNLOCKED), .vga_colour(colour_ltr_0_UNLOCKED), .vga_plot(plot_ltr_0_UNLOCKED));
        letter let_N(.clk(CLOCK_50),.rst_n(reset[31]), .colour(green), .start(start[31]),.x(ltrx_1_UNLOCKED),.y(ltry_0_UNLOCKED), .letter(letters[20]), .done(DONE[31]), .vga_x(x_ltr_1_UNLOCKED), .vga_y(y_ltr_1_UNLOCKED), .vga_colour(colour_ltr_1_UNLOCKED), .vga_plot(plot_ltr_1_UNLOCKED));
        letter let_L(.clk(CLOCK_50),.rst_n(reset[32]), .colour(green), .start(start[32]),.x(ltrx_2_UNLOCKED),.y(ltry_0_UNLOCKED), .letter(letters[21]), .done(DONE[32]), .vga_x(x_ltr_2_UNLOCKED), .vga_y(y_ltr_2_UNLOCKED), .vga_colour(colour_ltr_2_UNLOCKED), .vga_plot(plot_ltr_2_UNLOCKED));
        letter let_O(.clk(CLOCK_50),.rst_n(reset[33]), .colour(green), .start(start[33]),.x(ltrx_3_UNLOCKED),.y(ltry_0_UNLOCKED), .letter(letters[22]), .done(DONE[33]), .vga_x(x_ltr_3_UNLOCKED), .vga_y(y_ltr_3_UNLOCKED), .vga_colour(colour_ltr_3_UNLOCKED), .vga_plot(plot_ltr_3_UNLOCKED));
        letter let_C(.clk(CLOCK_50),.rst_n(reset[34]), .colour(green), .start(start[34]),.x(ltrx_4_UNLOCKED),.y(ltry_0_UNLOCKED), .letter(letters[23]), .done(DONE[34]), .vga_x(x_ltr_4_UNLOCKED), .vga_y(y_ltr_4_UNLOCKED), .vga_colour(colour_ltr_4_UNLOCKED), .vga_plot(plot_ltr_4_UNLOCKED));
        letter let_K(.clk(CLOCK_50),.rst_n(reset[35]), .colour(green), .start(start[35]),.x(ltrx_5_UNLOCKED),.y(ltry_0_UNLOCKED), .letter(letters[24]), .done(DONE[35]), .vga_x(x_ltr_5_UNLOCKED), .vga_y(y_ltr_5_UNLOCKED), .vga_colour(colour_ltr_5_UNLOCKED), .vga_plot(plot_ltr_5_UNLOCKED));
        letter let_E(.clk(CLOCK_50),.rst_n(reset[36]), .colour(green), .start(start[36]),.x(ltrx_6_UNLOCKED),.y(ltry_0_UNLOCKED), .letter(letters[25]), .done(DONE[36]), .vga_x(x_ltr_6_UNLOCKED), .vga_y(y_ltr_6_UNLOCKED), .vga_colour(colour_ltr_6_UNLOCKED), .vga_plot(plot_ltr_6_UNLOCKED));
        letter let_D(.clk(CLOCK_50),.rst_n(reset[37]), .colour(green), .start(start[37]),.x(ltrx_7_UNLOCKED),.y(ltry_0_UNLOCKED), .letter(letters[26]), .done(DONE[37]), .vga_x(x_ltr_7_UNLOCKED), .vga_y(y_ltr_7_UNLOCKED), .vga_colour(colour_ltr_7_UNLOCKED), .vga_plot(plot_ltr_7_UNLOCKED));

        vga_adapter#(.RESOLUTION("160x120")) dis(.resetn(SW[0]), .clock(CLOCK_50), .colour(colour), .x(x), .y(y), .plot(plot), .VGA_R(VGA_R_10), .VGA_G(VGA_G_10), .VGA_B(VGA_B_10), .*);
endmodule