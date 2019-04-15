// this file describes a 3-bit adder
// the adder description is behavioral

module adder_3_RTL(a, b, c_in, sum, c_out);
	output [2:0] sum;
	output c_out;
	input  [2:0] a, b;
	input  c_in;

assign {c_out, sum} = a+b+c_in;
endmodule


