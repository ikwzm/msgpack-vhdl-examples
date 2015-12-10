module Add(a,b,clk,ce,s);
   input  signed[31:0] a;
   input  signed[31:0] b;
   input               clk;
   input               ce;
   output signed[31:0] s;
   reg    signed[31:0] s;
   
   always @(posedge clk)
     if (ce)
       s <= a + b;
endmodule

module multiplier(a,b,clk,ce,p);
   input  signed[31:0] a;
   input  signed[31:0] b;
   input               clk;
   input               ce;
   output signed[31:0] p;
   reg    signed[31:0] p;
   
   always @(posedge clk)
     if (ce)
       p <= a * b;
endmodule

module Divider(dividend,divisor,clk,quotient,fractional,rfd);
   input  signed[31:0] dividend;
   input  signed[31:0] divisor;
   input               clk;
   output signed[31:0] quotient;
   output signed[31:0] fractional;
   output signed[31:0] rfd;
endmodule
