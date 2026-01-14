*************************************************************************************************************************
Vladimir\'s Presentation
*************************************************************************************************************************

.. sidebar:: References

    - `Read the Docs Sphinx Theme <https://sphinx-rtd-theme.readthedocs.io>`__
    - `Sphinx-Needs <https://www.sphinx-needs.com>`__
    - `UVM Verilator <https://antmicro.com/blog/2025/10/support-for-upstream-uvm-2017-in-verilator>`__

:Last updated: |today|
:Version: |version|
:Release: |release|

.. contents:: Table of Contents

AI Neuron (AIN) Design Under Test (DUT)
=========================================================================================================================

The AI Neuron (AIN) SystemVerilog RTL module is Design Under Test (DUT).
The AIN is the building block of Artificial Intelligence (AI) neural networks.

.. grid:: 1

    .. grid-item-card:: Biological vs. Artificial Neuron

       .. figure:: _static/img/biologicalvsartificialneuron.webp

AIN Model
-------------------------------------------------------------------------------------------------------------------------

.. grid:: 1

    .. grid-item-card:: AIN Mathematical Model

       .. math::

          y = f\left( \sum_{i=1}^{n} w_i x_i + b \right)

The Artificial Neuron Mathematical Model output :math:`y` is calculated using the following steps:

- **Step #1. Weighted Sum**: Calculate the sum of inputs multiplied by weights.
- **Step #2. Bias**: Add a bias term to the sum.
- **Step #3. Activation**: Apply a non-linear activation function:

  - **Sigmoid**: Outputs a value between 0 and 1.
  - **ReLU**: Rectified Linear Unit, outputs the input if positive, else zero.

.. grid:: 1

    .. grid-item-card:: AIN Model Diagram

       .. uml:: _static/puml/neuron.puml

.. grid:: 1

    .. grid-item-card:: AIN RTL Source Code

       .. literalinclude:: rtl/ain_top.sv
           :language: SystemVerilog
           :linenos:
           :emphasize-lines: 7-13

Verification
=========================================================================================================================

Directed Tests
-------------------------------------------------------------------------------------------------------------------------

.. grid:: 1

    .. grid-item-card:: Hello World Testbench Source Code

       .. literalinclude:: tb/directed_tests/helloworld/ain_tb.sv
           :language: SystemVerilog
           :linenos:
           :emphasize-lines: 14-20

    .. grid-item-card:: Hello World Simulation Waveforms

       .. figure:: sim/directed_tests/helloworld/dump.png

    .. grid-item-card:: Simulation Log

       .. code-block:: Text
          :linenos:

          Test Case 1 Passed: Output is   8
          Test Case 2 Passed: Output is   0
          Simulation Finished
          /tb/directed_tests/helloworld/ain_tb.sv:76: Verilog $finish
          - S i m u l a t i o n   R e p o r t: Verilator 5.042 2025-11-02
          - Verilator: $finish at 45ps; walltime 0.001 s; speed 26.443 ns/s
          - Verilator: cpu 0.002 s on 1 threads; alloced 95 MB

Universal Verification Methodology (UVM)
-------------------------------------------------------------------------------------------------------------------------

The Universal Verification Methodology (UVM) is a standardized methodology for
verifying integrated circuit designs. It is based on the IEEE 1800.2 standard
and provides a modular, object-oriented framework.

Key Benefits
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* **Reusability**: Standardized components can be reused across different
  projects and levels of design.
* **Automation**: Features like factory overrides and built-in phases automate
  testbench construction.
* **Interoperability**: Supported by all major EDA vendors.

Core Components
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

A typical UVM testbench consists of the following components:

UVM Driver
    Converts transaction-level stimulus into pin-level activity for the
    Design Under Test (DUT).

UVM Monitor
    Samples pin-level activity and converts it back into transactions for
    analysis.

UVM Sequencer
    Manages the flow of transactions (sequence items) from sequences to
    the driver.

UVM Agent
    A container that groups the sequencer, driver, and monitor for a
    specific interface.

UVM Scoreboard
    Checks the correctness of the DUT by comparing actual output against
    expected results.

