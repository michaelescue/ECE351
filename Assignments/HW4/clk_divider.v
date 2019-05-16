// clk_divider.v - parameterized clock divider
//
// Roy Kravitz
// 28-Sep-2016
//
// Description:
// ------------
// Implements a clock divider that can be used to generate a slow(er) clock from the system clock.
// The module is parameterized so that the clock divider can generate a range of clock outputs.
// The output clock "tick" is single cycle pulse so that it is usable as an enable in clocked sequential
// logic.
//
module clk_divider
#(
	parameter		CLK_INPUT_FREQ_HZ = 32'd100_000_000,		// clock input frequencey in HZ, defaults to 100MHz
	parameter		TICK_OUT_FREQ_HZ = 32'd100_000,				// clock output frequency in HZ, defaults to 100KHz
	parameter		SIMULATE = 0								// simulation or hardware, default to hardware
																// if SIMULATE is asserted the clock timeout period is shortened
)
(
	input wire		clk,										// input clock
	input wire		reset,										// reset signal, asserted high to reset the circuit
	output reg		tick_out									// output clock pulse.  1 cycle pulse at output frequency
);

// local parameters to calculate divider counter parameters
localparam	[31:0]		CLK_COUNTS = CLK_INPUT_FREQ_HZ / TICK_OUT_FREQ_HZ;		// Top count for clock counter is Input Freq/Output Freq
																				// For example, using the default case CLK_COUNT is 1000
																				
localparam	[31:0]		clk_top_count = SIMULATE ? 32'd5 : (CLK_COUNTS - 1);	// top count for clock divider counter
																				// subtract 1 from the count because the timer starts at 0

// internal variables
reg			[31:0]		clk_div_counter;										// clock divider


// implement the clock divider
// Use a synchronous reset because Cumming/Mills recommend it as a way to avoid issues when the circuit
// comes out of reset
always @(posedge clk) begin
	if (reset)  begin
		clk_div_counter <= 32'd0;
		tick_out <= 1'b0;
	end // reset case
	else if (clk_div_counter == clk_top_count) begin
		clk_div_counter <= 32'd0;
		tick_out <= 1'b1;
	end // top count case
	else begin
		clk_div_counter <= clk_div_counter + 32'd1;
		tick_out <= 1'b0;
	end // increment clock divider count
end // always

endmodule
