ECE 351
Professor Greenwood	“somebody who doesn’t know the answer tell me…”
05/07/19

General Partitioning Rules:

	-	Only leaf nodes in the hierarchy should be gate level of abstraction.
	
		>	Makes synthesis faster.
		
	-	Critical paths should be entirely in one module.
	
Critical Path:

	-	Slowest combination logic path between registers

	-	Makes timing analysis easier (makes it easier to optimize the timing).
	
		>	If a logic block has critical timing must be re-coded if timing constraints are not met.
		
		>	Combining multiple modules with critical paths into a single module makes analysis easier. 
	
	-	Whenever possible, register the module output.
	
		>	This also makes it easier to determine timing between modules.
		
	-	Potentially sharable resources (within the FPGA) should be in the same module.
	
		>	Example:
		
				always@(A or B or C or Sel)
					D = Sel? A+C : A+B;
					
		>	Without sharing:	Two or gates for A, B, and C, and a multiplexer with Sel to provide output.
		
		>	With sharing:	A multiplexer for B and C, and an or gate for A and the output of the multiplexer.
		
	-	Keep modules as small as possible (Consistent with above guidelines).
	
Circuit Synthesis:

	-	Continuous assignment statements synthesize as combinational ligic.
		
		>	Depenent on the component library.
		
		>	Don't always get what you expect.
		
		>	Example:
		
				assign y = a & b & coded
				
		>	Expect a 3-input and gate.
		
		>	The synthesizer will synthesisze two and gates.
		
	-	Blocking Modules

		>	
		
Macros:	

	-	Common logic functions that are used repeatedly.
	
		>	and gates, feeding an or gate, feeding an inverter.
		
		>	Able to create smaller circuitry with these.
		
		>	Able to create faster circutiry with these.
		
		
			