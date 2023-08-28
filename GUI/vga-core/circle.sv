module circle(input logic clk, input logic rst_n, input logic [2:0] colour,
              input logic [7:0] centre_x, input logic [6:0] centre_y, input logic [7:0] radius,
              input logic start, output logic done,
              output logic [7:0] vga_x, output logic [6:0] vga_y,
              output logic [2:0] vga_colour, output logic vga_plot);
     // draw the circle

     logic [7:0] offx;             // initiallize variables
     logic signed [8:0] crit;
     logic [6:0] offy;
     logic signed [8:0] x = -1;
     logic signed [8:0] y = -1;

     enum{rst, init, oct1, oct2, oct3, oct4, oct5, oct6, oct7, oct8, finish} state = init;

     assign vga_x = x;
     assign vga_y = y;

     always @(posedge clk or negedge rst_n) begin
          if(~rst_n)
          begin
               state <= init;
               done <= 0;
          end
          else begin
               case(state)
                    rst: state <= rst;
                    init: begin
                         vga_plot = 0;            // set initial values for variables
                         offx = radius;
                         offy = 0;
                         crit = 1 - radius;
                         vga_colour = colour;
                         done = 0;
                         if(start)
                              state <= oct1;
                    end
                    oct1: begin
                         vga_plot = 0;
                         x = centre_x + offx;
                         y = centre_y + offy;
                         if(x >= 0 && x < 160 && y >= 0 && y < 120)   // checks to make sure pixel is in screen bounds
                              vga_plot = 1;
                         state <= oct2;
                    end
                    oct2: begin
                         vga_plot = 0;
                         x = centre_x + offy;
                         y = centre_y + offx;
                         if(x >= 0 && x < 160 && y >= 0 && y < 120)
                              vga_plot = 1;
                         state <= oct3;
                    end
                    oct3: begin
                         vga_plot = 0;
                         x = centre_x - offy;
                         y = centre_y + offx;
                         if(x >= 0 && x < 160 && y >= 0 && y < 120)
                              vga_plot = 1;
                         state <= oct4;
                    end
                    oct4: begin
                         vga_plot = 0;
                         x = centre_x - offx;
                         y = centre_y + offy;
                         if(x >= 0 && x < 160 && y >= 0 && y < 120)
                              vga_plot = 1;
                         state <= oct5;
                    end
                    oct5: begin
                         vga_plot = 0;
                         x = centre_x - offx;
                         y = centre_y - offy;
                         if(x >= 0 && x < 160 && y >= 0 && y < 120)
                              vga_plot = 1;
                         state <= oct6;
                    end
                    oct6: begin
                         vga_plot = 0;
                         x = centre_x - offy;
                         y = centre_y - offx;
                         if(x >= 0 && x < 160 && y >= 0 && y < 120)
                              vga_plot = 1;
                         state <= oct7;
                    end
                    oct7: begin
                         vga_plot = 0;
                         x = centre_x + offy;
                         y = centre_y - offx;
                         if(x >= 0 && x < 160 && y >= 0 && y < 120)
                              vga_plot = 1;
                         state <= oct8;
                    end
                    oct8: begin
                         vga_plot = 0;
                         x = centre_x + offx;
                         y = centre_y - offy;

                         offy = offy + 1;

                         if(crit <= 0)
                              crit = crit + 2 * offy + 1;
                         else begin
                              offx = offx - 1;
                              crit = crit + 2 * (offy - offx) + 1;
                         end 

                         if(x >= 0 && x < 160 && y >= 0 && y < 120)
                              vga_plot = 1;
                         
                         if(offy <= offx)
                              state <= oct1;
                         else
                              state <= finish;
                    end
                    default: begin           // finish state
                         done = 1;
                         if(~start)
                              state <= init;
                    end
               endcase
          end
     end
endmodule

