
// D flip-flop with asynchronous reset
// dff.v
// Don M. Gruenbacher
// Feb. 4, 2000

`timescale 100 ns / 1 ns

module dff (clk, ar, d, q);
	input  clk, ar, d;
	output reg q;
	

always @ (posedge clk or negedge ar)
	if(~ar)
	  q = 1'b0;
	else	
	  q = d;

endmodule
