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

module moorestatemachine_testbench;

/* size of stimulus	*/
parameter r_size = 9;

/* Local connections	*/
  reg out;	// redeclaration
  reg r_reg;
  wire [(r_size -1 ):0] r_wire;
  reg clk;
 reg reset;	

/* Stimulus	parameters	*/
parameter r = 9'b001011110;

/* laps	*/
parameter laps = r_size;

/* Clock parameters	*/
parameter delay_on = 10;
parameter delay_off= 10;


/* Module instantiation	*/
moorestatemachine statemachine(.out(out), .r(r_wire[0]), .clk(clk), .state_reset(reset));

/* Internal connections	*/
assign r_wire = r_reg;

/* Logic	*/
initial
	begin
	r_reg = r;
	reset = 0;
		repeat(laps)
			begin
				r_reg = r_reg << 1;
			end
	reset = 1;
	end

/* Clock Timing	*/
always
	begin
		#delay_on clk = 1;
		#delay_off clk = 0;
	end
	
endmodule