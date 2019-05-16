ECE 351
Professor Greenwood	“somebody who doesn’t know the answer tell me…”
04/02/19	Synthesis

project:

	-	a hierarchy of directories containing all of the files and other data needed for an FPGA build.
	
wizard:
	
	-	A "wizard" in computing is something that guides the user through a sequence of steps to accomplish some process. 
	
Devleopment Board:

	-	PCB with the fpga chip which includes other devices that are use to check design.
	
		>	example devices include LEDs, Seven Segment Displays, Switches, etc.
		
	-	If you have a Microprocessor that is part of the design.
	
Synthesis:

	-	The process of converting a high level description into a netlist.
	
	- 	The description is typically RTL code (Data flow level of abstraction).
	
	-	A constraint file is required.
	
	-	Architectural description is you system specification.
	
	-	Always check the Verilog HDL constructs for Logic sysnthesis to make sure you are in complianc with the synthesizer's 		requirements.
	
	-	True for all Synthesizers:
	
		>	All delays are ignored.
		
			+	Simulation results != sythesizer results
			
			+	Any # delays used in the design will not match.
			
		>	Warnings must be checked.
		
			+	Latch inferrence will generate a warning (THIS IS BAD).
			
Negative affects of Logic Optimization:

	-	"Hazard Covers" will be removed.
	
ASIC Synthesis:

	-	The three inputs required for synthesis:
	
		>	Library
		
		>	HDL
		
		>	Constraints
		
ASIC Library:

	-	Contains standard cells (primitive gates) and Macros.
	
		>	Macros are commonly used logic blocks which appear in designs.
		
			+	Muxes, counters, etc.
			
	-	Each cell or macro contains:
	
		>	Functional information.
		
		>	Layout information.
		
			+	The area each standard cell actually requires.
			
		>	Timing information.
		
		>	Power consumption information.
		
Standard Cell Design Style:

	-	Consists of Rows and channels.
	
		>	Rows consist of standard cells.
	
		>	Channels encompass the vias between rows.
		
Design Example:

	-	Specification (comparator)
	
		A -->|```````````A = B|----->
			 |				  |
			 |				  |
		B -->|________________|----->
		
	- We want delay  (tpd) to be as small as possible.
	
	- Area and speed are inversely proportional.
	
Look Ahead Carry Circuitry:

	-	Carry is known at each bit position so the numbers can be added, then the sum added to the bit positions for the 	known carries and the sum is the expected result.
	
RTL Magnitude Comparator Example:

	-	The vendor can provide a component library for your design.
	
	-	The vendor must also provide a simulation library for the simulator software to understand their component 			definitions.
	
	-	The Simulation Library will defne timing constraints.
	
Timing Verification:

	-	Proof that the design meets the function intent.
	
Timing Closure:

	-	Proof the design meets the timing restrictions.
	
	-	Timing closure has nothing to do with verifying the functionality of the device.
	
Managing Complexity:

	-	Guiding priciple:	Always seperate the data path from the control path.
	
	1.	Structure the data path.
	
		>	From the design spec, determine what functional units to use (Muxes, adders, etc).
		
			+	There are tradeoffs to consider.
			
	2.	Identify Control Points.
	
		>	Functional units have control/status signals (called control points).
		
	3.	Determine a Control Strategy.
	
		>	Finite State Machine 
	
		>	Counter
		
	4.	Determine a Reset Strategy.
	
		>	What gets initialized and what is the initial value.
		
		>	FSM's have an initial state.
		
		>	Counters have an initial count value.
		
		>	Decoders may have a defined output polarity.
		
		>	FFs (registers) need an initial state.
		
		>	Don't forget about the reset signal itself (Does it need to be logic 0 or 1 to reset devices).
		
	5.	Always Design before Coding.
	
		>	Failure to do so will lead to wasted time and effort.