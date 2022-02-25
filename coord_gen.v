/* FPGA Homework0 - SET                       
 * file: coord_gen.v                         
 * description: generate the coordanates for the system                  
 * author: Jumha (e24076750@gs.ncku.edu.tw)   
 */

`include "def.v"

module coord_gen(clk_i, rst_i, start_row_i, coord_en_i, coord_o);
  
  input clk_i, rst_i, coord_en_i;
  input [3:0] start_row_i;
  output [`COORD_SZ - 1:0] coord_o;

  reg next_row;
  reg [3:0] x_coord, y_coord; // x_coord and y_coor are 4 bits

  assign coord_o[`X_COORD] = x_coord;
  assign coord_o[`Y_COORD] = y_coord + next_row;

  always @(posedge clk_i or negedge rst_i) begin
    
    if (rst_i == 1'b1) begin
      next_row <= 4'b0;
      x_coord <= 4'b0;
      y_coord <= 4'b0;
    end
    else begin
      if (coord_en_i == 1'b1) begin
        x_coord <= 4'b1;              // x start from 1
        y_coord <= start_row_i;
      end
      else begin
        if (x_coord == 4'b1000) begin // when x == 8, y += 1
          x_coord <= 4'b1;
          next_row <= ~next_row;
        end
        else begin
          x_coord <= x_coord + 4'b1;
        end
      end
    end
  end

endmodule  


      
