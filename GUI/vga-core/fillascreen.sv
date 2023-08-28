// modified module of fillscreen to take colour into account
module fillascreen(input logic clk, input logic rst_n, input logic [2:0] colour,
                  input logic start, output logic done,
                  output logic [7:0] vga_x, output logic [6:0] vga_y,
                  output logic [2:0] vga_colour, output logic vga_plot);
     // fill the screen

     enum{rst, init, fill, finish} state = init;

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
                         vga_x = -1;
                         vga_y = -1;
                         vga_colour = colour;
                         vga_plot = 0;
                         done = 0;
                         if(start)
                              state <= fill;
                    end
                    fill: begin
                         if(~start)
                              state <= init;
                         if(vga_y < 120) begin
                              vga_y = vga_y + 1;
                              vga_plot = 1;
                         end else begin
                              vga_x = vga_x + 1;
                              vga_y = 0;
                              vga_plot = 1;
                         end
                         if(vga_x == 160)
                              state <= finish;
                    end
                    default: begin
                         done = 1;
                         if(~start)
                              state <= init;
                    end
               endcase
          end
     end
endmodule
