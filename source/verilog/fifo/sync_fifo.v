//-------------------------------------------------------------------------
// File       : sync_fifo.v
// Design     : sync_fifo
// Descrition : Synchronous FIFO
// Author     : Khanh, Dang <dnk0904[at]gmail[dot]com>
// Date       : 28 Apr 2014
// Revision   : 1.0
//-------------------------------------------------------------------------

module sync_fifo
#(
  parameter DATA_WIDTH = 8, // data's width
  parameter ADDR_WIDTH = 4,// depth of fifo
  parameter OUTPUT_REG = 1  // output register
)
(
  input   clk,                       // systems's clock
  input   rst_n,                     // systems's reset, low active
  input   clear,                     // clear signal for FIFO
  input   push,                      // push
  input   pop,                       // pop
  input   [DATA_WIDTH-1:0] data_in,  // input data
  output  [DATA_WIDTH-1:0] data_out, // output data
  output  empty,                     // empty signal
  output  full                       // full signal
);
  // Declares parameters
  //parameter ADDR_WIDTH = $clog2(FIFO_DEPTH); // Error: no clog2
  parameter FIFO_DEPTH = 2**ADDR_WIDTH;
  // Declares wires and registers
  reg [ADDR_WIDTH-1:0] wr_pointer;
  reg [ADDR_WIDTH-1:0] rd_pointer;
  reg [ADDR_WIDTH:0]   status_cnt;
  reg [DATA_WIDTH-1:0] data_push_in;
  reg [DATA_WIDTH-1:0] data_pop_out;

  reg [DATA_WIDTH-1:0] ram [FIFO_DEPTH-1:0];

  // assign signals
  assign full = (status_cnt == FIFO_DEPTH-1)? 1:0;
  assign empty = (status_cnt == 0)? 1:0;
  //

  // write pointer
  always @ (posedge clk or negedge rst_n)
  begin : WRITE_POINTER
    if (! rst_n)
      wr_pointer <= 'b0;
    else begin
      if (clear)
        wr_pointer <= 'b0;
      else if (push)
        wr_pointer <= wr_pointer + 1;
    end
  end

  // read pointer
  always @ (posedge clk or negedge rst_n)
  begin : READ_POINTER
    if (!rst_n)
      rd_pointer <= 'b0;
    else begin
      if (clear)
        rd_pointer <= 'b0;
      else if (pop)
        rd_pointer <= rd_pointer  + 1;
    end
  end

  // status counter
  always @ (posedge clk or negedge rst_n)
  begin: STATUS_COUNTER
    if (!rst_n)
      status_cnt <= 0;
    else begin
      if (clear)
        status_cnt <= 0;
      else if (push)
        status_cnt <=  status_cnt +1;
      else if (pop)
        status_cnt <= status_cnt -1;
    end
  end

  // data storage
  integer i;
  always @ (posedge clk or negedge rst_n)

  begin: DATA_STORAGE
    if (!rst_n) begin
      for (i = 0; i < FIFO_DEPTH; i = i +1) ram[i] <= 0;
    end else begin
      if (clear) begin
        for (i = 0; i < FIFO_DEPTH; i = i +1) ram[i] <= 0;
      end else if (push)
        ram[wr_pointer] <= data_in;
    end
  end
  // read out non regs
  assign data_out = ram[rd_pointer];

endmodule
