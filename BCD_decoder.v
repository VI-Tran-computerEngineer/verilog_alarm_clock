//decode BCD to 7-segment LEDs
module BCD_decoder(output [6:0]out_led,
                   input [3:0]time_in,
						 input reset);
     reg [6:0]r_out_led;
	  always @(reset, time_in) begin
	      if(reset == 1)
			    r_out_led = 7'b1000000;
			else begin
			    case(time_in)
				    4'd1: r_out_led = 7'b1111001;
                4'd2: r_out_led = 7'b0100100;
                4'd3: r_out_led = 7'b0110000;
                4'd4: r_out_led = 7'b0011001;
                4'd5: r_out_led = 7'b0010010;
                4'd6: r_out_led = 7'b0000010;
                4'd7: r_out_led = 7'b1111000;
                4'd8: r_out_led = 7'b0000000;
                4'd9: r_out_led = 7'b0010000;
					 default: r_out_led = 7'b1000000;
			    endcase
	      end
	  end
	  assign out_led = r_out_led;
endmodule
