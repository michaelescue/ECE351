ECE 351
Professor Greenwood	“somebody who doesn’t know the answer tell me…”
04/18/19

//Only gate and dataflow levels of abstraction will be on the 1st test.	

/**	Timing Controls	*/

	parameter on_delay = 3, off_delay = 5;
	reg A;
	initial A = 0;

	always
		begin
			#on_delay A = 1;
			#off_delay A = 0;
		end

	/* Signal generated		*/
	
	A: 	_______|````````````````````````|____________
	t:	0		3						8		->t


case 1:

	initial
		begin
			r = 0;
			#100 r = 1;
			#80 r = 0;
			#30 r = 1;
		end
			
	/*	Signal generated	*/
	
	r: 	_______|``````|________|`````````````````````
	t:	0		100		180		210				->t


case 2:

	initial
		begin
			r = 0;
			r = #100	1;
			r = #80  	0;
			r = #30		1;
		end

	/*	Signal generated	*/
	
	r:	____|````|____|````
	t:	0	30	80	100


	/* Non-blocking assignments set any delays to absolute time.	*/

/** Writing Tenchbenches	*/

	syntax:
		
	module module_name;		// No port list
		local reg /*Or*/ net variable declarations;
		instantiate modules to be tested;
		initial /*Or*/ always statements to generate test patterns;
	endmodule
	
/** When to use BLOCKING or NON-BLOCKING assignments.	*/

	/*	BLOCKING assignments	*/
		
		initial 
			clock = 0;
		always
			#10 clock = ~clock;
			
	/*	When you want to generate a signal	*/

	w:	_____|``````|____|``|________________|````|____
	t:	0	100		150	170	172				591	863
	
		NON-BOCKING assignments would be preferred because the dealys can be made absolute
		at each fvalue present on the waveform. Using blocking assignments would mean the 
		relative delays would need to be calculated.
	
	
		For NON-BLOCKING statements order doesn't matter.	
		The RHS of the NON-BLOCKING statment is recorded.
	
	
/** Event Controls*/

	"@" denotes Event Control, i.e.: 
		
		@("Event List")
	
	Events include asserted signals, clock edges, etc.
	
	Types of Event Control: Level, Edge triggered.
	
	/* Edge triggered events	*/
		
		clk:	____|```````|____
					^	 	^
					|	  	|		
			posedge clk		|
			0->1			negedge clk
			0->x			1->0
			0->z			1->x
			x->1			1->Z
			z->1			x->0
							z->0
							
	/* Events can be maninpulated with logical operators	*/
	
		@(posedge A or negedge B);
					^
					|
					keyword
						Dont use logical operator symbols, only keywords.
					
	/*	For if statements	*/
	
		~	is used for complementing a vlaue (Don't use for if statements).
		!	is used for evaluation as "not".
		
	/* Event control for any chaging variables	*/
		
		@(*) covers all signals and if any signals change, will trigger the event controlled code.
		
	/*Switch statements in Verilog	*/
	
	case statement:	Nearly identical to "C" switch statment.
	
	syntax:
		
		case(expression)
			alternative	n:	Statement n;
			...
			default:	default statment;
		endcase
		
	The case statment expression (and other if/else statemetns) can use concatenation of 2 or more signals
	for evaluation.
	
	example:
	
		case({s1, s0})		// Case expression of 2 bits.
			alternative 2'd0:	// Alternative is equal to 0 in decimal.
			alternative 2'd1:	// Alternative is equal to 1 in decimal.
			alternative 2'd2:	// Alternative is equal to 2 in decimal.
			alternative 2'd3:	// Alternative is equal to 3 in decimal.
						  ^
						  |
						  decimal format
	
	When case is used, all expression variables must match.
	When casez is used, any z-bits are ignored.
	when casex is used, any z or x bits are ignored.
	
		Ignored bits are not compared to input. 
		
		All uses must include endcase keyword.
		
	example:
	
		a = 2'b11		// equal to "11"
		
		case(a)
			2'bx1:		B = 0;	// A doesn't equal "x1" so next evaluated at this alternative.
			default: 	B = 1;
		endcase
		
		casex(a)
			2'bx1:		B = 0;	// Because only the LSb is evaluated, the alternative is valued, and the expression evaluated.
			default: 	B = 1;
		endcase
		
	/* Multiple alternatives can be combined on the same line	*/
	
		2'bx0, 2'bx1, ...: Statement;
		
		Sometimes vendors recommend good coding styles depending on the FPGA design.
		This will result in beter performance.
		
	/* Loops	*/
	
	Must reside in an initial or always statement.
	
	there are 4 types of loops:
		while
		for
		repeat
		forever
		