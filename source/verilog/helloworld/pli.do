set GITHUB {../Github}
set MODELSIM_FOLDER {/data/apps/modelsim/modeltech/}
vlog  $GITHUB/TITAN/verilog/helloworld/hello_pli.v
gcc -c -g -I $MODELSIM_FOLDER/include/  $GITHUB/TITAN/verilog/helloworld/hello.c
ld -share -E -o hello.sl hello.o
vsim -pli hello.sl hello_pli; run -all;
