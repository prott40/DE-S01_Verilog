
// n-bit synchronous counter with asynchronous reset
// ctr.v
// Don M. Gruenbacher
// Jan. 23, 2018

`timescale 100 ns / 1 ns

module ctr(clk, ar, q);
	parameter n = 8;
	input  clk, ar;
	output reg [n-1:0] q;



always @ (posedge clk or negedge ar)
	if(~ar)
		q = {n{1'b0}};
	else	
		q = q + 1;

endmodule
