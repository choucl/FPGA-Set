/* FPGA Homework0 - SET                       
 * file: coord_gen.v                         
 * description: generate the coordanates for the system                  
 * author: Jumha (e24076750@gs.ncku.edu.tw)   
 */

`include "def.v"

module coord_gen(
    input                  clk_i, 
    input                  rst_i, 
    input  [`ROW_SZ-1:0]   start_row_i, 
    input                  coord_en_i, 
    output [`COORD_SZ-1:0] coord_o
);
  
    reg next_row;
    reg [`X_COORD_SZ-1:0] x_coord; 
    reg [`Y_COORD_SZ-1:0] y_coord; // x_coord and y_coor are 4 bits

    assign coord_o[`X_COORD] = x_coord;
    assign coord_o[`Y_COORD] = y_coord + {3'd0, next_row};

    always @(posedge clk_i or negedge rst_i) begin
      
        if (rst_i == 1'b1) begin
            next_row <= 1'b0;
            x_coord  <= `X_COORD_SZ'b0;
            y_coord  <= `Y_COORD_SZ'b0;
        end
        else begin
            if (coord_en_i == 1'b1) begin
                x_coord <= `X_COORD_SZ'b1;              // x start from 1
                y_coord <= start_row_i;
            end
            else begin
                if (x_coord == 4'b1000) begin // when x == 8, y += 1
                    x_coord  <= `X_COORD_SZ'b1;
                    next_row <= ~next_row;
                end
                else begin
                    x_coord <= x_coord + `X_COORD_SZ'b1;
                end
            end
        end
    end

endmodule  
