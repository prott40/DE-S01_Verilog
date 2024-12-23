
module SR(ar, clk, out);

input ar, clk;
output out;


reg [0:7]sr;
wire sr_in;

assign sr_in = sr[1] ^ sr[2] ^ sr[3] ^ sr[7];

assign out = sr[3];

always@(negedge ar or posedge clk)
	if(~ar)
		sr =8'd1;
	else
		sr = {sr_in, sr[0:6]};
endmodule