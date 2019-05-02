ECE 351
Professor Greenwood	“somebody who doesn’t know the answer tell me…”
04/30/19

/* Assignments:	*/

	-	There are procedural continuous assignments that override existing assignments.
	
	-	"assign" and "deassign" are now bad coding style.
	
		>	It is recommended that "force" and "release" are used.
		
"Force" and "Release" keywords:

	-	Forcing an assignment causes the the internal connection to be assigned a value until it is released.
	
		>	Can be a register or a net.
		
	Example:
	
		assign out = a&b&c;	//normal assignment
		
		initial...
			
			force out = a|b&c;
		
		end...
		
	-	When a net variable is released, the variable instantly returns to its previous assignment.
	
	-	When a reg variable is released, the reg must wait for stimulous before changing.
	
/* Module Instance Parameter Values:	*/

	-	Should always be practiced. 
	
	- 	IP (module) reuse is one of the best things about HDLs.
	
	-	Paramters allow for slight changes without changing the functionality of the module.
	
	Example:
	
		module hello;
		
		parameter id_num = 22;
		
			initial 
			
				$display( "id_num = %d", id_num);
				
			end
				
		endmodule
		
	----------how to use the module without re-coding it-----------------
	
	module top;
	
		hello #(49) w1;			// pass by position.
		
		hello #(.id_num(49)) w2	// pass by name.
		
	----------------------------------------------------------------------
	
	-	Parameters need to be used to lengths of data or anything that can change. 
	
/* Time Scales in Simulation	*/

	-	The default time unit is usually 1 ns.
	
	Syntax:
	
		`timescale time_unit/time_precision
		
	1.	The values must be 1, 10, 100.
	
		>	Cannot pick a time unit of 3 (for example) nanoseconds.
		
	2.	Units can be :
		
		>	S for seconds.
		
		>	ms for miliseconds.
		
		>	ns for nanoseconds.
		
		>	ps for picoseconds.
		
		>	fs for femtoseconds.

	3.	"time_unit" sets the delay units. "time_precision" sets the round off units during simulation.
	
	Example:
	
		`timescale	1ns/100ps
		
		assign #5 A = B;	// delay by 5ns.
		
		`timescale	100ns/1ns	//<--- This may be incorrect.
		
		assign #5 A = B;	// delay by 5us.
		
/* $display, $monitor, and $strobe	*/

	$display: 
		
		-	syntax is fully equivelant to printf in 'C'. 
	
	$monitor:
	
		-	prints, but prints everytime the variables used change. 
	
	$strobe: 
	
		-	waits until all used variables are assigned to print to stdout.
		
/* File I/O	*/

Opening a file:
	
	Syntax:
	
		$fopen("file_name");
		
			>	Returns an int pointer.
			
	Example:
	
		integer ptr;
		
			ptr = $fopen("my_file");
				
Closing a file:

	Syntax:
	
		$fclose(file_ptr);
		
Writing to a file:

	Syntax:
	
		$fdisplay(file_ptr, p1, p2,...,pn);
		
			// Where pn are parameters.
			
		$fmonitor(file_ptr, p1, p2,...,pn);
		
Reading from a file:

	Syntax:
	
		$readmemb	//binary
		
		$readmemh	//hex
		
Reading and Writing from a file (can be used as ROM):

	Example:
	
		// For a 3-bit adder.
		
		Assume "test.vec" conatins:
		
		010 010 0 	100	0
		010 011 1 	110	0
		^	^	^	^	^
		|	|	|	|	|
		A	B	Cin	|	|
					Expected Sum
						|
						Expected Co
						
		reg [11 : 1]	vmem [2 : 1]
		
		// Instantiate adder
		
		adder_3bit F1(A,B,Cin,Sum,Cout);
		
		initial
		
			begin
			
				$readmemb ("test.vec", Vmem);
				
				for(j = 1 ; j < = 2 ; j = j + 1)
					
					begin
						
						{A, B, Cin, Sum_Ex, Cout_Ex} = Vmem[j];
						
						if((sum !==	Sum_Ex) || (Cout !== Cout_Ex))	// "!==" is case inequality
						
							$display ("mismatch vector %d", Vmem[j]);
					end
			
			end
		
		end
		
/* Value Change Dump File (VCD)	*/

	-	Verilog equivalent of a source level debugger.
	
	- In the VCD file itself, each signal is assigned a symbolic character to represet the signal at each printed instance.
	
VCD File:

	-	An ASCII file that stores 'timestamped' signal changes.
	
	-	It is used by postprocessing design automation tools.
	
$dumpfile:

	-	Simulation info dumped to file.
	
	Example:
	
		$dumpfile("myfile.dmp")
		
			>	Dumps to myfile.dmp.
			
$dumpvars:

	-	Any signal change gets dumped into the specified file.
	
	Example:
	
		$dumpvars(1, top);
		
			>	Dump variables in module instance top.
			
			>	Number '1' indicates level of hierarchy.
			
			>	Dump '1' hierarchy level below top, ie.e, dump variables in top, but not signals in modules instantiated by 	top.
			
		$dumpvars(2, top.m1)
		
			>	Dumps up to 2 levels of heierarchy below top.m1 (top.m1 is not a signal).
	
$dumpon & $dumpoff:

	-	$dumpon starts dumping.
	
	-	$dumpoff stops dumping.
	
$dumpall:

	- Dumps everything. If you delay this dump, you can create "checkpoints" at a particluar time instance.
	
Other VCD file system Tasks:

	1.	$dumplimit(size):
	
		-	"size" is decimal # of bytes.
		
	2.	%dumvars(0, sig1, sig2,...,sign);
	
		-	Signals are reg'd.
		
		-	Signals are stored in VCD file.
		
	Example:
	
		$dumpvars(0, div.clk);
		
			-	Stores variable (or signal) "clk" from module "div".
	
	