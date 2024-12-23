module mag_8bit(a, a_mag, a_neg, a_sign);
input signed [7:0] a;
output wire a_sign;
output wire [7:0] a_neg;
output wire [7:0] a_mag;
assign a_sign = a[7];
assign a_neg = ~a + 1'b1;
assign a_mag = a_sign?a_neg:a;
endmodule