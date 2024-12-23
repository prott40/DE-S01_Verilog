// synchronous DFF sound from
// https://esrd2014.blogspot.com/p/d-flip-flop.html#:~:text=A%20D%20Flip%2DFlop%20can,is%20synchronous%20D%20Flip%2DFlop.
module DFF(Q, Qbar, D, clk, ar);
output reg Q;
output Qbar;
input D, clk,ar;

assign Qbar = !Q;

always@(posedge clk)
begin
if(ar == 1'b1)
Q= 1'b0;
else
endmodule