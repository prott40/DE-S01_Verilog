// 4:1 mux 
// File: mux4_1a.v 
// Don M. Gruenbacher 
// Feb. 5, 2000 

`timescale 100 ns / 1 ns 

module mux4_1a(select, a,b, c, d, f);
	input [1:0] select; 
	input a,b,c,d; 
	output f; 
	reg f; 

always@(a or b or c or d) 
    begin 
	case(select) 
		2'b00: f = a; 
		2'b01: f = b; 
		2'b10: f = c; 
		default : f = d;  // Necessary to cover all other values (X, Z, ...) and prevent latches

	endcase 

end endmodule 
