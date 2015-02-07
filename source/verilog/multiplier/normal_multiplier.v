//-------------------------------------------------------------------------
// File : normal_multiplier.v
// Design : normal_multiplier
// Descrition : multiplier.
// Author : Khanh, Dang <dnk0904[at]gmai[dot]com>
// Date : 11 Jun 2014
// Revision : 1.0
//-------------------------------------------------------------------------
module normal_multiplier #(
  parameter WIDTH_A = 8,
  parameter WIDTH_B = 8,
  parameter TYPE = 0
)
(
  input             clk,    // system synchronous clock
  input             rst_n,  // system asynchrous negative reset
  input             en,     // system synchronous enable
  input [WIDTH_A-1:0] a,      // input a
  input [WIDTH_B-1:0] b,      // input b
  output [WIDTH_A+WIDTH_B-1:0] m);  // output of multiplier

/*
  * As a normal multiplier, I did it with as normal as possible method.
  * Specifically, element a multiply with element b can be expressed as shift
  * & adder. As defination: a = [a(N-1) : a(0)] and b =  [b(M-1):b(0)]. So the
  * result m = [m(M+N-1):m(0)]. Since the normal of multiplier with be sum of
  * multiply of element a with each bit of b. Hence, we have:
  * m = sum{ a*b(M-1) : a*b(0)}. Furthermore, because of binary logic
  * operator, a*b(X) will be shift function.
  *
  * As a note, I did not insert any register inside this multiplier. Therefore
  * the latency will be unacceptable. Depend on technology and goal frequency,
  * you should insert it mannually. To suitable for inserting register,
  * I separated each step of shifting and adding.
*/

  wire [WIDTH_A+WIDTH_B-1:0] post_shifting [WIDTH_B-1:0];
  // Register must be inserted between two signals
  wire [WIDTH_A+WIDTH_B-1:0] pre_adding [WIDTH_B-1:0];

  wire [WIDTH_A+WIDTH_B-1:0] post_adding [WIDTH_B-1:0];
  wire [WIDTH_A+WIDTH_B-1:0] a_extend;
  // Shifting function;
  assign a_extend = a;
  genvar i;
  generate
    for (i = 0; i < WIDTH_B; i = i + 1) begin: SHIFTING
      //assign pre_adding[i] = (b[i] == 1) ? {a << i}:0;
      //
      assign post_shifting[i] = (b[i] == 1) ? {a_extend << i}:0;
    end
  endgenerate
  // Instead of these lines, the registers should be inserted.
  generate
    for (i = 0; i < WIDTH_B; i = i + 1) begin: REGISTERING_OR_NOT
      assign pre_adding[i] = post_shifting[i];
    end
  endgenerate
  // Instead of serial adders, the binary case should be implemented.
  assign post_adding[0] = pre_adding[0];
  generate
  for (i = 1; i < WIDTH_B; i = i + 1) begin: ADDING
    assign post_adding[i] =  post_adding[i-1] + pre_adding[i];
  end
  endgenerate
  // output assignment
  assign m = post_adding[WIDTH_B-1];




endmodule
