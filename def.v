/* def.v
 * Define some neccessary values in this project
 */
// bit widths
`define COORD_SZ     8
`define CENTRAL_SZ   24
`define RADIUS_SZ    12
`define COVERED_SZ   3
`define MODE_SZ      2
`define LU_BUS_SZ    4
`define CANDIDATE_SZ 8
`define SQR_SZ       8
`define ROW_SZ       4
`define X_COORD_SZ   4
`define Y_COORD_SZ   4

// position of coordinate
`define X_COORD 7:4
`define Y_COORD 3:0
`define A_X     23:20
`define A_Y     19:16
`define B_Y     15:12
`define B_X     11:8
`define C_Y     7:4
`define C_X     3:0

// position of raidus
`define A_R     11:8
`define B_R     7:4
`define C_R     3:0

// modes
`define MODE1  2'd0  // covered in a circle
`define MODE2  2'd1  // A & B
`define MODE3  2'd2  // (A | B) - (A & B)
`define MODE4  2'd3  // (A & B) + (B & C) + (A & C) - (A | B | C)
