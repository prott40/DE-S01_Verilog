module PR4
(A,B,ar,sign,Y,dig3_segs,dig2_segs,dig1_segs,dig0_segs,clk,A_sign,B_sign,Y_sign,P10,P1);
	output [6:0] dig3_segs	/* synthesis chip_pin = "Y19, AF23, AD24, AA21, AB20, U21, V21" */ ;
	output [6:0] dig2_segs	/* synthesis chip_pin = "W28, W27, Y26, W26, Y25, AA26, AA25" */ ;
	output [6:0] dig1_segs	/* synthesis chip_pin = "U24, U23, W25, W22, W21, Y22, M24" */ ;
	output [6:0] dig0_segs	/* synthesis chip_pin = "H22, J22, L25, L26, E17, F22, G18" */ ;
	input signed [3:0] A /* synthesis chip_pin = "AD27, AC27, AC28, AB28" */ ;
	input signed [3:0] B /*synthesis chip_pin = "AB26, AD26, AC26 ,AB27"*/;
	output[3:0] P10,P1;
	output [7:0] Y;
	input clk;
	input ar;
	output A_sign /*synthesis chip_pin = "G19"*/;
	output B_sign /*synthesis chip_pin = "F19"*/;
	output Y_sign /*synthesis chip_pin = "E19"*/;
	input [1:0] sign /*synthesis chip_pin = "M21, M23"*/;
	// extra credit
	output [7:0] red /*synthesis chip_pin = "H10, H8, J12, G10, F12, D10, E11, E12,"*/;
	output [7:0] green /*synthesis chip_pin = "C9, F10, B8, H12, F8, G11, G8"*/;
	output [7:0]blue /*synthesis chip_pin = "D12, D11, C12, A11, B11, C11, A10, B10"*/;
	output vert/*synthesis chip_pin = "C13"*/;
	output horiz/*synthesis chip_pin = "G13"*/;
	output blank/*synthesis chip_pin = "F11"*/;
	output synch/*synthesis chip_pin = "C10"*/;
	output clock/*synthesis chip_pin = "A12"*/;
//first takes A and B in 2's compliment form from dip sticks,checks for sign from push buttons,enters ALU
ALU math(.A(A),.B(B),.sign(sign),.clk(clk),.ar_n(ar),.y_clk(Y));


// takes A B inputs and uses finds their magnitude 
mag_4bit Agetsign(.a(A),.a_sign(A_sign),.a_mag(A));// give new manes to wires that leave the mag and bi to bcd
mag_4bit Bgetsign(.a(B),.a_sign(B_sign),.a_mag(B));

//puts output into magnitude to find if positive or negative
mag_8bit getans(.a(Y),.a_sign(Y_sign),.a_mag(Y));//how to break down magnitude of a_mag so that it feeds into dig0_segs and dig1_segs
// moves magnitude of output to Binary to bcd
bin2bcd converts(.binary(Y),.tens(P10),.ones(P1));
//moves input magnitues to 7 segment display
// takes binary to 7 segment display

sevseg_dec Anum(.x_in(A),.segs(dig3_segs));
sevseg_dec Bnum(.x_in(B),.segs(dig2_segs));
sevseg_dec outtens(.x_in(P10),.segs(dig1_segs));
sevseg_dec outones(.x_in(P1),.segs(dig0_segs));

vga_rom screen(CLOCK_50.(clk),.ar(ar),.VGA_R(red),.VGA_G(green),.VGA_B(blue),.VGA_HS(horiz),.VGA_VS(vert),
.VGA_BLANK(blank),.VGA_SYNC(synch),.VGA_CLK(clock),.a(A),.b(B),.cone(P1),.cten(P10),.sign(sign),.c_sign(Y_sign));


endmodule

