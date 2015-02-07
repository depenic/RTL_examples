//-------------------------------------------------------------------------
// File : normal_multiplier_tb.v
// Design : normal_multiplier_tb
// Descrition : multiplier testbench
// Author : Khanh, Dang <dnk0904[at]gmai[dot]com>
// Date : 11 Jun 2014
// Revision : 1.0
//-------------------------------------------------------------------------
module normal_multiplier_tb;

parameter WIDTH_A = 8;
parameter WIDTH_B = 8;
parameter TYPE = 0;

reg clk;
reg rst_n;
reg en;

reg [WIDTH_A-1:0] a;
reg [WIDTH_B-1:0] b;

wire [WIDTH_A+WIDTH_B-1:0] m;

integer i;

// mapping
//
   normal_multiplier #(
     .WIDTH_A (WIDTH_A),
     .WIDTH_B (WIDTH_B),
     .TYPE   (TYPE))
    U0 (
      .clk    (clk),
      .rst_n  (rst_n),
      .en     (en),
      .a      (a),
      .b      (b),
      .m      (m));

  initial begin
    a = 0;
    b = 0;
    clk = 0;
    rst_n = 0;
    en = 0;
  end
  initial
    $monitor( "a(%d) * b(%d) = m(%d) | true_val(%d) | verified(%s)", a, b, m, {b*0,a}*b, (m == {b*0,a}*b)? "right":"wrong" );
  always @ ( a, b ) begin
     // generate truth table
     for ( i = 0; i < 2**16; i = i + 'b1000000001 )
             // every 10 ns set a, b, and cin to the binary rep. of i
             #1 {a, b} = i;
     // stop 10ns after last change of inputs
     //#1 $stop;
  end

endmodule
