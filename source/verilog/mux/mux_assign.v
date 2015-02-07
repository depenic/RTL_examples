//-------------------------------------------------------------------------
// File       : mux_assign.v
// Design     : mux_assign
// Descrition : multiplexer -  use assign.
// Author     : Khanh, Dang <dnk0904[at]gmai[dot]com>
// Date       : 21 Apr 2014
// Revision   : 1.0
//-------------------------------------------------------------------------

module mux_assign #(
  parameter DAT_WIDTH = 8,
  parameter SEL_WIDTH = 4
) (
  input   [(2**SEL_WIDTH)*DAT_WIDTH-1:0] mux_in ,
  input   [SEL_WIDTH-1:0] sel_in,
  output  [DAT_WIDTH-1:0] mux_out
);
  genvar i;
  generate
  for ( i = 0; i < DAT_WIDTH; i = i + 1)
    assign mux_out[i] = mux_in[sel_in*DAT_WIDTH + i];
  endgenerate

endmodule
