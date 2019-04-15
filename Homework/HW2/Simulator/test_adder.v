module test;

wire [2:0] SUM;
wire COUT;
reg CIN;
reg [2:0] A,B;

// instantiate adder

adder_3_RTL U1(.c_in(CIN), .c_out(COUT), .sum(SUM), .a(A), .b(B));

initial
  begin
  A=0; B=0; CIN=0;
  #5; B=2;
  #11 A=7;
  #18 B=0;
  #4  A=6;
  #20 $finish;
  end



endmodule

