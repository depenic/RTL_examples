//-------------------------------------------------------------------------
// File : fulladder_para.v
// Design : full adder w parameter
// Descrition : Adder (full) design.
// Author : Khanh, Dang <dnk0904[at]gmai[dot]com>
// Date : 6 Jun 2014
// Revision : 1.0
//-------------------------------------------------------------------------
module fulladder_para #(
  parameter LEVEL = 2,
  parameter WIDTH = 8
)
(
  input  [WIDTH-1:0] a,
  input  [WIDTH-1:0] b,
  input              cin,
  output [WIDTH-1:0] s,
  output             cout
);

  // Wires for generate
  wire [WIDTH-1:0] cix,cox;
  // assign Wires
  assign cix[0] = cin;
  assign cix[WIDTH-1:1]  = cox[WIDTH-2:0];
  assign cout = cox[WIDTH-1];
  genvar i;
  generate
    for (i = 0; i < WIDTH; i = i + 1) begin: GEN_ADDER
       fulladder_element
       #(.LEVEL (LEVEL))
       ELEMENT0
        (.a     (a[i]),
        .b      (b[i]),
        .cin    (cix[i]),
        .s      (s[i]),
        .cout   (cox[i]));

    end
  endgenerate
endmodule
