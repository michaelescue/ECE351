ECE 351
Professor Greenwood	“somebody who doesn’t know the answer tell me…”
04/25/19


/* Functions and Tasks	*/

-	No such thing as a global Function or Task.

	/* Task properties	*/
	
		-	"called" from an initial or always statement.		// cannot be isolated within the block it will be provided.
		-	Can have any number of ports (including zero ports).
		-	May have timing and / or event controls.
				i.e. @(posedge..)
				
	syntax:
		
		task [automatic] taskname;
			port declarations;
			procedural statements;
		endtask
		