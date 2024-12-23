// File: PRJ1_pG_tb.v
// Description:take 7 inputs and only output. will output 1 if odd number of inputs
// Author(s): Preston Rottinghaus
// Date Created: September 4, 2023
`timescale 100 ns / 1 ns

module PRJ1_pG_tb;
	reg   [6:0] ctr;
	wire  a_test, b_test, c_test, d_test, e_test, f_test, g_test, P_test;
	  
PRJ1_pG instance1 (.x(ctr),.P(P_test));
initial
	begin
		ctr = 7'b0;
	end
	
	always // incremets ctr every 10 time units
		#10 ctr = ctr + 1;
		
// assigns each input with a ctr value
assign a_test = ctr[6];
assign b_test = ctr[5];
assign c_test = ctr[4];
assign d_test = ctr[3];
assign e_test = ctr[2];
assign f_test = ctr[1];
assign g_test = ctr[0];

endmodule


