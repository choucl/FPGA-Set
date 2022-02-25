/* FPGA Homework0 - SET                       
 * file: controller.v                         
 * description: Controller for our design                   
 * author: Jumha (e24076750@gs.ncku.edu.tw)   
 */

`include "def.v"

module controller(clk_i, rst_i, en_i, valid_o, busy_o, acc_en_o, acc_clear_o, buffer_en_o, clear_o, coord_en_o);

  parameter RESET = 2'd0,
            START = 2'd1,  // start to do logic 
            BUSY  = 2'd2,  // system is busy
            DONE  = 2'd3;  // candidate is correct

  input clk_i, rst_i, en_i;
  output valid_o, busy_o, acc_en_o, acc_clear_o, buffer_en_o, clear_o, coord_en_o;


  reg [4:0] counter; 
  reg [1:0] ns, cs;

  assign valid_o = (cs == DONE)? 1'b1: 1'b0;
  assign busy_o = (cs == START || cs == BUSY)? 1'b1: 1'b0;
  assign acc_en_o = (cs == BUSY)? 1'b1: 1'b0;
  assign acc_clear_o = (cs == START)? 1'b1: 1'b0;
  assign buffer_en_o = en_i;
  assign clear_o = (cs == DONE)? 1'b1: 1'b0;
  assign coord_en_o = (cs == START)? 1'b1: 1'b0;

  always @(posedge clk_i or posedge rst_i) begin
    if (rst_i) begin
      cs <= RESET;
      counter <= 5'b0;
    end
    else begin
      cs <= ns;
      case (cs)
        START: begin
          counter <= 5'b0;
        end
        BUSY: begin
          counter <= counter + 5'b1;
        end
        DONE: begin
          counter <= 5'b0;
        end
      endcase
    end   
  end

  always @(*) begin
    case(cs)
      RESET: begin
        if (en_i == 1'b1) begin
          ns = START;
        end
        else begin
          ns = RESET;
        end
      end
      START: begin
        ns = BUSY;
      end
      BUSY: begin
        if (counter == 5'b10000) begin // BUSY are 17 cycles
          ns = DONE;
        end 
        else begin
          ns = BUSY;
        end
      end
      DONE: begin
        if (en_i == 1'b1) begin // next data is ready
          ns = START;
        end
        else begin
          ns = DONE;
        end
      end
      default: begin
        ns = RESET;
      end
    endcase
  end

endmodule      
