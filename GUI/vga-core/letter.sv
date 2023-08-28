module letter(input logic clk, input logic rst_n, input logic [2:0] colour,
                  input logic start, input logic [7:0] x, input logic [6:0] y,input logic [15:0][11:0] letter, output logic done,
                  output logic [7:0] vga_x, output logic [6:0] vga_y,
                  output logic [2:0] vga_colour, output logic vga_plot);

          //	DW $060,$060,$0F0,$0F0,$0F0,$198,$198,$198,$30C,$3FC,$3FC,$606,$606,$606,$000,$000	; A
          // 0 0,0, 1, 1,0 2 2,0  11 11,0 12 0,1 13 1,1 x = index%12 y = index/12  
          //assign letters[0] = {12'h060,12'h060, 12'h0F0, 12'h0F0, 12'h0F0, 12'h198, 12'h198, 12'h198, 12'h30C, 12'h3FC, 12'h3FC, 12'h606, 12'h606, 12'h606, 12'h000, 12'h000};
          enum{rst, init, fill, finish} state = init;

          always@(posedge clk or negedge rst_n) begin
               if(~rst_n)
               begin
                    state <= init;
                    done <= 0;
               end
               else begin
                    case(state)
                         rst: state <= rst;
                         init: begin
                              vga_x <= x;
                              vga_y <= y;
                              vga_colour = colour;
                              vga_plot <= 0;
                              done <= 0;
                              if(start)
                                   state <= fill;
                         end
                         fill: begin
                              if(~start)
                                   state <= init;
                              if (vga_x < x + 12) begin
                                   vga_plot <= letter[15+y-vga_y][11+x-vga_x];
                                   vga_x <= vga_x + 1;
                              end
                              else begin
                                   vga_plot <= letter[15+y-vga_y][11+x-vga_x];
                                   vga_y <= vga_y + 1;
                                   vga_x <= x;
                                   
                              end
                              if( vga_y == y+16)
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