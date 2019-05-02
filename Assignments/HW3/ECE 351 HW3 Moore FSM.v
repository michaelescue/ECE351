/** 
*	Homework 3
*	Moore FSM verilog module
*	Based upon material from ECE 351 lecture on April 18, 2019
*	by Dr. Greenwood, PSU
*
*	input sequence r = 001011110;
*	
*	States:
*		A, B, C, D, E;
*
*	Initial State:
*		A
*
*	Number of inputs:
*		1
*
*	Number of outputs:
*		1
*	
**/

module moorestatemachine(out, r, clk, state_reset);
output out; reg out;	// redeclaration
input r, clk, state_reset;
/* States */
parameter A = 4'b0000, B = 4'b0001, C = 4'b0010, D = 4'b0100, E = 4'b1000;
reg [3:0] current_state; // state registers
reg [3:0] next_state;

/* Logic	*/
always @(r OR current_state)
	case (current_state)
		A:	begin 
					out = 0;
					if(r) next_state = D;
					else next_state = B; 
			end
		B:	begin
					out = 0;
					if(r) next_state = C;
					else next_state = B; 
			end
		C:	begin 
					out = 1;
					if(r) next_state = D;
					else next_state = E; 
			end
		D:	begin 
					out = 0;
					if(r) next_state = D;
					else next_state = E; 
			end
		E:	begin 
					out = 1;
					if(r) next_state = C;
					else next_state = B; 
			end
	endcase;
	
/* Registers	*/
always @(posedge clk OR state_reset)
	begin
		if (state_reset)
			begin
				current_state = A;
				out = 0
			end
		else current_state = next_state;
	end
	
endmodule