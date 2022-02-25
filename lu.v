/* lu.v
 * LU module implementation, calculate logic
 * with different input modes
 */
`include "def.v"

module LU (
    input [`COVERED_SZ-1:0] covered_i,
    input [`MODE_SZ-1:0] mode_i,
    output reg hit
);

reg aorb;
reg aandb;
reg bandc;
reg aandc;

always @(*) begin

    aorb  = covered_i[2] | covered_i[1];
    aandb = covered_i[2] & covered_i[1];
    bandc = covered_i[1] & covered_i[0];
    aandc = covered_i[2] & covered_i[0];
    
    case (mode_i)
        `MODE1: hit = covered_i[2];
        `MODE2: hit = aandb;
        `MODE3: hit = aorb - aandb;
        `MODE4: hit = aandb + bandc + aandc - &covered_i;
        default: hit = 0;
    endcase
end

endmodule
