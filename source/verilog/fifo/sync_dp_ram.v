//-------------------------------------------------------------------------
// File       : sync_dp_ram.v
// Design     : sync_dp_ram
// Descrition : Synchronous dual port RAM
// Author     : Khanh, Dang <dnk0904[at]gmail[dot]com>
// Date       : 26 Apr 2014
// Revision   : 1.0
//-------------------------------------------------------------------------

module sync_dp_ram
#(
  parameter ADDR_WIDTH = 8, // address's width
  parameter DATA_WIDTH = 8  // data's width
)
(
  input clk,    // systems's clock

  input                       cen_0, // chip select, port 0, low active
  input                       wen_0, // write enable, port 0, low active
  input      [ADDR_WIDTH-1:0] a_0,   // address, port 0
  input      [DATA_WIDTH-1:0] d_0,   // data in, port 0
  output reg [DATA_WIDTH-1:0] q_0,   // data out, port 0

  input                       cen_1, // chip select, port 1, low active
  input                       wen_1, // write enable, port 1, low active
  input      [ADDR_WIDTH-1:0] a_1,   // address, port 1
  input      [DATA_WIDTH-1:0] d_1,   // data in, port 1
  output reg [DATA_WIDTH-1:0] q_1   // data out, port 1
);

  parameter RAM_DEPTH = 1 << ADDR_WIDTH;
  //reg [DATA_WIDTH-1:0] q_0_reg, q_1_reg;
  reg [DATA_WIDTH-1:0] ram [RAM_DEPTH-1:0];

  always @ (posedge clk)
  begin: WRITE_IN
    if (cen_0 == 0 && wen_0 == 0) begin
      ram[a_0] <= d_0;
    end else if (cen_1 == 0 && wen_1 == 0) begin
      ram[a_1] <= d_1;
    end
  end

  always @ (posedge clk)
  begin: READ_0
    if (cen_0 == 0 && wen_0 == 1)
      q_0 <= ram[a_0];
    else
      q_0 <= 'b0;
  end


  always @ (posedge clk)
  begin: READ_1
    if (cen_1 == 0 && wen_1 == 1)
      q_1 <= ram[a_1];
    else
      q_1 <= 'b0;
  end
endmodule
