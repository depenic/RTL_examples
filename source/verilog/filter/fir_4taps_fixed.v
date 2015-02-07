//-------------------------------------------------------------------------
// File : fir_4taps_fixed.v
// Design : fir_4taps_fixed
// Descrition : FIR 4 taps fixed coefficients.
// Author : Khanh, Dang <dnk0904[at]gmai[dot]com>
// Date : 12 Jun 2014
// Revision : 1.0
// Note: Base on book: Digital Signal Processing with Field Programmable Gate
// Arrays (c) Uwe  Meyer-Base - 2004
//-------------------------------------------------------------------------

module fir_4taps_fixed #(
  parameter D_W = 8) // Input width
(
  input             clk, // system clock
  input   [D_W-1:0] x,   // fir input
  output reg  [D_W-1:0] y);  // fir output

  //parameter COEFFS = [-1 3.75 3.75 -1]
  reg [D_W-1:0] tap [3:0];
  integer i;

  always @ (posedge clk)
  begin : FOUR_TAPS_FIRS
    y <= tap[1] << 1 + tap[1] + {tap[1][D_W-1],tap[1][D_W-1:1]} + {{2{tap[1][D_W-1]}},tap[1][D_W-1:2]}
       + tap[2] << 1 + tap[2] + {tap[2][D_W-1],tap[2][D_W-1:1]} + {{2{tap[2][D_W-1]}},tap[2][D_W-1:2]}
       - tap[3] - tap[0] ;
    for (i = 1; i < 4;i = i + 1) begin
      tap[i] <= tap[i-1];
    end
    tap[0] <= x;
  end

endmodule
