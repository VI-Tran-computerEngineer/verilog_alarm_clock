//sua tan so cua clk ve 1Hz
module slowclock(clk, reset, clk_1);
     input clk;
	  input reset;
	  output clk_1;
	  reg clk_1s;
	  reg [31:0] counter;
	  
	  always @(posedge clk, posedge reset) begin
	       if(reset) begin
			      counter <= 0;
					clk_1s <= 1'b0;
			 end
			 else begin
			   if(counter == 24999999) begin
			      clk_1s <= ~clk_1s;
					counter <= 0;
			   end
	         else
			      counter <= counter + 1;
			 end
		end
		assign clk_1 = clk_1s;
		//assign clk_1 = clk; //dung de mo phong modelsim
endmodule
