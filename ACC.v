/* ACC.v
 * ACC module implementation, accumulate candidate
 */
`include "def.v"

module ACC(
    input                           clk_i,
    input                           rst_i,
    input                           acc_en_i,
    input                           acc_clear_i,
    input [`LU_BUS_SZ-1:0]          hit_i,
    output reg [`CANDIDATE_SZ-1:0]  candidate_o
);

    reg [`CANDIDATE_SZ-1:0]         psum;

    //  candidate
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i == 1'b1)
            candidate_o <= `CANDIDATE_SZ'b0;
        else if (acc_clear_i == 1'b1)
            candidate_o <= `CANDIDATE_SZ'b0;
        else
            candidate_o <= candidate_o + psum;
    end

    //  psum
    always @(*) begin
        if (acc_en_i == 1'b0)
            psum = `CANDIDATE_SZ'b0;
        else
            psum = {7'd0, hit_i[0]} + {7'd0, hit_i[1]}
                 + {7'd0, hit_i[2]} + {7'd0, hit_i[3]};
    end

endmodule
