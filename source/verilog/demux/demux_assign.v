//-------------------------------------------------------------------------
// File       : demux_assign.v
// Design     : demux_assign
// Descrition : demultiplexer -  use always.
// Author     : Khanh, Dang <dnk0904[at]gmai[dot]com>
// Date       : 22 Apr 2014
// Revision   : 1.0
//-------------------------------------------------------------------------

module demux_assign #(
  parameter DAT_WIDTH = 8,
  parameter SEL_WIDTH = 4
)
(
  input  [DAT_WIDTH-1:0]demux_in ,
  input  [SEL_WIDTH-1:0] sel_in,
  output [(2**SEL_WIDTH)*DAT_WIDTH-1:0] demux_out
);

  genvar i,sel;
  generate 
  for (sel = 0; sel < 2**SEL_WIDTH; sel = sel + 1) begin : GEN_DEMUX
     for ( i = 0; i < DAT_WIDTH; i = i + 1) begin: gen_assg
       assign demux_out[sel*DAT_WIDTH + i] = (sel == sel_in)? demux_in[i] : 0 ;
	  end
	end
  endgenerate

endmodule
