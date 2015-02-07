//-------------------------------------------------------------------------
// File       : hello_pli.v
// Design     : hello_pli
// Descrition : Print "Hello World" in console, using PLI.
// Author     : Khanh, Dang <dnk0904[at]gmail[dot]com>
// Date       : 19 Apr 2014
// Revision   : 1.0
//-------------------------------------------------------------------------

module hello_pli ();
initial begin
  $hello;
  #10 $finish;
end
endmodule
