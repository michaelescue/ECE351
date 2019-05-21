ECE 351
Professor Greenwood	“somebody who doesn’t know the answer tell me…”
05/16/19

FGPA Implementation

-	Library HDL(.v or .vhd) and constrainst files are input to the synthesiszer.

-	The synthesizer outputs the netlist.


IP Generation tools

-	IP generation tools create IP and "hard macro" in vendor speciic file formats.

	>	Altera FPGA
	
		+	MegaWizard IP generation tool.
		
		+	.edif, .edf. adl File Format.
	
	>	Actel FPGA
	
		+	SmartGen IP Generation tool.
		
		+	.vqm File Format.
		
	>	Lattice FPGA
	
		+	IPExpress IP Generation tool.
		
		+...
		

Third Party IP

-	No source file? An analogy:

	>	C program is fed to compiler.
	
	>	Compiler generates assembly language which is fed to the assembler.
	
	>	The assembler outputs the object file which is fed to the linker/loader.
	
	>	The linker/loader outputs the executable file to memory.
	
-	Suppose a function 'foo' is called but no source file is included in the program code.

	>	Only an object file is included from the compilation of the source code for 'foo'.
	
Black Box Synthesis

-	"Black Box" modules are just port declarations.

	>	No functionality described (not necessary)
	
	>	Use synthesis directive "synthesis syn_black_box".
	
	>	Without the directive, a warning will be issued.

-	Netlist with Black Box modules are input to the PNR tool.

-	"ngc" or "EDIF" files for vendor genreated IP and other edif files from 3rd party IP are input to the PNR tool.

-	The PNR tool outputs the bitstream.

Xilinx FPGA Terminology.

-	Slices

	>	Each CLB contains two slices.
	
	>	Carry logic is implemented. Carry output will be input to adjacent CLB slices.
	
-	SRL

	>	Shift Register LUT.
	
-	When hard IP is provided, you should default to using it. Preserve resources in FPGA fabric.

-	PowerPC Chip

	>	Complete microprocessor chip on FPGA chip.
	
-	Rocket IO Transceiver

	>	Serial data communication without having to build one.
	
Inferring Distributed RAM

	module ramtest(z, raddr, d, waddr, we, clk);
	output [3:0] z;
	input [3;0] d;
	input [3:0] raddr, waddr;
	input we;
	input clk;
	
	reg {3:0] mem [7:0];
	
	assign z = mem[raddr];
	always @(posedge clk) begin
	...
	..
	.
	
	
Inferring Distributed Dual Port RAM

	module ram16x8(z, raddr, d, waddr, we, clk);
	output [7:0] z;
	input [7:0] d;
	input [3:0] raddr, waddr;
	input we;
	input clk;
	reg [7:0] z;
	reg [7:0] mem0, mem1, mem2, mem3, mem4.......
	....
	...
	..
	.
	justalways @(posedge clk) begin
	if(we)
		begin
		
		
Inferring Block RAM

-	The read address or the output must be registered.

-	Both the read address and output address must be registered. ????????????????????????????????


Byte Wide Write Enable

-	Write 8-bit portions of incoming data.

-	Byte slectable, not all bits are required.

-	Each byte is associated with a parity bit.

	>	Hence 36Kbytes of RAM.
	
	
ROM

-	Can be inferred from a case statement where all assigned contexts are constant values.

-	In Synplicity, a synthesis directive is necessary.


FSM in Block Ram

-	...


Shift Register LUT

-	Inferred by:

	always @(posedge C)
	begin
		Q_INT <= {Q_INT[14:01], D};
	end
	
	always @(Q_INT)
	begin
	
		Q <= Q_INT[15];
	end
	
