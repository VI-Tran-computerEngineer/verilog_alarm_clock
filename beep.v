
//nhay led trong 60s
module beep(output beeping,
            output auto_reset,
            input clk,
			   input on,
				input reset);
	  wire off;
	  assign off = reset | ~on;
	  counter_beep cnt(.beeping(beeping), .auto_reset(auto_reset), .clk(clk), .reset(off)); // bo dem len toi 60
endmodule

module counter_beep(output beeping,
                    output auto_reset,
                    input reset,
						  input clk);
   reg r_beep;
	reg r_auto_rst;
	reg [7:0]counter;
   always @(posedge clk, posedge reset) begin
      if(reset) begin
		   counter <= 0;
			r_beep <= 0;
			r_auto_rst <= 0;
		end
		else begin
		   r_auto_rst <= 0;
		   if(counter == 8'd59) begin
				r_beep <= 0;
				r_auto_rst <= 1;
			end
			else if(counter == 0) begin
			   r_beep <= 1;
				counter <= counter + 1;
			end
			else begin
			   counter <= counter + 1;
				r_beep <= ~r_beep;
			end
		end
   end	
	assign beeping = r_beep;
	assign auto_reset = r_auto_rst;
endmodule
