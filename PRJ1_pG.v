// File: PRJ1_partityGeneorator.v
// Description:take 7 inputs and only output 1 if odd number of inputs
// Author(s): Preston Rottinghaus
// Date Created: September 4, 2023
`timescale 100 ns / 1 ns

module PRJ1_pG (x,f);
	input[6:0]x;
	output f;
	
	assign f = ~(^x);
endmodule