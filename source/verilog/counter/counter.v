//-------------------------------------------------------------------------
// File : counter.v
// Design : counter
// Descrition : Counter up by clock as trigger.
// Author : Khanh, Dang <dnk0904[at]gmai[dot]com>
// Date : 11 Apr 2014
// Revision : 1.0
//
//-------------------------------------------------------------------------

module counter (
  clk,
  rst,
  en,
  cntr_o
);
// Parameters:
parameter COUNTER_WIDTH = 8;
// Note: Inputs
input clk;
input rst;
input en;
// Outputs
output cntr_o;
// Variables
wire clk, rst, en;
reg [COUNTER_WIDTH-1:0] cntr_o;
// Counter block
always @ (posedge clk)
begin : COUNTER
  if (rst == 1'b1) begin
    cntr_o <= 0;
  end
  else if (en == 1'b1) begin
    cntr_o <= cntr_o + 1;
  end
end
endmodule
