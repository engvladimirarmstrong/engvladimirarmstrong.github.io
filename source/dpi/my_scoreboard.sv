class my_scoreboard extends uvm_scoreboard;
   `uvm_component_utils(my_scoreboard)

   import dpi_pkg::*; // Import the package containing the C call

   function void check_phase(uvm_phase phase);
      int expected_val;
      int a = 5, b = 10;

      // Call the C model directly
      expected_val = c_adder(a, b);

      `uvm_info("SCBD", $sformatf("C Model Result: %0d", expected_val), UVM_LOW)
   endfunction
endclass
