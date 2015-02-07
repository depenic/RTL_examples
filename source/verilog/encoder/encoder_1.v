//-------------------------------------------------------------------------
// File       : encoder_1.v
// Design     : encoder_1
// Descrition : parameterized encoder
// Author     : Khanh, Dang <dnk0904[at]gmai[dot]com>
// Date       : 16 Apr 2014
// Revision   : 1.0
//-------------------------------------------------------------------------
module  encoder_1
#(
  parameter BIN_WIDTH = 4            // Binary width
)
(
  input [BIN_WIDTH-1:0]         bin_in, // Binary input
  input                         enable, // enable signal
  output reg [2**BIN_WIDTH-1:0] enc_out // Encoded output
);

  integer i;

always @ (enable or bin_in )
begin
  enc_out = 0;
  if (enable) begin
    for (i=0; i < BIN_WIDTH; i=i+1) begin
      if (bin_in == 2**i)
        enc_out <= i;
    end
  end
end

endmodule
