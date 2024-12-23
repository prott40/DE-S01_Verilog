// Testbench 4-bit synchronous BCD counter with asynchronous reset
// ctr_tb.v
// Don M. Gruenbacher
// Feb. 4, 2000

`timescale 1 ns / 1 ns

module clkdiv_tb;
	reg		clk;
	reg		reset;

	wire clkout;	// Output of clock divider
	

// instantiate the clock divider
//	clk_div   divider1 (.ar(reset), .clk_in(clk), .clk_out (clkout));
	clk_div #(25, 25'd25000000)   divider1 (.ar(reset), .clk_in(clk), .clk_out (clkout));

initial
  begin
	clk = 1'b0;	// set to 0 so toggling can occur

	reset = 1'b1;   // Start reset at 1

	#1 reset = 1'b0; // Set reset to 0 after 5 ns
	#20 reset = 1'b1; // Set reset to 1
  end


// Controls the test clock
always
	#10 clk = ~clk; 	// For 20 ns period (50 MHz)

endmodule
