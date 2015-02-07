//-------------------------------------------------------------------------
// File : fulladder_tb.v
// Design : full adder w parameter's tb
// Descrition : Adder (full) testbench.
// Author : Khanh, Dang <dnk0904[at]gmai[dot]com>
// Date : 6 Jun 2014
// Revision : 1.0
//-------------------------------------------------------------------------
module fulladder_tb;
// parameter
  parameter LEVEL = 2;
  parameter WIDTH = 8;
  integer i = 0;
// signal
  reg  [WIDTH-1:0] a;
  reg  [WIDTH-1:0] b;
  reg              cin;
  wire [WIDTH-1:0] s;
  wire             cout;
// mapping module
  fulladder_para
  #(.LEVEL  (LEVEL),
    .WIDTH  (WIDTH))
  FADDER
  (.a     (a),
  .b      (b),
  .cin    (cin),
  .s      (s),
  .cout   (cout));

// init>
  initial begin
    a = 0;
    b = 0;
    cin = 0;
  end
  initial
    $monitor( "a(%b) + b(%b) + carry_in(%b) = carry_out(%b) sum(%b)", a, b, cin, cout, s );
  always @ ( a, b, cin ) begin
     // generate truth table
     for ( i = 0; i < 2**16; i = i + 101 )
             // every 10 ns set a, b, and cin to the binary rep. of i
             #1 {a, b, cin} = i;
     // stop 10ns after last change of inputs
     //#1 $stop;
  end


endmodule
