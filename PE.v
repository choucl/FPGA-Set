/* PE.v
 * PE module implementation, processing element 
 * for calculating distances
 */
`include "def.v"
module PE (
    input [`COORD_SZ-1:0] coord_i,             // coordinate
    input [`RADIUS_SZ-1:0] r_buf_i,            // radius of circle
    input [`CENTRAL_SZ-1:0] cent_buf_i,        // center of circle
    output [`COVERED_SZ-1:0] covered_o         // output of coverage
);

    reg [`SQR_SZ+1:0] a_sqr;  // store the accumulate, bit were reserved for overflow situation
    reg [`SQR_SZ+1:0] b_sqr;
    reg [`SQR_SZ+1:0] c_sqr;

    always @(*) begin

        a_sqr = ({6'd0, coord_i[`X_COORD]} - {6'd0, cent_buf_i[`A_X]}) 
              * ({6'd0, coord_i[`X_COORD]} - {6'd0, cent_buf_i[`A_X]})
              + ({6'd0, coord_i[`Y_COORD]} - {6'd0, cent_buf_i[`A_Y]}) 
              * ({6'd0, coord_i[`Y_COORD]} - {6'd0, cent_buf_i[`A_Y]})
              - r_buf_i[`A_R] * r_buf_i[`A_R];
        
        b_sqr = ({6'd0, coord_i[`X_COORD]} - {6'd0, cent_buf_i[`B_X]}) 
              * ({6'd0, coord_i[`X_COORD]} - {6'd0, cent_buf_i[`B_X]})
              + ({6'd0, coord_i[`Y_COORD]} - {6'd0, cent_buf_i[`B_Y]}) 
              * ({6'd0, coord_i[`Y_COORD]} - {6'd0, cent_buf_i[`B_Y]})
              - r_buf_i[`B_R] * r_buf_i[`B_R];
        
        c_sqr = ({6'd0, coord_i[`X_COORD]} - {6'd0, cent_buf_i[`C_X]}) 
              * ({6'd0, coord_i[`X_COORD]} - {6'd0, cent_buf_i[`C_X]})
              + ({6'd0, coord_i[`Y_COORD]} - {6'd0, cent_buf_i[`C_Y]}) 
              * ({6'd0, coord_i[`Y_COORD]} - {6'd0, cent_buf_i[`C_Y]})
              - r_buf_i[`C_R] * r_buf_i[`C_R];

    end

    assign covered_o[2] = a_sqr[`SQR_SZ] | !(|a_sqr); // consider 0 situation
    assign covered_o[1] = b_sqr[`SQR_SZ] | !(|b_sqr);
    assign covered_o[0] = c_sqr[`SQR_SZ] | !(|c_sqr);

endmodule
