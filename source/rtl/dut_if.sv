// This is the SystemVerilog interface that we will use to connect our design to our UVM testbench.
interface dut_if;
   logic clock, reset;
   logic cmd;
   logic [7:0] addr;
   logic [7:0] data;
endinterface
