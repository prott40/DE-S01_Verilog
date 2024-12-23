

`timescale 1 ns / 1 ns

module parity_tb;
   reg  [6:0]  ctr;
   
   wire   p_test;
   
   

// instantiate the design
parity odd_parity_gen(.x(ctr), .p(p_test));


initial
  begin        
     ctr = 7'd0;
  end

always           // Wait 10 time units
   #5   ctr = ctr + 1;

   

endmodule
