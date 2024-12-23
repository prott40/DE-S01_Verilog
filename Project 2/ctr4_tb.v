// Testbench 4-bit synchronous BCD counter with asynchronous reset
// ctr_tb.v
// Don M. Gruenbacher
// Feb. 4, 2000

`timescale 1 ns / 1 ns

module ctr4_tb;
	reg		clk;
	reg		reset;

	wire [3:0]	q4, qbcd;	// Outputs of counter
	

// instantiate the counter

 ctr_bcd  counter_bcd (clk, reset, qbcd);
 ctr4 counter_4bit (clk, reset, q4);

initial
  begin
	clk = 1'b0;	// set to 0 so toggling can occur

	reset = 1'b1;   // Start reset at 1

	#1 reset = 1'b0; // Set reset to 0 after 5 ns
	#20 reset = 1'b1; // Set reset to 1
  end


// Controls the test clock
always
	#50 clk = ~clk; 	// For 100 ns period

endmodule
