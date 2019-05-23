ECE 351
Professor Greenwood	“somebody who doesn’t know the answer tell me…”
05/21/19


Shift Register LUT

-	Inferred by:

	always @(posedge C)
	begin
		Q_INT <= {Q_INT[14:01], D};
	end
	
	always @(Q_INT)
	begin
	
		Q <= Q_INT[15];
	end
	
-	If not inferred like this, the synthesizer will implement a simple shift register made of LUTs and registers.

// Vertex 5 Design Video

-	There is no perfect way to create a design.

	>	Different synthesis options and implementation options will lead to different results.
	
		+	One method will not work best ina ll cases.
		
	>	The coding techniques described here are strongly recommended because they have the biggest impact on device utilization and speed.
	
-	Shrink the register and LUT utilization where possible

	>	Use hard IP for better timing and to preserve LUTs and Register.
	
	>	Allow the synthesizer to have more flexiblity with place and route.
	
-	One of the most effective ways to reduce power in FPGAs is to .....

-	Build a design that uses fewer "limiting" resources.

-	Control Sets

	>	Group of control signals used for one slice.
	
	>	Vcc and GND are connected to unused ports.
	
		+	Vcc and GND are also control signals in this sense.
		
	>	The unique sets are the unique combinations of control signals in your design.
	
		+	The goal is to reduce the # of sets in your design.
		
		+	For example if flip flops use different control sets, they cannot be placed in the same slice.
		
- ... Lots of missing notes on video.

-	Design trade-offs.

	>	Using the synthesizer to switch synchronous vs asynchronous resets can cause the synthesis result to change.
	
		+	This has a dramatic effect on reusablility.
		
		
Design without resets

-	No resets saves routing and improves speed.

-	Finite state machines can be declared and assigned a registered value to initialze them without a reset.

	>	All reg variables should be initialized.