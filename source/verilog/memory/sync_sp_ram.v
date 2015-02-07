//-------------------------------------------------------------------------
// File       : sync_sp_ram.v
// Design     : sync_sp_ram
// Descrition : Synchronous single port RAM
// Author     : Khanh, Dang <dnk0904[at]gmail[dot]com>
// Date       : 14 Apr 2014
// Revision   : 1.0
//-------------------------------------------------------------------------
module sync_sp_ram
#(
 // Parameters
  parameter ADDR_WIDTH = 8,  // address's width
  parameter DATA_WIDTH = 8   // data's width
)
(
  input clk,    // system clock
  input cen,    // chip select, low active
  input wen,    // write enable, low active

  input [ADDR_WIDTH-1:0] a,      // address
  input [DATA_WIDTH-1:0]d,      // data in
  output reg [DATA_WIDTH-1:0] q // data out
);

// Internal values
reg [DATA_WIDTH-1:0] ram [2**ADDR_WIDTH-1:0];

always @ (posedge clk)
begin: RAM
  if (cen == 1'b0) begin
    if  (wen == 1'b0)
      ram[a] <= d;
    q <= ram[a];
  end
end

endmodule
