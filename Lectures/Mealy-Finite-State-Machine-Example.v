/** Mealy FSM Example
*	A FSM which takes an input stream and turns the 1st "1" encountered
*	into a zero, and any consecutive ones are unchanged until the next zero
*	is encountered, and the next one will be changed to zero.
*
*	r = 		100110111010
*	Output = 	000010011000
*
*/

module mealy(clk, r, out, reset);
input clk, r, reset;
output out; reg out;
reg state; 	// State Registers
reg next_out; reg next_state;	// Different from moore, in that the output changes with the clock.
parameter zero = 0; parameter one = 1;	// State assignments
always @(r OR state)
case(state)
	zero:	begin
				if (r) next_state = one;
				else next_state = zero;
				next_out = 0;
			end
	one:	begin
				if (r) 
				begin
					next_state = one;
					next_out = 1;
				end
				else
				begin
					next_state = zero;
					next_out = 0;
				end
			end
			
endcase

always @(posedge clk)
	if (reset)
		begin
			state = zero;
			out = 0;
		end
	else 
	begin
			state = next_state;
			out = next_out
		end

endmodule