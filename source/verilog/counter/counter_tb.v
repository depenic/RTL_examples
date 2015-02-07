//-------------------------------------------------------------------------
// File       : counter_tb.v
// Design     : counter_tb
// Descrition : testbench for counter. modified it from asic-world.com, add
// trace  vcd
// Author     : Khanh, Dang <dnk0904[at]gmail[dot]com>
// Date       : 25 Apr 2014
// Revision   : 1.0
//-------------------------------------------------------------------------

module counter_tb ();
  // Declare the parameters and signals
  parameter COUNTER_WIDTH = 8;
  reg  clk, rst, en;
  wire [COUNTER_WIDTH-1:0] cntr_o;

  // Mapping module inside testbench
  counter #(
    .COUNTER_WIDTH (COUNTER_WIDTH)
  )
  DUT0 (
    .clk    (clk),
    .rst    (rst),
    .en     (en),
    .cntr_o (cntr_o)
  );

  initial begin
    clk = 0;
    rst = 1;
    en  = 0;
    #10;
    rst = 0;
    en  = 1;
  end
  // generate clock signal
  always
    #5 clk = !clk;
  // Set dump File
  initial begin
    $dumpfile("counter.vcd"); // Set dumpfile
    $dumpvars(0, DUT0);       // Start to dump, level 0, dump all
    $dumpon;
    // Note: The intruction of dump is followed in ./docs
  end
  // Monitoring
  initial begin
     $display("\t\t\ttime,\tclk,\trst,\ten,\tcntr_o");
     // $display =  display to terminal; \t = tab, next is signal
     $monitor("\t%d,\t%b,\t%b,\t%b,\t%d",$time, clk,rst,en,cntr_o);
     // $monitor: keep tracking with signal radiation %d = decimal, %b =  binary
  end

  // Set run time
  initial begin
    #1000 $finish;
  end

endmodule
