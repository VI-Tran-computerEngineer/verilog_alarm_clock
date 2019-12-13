module alarm_clock (output [4:0]BEEPING,          //5 leds used to beep 5 alarms
                    output [13:0]HH_clock,     //2 7-segment LEDs
						  output [13:0]MM_clock,     //2 7_segment LEDs
						  output [13:0]SS_clock,     //2 7-segment LEDs
						  
						  input reset,               //1 switch
						  input clk,
						  input [6:0]set_time,       // 7 swith use to set alarm's time
						  input [2:0]set_H_M_S,      // 3 button use to save alarm's time
						  input [4:0]five_alarm,     // use 5 switchs
						  input change_real_time,    // 1 swith to set real time
						  input see_alarm_time);     // see alarm time 
						  
    wire clk_1s; // 1s clock
    slowclock set_1s_clk(clk, reset, clk_1s);
 
    wire [7:0] A_hour[4:0];
    wire [7:0] A_min[4:0];
    wire [7:0] A_sec[4:0];
    wire [7:0] five_a;
 
    wire [7:0] hour;
    wire [7:0] min;
	 wire [7:0] sec;
	 
	 wire w_check;
	 wire [2:0]w_H_M_S;
	 check_time_in check(.check_out(w_check), .H_M_S(w_H_M_S),
	                     .time_in({1'b0, set_time}), .is_hour(set_H_M_S));
								
	 wire w_alarm_t;
	 wire w_real_t;
	 demux dmp(.out_A(w_alarm_t), .out_R(w_real_t),
	           .enable(change_real_time), .in(w_check));
	 save_input SI(.A_hour0(A_hour[0]), .A_hour1(A_hour[1]), .A_hour2(A_hour[2]), .A_hour3(A_hour[3]), .A_hour4(A_hour[4]), 
	               .A_min0(A_min[0]), .A_min1(A_min[1]), .A_min2(A_min[2]), .A_min3(A_min[3]), .A_min4(A_min[4]),
						.A_sec0(A_sec[0]), .A_sec1(A_sec[1]), .A_sec2(A_sec[2]), .A_sec3(A_sec[3]), .A_sec4(A_sec[4]), 
	               .set_H_M_S(w_H_M_S), .set_time({1'b0, set_time}), .five_alarm(five_alarm), .check_in(w_alarm_t),
						.reset(reset), .clock(clk)); 
 
    counter cout(.hour(hour), .min(min), .sec(sec), .clk(clk_1s), .reset(reset),
	              .set_time({1'b0, set_time}), .enable(w_H_M_S), .save(w_real_t));
	 
	 wire [4:0]auto_reset;    //stop beeping after 60s
	 wire [4:0]turn_on;       //beeping
	 //alarm 1
	 compare_with_alarm comparator_A1(.on(turn_on[0]),
	                                  .a_hour(A_hour[0]), .hour(hour), .a_min(A_min[0]), .min(min), .a_sec(A_sec[0]), .sec(sec),
											    .on_or_off(five_alarm[0]), .rst(reset), .auto_rst(auto_reset[0]));
	 beep bp_A1(.beeping(BEEPING[0]), .auto_reset(auto_reset[0]),
	            .clk(clk_1s), .on(turn_on[0]), .reset(reset));
	 //alarm 2		
	 compare_with_alarm comparator_A2(.on(turn_on[1]),
	                                  .a_hour(A_hour[1]), .hour(hour), .a_min(A_min[1]), .min(min), .a_sec(A_sec[1]), .sec(sec),
											    .on_or_off(five_alarm[1]), .rst(reset), .auto_rst(auto_reset[1]));
	 beep bp_A2(.beeping(BEEPING[1]), .auto_reset(auto_reset[1]),
	            .clk(clk_1s), .on(turn_on[1]), .reset(reset));
	 //alarm 3			
	 compare_with_alarm comparator_A3(.on(turn_on[2]),
	                                  .a_hour(A_hour[2]), .hour(hour), .a_min(A_min[2]), .min(min), .a_sec(A_sec[2]), .sec(sec),
											    .on_or_off(five_alarm[2]), .rst(reset), .auto_rst(auto_reset[2]));
	 beep bp_A3(.beeping(BEEPING[2]), .auto_reset(auto_reset[2]),
	            .clk(clk_1s), .on(turn_on[2]), .reset(reset));
	 // alarm 4
	 compare_with_alarm comparator_A4(.on(turn_on[3]),
	                                  .a_hour(A_hour[3]), .hour(hour), .a_min(A_min[3]), .min(min), .a_sec(A_sec[3]), .sec(sec),
											    .on_or_off(five_alarm[3]), .rst(reset), .auto_rst(auto_reset[3]));
	 beep bp_A4(.beeping(BEEPING[3]), .auto_reset(auto_reset[3]),
	            .clk(clk_1s), .on(turn_on[3]), .reset(reset));
	 // alarm 5
	 compare_with_alarm comparator_A5(.on(turn_on[4]),
	                                  .a_hour(A_hour[4]), .hour(hour), .a_min(A_min[4]), .min(min), .a_sec(A_sec[4]), .sec(sec),
											    .on_or_off(five_alarm[4]), .rst(reset), .auto_rst(auto_reset[4]));
	 beep bp_A5(.beeping(BEEPING[4]), .auto_reset(auto_reset[4]),
	            .clk(clk_1s), .on(turn_on[4]), .reset(reset));
	 
    //display hour
    wire [7:0]w_hour;
	 
    mux mux_H(.out(w_hour),
	            .A_time0(A_hour[0]), .A_time1(A_hour[1]), .A_time2(A_hour[2]), .A_time3(A_hour[3]), .A_time4(A_hour[4]), 
					.R_time(hour), .choose_A(five_alarm), .A_or_R(see_alarm_time));
	 BCD_decoder _H(.out_led(HH_clock[6:0]), .time_in(w_hour[3:0]), .reset(reset));
	 BCD_decoder H_(.out_led(HH_clock[13:7]), .time_in(w_hour[7:4]), .reset(reset));
	 
	 //display minute		
    wire [7:0]w_min;
	 
    mux mux_M(.out(w_min),
	            .A_time0(A_min[0]), .A_time1(A_min[1]), .A_time2(A_min[2]), .A_time3(A_min[3]), .A_time4(A_min[4]), 
					.R_time(min), .choose_A(five_alarm), .A_or_R(see_alarm_time));	 
	 BCD_decoder _M(.out_led(MM_clock[6:0]), .time_in(w_min[3:0]), .reset(reset));
	 BCD_decoder M_(.out_led(MM_clock[13:7]), .time_in(w_min[7:4]), .reset(reset));
	 
	 // display second
    wire [7:0]w_sec;
	 
    mux mux_S(.out(w_sec),
	            .A_time0(A_sec[0]), .A_time1(A_sec[1]), .A_time2(A_sec[2]), .A_time3(A_sec[3]), .A_time4(A_sec[4]), 
					.R_time(sec), .choose_A(five_alarm), .A_or_R(see_alarm_time));	 
	 BCD_decoder _S(.out_led(SS_clock[6:0]), .time_in(w_sec[3:0]), .reset(reset));
	 BCD_decoder S_(.out_led(SS_clock[13:7]), .time_in(w_sec[7:4]), .reset(reset)); 
endmodule 



module mux(output [7:0]out,

           input [7:0]A_time0,
			  input [7:0]A_time1,
			  input [7:0]A_time2,
			  input [7:0]A_time3,
			  input [7:0]A_time4,
			  input [7:0]R_time,
			  input [4:0]choose_A,
			  input A_or_R);
	 reg [7:0]r_out;
	 always @(A_or_R, choose_A, R_time, A_time0, A_time1, A_time2, A_time3, A_time4) begin
	     if(~A_or_R) begin
		      casex(choose_A)
				     5'bxxxx1: r_out = A_time0;
					  5'bxxx10: r_out = A_time1;
				     5'bxx100: r_out = A_time2;
					  5'bx1000: r_out = A_time3;
					  5'b10000: r_out = A_time4;
					  default:  r_out = R_time;
				endcase   
		  end
		  else
		      r_out = R_time;
	 end
    assign out = r_out;
endmodule 


module demux(output out_R,
             output out_A,
             input enable,
				 input in);
	 reg r_out_R;
	 reg r_out_A;
    always @(in, enable) begin
        if(enable == 1) begin
		      r_out_R <= in;
				r_out_A <= 0;
		  end
		  else begin
		      r_out_A <= in;
				r_out_R <= 0;
        end
    end	 
	 assign out_A = r_out_A;
	 assign out_R = r_out_R;
endmodule 
