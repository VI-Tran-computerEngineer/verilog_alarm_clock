//counter real time
module counter(output [7:0] hour,
               output [7:0] min,
				   output [7:0]sec,
               input clk,
					input reset,
					input [7:0]set_time,
					input [2:0]enable,
					input save);
    
	 
	 reg [7:0]r_hour;
	 reg [7:0]r_min;
	 reg [7:0]r_sec;
	 
	 always @(posedge clk, posedge reset) begin
	     if(reset) begin
		     r_hour <= 7'h0;
			  r_min <= 7'h0;
			  r_sec <= 7'h0;
		  end
		  else begin
		     if(save) begin
		        case(enable)
		           3'b011: r_hour <= set_time;
				     3'b101: r_min <= set_time;
				     3'b110: r_sec <= set_time;
		        endcase
	        end
			  else begin
		        if(r_sec == 7'h59) begin
			        if(r_min == 7'h59) begin
				  
				        if(r_hour == 7'h23)
					        r_hour <= 7'h0;
					     else begin
					        if(r_hour[3:0] == 4'd9) begin
						        r_hour[3:0] <= 4'd0;
							     r_hour[7:4] <= r_hour[7:4] + 4'd1;
						     end
						     else
					           r_hour[3:0] <= r_hour[3:0] + 4'd1;
					     end
					     r_min <= 7'h0;
				     end
				  
				     else begin
				        if(r_min[3:0] == 4'd9) begin
					        r_min[7:4] <= r_min[7:4] + 4'd1;
					        r_min[3:0] <= 4'd0;
					     end
					     else
					        r_min[3:0] <= r_min[3:0] + 4'd1;
				     end
				     r_sec <= 7'h0;
			     end
			  
			     else begin
				     if(r_sec[3:0] == 4'd9) begin
					     r_sec[7:4] <= r_sec[7:4] + 4'd1;
					     r_sec[3:0] <= 4'd0;
				     end
				     else
					     r_sec[3:0] <= r_sec[3:0] + 4'd1;
			     end
			 end
	    end
	 end
    assign hour = r_hour;
    assign min = r_min;
	 assign sec = r_sec;  
endmodule

