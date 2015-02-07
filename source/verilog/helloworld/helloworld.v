//-------------------------------------------------------------------------
// File       : helloworld.v
// Design     : helloworld
// Descrition : Print "Hello World" in console, not synthesizable module.
// Author     : Khanh, Dang <dnk0904[at]gmail[dot]com>
// Date       : 11 Apr 2014
// Revision   : 1.0
//-------------------------------------------------------------------------

module helloworld;

initial begin
	$display ("Hello World");
	#10 $finish;
end

endmodule
