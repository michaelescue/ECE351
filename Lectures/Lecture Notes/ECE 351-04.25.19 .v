ECE 351
Professor Greenwood	“somebody who doesn’t know the answer tell me…”
04/25/19


/* Functions and Tasks	*/

-	No such thing as a global Function or Task.

	/* Task properties	*/
	
	-	"called" from an initial or always statement.		// Cannot be isolated within the block it will be provided.
	-	Can have any number of ports (including zero ports).
	-	May have timing and / or event controls.
			i.e. @(posedge..)
				
		syntax:
			
			task [automatic] taskname;
				port declarations;
				procedural statements;
			endtask
			
	-	Default type for all ports is a reg.
	-	ports in modules != ports in tasks.
				 |					 |
				 V					 |
		I/F signals					 V
									Values passed to /from the task.
									
	-	Tasks can operate on any variables declared in the module.
	-	The order of declaration matters when defining a task.
	-	Keyword "automatic", if included, akes the task re-entrant.
	
	/* Function properties	*/
	
	-	There are no delay, timing, or event control constructs in the procedure.
	-	The procedure returns a 'single' value.
	-	There is at least one input argument.
	-	There are no output or inout arguments.
	-	There are no non-blocking assignments.

		syntax:
		
			function [range] function_name;
				input declarations;
				other local declarations;
				procedural statements;
			endfunction
			
	-	If no range is specified the function returns a single bit.
	
	// Example:
	
		module foo;
			parameter max = 8;
			.
			.. // Module declarations.
			...
			function [max - 1 : 0] reverse;		// Function template.
				input [max -1 : 0] Din;
				integer k;
				begin
					for(k = 0; k < max; k = K + 1)
						reverse [max - k - 1] = Din [k];
				end
			endfunction
			
	-	"function" implies some sort of storage, such as a register to store the function result.
	
	/* Calling functions	*/
	
		module example;
		.
		..
		...
			reg [max - 1: 0] new_val, old_val;
			.
			..
			...
				function [max - 1: 0] reverse;	//template.
				.
				..
				...
				endfunction
				.
				..
				...
			always @(	)
				new_val = reverse(old_val);
				
		endmodule
		

	