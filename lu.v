/* lu.v
 * LU module implementation, calculate logic
 * with different input modes
 */
`include "def.v"
module LU (
    input [`COVERED_SZ-1:0] covered_i,
    input [`MODE_SZ-1:0] mode_buf_i,
    output reg hit
);

    assign aandb = covered_i[2] & covered_i[1];

    always @(*) begin

        case (mode_buf_i)
            `MODE1: hit = covered_i[2];
            `MODE2: hit = aandb;
            `MODE3: hit = covered_i[2] ^ covered_i[1];
            `MODE4: hit = |covered_i - &covered_i;
            default: hit = 0;
        endcase
    end

endmodule
