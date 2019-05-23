ECE 351
Professor Greenwood	“somebody who doesn’t know the answer tell me…”
04/16/19

-	Nested ternary operations are legal
o	Example:

Assign out = s1 ? (s0 ? i3: i2) : (s3 ? i3: i1);

-	Concatenated LHS statements are also legal
o	Example:

assign {c_out, sum} = a + b + c_in;
	The upper 1 bit will go to c_out
	The lower 4 bits will got o sum
	Sum is a 4 bit output.
	C_out is a 1 bit output.

-	Example 6-8
o	Port list:	q, qbar, d, clk, clear
o	Instantiation:	q, , ~q, clk, clear
	Note that the second item in the portlist is not used and a “ “ space is used to show it as unused, or unconnected.

-	Behavioral Level of Abstraction:	Highest level of abstraction.
o	Arguably the 1st choice for programming.
	Coding should be evaluated to determine if the abstraction level should be lowered for better performance output.
o	Testbench first approach:	Not covered in the book
o	Not everything in Behavioral Modeling is synthesizable.
o	Some non-synthesizable models can be used in the testbench.

-	Behavioral level of Abstraction:		Models have 2 structured procedures
o	Initial statements (Not synthesizable) 
o	Always statements
o	No limit on the number of these in a module
o	All of them execute concurrently and begin a time t=0;
o	These cannot be nested.

-	Behavioral level of Abstraction:		Testbench	
o	A program designed to exercise a digital system to verify its functionality.
o	Not Synthesizable.
o	Testbenches are written in Verilog at the Behavioral Level.
o	Testbenches don’t verify timing.
o	Testbenches generate test patterns to exercise the digital design.
o	Testbenches collect and output the circuit’s response.
o	Optionally, they are also used to compare outputs with expected outputs.
o	All testbenches will include the following behavioral statement:

Initial
#50 $finish

o	This tells the simulator to run the system task “$finish” after 50 time units of delay.
	This means the simulator will end the testbench after 50t.

-	Behavioral level of Abstraction:		Syntax
o	Example:

initial	(keyword)
[delay] “Procedural Statement”

o	Procedural Statement:
o	assignment (blocking, non-blocking)
o	continuous assignment
o	conditional statement
o	case statement
o	loop 
o	event trigger
o	parallel block
o	wait statement
o	disable statement

o	When there are more than 1 procedural statements:

Initial	(keyword)
Begin	(keyword)
…	[delay] “Procedural Statement”
…	[delay] “Procedural Statement”
…	[delay] “Procedural Statement”
…	…
			End	(keyword)
	This is an example of a sequential block.

-	Behavioral level of Abstraction:		Blocking Assignments		(a = b;)
o	LHS updates before next statement executes.
o	Example:

-	Behavioral level of Abstraction:		Non-Blocking Assignments	(a <= b;)
o	RHS is recorded
o	LHS updates at the end of an initial/ always procedure


 
-	Behavioral level:	In a sequential block, statements DO EXECUTE SEQUENTIALLY
o	Example
Initial
	Begin
		#5 a = 1’b1;
		#25 b = 1’b0;
	End
	The delay’s using “#” are sequential, thus additive.
	“b” will not be initialized until time unit 30.
