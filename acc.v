/* acc.v
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
    always @(posedge clk_i) begin
        if (rst_i || acc_clear_i)
            candidate_o <= `CANDIDATE_SZ'b0;
        else
            candidate_o <= candidate_o + psum;
    end

    //  psum
    always @(*) begin
        if (!acc_en_i)
            psum = `CANDIDATE_SZ'b0;
        else begin
            psum = hit_i[0] + hit_i[1] + hit_i[2] + hit_i[3];
        end
    end

endmodule