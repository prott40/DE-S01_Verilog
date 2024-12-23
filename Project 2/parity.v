// 	File:	


`timescale 1 ns / 1 ns	

 
module parity(x, p);
	input [6:0] x;
	output p;
	
	assign p = ~(^x);  // Generates odd parity using reduction operator
	
endmodule
