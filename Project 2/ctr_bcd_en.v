
// 4-bit synchronous BCD counter with asynchronous reset and enables
// ctr4.v
// Don M. Gruenbacher
// Feb. 4, 2000

`timescale 100 ns / 1 ns

module ctr_bcd_en (clk, ar, en_in, en_out, q);
	input  clk, ar, en_in;
	output en_out;
	output reg [3:0] q;
	
assign en_out = (q >= 4'h9) ? 1'b1 : 1'b0;

always @ (posedge clk or negedge ar)
	if(~ar)
		q = 4'b0;
	else	
	  if(en_in)
		if(en_out) // If q >= 4'h9, reset the counter
			q = 4'b0;
		else
			q = q + 1;

endmodule
