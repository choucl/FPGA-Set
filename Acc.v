module Acc(clk, rst, acc_en, hit, candidate);

    input               clk, rst, acc_en;
    input [3:0]         hit;
    output reg [7:0]    candidate;
    reg [7:0]           psum;

    //--------------candidate--------------//
    always @(posedge clk) begin
        if (rst)
            candidate <= 8'b0;
        else
            candidate <= candidate + psum;
    end

    //-----------------psum----------------//
    always @(*) begin
        if ((clk && rst) || !acc_en)
            psum = 8'b0;
        else begin
            psum = hit[0] + hit[1] + hit[2] + hit[3];
        end
    end

endmodule