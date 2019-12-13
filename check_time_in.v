//check input
module check_time_in(output check_out,
                     output [2:0]H_M_S,
                     input [7:0]time_in,
							input [2:0]is_hour);
	 reg [7:0]r_check;
	 reg [2:0]r_H_M_S;
	 
    always @(is_hour, time_in) begin
				 if(is_hour == 3'b011) begin
				     if(time_in  <= 8'h23) begin
					      r_check = 1;
							r_H_M_S = 3'b011;
					  end
					  else 
					      r_check = 0;
				 end
				 else if(is_hour != 3'b111) begin
					  if(time_in <= 8'h59) begin
					      r_check = 1;
							if(is_hour == 3'b110)
							   r_H_M_S = 3'b110;
							else
							   r_H_M_S = 3'b101;
					  end
					  else
					      r_check  = 0;
				 end	
				 else 
				     r_check = 0;
	 end
	 assign H_M_S = r_H_M_S;
	 assign check_out = r_check;
endmodule
