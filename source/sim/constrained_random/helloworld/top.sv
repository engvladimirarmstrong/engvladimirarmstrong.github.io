`include "uvm_macros.svh"
import uvm_pkg::*;

module top;
   initial begin
      `uvm_info("TEST", "Hello World from UVM and Verilator!", UVM_LOW)
      #10;
      $display("Simulation finished.");
      $finish;
   end
endmodule
