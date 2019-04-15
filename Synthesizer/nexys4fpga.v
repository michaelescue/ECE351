// nexys4fpga.v - Top level module for Nexys4 as used in the Digital Scoreboard Demo
//
// Copyright Roy Kravitz, 2016
// 
// Created By:		Roy Kravitz
// Last Modified:	06-Oct-2016 (RK)
//
// Revision History:
// -----------------
// Oct-2016		RK		Created this module based on nexys4fpga.v as used in ECE 540
//
// Description:
// ------------
// Top level module for the Digital Scoreboard demo for the Verilog Workshop.
// This version is for the Nexys4 DDR board.  Uses the ECE 540 Seven Segment display
// driver and Scoreboard.v from the Digital Scoreboard homework problem
//
// Use the pushbuttons to control the Digital Scoreboard:
//	btnL			Decrement player 1 score
//	btnU			Increment player 2 score
//	btnR			Increment player 1 score
//	btnD			Decrement player 2 score
//  btnC			Clear both scores (must be pressed 5 times to clear the score)
//	btnCpuReset		CPU RESET Button - Global reset.  Asserted low by Nexys 4 board
//
//	sw[15:0]		Not used in this design
//	leds[15:0]		Not used in this design
//
//	uses digits 6 and 5 for the player 1 score and digits 2 and 1 for the player 2 score
//	on the Seven Segment Display
//
// External port names match pin names in the n4DDRfpga.xdc constraints file
///////////////////////////////////////////////////////////////////////////

module Nexys4fpga (
	input 				clk,                 	// 100MHz clock from on-board oscillator
	input				btnCpuReset,			// red pushbutton input 
	
	output 	[6:0]		seg,					// Seven segment display cathode pins
	output              dp,
	output	[7:0]		an						// Seven segment display anode pins	
); 

	// parameter
	parameter SIMULATE = 0;

	// internal variables
	wire				sysclk;							// 100MHz clock from on-board oscillator	
	wire				sysreset;						// system reset signal - asserted high to force reset
	
	wire 	[7:0]		decpts = {7'b0000000, clk_1Hz};	// dp0 is toggled by clk_100Hz 
	wire	[7:0]		segs_int;						// seven segment display segments
	wire				clk_1Hz;						// 1HZ clock to drive the counter
	wire   [3:0]        count_out;                      // 4-bit decade counter output
	
	// global assigns
	assign	sysclk = clk;
	assign 	sysreset = ~btnCpuReset;					// btnCpuReset is asserted low	
	assign dp = segs_int[7];							// multiplexed decimal points and segments
	assign seg = segs_int[6:0];							// produced by the Seven Segment display driver	

    // instantiate the clock divider
   clk_divider
    #(
       .CLK_INPUT_FREQ_HZ(32'd100_000_000),
       .TICK_OUT_FREQ_HZ(1),
       . SIMULATE(SIMULATE)
    ) CLKDIV
    (
        .clk(sysclk),
        .reset(sysreset),
        .tick_out(clk_1Hz) 
    );
    
    // instantiate the decade counter
    Decade DCTR
    (
        .CLK(clk_1Hz),
        .RST(sysreset),
        .Q(count_out)
     );
    		
	// instantiate the 7-segment, 8-digit display
	sevensegment
	#(
		.RESET_POLARITY_LOW(0),
		.SIMULATE(SIMULATE)
	) SSB
	(
		// inputs for control signals
		// 5'b11111 is the code for blank
		.d0({1'b0, count_out}),
		.d1(5'b11111),
 		.d2(5'b11111),
		.d3(5'b11111),
		.d4(5'b11111),
		.d5(5'b11111),
		.d6(5'b11111),
		.d7(5'b11111),
		.dp(decpts),
		
		// outputs to seven segment display
		.seg(segs_int),			
		.an(an),
		
		// clock and reset signals (100 MHz clock, active high reset)
		.clk(sysclk),
		.reset(sysreset),
		
		// ouput for simulation only
		.digits_out()
	);
	
	endmodule
	
	