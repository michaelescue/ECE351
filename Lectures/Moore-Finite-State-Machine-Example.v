/** Moore FSM Example
*	A FSM which takes an input stream and turns the 1st "1" encountered
*	into a zero, and any consecutive ones are unchanged until the next zero
*	is encountered, and the next one will be changed to zero.
*
*	r = 		100110111010
*	Output = 	000010011000
*
*/

module moore(out, r, clk, reset);
output out; reg out;
input r, clk, reset;
parameter zero = 0, one1 = 1, two1s = 2	// State assignments
reg [1:0] state; // state registers
reg [1:0] next_state;

always @(r OR state)
	case (state)
		zero:	begin 
					out = 0;
					if(r) next_state = one1;
					else next_state = zero; 
				end
		one1:	begin
					out = 0;
					if(!r) next_state = zero;
					else next_state = two1s; 
				end
		two1s:	begin 
					out = 1;
					if(r) next_state = two1s;
					else next_state = zero; 
				end
	endcase;
	
always @(posedge clk OR reset)
	if (reset)
		begin
			state = zero;
			out = 0
		end
	else 
		state = next_state;