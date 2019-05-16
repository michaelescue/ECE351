ECE 351
Professor Greenwood	“somebody who doesn’t know the answer tell me…”
05/14/19

2-to-4 decoder example

-	Requires 3 ICs to complete the circuit.

	>	1 hex inverter chip.
	
	>	1 Quad 2-input and chip.
	
	>	1 Quad 2-input xor chip.
	
-	Any boolean equation can be implemented with an appropriate sized memory chip.

-	The same implementation which requires 3 chips can be implemented with a signle 8x2 ROM chip.

	>	Example:
	
			y1 = a + b + c;
			
			y2 = a (+) c;		// (+) = xor.
			
			abc	|	y1	y2
			000	|	0	0	
			001	|	1	1	
			010	|	1	0
			011	|	1	1
			100	|	1	1
			101	|	1	0
			110	|	1	1
			111	|	1	0
	
		---------------------------------------
		
				(8x2 ROM)
			
				|`````````|
		c	->	|A0		d0|	->	y1
		b	->	|A1		d1|	->	y2
		a	->	|A2		  |	
				|_________|
				
	
	>	This implementation is called a LUT.
	
FPGA "fabric"

-	Consists of objects that must be intentionally programmed:

	>	Programmable interconnects.
	
	>	Configurable Logic Block (CLB).
	
	>	I/O pads provide: Types of inputs and outputs needed in design.
	
		+	May want a tri-state I/O.
		
		+	May want a registered Output
		
Circuit Netlist

-	Output of the synthesizier

	>	Netlist goes into a seperate tool for Place and Route (PNR)

-	Devices used + their ineterconnects.

-	tHE THREE TASKS WHICH MUST BE COMPLETED FOR SYNTHESIS:

	1.	Mapping Phase
	
		+	Assign all gates to virtual LUTs (virtual in the sense that the numbering is arbitrary).
		
		+	Registers get assigned to virtual flip-flops.
		
	2.	Placement Phase
	
		+	Virtual LUTs and Registers are assigned to the physical LUTs and Registers in the FPGA fabric.
		
	3.	Routing Phase (PNR)
	
		+	Connections are made between all CLBs and I/O pads.
		
Introductory Document to FPGA Architecutre (XILINX SPARTAN FPGA)

-	Remember that all combinational circuits can be built using 2-input nand and 2-input nor gates.
	
	>	The number of gates available on a chip are listed in the datasheet.

-	CLB matrix is listed.

-	Basic FPGA Block Diagram:

	>	Shows CLBs
	
	>	Shows Exterior Resources.
	
		+	Oscillators (20-25MHZ typcial).
		
		+	Startup Block.
		
		+	Readback Block ("reads back" binary strings used to program the device).
		
-	CLB Diagram (simplified):

	>	LUTS are MEMORY CHIPS.
	
		+	1 G-LUT
	
		+	1 F-LUT
	
		+	1 H-LUT
	
	>	Multiplexers on either side of the H-LUT and on the outpus of the F and G LUTs.
	
	>	Registers on the outputs of the Multiplexers on the output side of the H-LUT.
	
		+	[H-LUT -> Multiplexers -> Registers]
		
-	CLB Diagram (Output register details).

	>	Clock input driven by multiplexer
	
		+	Multiplexer input is "CK"
		
		+	Inverting and non-inverting inputs to the multiplexer which feeds the clk input to the register
		
		+	Allows for posedge or negedge clk.
			
	>	GSR is a global reset for when the chip is powered on that initializes the registers.
	
-	I/O Block Diagram (Simplified)

	>	Package Pad is the FPGA pin.
	
	>	Input buffers.
	
	>	Tri-state output buffers.
	
	>	"O" output can be asserted high or low
	
		+	This can be registered to an output or unregistered to an output pin dependent on programming.
		
-	Programmable Switch Matricies (PSM)
		
	>	Use six-pass transistors per switch matrix interconnect point.
	
	>	Uses "North, South, East, and West" transistor path directions.
	
-	Distributed RAM

	>	"Microblaze"
	
		+	A complete microprocessor implemented in FPGA fabric.
		
	>	There are two sources for memory:
	
		1.	Distributed RAM
		
			+	When LUTs are used as the RAM memory structure
			
			+	"Distrubuted" because the LUTs are not consolodated, but are in multiple CLBs.
		
		2.	Block RAM
		
			+	External to the FPGA. 
			
			+	May also be an integrated resource exterior to the FPGA fabric, but present on the FPGA chip.
			
			
Intellectual Property (IP)

-	In the context of FPGAs, these are MODULES.

-	IP:

	+	Previously designed, tested and synthesized modules.
	
	+	Also called "Cores" or "IP Cores"
	
-	Soft IP:

	+	Available as a verilog or VHDL module only. 
	
-	Hard IP:

	+	A hardware component inside the FPGA.
	
	+	Exterior resource (External to FPGA fabric).
	
	+	Block RAM is an example of Hard IP.
	
	+	DSP circuitry is an example of Hard IP.
	
	+	Can be instantiated.
	
	+	Can be inferred.
	
	+	Recommended by XILINX (anyway) to save FPGA fabric resources. 
	
-	IP Sources:

	1.	User (HDL you write).
	
	2.	Vendor supplied (FPGA vendor).
	
		>	Xilinx has a library of pre-defined modules that are usually licensed to you (for a license fee).
	
	3.	Third party IP. 
	
		>	IP licensed to you from a company that doesn't make FPGAs, just IP.
		
		>	Work closely with FPGA vendors to ensure efficient use of resources and is compatible with common synthesizers.
		

Dual Port RAM

-	Seperate Write address and Seperate Read Address and Seperate Data lines.
	
-	Allows for simultaneous reads and writes.



Core Generator Video

-	All the resources that can be used in the Xilinx Vertex 5 will not be covered.

-	Tools are similarly not all covered.

-	Focus on the concepts of how the GUI allows you to select, configure, and see the output of the core generator.

	>	Each FPGA vendor has their own tools.
	
	>	All Core Generator tools work in the same conceptual manner.

-	A core is a ready-made fnction that you can instantiate into your design as a black box.

-	Cores range in complexity.

	>	Simple artithmetic operators, such as adders, accumulators, and multipliers.
	
	>	System-level building blocks, such as filters, transforms, and memories.
	
	>	Specialized functions, such as bus interfaces, controllers, and microprocessors.

-	Some cores can be customized.

-	Benefits of Using Cores:

	>	Save design time
	
		+	Cores are creatd by expert designers who have in-depth knowledge of XILINX FPGA architecture.
		
		+	Garunteed functionality saves time during simulation.
		
	>	Increase design performance.
	
		+	Cores that contain mapping and placement information have predictable performance that is constant over device size and utilization.
		
		+	The data sheet for each core provides performance expectations (use timing constraints to achieve maximum peformance).
		
-	LogiCOREs.

	>	Typically customizable.
	
	>	Fully tested, documented, and supported by Xilinx.
	
	>	Many are pre-placed for predictable timing.
	
	>	Many ar unlicensed and provided for free with Xilinx software.
	
		+	More complex LogiCORE solution products are licensed.
		
	>	VHDL and Verilog flow support for several EDA tools.
	
-	 AllianceCOREs.

	>	Point-solution cores.
	
		+	Typically not customizable (some HDL versions are customizable).
		
	>	Sold and supported by Xilinx AllianceCORE solution partners.
		
		+	Partners can be contacted directly to provide cusotmized cores.

		+	A free evaluation version of the module is availabe.
		
	>	All cores are optimized for Xilinx; soem are pre-placed.
	
	>	Typcially supplied as an EDIF.
	
	>	VHDL and verilog flow support.
	
@06:45

-	See implementations slide for example functions.

-	CORE Generator Software System.

	>	A Graphical User Interface (GUI) allows central access to LogiCORE IP products.
	
		+	Access to data sheets.
		
		+	Access to Customizable parameters.
		
	>	Interfaces with design entry tools.
	
		+	Creates instantiation template for HDL-based designs.
		
	>	Web Links tab provides access to the Xilinx Website and the IP Center.
	
		+	The IP Center contains new cores to download and install.
		
-	Behavioral SImulation Wrapper files

	>	
	
	
	