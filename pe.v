/* pe.v
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

    reg [`SQR_SZ:0] a_sqr;
    reg [`SQR_SZ:0] b_sqr;
    reg [`SQR_SZ:0] c_sqr;
    reg [`SQR_SZ:0] ra_sqr;
    reg [`SQR_SZ:0] rb_sqr;
    reg [`SQR_SZ:0] rc_sqr;

    always @(*) begin

        a_sqr  = (coord_i[`X_COORD] - cent_buf_i[`A_X]) 
               * (coord_i[`X_COORD] - cent_buf_i[`A_X]);
        a_sqr += (coord_i[`Y_COORD] - cent_buf_i[`A_Y]) 
               * (coord_i[`Y_COORD] - cent_buf_i[`A_Y]);
        ra_sqr = r_buf_i[`A_R] * r_buf_i[`A_R];
        
        b_sqr  = (coord_i[`X_COORD] - cent_buf_i[`B_X]) 
               * (coord_i[`X_COORD] - cent_buf_i[`B_X]);
        b_sqr += (coord_i[`Y_COORD] - cent_buf_i[`B_Y]) 
               * (coord_i[`Y_COORD] - cent_buf_i[`B_Y]);
        rb_sqr = r_buf_i[`B_R] * r_buf_i[`B_R];
        
        c_sqr  = (coord_i[`X_COORD] - cent_buf_i[`C_X]) 
               * (coord_i[`X_COORD] - cent_buf_i[`C_X]);
        c_sqr += (coord_i[`Y_COORD] - cent_buf_i[`C_Y]) 
               * (coord_i[`Y_COORD] - cent_buf_i[`C_Y]);
        rc_sqr = r_buf_i[`C_R] * r_buf_i[`C_R];

    end

    assign covered_o[2] = (ra_sqr >= a_sqr);
    assign covered_o[1] = (rb_sqr >= b_sqr);
    assign covered_o[0] = (rc_sqr >= c_sqr);

endmodule
