// File: PRJ1_tb.v
// Description: Testbench for PRJ1 using majority voter
// Author(s): Preston Rottinghaus
// Date Created: September 4, 2023
`timescale 100 ns/1 ns

module PRJ1_tb;
	reg y1_test,y2_test,y3_test;
	wire y_test;

PRJ1 instance1(.y1(y1_test),.y2(y2_test),.y3(y3_test),.y(y_test);
initial
	begin
	#10	y1_test = 1'b0;
		y2_test = 1'b0;
		y3_test = 1'b1;

	#10	y1_test = 1'b0;
		y2_test = 1'b1;
		y3_test = 1'b1;

	#10	y1_test = 1'b1;
		y2_test = 1'b1;
		y3_test = 1'b0;

	end
endmodule
