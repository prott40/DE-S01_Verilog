//coppied from lecture 16 slides
module ALU(A, B, sign, clk, ar_n, y_clk);
parameter n = 4;
input signed [n-1:0] A;
input signed [n-1:0] B;
input [1:0] sign;
input clk;
input ar_n;
output reg signed [2*n-1: 0] y_clk;

reg signed[n-1:0] a_clk, b_clk;
reg signed[2*n-1 : 0] y;

always @(posedge clk or negedge ar_n)
		if(~ar_n)
			begin
				a_clk = {n{1'b0}};
				b_clk = {n{1'b0}};
				y_clk = {2*n{1'b0}};
			end
			else
				begin
					a_clk = A;
					b_clk = B;
					y_clk = y;
			end
always @(a_clk or b_clk or sign)
	case(sign)
		2'b00: y = a_clk + b_clk;
		2'b01: y = a_clk - b_clk;
		2'b10: y = a_clk * b_clk;
		default: y = a_clk + b_clk;
	endcase
endmodule