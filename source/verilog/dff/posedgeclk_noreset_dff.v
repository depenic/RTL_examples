//-------------------------------------------------------------------------
// File       : posedgeclk_noreset_dff.v
// Design     : posedgeclk_noreset_dff
// Descrition : posedge clk, no reset d-flip flop
// Author     : Khanh, Dang <dnk0904[at]gmai[dot]com>
// Date       : 14 Apr 2014
// Revision   : 1.0
//-------------------------------------------------------------------------
module posedgeclk_noreset_dff (
  input clk,
  input  d,
  output reg q);

always @(posedge clk)
  begin
     q <= d;
  end
endmodule
