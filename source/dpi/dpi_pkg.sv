package dpi_pkg;
   // Import the C function into SystemVerilog
   import "DPI-C" function int c_adder(int a, int b);
endpackage
