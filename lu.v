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
    assign bandc = covered_i[1] & covered_i[0];
    assign aandc = covered_i[2] & covered_i[0];

    always @(*) begin

        case (mode_buf_i)
            `MODE1: hit = covered_i[2];
            `MODE2: hit = aandb;
            `MODE3: hit = covered_i[2] ^ covered_i[1];
            `MODE4: hit = (aandb | bandc | aandc) & !(aandb & covered_i[0]);
            default: hit = 0;
        endcase
    end

endmodule
