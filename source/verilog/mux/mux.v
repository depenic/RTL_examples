//-------------------------------------------------------------------------
// File       : mux.v
// Design     : mux
// Descrition : multiplexer -  use always.
// Author     : Khanh, Dang <dnk0904[at]gmai[dot]com
// Date       : 21 Apr 2014
// Revision   : 1.0
//-------------------------------------------------------------------------

module mux #(
  parameter DAT_WIDTH = 8,
  parameter SEL_WIDTH = 4
)
(
  input       [(2**SEL_WIDTH)*DAT_WIDTH-1:0] mux_in ,
  input       [SEL_WIDTH-1:0] sel_in,
  output reg  [DAT_WIDTH-1:0] mux_out
);

  integer i,j;

  always @ (mux_in or sel_in)
  begin
    for (i = 0; i < 2**SEL_WIDTH; i = i + 1) begin
      if( i == sel_in)
        for ( j = 0; j < DAT_WIDTH; j = j + 1)
          mux_out[j] = mux_in[i*DAT_WIDTH+j];
      else
        mux_out = 'b0;
    end
  end

endmodule
