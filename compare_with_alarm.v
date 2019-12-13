//so sanh voi alarm-time-set
module compare_with_alarm(output on,
                          input [7:0]a_hour,
								  input [7:0]hour,
								  input [7:0]a_min,
								  input [7:0]min,
								  input [7:0]a_sec,
								  input [7:0]sec,
								  input on_or_off,
								  input rst,
								  input auto_rst);
     reg r_on;
	  reg [7:0]r_sec; 
	  reg [7:0]r_min;
	  reg [7:0]r_hour;
	  always @(rst, on_or_off, auto_rst, a_hour, hour, a_min, min, a_sec, sec) begin
	      if((rst) || (~on_or_off) ||(auto_rst)) begin
			    r_on = 0;
			end
			else begin
			   if(sec[3:0] == 4'b1001) begin   // giay _9
				   r_sec[3:0] <= 0;
					if(sec[7:4] == 4'b0101) begin   //giay 59
					   r_sec[7:4] <= 0;
						
						if(min[3:0] == 4'b1001) begin  // phut _9
						   r_min[3:0] <= 0;
							if(min[7:4] == 4'b0101) begin   // phut 59
							   r_min[7:4] <= 0;
								
							   if(hour == 8'b00100011)      // gio 23
							      r_hour <= 0;
								else if(hour[3:0] == 4'b1001) begin    // gio _9
								   r_hour[3:0] <= 0;
									r_hour[7:4] <= hour[7:4] + 1;
								end
							   else
							      r_hour <= hour + 1;
									
							end
							else begin
							   r_hour <= hour;
								r_min[7:4] <= min[7:4] + 1;
							end
						end
						else begin
						   r_hour <= hour;
							r_min[3:0] <= min[3:0] + 1;
							r_min[7:4] <= min[7:4];
						end
					end
					else begin
				      r_sec[7:4] <= sec[7:4] + 1;
					   r_min <= min;
					   r_hour <= hour;
					end	
				end
				else begin
				   r_sec[3:0] <= sec[3:0] + 1;
					r_sec[7:4] <= sec[7:4];
					r_min <= min;
					r_hour <= hour;
				end
				
			   if((a_hour == r_hour) && (a_min == r_min) && (a_sec == (r_sec)))
				   r_on <= 1;
	      end
	  end
	  
	  assign on = r_on;
endmodule
