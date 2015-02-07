//-------------------------------------------------------------------------
// File : fulladder_element.v
// Design : full adder element
// Descrition : Adder (full) design.
// Author : Khanh, Dang <dnk0904[at]gmai[dot]com>
// Date : 6 Jun 2014
// Revision : 1.0
//-------------------------------------------------------------------------
module  fulladder_element #(
  parameter LEVEL = 2 // 3: behav, 2: rtl,  1: gate
)
(
  input a,
  input b,
  input cin,
  output s,
  output cout
);
  generate
    if(LEVEL > 2)
      // Behavious level
      assign {cout,s} = a + b + cin;
    else if (LEVEL == 2) begin
      // RTL level
      assign s = a ^ b ^ cin;
      assign cout = ((a ^ b) & cin) | (a & b);
    end else begin
      // wires (from ands to or)
      wire w1, w2, w3;
      // carry-out circuitry
      and( w1, a, b );
      and( w2, a, cin );
      and( w3, b, cin );
      or( cout, w1, w2, w3 );
      // sum
      xor( s, a, b, cin );// Gate level
    end
  endgenerate
endmodule