Simulation Phases
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

UVM components use standard execution phases to ensure consistent behavior across the testbench:

1. **build_phase**: Instantiate and configure components.
2. **connect_phase**: Establish communication links between components.
3. **run_phase**: Execute the main simulation stimulus (time-consuming).
4. **report_phase**: Summarize and display simulation results.

UVM Testbench Hierarchy
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This diagram illustrates the standard containment of UVM components, from the top-level test down to the driver and monitor.

.. grid:: 1

    .. grid-item-card:: UVM Component Diagram

       .. uml:: _static/puml/uvm_tb.puml

UVM Transaction Flow
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This example shows the typical "handshake" between a sequence and a driver, which is fundamental for UVM testbench operation.

.. grid:: 1

    .. grid-item-card:: UVM Sequence Diagram

       .. uml:: _static/puml/uvm_seq.puml

UVM Hello World Example
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. grid:: 1

    .. grid-item-card:: Testbench Source Code

       .. literalinclude:: /tb/constrained_random/helloworld/ain_tb.sv
           :language: SystemVerilog
           :linenos:

    .. grid-item-card:: Package Source Code

       .. literalinclude:: /tb/constrained_random/helloworld/my_testbench_pkg.svh
           :language: SystemVerilog
           :linenos:

    .. grid-item-card:: Sequence Source Code

       .. literalinclude:: /tb/constrained_random/helloworld/my_sequence.svh
           :language: SystemVerilog
           :linenos:

    .. grid-item-card:: Driver Source Code

       .. literalinclude:: /tb/constrained_random/helloworld/my_driver.svh
           :language: SystemVerilog
           :linenos:

    .. grid-item-card:: DUT Source Code

       .. literalinclude:: /rtl/dut.sv
           :language: SystemVerilog
           :linenos:

    .. grid-item-card:: Interface Source Code

       .. literalinclude:: /rtl/dut_if.sv
           :language: SystemVerilog
           :linenos:

    .. grid-item-card:: Simulation Log

       .. code-block:: Text
          :linenos:

          UVM_INFO /rtl/dut.sv(12) @ 15: reporter [DUT] Received cmd=0, addr=0x1d, data=0x7e
          UVM_INFO /rtl/dut.sv(12) @ 25: reporter [DUT] Received cmd=0, addr=0x57, data=0x3e
          UVM_INFO /rtl/dut.sv(12) @ 35: reporter [DUT] Received cmd=0, addr=0xb1, data=0xf9
          UVM_INFO /rtl/dut.sv(12) @ 45: reporter [DUT] Received cmd=1, addr=0xf7, data=0xba
          UVM_INFO /rtl/dut.sv(12) @ 55: reporter [DUT] Received cmd=0, addr=0x9d, data=0x5b
          UVM_INFO /rtl/dut.sv(12) @ 65: reporter [DUT] Received cmd=0, addr=0x8f, data=0xda
          UVM_INFO /rtl/dut.sv(12) @ 75: reporter [DUT] Received cmd=0, addr=0x7f, data=0x7c
          UVM_INFO /rtl/dut.sv(12) @ 85: reporter [DUT] Received cmd=0, addr=0x4f, data=0x1e
          --- UVM Report Summary ---

          ** Report counts by severity
          UVM_INFO :   12
          UVM_WARNING :   21
          UVM_ERROR :    0
          UVM_FATAL :    0
          ** Report counts by id
          []     1
          [DUT]     8
          [NO_DPI_TSTNAME]     1
          [RNTST]     1
          [UVM/COMP/NAME]    20
          [UVM/COMP/NAMECHECK]     1
          [UVM/RELNOTES]     1

          - /opt/Accellera/1800.2-2017-1.0/src/base/uvm_root.svh:585: Verilog $finish
          - S i m u l a t i o n   R e p o r t: Verilator 5.042 2025-11-02
          - Verilator: $finish at 90ps; walltime 0.071 s; speed 7.621 ns/s
          - Verilator: cpu 0.012 s on 1 threads; alloced 108 MB
