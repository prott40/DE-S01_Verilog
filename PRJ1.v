// File: PRJ1.v
// Description: Majority voter takinging 3 inputs
// Author(s): Preston Rottinghaus
// Date Created: September 4, 2023

timescale 100 ns / 1 ns

module PRJ1(y1,y2,y3,y);

	input y1,y2,y3;//sets up inputs
	output y;// sets up output

	assign y = ~y1y2y3 | y1~y2y3 | y1y2~y3 | y1y2y3;
endmodule
