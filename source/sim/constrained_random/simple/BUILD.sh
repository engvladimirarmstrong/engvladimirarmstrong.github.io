verilator -Wno-fatal \
          --cc \
          --trace \
          --binary -j $(nproc) \
          --top-module tbench_top \
          +incdir+$UVM_HOME \
          +define+UVM_NO_DPI \
          +incdir+$CR_SIMPLE_TB \
          $UVM_HOME/uvm_pkg.sv \
          $CR_SIMPLE_TB/sig_pkg.sv \
          $CR_SIMPLE_TB/tb.sv
