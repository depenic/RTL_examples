//-------------------------------------------------------------------------
// File       : demux.v
// Design     : demux
// Descrition : demultiplexer -  use always.
// Author     : Khanh, Dang <dnk0904[at]gmai[dot]com
// Date       : 22 Apr 2014
// Revision   : 1.0
//-------------------------------------------------------------------------

module demux #(
  parameter DAT_WIDTH = 8,
  parameter SEL_WIDTH = 4
)
(
  input       [DAT_WIDTH-1:0]demux_in ,
  input       [SEL_WIDTH-1:0] sel_in,
  output reg  [(2**SEL_WIDTH)*DAT_WIDTH-1:0] demux_out
);

  integer i,j;

  always @ (demux_in or sel_in)
  begin
    demux_out = 'b0;
    for (i = 0; i < 2**SEL_WIDTH; i = i + 1) begin
      if( i == sel_in)
        for ( j = 0; j < DAT_WIDTH; j = j + 1)
          demux_out[i*DAT_WIDTH+j] = demux_in[j];
    end
  end

endmodule
