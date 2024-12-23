module FSM(ar, clk, x, f);
	input ar,clk,x;
	output reg f;
	
	parameter [1:0] Idle = 2'b00, Start = 2'b01, Stop = 2'b10;
	reg[1:0] cs;
	
	always @ (negedge ar or posedge clk)
	if(~ar)
		begin
		cs = Idle;
		end
	else
		case(cs)
			Idle:
			if(x)
				begin
					cs = Start;
					f = 1'b1;
				end
			else
				begin
					cs = Idle;
					f = 1'b0;
				end
			Start:
			if(x)
				begin
					cs = Start;
					f = 1'b1;
				end
			else
				begin
					cs = Stop;
					f = 1'b0
				end
			Stop:
			if(x)
				begin
					cs = Stop;
					f = 1'b0;
				end
			else
				begin
					cs = Idle;
					f = 1'b0;
				end
				
			default:
				if(x)
					begin
						cs = Start;
						f = 1'b1;
					end
				else
					begin
						cs = Idle;
						f = 1'b0;
					end
				endcase