// VGA driver design
// File vga.v
// Generates VGA timing and data signals to drive a VGA monitor
//   in 640 x 480 mode
// Don M. Gruenbacher
// March 8, 2004




module vga_rom(CLOCK_50, ar, VGA_R, VGA_G, VGA_B, VGA_HS, VGA_VS, VGA_BLANK, VGA_SYNC, VGA_CLK, a, b, cone, cten, sign, c_sign);
   input CLOCK_50; // 50 MHz input clock
	input ar;  // Active low asynchronous reset
   output [9:0] VGA_R, VGA_G, VGA_B; // Red, green, and blue outputs
   output VGA_HS;   // Output horizontal synch
   output VGA_VS;   // Output vertical synch
	output VGA_BLANK, VGA_SYNC;
	output VGA_CLK;
	input signed [3:0]a;
	input signed [3:0]b;
	input signed [8:0]signc;
	input [1:0]sign;
	input [1:0] c_sign

   reg 	  r, g, b;
   reg    hsync, vsync;
	reg clk; // 25 MHz  clock
   


   reg [9:0] hcount, vcount;  // Counters used for creating the vsync and hsync signals

   reg 	     video_on_h, video_on_v;
   
	assign VGA_BLANK = 1'b1;
	assign VGA_SYNC = 1'b1;
	assign VGA_HS = hsync;
	assign VGA_VS = vsync;
	
	assign VGA_R = {1'b1, {8{r}}}; //, 7'b0};
	assign VGA_G = {1'b1, {8{g}}};// g, 7'b0};
	assign VGA_B = {1'b1, {8{b}}};//b, 7'b0};
	
   parameter [9:0] h_max = 10'd799;
   parameter [9:0] v_max = 10'd524;
   
	wire	AUD_CTRL_CLK;
	
   
	// Instantiate the 256x8 Asynchronous ROM containing the fonts
	// Note:   the font file, tcgrom.mif, actually has 512 words, but we 
	//	will only readn in the first 256 words and store them in the ROM
	//	Each character is 8x8 pixels, so we are storing 32 characters
	
   parameter 	   LPM_FILE = "tcgrom.mif";
   
	     
   wire [8:0] 	   rom_addr;
   wire [7:0] 	   rom_q;
   

   reg [7:0] 	   shift_reg;
	
	wire [5:0] disp_char [8:0];   // Two-dimensional array that holds characters to be displayed
	
	wire [3:0] a_mag;
	wire a_sign;
	wire [3:0] a_neg;
	
	assign a_neg = ~a + 1'b1;
	assign a_sign = a[3];
	assign a_mag = a_sign ? (a_neg : a);
	
	
	wire [3:0] b_mag;
	wire b_sign;
	wire [3:0] b_neg;
	
	assign b_neg = ~b + 1'b1;
	assign b_sign = b[3];
	assign b_mag = b_sign ? (b_neg : b);
	

	
	
	
	assign disp_char[0] = a_sign ? 6'o55: 6'o40; //6'o62;   // sign of A
	assign disp_char[1] = {2'b11,  a_mag[2:0]};//6'o53;   // magnitude of Q
	assign disp_char[2] = sign[0] ? (sign[1]?6'o53:6'o55): (sign[1] ? 6'o52 : 6'o53);
	assign disp_char[3] =  b_sign ? 6'o55:6o40;   // sign b  
	assign disp_char[4] = {2'b11, b_mag}6'o65;   // 5
	assign disp_char[5] = 6'o42;   // "
	assign disp_char[6] = c_sign ? 6'o55: 6'o40; //6'o62;    // 
 	assign disp_char[7] = {2'b11, cten};
	assign disp_char[7] = {2'b11, cone};
	// 
	
	
 	font_rom rom1(
	.address(rom_addr),
	.clock(clk),
	.q(rom_q));   
		
   assign rom_addr = {disp_char[hcount[8:3]], vcount[2:0]};

	
// Implement the shift register that interfaces the ROM outputs to the VGA RGB outputs

   always @(negedge ar or posedge clk)
     if(~ar)
       shift_reg = 8'b0;
     else
       begin
	 if (hcount[2:0] == 3'h7) 
	   shift_reg = rom_q;
	 else
	   shift_reg = {shift_reg[6:0], 1'b0};
       end

   
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
	      if(hcount > 7 && hcount < 80)
					r = shift_reg[7];
					g = r;
					b = g;
				end 
	       else
				begin
				r = hcount[8];
				g = hcount[7];
				b = hcount[6];
				end
	    end 
		 		 
	  else // Outside the VGA screen
	    begin
	       r = 1'b0;
	       g = 1'b0;
	       b = 1'b0;
	    end // else: !if(video_on_v & video_on_h)
	  
	  
       end // else: !if(~ar)
		 
   
   
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
   



endmodule // vga
