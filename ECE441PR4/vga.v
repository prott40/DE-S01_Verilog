// VGA driver design
// File vga.v
// Generates VGA timing and data signals to drive a VGA monitor
//   in 640 x 480 mode
// Don M. Gruenbacher
// March 8, 2004




module vga(CLOCK_50, ar, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS, VGA_BLANK, VGA_SYNC, VGA_CLK);
   input CLOCK_50; // 50 MHz input clock
   //input CLOCK_27;  // 27 MHz input clock
	input ar;  // Active low asynchronous reset
   output [9:0] VGA_R, VGA_G, VGA_B; // Red, green, and blue outputs
   output VGA_HS;   // Output horizontal synch
   output VGA_VS;   // Output vertical synch
	output VGA_BLANK, VGA_SYNC;
	output VGA_CLK;

   reg 	  r, g, b;
   reg    hsync, vsync;
	reg clk; // 25 MHz  clock
   


   reg [9:0] hcount, vcount;  // Counters used for creating the vsync and hsync signals

   reg 	     video_on_h, video_on_v;
   
	assign VGA_BLANK = 1'b1;
	assign VGA_SYNC = 1'b1;
	assign VGA_HS = hsync;
	assign VGA_VS = vsync;
	
	assign VGA_R = {r, r, r, r, r, r, r, r, r};
	assign VGA_G = {1'b1, g, 7'b0};
	assign VGA_B = {1'b1, b, 7'b0};
	
   parameter [9:0] h_max = 10'd799;
   parameter [9:0] v_max = 10'd524;
   
	wire	AUD_CTRL_CLK;
	
   //VGA_Audio_PLL 		p1	(	.areset(~ar),.inclk0(CLOCK_27),.c0(clk),.c1(AUD_CTRL_CLK),.c2(VGA_CLK)	);

	
   always @(negedge ar or posedge CLOCK_50)
     if(~ar)
			clk = 1'b0;
		else
			clk = ~clk;
		
	assign VGA_CLK = clk;
	
   // Generate the hcount & hsync

   always @(negedge ar or posedge clk)
     if(~ar)
       begin
	  hcount = 10'b0;
	  video_on_h  = 1'b0;
       end
   
     else
       begin
	  if(hcount >= h_max)
	    hcount = 10'b0;
	  else
	    hcount = hcount + 1;

	  
	  if(hcount <= 755 && hcount >= 659)
	    hsync = 1'b0;
	  else
	    hsync = 1'b1;

	  
	  if(hcount <= 639)
	    video_on_h = 1'b1;
	  else
	    video_on_h = 1'b0;

       end // else: !if(~ar)
   
  
	// v count and v synch
	
   always @(negedge ar or posedge clk)
     if(~ar)
       begin
	  vcount = 10'b0;
	  video_on_v  = 1'b0;
       end
   
     else
       begin
	  if(vcount >= v_max)
	    vcount = 10'b0;
	  else
         if(hcount == 10'd699)
     	    vcount = vcount + 1;
	  
	      
	  if(vcount <= 494 && vcount >= 493)
	    vsync = 1'b0;
	  else
	    vsync = 1'b1;

	  
	  if(vcount <= 479)
	    video_on_v = 1'b1;
	  else
	    video_on_v = 1'b0;

       end // else: !if(~ar)
   

   // Generate R,G,B outputs for a colorbar pattern (just use the hcount position)

   always @(negedge ar or posedge clk)
     if(~ar)
       begin
   
	  r = 1'b0;
	  g = 1'b0;
	  b = 1'b0;
       end
     else
       begin
	  if(video_on_v & video_on_h) // Allow non-zero RGB only within the 640x480 area
	    begin
	       r = hcount[8];
	       g = hcount[7];
	       b = hcount[6];
	    end
	  else
	    begin
	       r = 1'b0;
	       g = 1'b0;
	       b = 1'b0;
	    end // else: !if(video_on_v & video_on_h)
	  
	  
       end // else: !if(~ar)

endmodule // vga
