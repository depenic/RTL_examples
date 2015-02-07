//-------------------------------------------------------------------------
// File       : decoder_1.v
// Design     : decoder_1
// Descrition : parameterized decoder
// Author     : Khanh, Dang <dnk0904[at]gmai[dot]com>
// Date       : 16 Apr 2014
// Revision   : 1.0
//-------------------------------------------------------------------------
module  decoder_1
#(
  parameter BIN_WIDTH = 4            // Binary width
)
(
  input [2**BIN_WIDTH-1:0]   enc_in, // Encoded input
  input                      enable, // enable signal
  output reg [BIN_WIDTH-1:0] bin_out // Binary output
);

  integer i;

always @ (enable or enc_in )
begin
  bin_out = 0;
  if (enable) begin
    for (i=0; i < 2**BIN_WIDTH; i=i+1) begin
      if (enc_in == i)
        bin_out[i] = 1'b1;
      else
        bin_out[i] = 1'b0;
    end
  end
end

endmodule
