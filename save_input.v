module save_input(output [7:0]A_hour0, output [7:0]A_hour1, output [7:0]A_hour2, output [7:0]A_hour3, output [7:0]A_hour4,
                  output [7:0]A_min0, output [7:0]A_min1, output [7:0]A_min2, output [7:0]A_min3, output [7:0]A_min4,
	               output [7:0]A_sec0, output [7:0]A_sec1, output [7:0]A_sec2, output [7:0]A_sec3, output [7:0]A_sec4, 
	               input [2:0]set_H_M_S,
	               input [7:0]set_time,
	               input [4:0]five_alarm,
	               input check_in,
						input reset,
						input clock);
    reg [7:0]r_A_hour[4:0];
    reg [7:0]r_A_min[4:0];
	 reg [7:0]r_A_sec[4:0];
	 
	 always @(posedge clock, posedge reset) begin
	   if(reset) begin
	      r_A_sec[0] <= 8'h0;
			r_A_sec[1] <= 8'h0;
			r_A_sec[2] <= 8'h0;
			r_A_sec[3] <= 8'h0;
			r_A_sec[4] <= 8'h0;
			r_A_min[0] <= 8'h0;
			r_A_min[1] <= 8'h0;
			r_A_min[2] <= 8'h0;
			r_A_min[3] <= 8'h0;
			r_A_min[4] <= 8'h0;
			r_A_hour[0] <= 8'h0;
			r_A_hour[1] <= 8'h0;
			r_A_hour[2] <= 8'h0;
			r_A_hour[3] <= 8'h0;
			r_A_hour[4] <= 8'h0;
	   end	
	   else if(check_in) begin
	       if(set_H_M_S == 3'b110) begin
		      casex(five_alarm)
				    5'b10000: r_A_sec[4] = set_time;
					 5'bx1000: r_A_sec[3] = set_time;
					 5'bxx100: r_A_sec[2] = set_time;
					 5'bxxx10: r_A_sec[1] = set_time;
					 5'bxxxx1: r_A_sec[0] = set_time;
				endcase
		    end
		    else if(set_H_M_S == 3'b101) begin
		       casex(five_alarm)
				    5'b1xxxx: r_A_min[4] = set_time;
					 5'bx1xxx: r_A_min[3] = set_time;
					 5'bxx1xx: r_A_min[2] = set_time;
					 5'bxxx1x: r_A_min[1] = set_time;
					 5'bxxxx1: r_A_min[0] = set_time;
				endcase
		    end
		    else if(set_H_M_S == 3'b011) begin
		      casex(five_alarm)
				    5'b1xxxx: r_A_hour[4] = set_time;
					 5'bx1xxx: r_A_hour[3] = set_time;
					 5'bxx1xx: r_A_hour[2] = set_time;
					 5'bxxx1x: r_A_hour[1] = set_time;
					 5'bxxxx1: r_A_hour[0] = set_time;
				endcase
		    end
		end 
	 end
	 assign A_hour0 = r_A_hour[0];
	 assign A_hour1 = r_A_hour[1];
	 assign A_hour2 = r_A_hour[2];
	 assign A_hour3 = r_A_hour[3];
	 assign A_hour4 = r_A_hour[4];
	 assign A_min0 = r_A_min[0];
	 assign A_min1 = r_A_min[1];
	 assign A_min2 = r_A_min[2];
	 assign A_min3 = r_A_min[3];
	 assign A_min4 = r_A_min[4];
	 assign A_sec0 = r_A_sec[0];
	 assign A_sec1 = r_A_sec[1];
	 assign A_sec2 = r_A_sec[2];
	 assign A_sec3 = r_A_sec[3];
	 assign A_sec4 = r_A_sec[4];
	 
endmodule			