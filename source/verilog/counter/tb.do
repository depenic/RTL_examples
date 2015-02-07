set GITHUB {../Github}
vlog  ${GITHUB}/TITAN/verilog/counter/counter.v
vlog  ${GITHUB}/TITAN/verilog/counter/counter_tb.v
vsim -novopt counter_tb; run -all;
