//----------------------------------------------------------------------------------------------------------------------
// Artificial Intelligence Neuron (AIN) Testbench (TB) SystemVerilog Module
//----------------------------------------------------------------------------------------------------------------------
module ain_tb;

   // Inputs are reg in testbench as we need to control their values over time
   reg clk;
   reg rst;
   reg signed [3:0] tb_x1, tb_x2, tb_w1, tb_w2;
   // Output is wire in testbench to monitor the DUT's output
   wire signed [4:0] tb_output_val;

   // Instantiate the Design Under Test (DUT)
   ain_top ain_top (.clk(clk),
                    .rst(rst),
                    .x1(tb_x1),
                    .x2(tb_x2),
                    .w1(tb_w1),
                    .w2(tb_w2),
                    .output_val(tb_output_val));

   // Clock generation block
   initial begin
      clk = 0;
      forever #5 clk = ~clk; // Clock with a period of 10 time units
   end

   // Stimulus and checking block
   initial begin
      // 1. Initialize inputs and apply reset
      rst = 1;
      tb_x1 = 4'd0;
      tb_x2 = 4'd0;
      tb_w1 = 4'd0;
      tb_w2 = 4'd0;
      #10; // Wait a bit
      rst = 0; // Release reset
      #10;

      // 2. Apply test case 1 (Positive result: sum > 0)
      // x1=2, w1=1 (prod1=2)
      // x2=3, w2=2 (prod2=6)
      // sum=8. ReLU output=8.
      tb_x1 = 4'd2;
      tb_w1 = 4'd1;
      tb_x2 = 4'd3;
      tb_w2 = 4'd2;
      #10; // Wait for the next clock edge to register the output

      // Check the output after a full clock cycle
      if (tb_output_val == 5'd8) begin
         $display("Test Case 1 Passed: Output is %d", tb_output_val);
      end else begin
         $display("Test Case 1 Failed: Expected 8, got %d", tb_output_val);
      end

      // 3. Apply test case 2 (Negative result: sum <= 0)
      // x1=1, w1=1 (prod1=1)
      // x2=3, w2=-1 (prod2=-3)
      // sum=-2. ReLU output=0.
      tb_x1 = 4'd1;
      tb_w1 = 4'd1;
      tb_x2 = 4'd3;
      tb_w2 = -4'd1; // Represents -1 in 4-bit signed
      #10;

      // Check the output
      if (tb_output_val == 5'd0) begin
         $display("Test Case 2 Passed: Output is %d", tb_output_val);
      end else begin
         $display("Test Case 2 Failed: Expected 0, got %d", tb_output_val);
      end

      // 4. End simulation
      $display("Simulation Finished");
      $finish;
   end

   // Dump waveform data for visual inspection
   initial begin
      $dumpfile("dump.vcd");
      $dumpvars(0, tb_top);
   end

endmodule
