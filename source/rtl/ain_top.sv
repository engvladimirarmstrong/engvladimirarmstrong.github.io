//----------------------------------------------------------------------------------------------------------------------
// Artificial Intelligence Neuron (AIN) RTL Design SystemVerilog Module
//----------------------------------------------------------------------------------------------------------------------

// This module describes a Neuron (AIN) Design with 2 inputs and 4-bit fixed-point representation
// (e.g., 2 bits for the integer part, 2 bits for the fractional part).
module ain_top (input wire clk,
                input wire rst,
                input wire signed [3:0] x1,
                input wire signed [3:0] x2,
                input wire signed [3:0] w1,
                input wire signed [3:0] w2,
                output reg signed [4:0] output_val); // Output size is larger to accommodate summation result

   // Internal wires for intermediate calculations
   wire signed [7:0] prod1, prod2;
   wire signed [8:0] sum;
   wire signed [4:0] activated_sum;

   // Multiplication (can use dedicated DSP slices on an FPGA)
   assign prod1 = x1 * w1;
   assign prod2 = x2 * w2;

   // Summation
   assign sum = prod1 + prod2;

   // Activation Function (Simple ReLU: if sum > 0, output = sum; else output = 0)
   // We adjust sum back to a 5-bit width for a simple ReLU output.
   assign activated_sum = (sum > 0) ? sum[4:0] : 5'b00000;

   // Sequential logic to register the output on the clock edge
   always @(posedge clk or posedge rst) begin
      if (rst) begin
         output_val <= 5'b00000;
      end else begin
         output_val <= activated_sum;
      end
   end
