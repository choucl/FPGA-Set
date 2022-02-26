/* FPGA Homework0 - SET                       
 * file: buffer.v                         
 * description: Use to hold inputs.                   
 * author: Jumha (e24076750@gs.ncku.edu.tw)   
 */

`include "def.v"

module buffer(
    input                        clk_i, 
    input                        rst_i, 
    input                        buffer_en_i, 
    input                        clear_i, 
    input  [`CENTRAL_SZ-1:0]     central_i, 
    input  [`RADIUS_SZ-1:0]      r_i, 
    output reg [`CENTRAL_SZ-1:0] central_buf_o, 
    output reg [`RADIUS_SZ-1:0]  r_buf_o
);

    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i == 1'b1) begin
            central_buf_o <= `CENTRAL_SZ'b0;
            r_buf_o       <= `RADIUS_SZ'b0;
        end
        else if (clear_i == 1'b1) begin // when the system is done
            central_buf_o <= `CENTRAL_SZ'b0;
            r_buf_o       <= `RADIUS_SZ'b0;
        end
        else begin
            if (buffer_en_i == 1'b1) begin // else: hold the value
                central_buf_o <= central_i;
                r_buf_o       <= r_i;
            end
        end
    end

endmodule
