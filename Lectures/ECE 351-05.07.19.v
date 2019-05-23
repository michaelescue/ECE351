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
	
Macros:	

	-	Common logic functions that are used repeatedly.
	
		>	and gates, feeding an or gate, feeding an inverter.
		
		>	Able to create smaller circuitry with these.
		
		>	Able to create faster circutiry with these.
	
Circuit Synthesis:

	-	Continuous assignment statements synthesize as combinational ligic.
		
		>	Depenent on the component library.
		
		>	Don't always get what you expect.
		
		>	Example:
		
				assign y = a & b & coded
				
		>	Expect a 3-input and gate.
		
		>	The synthesizer will synthesisze two and gates.
		
	-	Blocking 

		>	Synthesize as basic logic gates.
		
	-	Nonblocking 
		
		>	Synthesizes as the same logic gates, with registers at the outputs.
		
		>	always@(pos/neg edge clk) synthesizes as rgistered outputs.
		
	-	Shift operator
	
		>	Synthesizes as inverters with grounded LSb's (in the case of a left shfit). 
		
		>	With a hard-coded constant, the bits are grounded.
		
		>	With a variable shift amount, the complexity becomes much greater (more flexibility, more complexity).
		
	-	Concatination of bit selects with an assignment statement.
	
		>	Synthesizes as an inverter feeding an inverter. 
		
	-	Variable position of the assignment statement determines the type of design will synthesize.
					
		>	If you have a non-constant bit select on the RHS, the circuit will be synthesized as a MULTIPLEXER.

		>	If you have a non-constant bit select on the LHS, the circuit will be synthesized as a DECODER.
		
	-	If then else statments synthesize as a MULTIPLEXER circuit.
	
Latch Inferrence:

	-	BAD
	
	-	Occurs when:
	
		>	an if-then-else doesnt' contain a default else.
		
		>	a case statement where not all case values are listed.
		
		>	a case statement where no deault is listed.
		
	-	If you haven't told the synthesizer how to update a previous value, it creates a latch to store the last value, because there isn't any value change.
	
	-	Always scan through the log window for latch inferrence and fix it!
	
	-	A pre-assignment is equivalent to adding a default option to a case statement
	
	-	Example:
	
			parameter s0 = 0, s1 = 1, s2 = 2, s3 = 3;
			
				always @(abc)
					case(abc)				//synthesis full_case
						s0,s1:	zip = 0;			|
						s3:		zip = 2;			|
					endcase							|
													V
													This is a synthesis directive, not a comment!
													
		>	Prevents latch inferrence without the need for a pre-assignment or a default case.
		
	-	When "synthesis full_case" makes more sense:
	
		>	Example:
		
				parameter s0 = 3'b001, s1 = 3'b010, s2 = 3'b100;
				
				case (state)	//synthesis full_case
					s0:	______
					s1:	______
					s3:	______
				endcase
				
		>	From a readability standpiont, the directive makes sense (for one hot encoding in this case, where default would never make sense).
		
"synthesis parallel_case":

	-	When this directive is used with a casex statement, all cases are evaluated at the same time with the same priority.
		
		>	This is equal to three independent if statements, still executed simultaneously.
		
	-	This directive treats all cases equally, and not the first matching case.
	
Priority Logic:

	-	else if else if else if....
	
		>	Synthesizes as a chain of multiplexers.
		
		>	The multiplexer closest to the output will have the least delay.
		
		>	The ordering of the statments checked in the If-Else statements will determine the order of the Logic Priority, where the first case is the highest.
		
	-	The "parallel_case" directive removes the Priority Logic.
	
		>	Will synthesize all cases to the same propagation delay using a single large multiplexer.
		
Blocking Assignments:

	-	Synthesize to combinational logic.
	
	-	Implements a natural order.
	
	-	Blocking should be used for combinational logic.
	
Non-blocking Assignment:

	-	No order, so the values on the RHS can use the old value instead of an updated value.
	
	-	This can infer a latch or flip flop.
	
	-	This is why blocking should be used for combinational logic implementations.
	
	
	