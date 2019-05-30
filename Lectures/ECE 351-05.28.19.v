ECE 351
Professor Greenwood	“somebody who doesn’t know the answer tell me…”
05/28/19

Configuration

-	Synthesizer
	
	>	The three inputs (Component library, HDL, User Constraint File)
	
	>	Produces the netlist.
	
-	Place and Route

	>	Accepts the netlist from the synthesizer
	
	>	Outputs the bit steam file which will program the FPGA.
	
-	Mode Pins

	>	Several sources of the bit stream file.
	
	>	Mode pins are used to determine the source of the programming bit stream.
	
// Begin Basic FPGA Configuration XILINX video

-	Most configuration principles are universal.

-	Daisy Chaining

	>	forms a psuedo shift register between multiple FPGA chips on a single circuit board.
	
	>	Serial inputs are connected in serial sequence.
	
What is configuration

-	Process of loading config data into FPGA

-	FPGAs are SRAM based.

	>	SRAM is volatile.
	
-	Flash memory wasn't cost effective

	>	Attempts at hybridizing on chip caused issues with real estate.
	
-	The FPGA has internal control logic.

	>	Custom logic control can be implemented by the customer/designer/engineer

-	Multi bit streams can be loaded on an FPGA.

	>	bit stream programming can happen on the fly.
	
When do you configure the FPGA

-	On power up

-	On demand

	>	By triggering the program pin.
	
@00:06:30

-	Take a screen shot of this slide out of the video.

Configuration methods

-	Xilinx Cables

	>	Using JTAG interface, Slave Serial, Slave SelectMap.
	
	>	Requires a computer

-	Microprocessor

	>	Microprocessor writes to the FPGA
	
	>	Using JTAG or Slave Serial or SLave SelectMAP
	
	>	Requires external control logic.
	
	>	Large percentage of systems do not have micrprocessors.

-	Xilinx PROMs

-	Commodity Flash

	>	Using Slave SelectMAP, SPI*, or BPI*
	
	>	Expected to know what SPI (Serial Peripheral Interface) and BPI (Byte-side Peripheral Interface) are.
	
	>	On chip memory must be programmed with JTAG before it can be used to program the FPGA chip.
	
Mode Pins

-	3 pins.

-	Slect which configuration mode is used.

Specific Pins on the FPGA are used during configuration

-	Pins act differently depending on the configuration mode

-	Some pins are only accessible in different modes.

PROGRAM_B

-	Input that initiates configuration

-	Active Low

-	Configure on command pin

CCLK(configuration Clk)

-	Input or output (depending on config mode)

-	Feq up to 100MHz depending on FPGA config

INIT_B

-	Open-drain bi-directional pin.

-	Error and power stabilization flag

-	Active Low

DONE

-	Open-drain bi-directional pin

-	

DIN

-	Serial input for configuation data

DOUT

-	Output to the next device in a daisy chain

-	Used in daisy chains only

-	Other pins are used for this purpose.

JTAG configuration mode @17:33

-	Control signals are parallel.

-	JTAG has configuration mode priority.

-	Always provide a JTAG interface with PCB boards that use an FPGA
	
	>	JTAG is only 4 wire interface.
	
	>	JTAG is necessary.
	
	>	Allows for programming in its target environment.

-	JTAG is most useful for debugging.

SPI

-	FPGA configures itself from an attached industry-standard SPI serial Flash PROMs

	>	FPGA issues a command to Flahs and it responds with the data.
	
	>	Can be used in multi-boot applications where multiple bitstreams can be loaded by the FPGA

-	Data is loaded 1 bit per CCLK (slow)

-	There are no standards for the commands

	>	Commands are vendor specific.
	
	>	vendor select (VS) pins tell the FPGA which commands to issue.
	
	>	There are x2 and x4 modes
	
	>	See data sheet or configuration user guide for list of supported vendors.
	
	>	Excellent choice for embedded applications
	
FPGA IMage

-	Binary file that conains programming data for the FPGA.

-	Image = configuration bitstream

-	Image = programming bitstream

-	Image = bitstream 

Boundaray Scan Registers

-	Accepts input from one line of a parallel input to the JTAG

TAP Controller

-	16 state Moore FSM

-	Getting to the initial state

	>	Only requires a logic "1" on the TMS pin and 5 clock cycles.
	
	>	All 1 paths will eventually lead to initial state. 
	
-	RTI (Run Test Idle)

Patform (Download) Cables

-	A vendor suplied IP will be downloaded to the FPGA chip which facilitates the writing to the FLASH memory.

-	At powerup the flash memory writes over the FPGA.

