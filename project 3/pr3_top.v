`timescale 1ns/1ns

module pr3_top(clk, ar, stop, clr, led_out, hundreds_segs, tens_segs, ones_segs);
	input clk;
	input ar;
	input stop;
	input clr;
	output led_out;
	output [6:0] hundreds_segs;
	output [6:0] tens_segs;
	output [6:0] ones_segs;
	
	wire clk_1kHz;
	wire clk_2Hz;
	wire counter_en;
	wire bcd1_en_out;
	wire bcd2_en_out;
	wire bcd3_en_out;
	wire bcd2_en_in;
	wire bcd3_en_in;
	wire bcd_clr;
	
	wire[3:0] bcd_ones;
	wire[3:0] bcd_tens;
	wire[3:0] bcd_hundreds;
	
	clk_div#(.n(19), .limit(19'd2499)) divider1khz(.ar(ar), .clk_in(clk), .clk_out(clk_1kHz));	
	clk_div#(.n(10), .limit(10'd999)) divider2sec(.ar(ar), .clk_in(clk_1kHz), .clk_out(clk_2Hz));
	SR SR_unit (.ar(ar), .clk(clk_2Hz), .out(led_out));
	FSM FSM_use(.ar(bcd_clr), .clk(clk_1kHz), .x(stop), .x(led_out), .x(counter_en);
	
	assign bcd_clr = ar & clear;
	assign bcd2_en_in = counter_en & bcd1_en_out;
	assign bcd3_en_in = bcd2_en_in & bcd2_en_out;
	
	ctr_bcd_en_v2 ctr_ones(.clk(clk_1kHz), .ar(bcd_clr), .en(counter_en), .en_out(bcd1_en_out), .q(bcd_ones));
	ctr_bcd_en_v2 ctr_tens(.clk(clk_1kHz), .ar(bcd_clr), .en(bcd2_en_in), .en_out(bcd2_en_out), .q(bcd_tens));
	ctr_bcd_en_v2 ctr_hunds(.clk(clk_1kHz), .ar(bcd_clr), .en(bcd3_en_in), .en_out(bcd3_en_out), .q(bcd_hundreds));
	
	sevseg_dec dec_ones (.x_in(bcd_ones), .segs(ones_segs));
	sevseg_dec dec_tens (.x_in(bcd_tens), .segs(tens_segs));
	sevseg_dec dec_hundreds (.x_in(bcd_hundreds), .segs(hundreds_segs));
	
	