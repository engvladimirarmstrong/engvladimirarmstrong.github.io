verilator --cc --trace -Wno-fatal --binary -j $(nproc) --top-module ain_tb +incdir+$RTL_HOME $DT_SIMPLE_TB/ain_tb.sv
