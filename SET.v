`include "def.v"
`include "controller.v"
`include "buffer.v"
`include "coord_gen.v"
`include "pe.v"
`include "lu.v"
`include "acc.v"

module SET (clk, rst, en, central, radius, mode, busy, valid, candidate);

    input                   clk;
    input                   rst;
    input                   en;
    input [23:0]            central;
    input [11:0]            radius;
    input [1:0]             mode;
    output                  busy;
    output                  valid;
    output [7:0]            candidate;

    // 4 PEs and 4 LUs
    wire [`COORD_SZ-1:0]    coord[3:0];     // output of coord_gen
    wire [`COVERED_SZ-1:0]  covered[3:0];   // output of PE
    wire [`LU_BUS_SZ-1:0]   hit;            // output of LU
    wire [`MODE_SZ-1:0]     mode_buf;       // output of buffer
    wire [`CENTRAL_SZ-1:0]  cent_buf;       // output of buffer
    wire [`RADIUS_SZ-1:0]   r_buf;          // output of buffer
    wire                    clear;          // output of controller, input of buffer
    wire                    buffer_en;      // output of controller, input of buffer
    wire                    coord_en;       // output of controller, input of coord_gen
    wire                    acc_en;         // output of controller, input of ACC
    wire                    acc_clear;      // output of controller, input of ACC

    //  Controller
    controller CTRL(
        .clk_i      (clk),
        .rst_i      (rst),
        .en_i       (en),
        .valid_o    (valid),
        .busy_o     (busy),
        .acc_en_o   (acc_en),
        .acc_clear_o(acc_clear),
        .buffer_en_o(buffer_en),
        .clear_o    (clear),
        .coord_en_o (coord_en)
    );

    //  Buffer
    buffer BUF(
        .clk_i        (clk),
        .rst_i        (rst),
        .buffer_en_i  (buffer_en),
        .clear_i      (clear),
        .mode_i       (mode),
        .central_i    (central),
        .r_i          (radius),
        .mode_buf_o   (mode_buf),
        .central_buf_o(cent_buf),  // rename?
        .r_buf_o      (r_buf)
    );

    //  coord_gen
    coord_gen CG0(
        .clk_i      (clk),
        .rst_i      (rst),
        .start_row_i(4'd1),  // start from row 1
        .coord_en_i (coord_en),
        .coord_o    (coord[0])
    );

    coord_gen CG1(
        .clk_i      (clk),
        .rst_i      (rst),
        .start_row_i(4'd3),  // start from row 3
        .coord_en_i (coord_en),
        .coord_o    (coord[1])
    );

    coord_gen CG2(
        .clk_i      (clk),
        .rst_i      (rst),
        .start_row_i(4'd5),  // start from row 5
        .coord_en_i (coord_en),
        .coord_o    (coord[2])
    );

    coord_gen CG3(
        .clk_i      (clk),
        .rst_i      (rst),
        .start_row_i(4'd7),  // start from row 7
        .coord_en_i (coord_en),
        .coord_o    (coord[3])
    );

    //  PE
    PE PE0(
        .coord_i   (coord[0]),
        .r_buf_i   (r_buf),
        .cent_buf_i(cent_buf),
        .covered_o (covered[0])
    );

    PE PE1(
        .coord_i   (coord[1]),
        .r_buf_i   (r_buf),
        .cent_buf_i(cent_buf),
        .covered_o (covered[1])
    );

    PE PE2(
        .coord_i   (coord[2]),
        .r_buf_i   (r_buf),
        .cent_buf_i(cent_buf),
        .covered_o (covered[2])
    );

    PE PE3(
        .coord_i   (coord[3]),
        .r_buf_i   (r_buf),
        .cent_buf_i(cent_buf),
        .covered_o (covered[3])
    );

    //  LU
    LU LU0(
        .covered_i (covered[0]),
        .mode_buf_i(mode_buf),
        .hit       (hit[0])
    );

    LU LU1(
        .covered_i (covered[1]),
        .mode_buf_i(mode_buf),
        .hit       (hit[1])
    );

    LU LU2(
        .covered_i (covered[2]),
        .mode_buf_i(mode_buf),
        .hit       (hit[2])
    );

    LU LU3(
        .covered_i (covered[3]),
        .mode_buf_i(mode_buf),
        .hit       (hit[3])
    );

    //  ACC
    ACC ACC0(
        .clk_i      (clk),
        .rst_i      (rst),
        .acc_en_i   (acc_en),
        .acc_clear_i(acc_clear),
        .hit_i      (hit),
        .candidate_o(candidate)
    );    

endmodule