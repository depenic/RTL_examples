//-------------------------------------------------------------------------
// File       : syncrst_dff.v
// Design     : syncrst_dff
// Descrition : posedge clk, clock enable, reset d-flip flop
// Author     : Khanh, Dang <dnk0904[at]gmai[dot]com>
// Date       : 16 Apr 2014
// Revision   : 1.0
//-------------------------------------------------------------------------
module syncrst_dff (
  input clk,     // System clock
  input en,      // System enable
  input rst,     // System reset
  input  d,      // input
  output reg q); // output

always @(posedge clk)
  begin
    if (~rst)
      q <= 1'b0;
    else if (en)
      q <= d;
  end
endmodule
