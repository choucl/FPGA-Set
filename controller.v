/* FPGA Homework0 - SET                       
 * file: controller.v                         
 * description: Controller for our design                   
 * author: Jumha (e24076750@gs.ncku.edu.tw)   
 */

`include "def.v"

module controller(
    input  clk_i, 
    input  rst_i, 
    input  en_i, 
    output valid_o, 
    output busy_o, 
    output acc_en_o, 
    output acc_clear_o, 
    output buffer_en_o, 
    output clear_o, 
    output coord_en_o
);

    parameter RESET = 2'd0,
              START = 2'd1,  // start to do logic 
              BUSY  = 2'd2,  // system is busy
              DONE  = 2'd3;  // candidate is correct

    reg [4:0] counter; 
    reg [1:0] ns, cs;

    assign valid_o     = (cs == DONE)? 1'b1:1'b0;
    assign busy_o      = (cs == START || cs == BUSY)? 1'b1:1'b0;
    assign acc_en_o    = (cs == BUSY)? 1'b1:1'b0;
    assign acc_clear_o = (cs == START)? 1'b1:1'b0;
    assign buffer_en_o = en_i;
    assign clear_o     = (cs == DONE)? 1'b1:1'b0;
    assign coord_en_o  = (cs == START)? 1'b1:1'b0;

    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i == 1'b1) begin
            cs      <= RESET;
            counter <= 5'b0;
        end
        else begin
            cs <= ns;
            case (cs)
                START: counter <= 5'b0;
                BUSY:  counter <= counter + 5'b1;
                DONE:  counter <= 5'b0;
            endcase
        end   
    end

    always @(*) begin
        case(cs)
            RESET: begin
                if (en_i == 1'b1) 
                    ns = START;
                else              
                    ns = RESET;
            end
            START: ns = BUSY;
            BUSY: begin
                if (counter == 5'b10000) // BUSY are 17 cycles
                    ns = DONE;
                else
                    ns = BUSY;
            end
            DONE: ns = RESET;
            default: ns = RESET;
        endcase
    end

endmodule      
