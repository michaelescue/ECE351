
module Decade(CLK, RST, Q);
input CLK, RST;
output [3:0] Q;

reg [3:0] Q;

always @(posedge CLK or posedge RST)
   if(RST == 1'b1)
      Q = 4'd0;
   else
      if(Q == 4'd9)  // if output =9, reset
         Q = 4'd0;
      else
         Q = Q + 1'd1;
endmodule
