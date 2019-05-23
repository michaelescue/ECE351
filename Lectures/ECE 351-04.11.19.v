ECE 351
Professor Greenwood	“somebody who doesn’t know the answer tell me…”
04/11/19

-	Figure 5-6:	1-bit Full adder
o	As with any module, any nets not covered by the port list will need internal declarations.
	As “wire” or perhaps “reg”.

-	Figure 5-8:	Module D
o	“#” represents the propagation delay.
o	Time delay base is 1ns by default in most simulators.
	This can be modified.

-	Figure 5-9:	Waveforms for Delay Simulation
o	The “X” on the E and OUT signals are undefined during the propagation time for each logic gate with delays #4 and #5. 
o	This would be the waveform result of using the “#” syntax.
o	Never use the “#” syntax.
o	Using the “#” syntax implies that a specific technology is used.
	This is bad because:
1.	Not synthesizable.
2.	HDLs are supposed to be technology-independent.

-	Dataflow Level of Abstraction
o	reg variables hold values.
o	net variables don’t.

 
-	Methods of Assigning net variable values
1.	Drive with a module output.
a.	Gate primitives are also considered modules.
2.	With a “Continuous Assignment Statement.”

-	Continuous Assignment Statement
o	Unique to the Dataflow level of abstraction.
	Recognizing a continuous assignment statement means the description is at the Dataflow level of abstraction.
o	Continuously drives the net variable.
o	LHS updates whenever the RHS changes.
o	Syntax:
assign	LHS = RHS;

	assign		keyword (reserved).
	LHS		Variable Identifier for Net variable (Left-hand side)
	RHS		Some expression, arithmetic, or logical. (Right-hand side) 
o	Actual Syntax:
assign [Strength Level] [delay]	LHS = RHS;

	However, neither Strength Level, nor delay, are synthesizable.

-	Bit Select
o	Suppose:	wire[7:0]A;
o	A[2]  is a bit select of bit 2 of wire a.

-	Expression:	A combination of operators and operands to get some result.
-	Operand:	a data element (a net variable or constant).
-	Operator:	anything that acts on an operand.

-	Arithmetic Operators:	‘+’,  ‘-‘,  ‘/’,  ‘*’, ‘%’ (modulus), ‘**’ (power) 
o	Each requires only two operands.
o	The LHS size is determined by the size of the largest operand.
o	Example:
wire [3:0]A, B, C;
wire [5:0]D;
…
A = B + C;		// 4 bit result.	(largest operand is 4 bits)
D = B + C;		// 6-bit result.	(largest operand is 6 bits)
o	If any bit on the RHS is a ‘x’ the result is ‘x’ (don’t care).

-	Logical Operators:	‘!’, ‘&&’ (and), and ‘||’(or)
o	Primary use will be in behavioral descriptions for if, then , else statements
o	Entire variable is considered as:
	A logic 0
	A logic 1
•	Is always the case if the operand doesn’t = 0 (or x or z).
	A don’t care ‘x’
	A high impedance ‘z’

-	Bitwise Logical Operators:	‘&’, ‘|’, ‘~’ (negation),  ‘^’(xor), ‘~^’ or ‘^~’ (xnor)

-	Concatenation Operator:	‘{ }’
o	Suppose:	assign D[7:4] = {D[0], D[1], D[3], D[6]};
o	Then		D[7:4] = 4’b1011;
o	Suppose:	assign D = {D[3:0], D[7:4]}; 
o	Then 		D = {D[3], D[2], D[1], D[0], D[7], D[6], D[5], D[4]}

-	Reduction Operators:	‘&’, ‘~&’, ‘|’, ‘~|’, ‘^’, ‘^~’, ‘~^’
o	The compiler will use context by number of operands to determine if reduction operators or logical operators are used.
o	This is great for parity checking.
o	Applies the bitwise operator on pairs of bits from right to left
o	Suppose: 	y = 6’b011010
&y	= 0110_1&0
	= 011_0&0
	= 01_1&0
	= 0_1&0
	= 0&0
	= 0

-	Shift Operators:
o	Syntax:		LHS = variable << [Decimal Number]

-	Conditional Operators:	
o	Syntax:		assign LHS = predicate ? value1 : value2;
	The predicate is only true or false.

-	Replication Operator:
o	Suppose:	Y = {4{A}}; where A = 1’b1
o	Results:		Y = 4’b1111

 
-	Dataflow Description:	2x1 Mux 
o	Inputs A, B, S.
o	Output Y.
o	assign Y = S ? B : A;

-	Dataflow Description:	   Buffer
o	Inputs A, C
o	Output B
o	assign B = C ? A : 1’bz;

-	Dataflow Description:	8-bit Comparator
o	Inputs (unsigned) A[7:0], B[7:0]
o	Outputs “A>B”, “A<B”, “A=B”
o	Example:
module comp(A, B, AGTB, ALTB, AEQB)
	input [7:0]A, B;
output AGTB, AEQB, ALTB;
	assign AGTB = A>B;
	assign ALTB = A<B;
	assign AEQB = A==B;
			endmodule 
	

