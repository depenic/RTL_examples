//-------------------------------------------------------------------------
// File       : posedgeclk_clockenable_noreset_dff.v
// Design     : posedgeclk_clockenable_noreset_dff
// Descrition : posedge clk, clock enable, no reset d-flip flop
// Author     : Khanh, Dang <dnk0904[at]gmai[dot]com>
// Date       : 14 Apr 2014
// Revision   : 1.0
//-------------------------------------------------------------------------
module posedgeclk_clockenable_noreset_dff (
  input clk,      // System clock
  input en,       // System enable
  input  d,       // input
  output reg q);  // output

always @(posedge clk)
  begin
    if (en)
     q <= d;
  end
endmodule
