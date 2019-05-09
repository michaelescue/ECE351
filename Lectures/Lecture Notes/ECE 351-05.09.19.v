ECE 351
Professor Greenwood	“somebody who doesn’t know the answer tell me…”
05/07/19

-	Coding style plays an important role in utilizing an FPGA resources.

-	HDL designs can either be synthesized as a flat module or as many smal hierarchical modules.

-	Remember that a critical path is a combinational logic path with the longest propagation delay.

Relaxation Constraint:
		
	-	A constraint which applies to the design as a whole, but which is relaxed on a specific module.
		
	-	Anything with an associated memory is implemented within the FPGA.

Encoding Methodologies for State Machines:

	-	For large or complex state machines, one-hot state encoding is preferable, as opposed to full encoding/gray code.

		>	This varies between FPGA vendors.
		
			+	Xilinx actually recommends that both are tried.
			
Commercial synthesizers:

	-	Synplify and LeonardoSpectrum GUI.

Pipelining:

	-	Can make circuit operate faster by placing registers after each block of combinational logic.

Priority Logic:

	-	If then else promotes priortiy logic whereas case statments are non-priority (parallel).

Vendors:

	-	Often vendors provide premade modules for your FPGA chip.

		>	Some are free, some are licensed.
		
		>	Typically includes a GUI where you can modify these provided module libraries. 
		
Gated Clocking:

	-	Using a gate signal to enable the clock or disable the clock.
	
		>	Not recommended because the gate signal could be activated asynchronously at an odd interval of the clock, making the output unpredicatble.
	
	-	Using a multiplexer to drive the input of a register and control the output change while still receiving every clock pulse so that the output still changes with the clock, but if the input is the current output, there is effectively no change.
	
		>	Doesn't have the timing issue that a gated clock is vulnerable to.
		
Video on Basic HDL Coding Techniques:

	@00:04:00 
-	The resources you can use (optimized or non-optimized) are dependent on the FPGA chip.

-	Instantiation vs. Inferrence
		
	>	Instantiation is telling the synthesizer what specific component to use in the design.
	
		+	Advantage is control.
		
		+	Disadvantage is less portability.
	
	>	Inferrence is a suggestion to the synthesizer of what component to use by your HDL syntax. 

		+	Advantage is flexible, portable designs.
		
		+	Disadvantage is loss of control.
		
	@21:23
-	Order and group arithmetic and logical functions and operators.

	>	A <= B + C + D + E should be A <= (B + C) + (D + E).
	
-	Asynchronous resets are NEVER recommended.

	>	Block RAM FSMs require synchronous resets.
	
	@22:10
-	Copy the slide at this time, it shows multiple reasons for using synchronous designs.

	@22:54
-	Also make a copy ofthis slide to see how to make a synchronous design.

	>	If it isn't dependent on a clock signal, it is asynchronous.
	

