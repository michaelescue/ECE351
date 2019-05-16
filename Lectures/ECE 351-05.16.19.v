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