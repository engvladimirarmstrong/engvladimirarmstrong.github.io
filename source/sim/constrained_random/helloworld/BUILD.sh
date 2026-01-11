verilator -Wno-fatal \
          --binary -j 0 \
          -I$UVM_HOME \
          $UVM_HOME/uvm.sv \
          top.sv \
          +define+UVM_NO_DPI \
          --top-module top
