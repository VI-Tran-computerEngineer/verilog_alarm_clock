
module testbench();
   reg a_1, b_1, c_1;
	wire out_1;
   
	//majority uut(.a(a_1), .b(b_1), .c(c_1),
	 //                 .out(out_1));
	
	initial begin
	    a_1 = 0; b_1 = 0; c_1 = 0;     #10;
		 $display($time, " -- a = %b, b = %b, c = %b, y = %b", a_1, b_1, c_1, out_1);
		 c_1 = 1;                       #10;
		 $display($time, " -- a = %b, b = %b, c = %b, y = %b", a_1, b_1, c_1, out_1);
		 b_1 = 1; c_1 = 0;              #10;
		 $display($time, " -- a = %b, b = %b, c = %b, y = %b", a_1, b_1, c_1, out_1);
		 b_1 = 1; c_1 = 1;              #10;
		 $display($time, " -- a = %b, b = %b, c = %b, y = %b", a_1, b_1, c_1, out_1);
		 a_1 = 1; b_1 = 0; c_1 = 0;     #10;
		 $display($time, " -- a = %b, b = %b, c = %b, y = %b", a_1, b_1, c_1, out_1);
		 c_1 = 1;                       #10;
		 $display($time, " -- a = %b, b = %b, c = %b, y = %b", a_1, b_1, c_1, out_1);
       b_1 = 1; c_1 = 0;              #10;
		 $display($time, " -- a = %b, b = %b, c = %b, y = %b", a_1, b_1, c_1, out_1);
       c_1 = 1;                       #10;
		 $display($time, " -- a = %b, b = %b, c = %b, y = %b", a_1, b_1, c_1, out_1);
	end
endmodule
	