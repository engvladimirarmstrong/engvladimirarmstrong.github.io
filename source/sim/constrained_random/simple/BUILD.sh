verilator --cc --trace -Wno-fatal --binary -j $(nproc) --top-module ain_tb +incdir+$UVM_HOME+$RTL_HOME+$CR_SIMPLE_TB +define+UVM_NO_DPI +incdir+$(pwd) $UVM_HOME/uvm_pkg.sv $CR_SIMPLE_TB/ain_tb.sv
