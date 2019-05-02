/** 
*	Homework 3
*	Moore FSM testbench
*	Based upon material from ECE 351 lecture on April 18, 2019
*	by Dr. Greenwood, PSU
*
*	Stimulus sequence:
*		r = 001011110;
*	
*	Number of inputs:
*		1
*
*	Number of outputs:
*		1
*	
**/

/* Included files	*/
`include "ECE 351 HW3 Moore FSM.v"

/* Local connections	*/
local reg out;	// redeclaration
local reg r_wire;
local reg clk;
local wire reset;


/* size of stimulus	*/
`define r_size 9;	

/* Stimulus	assignments*/
r_reg = `r_size/'b001011110;

/* laps	*/
parameter laps = r_size;

/* Clock parameters	*/
parameter delay_on = 10;
parameter delay_off= 10;


/* Module instantiation	*/
module moorestatemachine #(.out(out), .r(r_wire), .clk(clk), .state_reset(reset)) statemachine;


/* Logic	*/
initial
	begin
	reset = 0;
		repeat(laps)
			begin
				r_wire = r_wire << 1;
			end
	reset = 1;
	end

endmodule

/* Clock Timing	*/
always @(*)
	begin
		#delay_on clk = 1;
		#delay_off clk = 0;
	end