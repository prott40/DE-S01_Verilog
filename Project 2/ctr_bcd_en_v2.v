
// 4-bit synchronous BCD counter with asynchronous reset
// ctr_bcd.v
// Don M. Gruenbacher
// Feb. 4, 2000, updated 4/21/2023 with correct enable out behavior

`timescale 100 ns / 1 ns

module ctr_bcd (clk, ar, en, en_out, q);
	input  clk, ar;
	input  en;			// Enable input (active high)
	output reg en_out;   // Enable output for next signficant BCD counter input
	output [3:0] q;
	reg    [3:0] q;


always @ (posedge clk or negedge ar)

	if(~ar)
		begin
		q = 4'b0;
		en_out = 1'b0;
		end
	else	
	 if(en)
		  if(q >= 4'h9)
			begin
			en_out = 1'b1;
			q = 4'b0;
			end
		  else
			begin
			en_out = 1'b0;
			q = q + 1;
			end
	 else
		en_out = 1'b0;   	// Make sure the enable_out = 0 if enable in = 0

endmodule
