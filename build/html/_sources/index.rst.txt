*************************************************************************************************************************
Vladimir\'s UVM DPI-C Presentation
*************************************************************************************************************************

.. sidebar:: References

    - `Read the Docs Sphinx Theme <https://sphinx-rtd-theme.readthedocs.io>`__
    - `Sphinx-Needs <https://www.sphinx-needs.com>`__
    - `UVM Verilator <https://antmicro.com/blog/2025/10/support-for-upstream-uvm-2017-in-verilator>`__

:Last updated: |today|
:Version: |version|
:Release: |release|
:UVM: Universal Verification Methodology (constrained-random verification)
:DPI: Direct Programming Interface (C reference model)
:AIN: Artificial Intelligence Neuron (DUT)

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

    .. grid-item-card:: Directed Tests Testbench Source Code

       .. literalinclude:: tb/directed_tests/helloworld/ain_tb.sv
           :language: SystemVerilog
           :linenos:
           :emphasize-lines: 14-20

    .. grid-item-card:: Directed Tests Simulation Waveforms

       .. figure:: sim/directed_tests/helloworld/dump.png

    .. grid-item-card:: Directed Tests Simulation Log

       .. code-block:: Text
          :linenos:

          Test Case 1 Passed: Output is   8
          Test Case 2 Passed: Output is   0
          Simulation Finished
          /tb/directed_tests/helloworld/ain_tb.sv:76: Verilog $finish
          - S i m u l a t i o n   R e p o r t: Verilator 5.042 2025-11-02
          - Verilator: $finish at 45ps; walltime 0.001 s; speed 26.443 ns/s
          - Verilator: cpu 0.002 s on 1 threads; alloced 95 MB

UVM Overview
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
* **Constrained-random verification (CRV)**: Reduced, automated test creation, enhanced bug detection in unexpected scenarios, superior scalability, and better, actionable coverage metrics to ensure high-quality, comprehensive validation.

  - **Higher Bug Detection Rate**: Because constrained-random testing generates unexpected input combinations, it exposes deep design flaws and corner cases that manual, directed tests often miss.
  - **Reduced Test Development Time**: Instead of writing hundreds of manual tests, engineers write a smaller set of constrained-random scenarios that can generate millions of varied, meaningful stimulus scenarios automatically.
  - **Improved Coverage Efficiency**: UVM allows for the automation of functional coverage collection, ensuring that all defined corner cases and scenarios are hit.
  - **Scalability for Complex Designs**: As ASIC designs grow in complexity, CRV provides a scalable solution to verify billions of transistors by defining rules (constraints) rather than explicit scenarios.
  - **Flexibility with Constraints**: Constraints allow engineers to direct the stimulus to specific areas of interest (e.g., specific timing or data ranges) while keeping the tests random, often referred to as guided random testing.

Phases Overview
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
UVM components use standard execution phases to ensure consistent behavior across the testbench:

1. **build_phase**: Instantiate and configure components.
2. **connect_phase**: Establish communication links between components.
3. **run_phase**: Execute the main simulation stimulus (time-consuming).
4. **report_phase**: Summarize and display simulation results.

.. grid:: 1

    .. grid-item-card:: UVM Phases Flow

       .. uml:: _static/puml/uvm_phases.puml

Core Components
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
A typical UVM testbench consists of the following components:

UVM Driver
    Converts transaction-level stimulus into pin-level activity for the Design Under Test (DUT).

UVM Monitor
    Samples pin-level activity and converts it back into transactions for analysis.

UVM Sequencer
    Manages the flow of transactions (sequence items) from sequences to the driver.

UVM Agent
    A container that groups the sequencer, driver, and monitor for a specific interface.

UVM Scoreboard
    Checks the correctness of the DUT by comparing actual output against expected results.

Predictor (Reference Model)
    Acts as a wrapper that receives input transactions from the input monitor. It uses SystemVerilog **DPI-C imports** to pass these inputs to a golden C/C++ model, which computes the expected result.

DPI-C Interface
    Provides the bridge between SystemVerilog transactions and C-code functions. It allows the predictor to leverage high-level software models for complex mathematical or behavioral checking.

.. grid:: 1

    .. grid-item-card:: UVM Component Diagram

       .. uml:: _static/puml/uvm_tb.puml

DPI-C Overview
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
In a UVM verification environment, a **Predictor** (Reference Model) often uses **DPI-C** to call a golden C/C++ model for expected behavior calculation.
The **Scoreboard** then compares these predicted results with the actual outputs monitored from the DUT.

- **Predictor (Reference Model)**: Acts as a wrapper that receives input transactions from the input monitor. It uses SystemVerilog **DPI-C imports** to pass these inputs to a golden C/C++ model, which computes the expected result.
- **DPI-C Interface**: Provides the bridge between SystemVerilog transactions and C-code functions. It allows the predictor to leverage high-level software models for complex mathematical or behavioral checking.
- **Scoreboard**: Houses TLM analysis implementation ports (uvm_analysis_imp) to receive two streams of data: "expected" data from the predictor and "actual" data from the output monitor. It performs the final comparison and reports errors on mismatches.
- **Monitors**: Passive components that capture pin-level activity from the DUT and convert it into high-level transactions sent to the predictor and scoreboard.

.. grid:: 1

    .. grid-item-card:: DPI-C Predictor Block Diagram

       .. uml:: _static/puml/uvm_dpi.puml

    .. grid-item-card:: DPI-C Predictor Sequence Diagram

       .. uml:: _static/puml/uvm_seq.puml

    .. grid-item-card:: C Model Source Code

       .. literalinclude:: /dpi/c_model.c
           :language: C
           :linenos:
           :emphasize-lines: 4

    .. grid-item-card:: Package SystemVerilog Source Code

       .. literalinclude:: /dpi/dpi_pkg.sv
           :language: Verilog
           :linenos:
           :emphasize-lines: 3

    .. grid-item-card:: Scoreboard SystemVerilog Source Code

       .. literalinclude:: /dpi/my_scoreboard.sv
           :language: SystemVerilog
           :linenos:
           :emphasize-lines: 11

    .. grid-item-card:: Expected Simulation Log

       .. code-block:: Text
          :linenos:

          [C MODEL] Adding 5 + 10
          [SCBD] C Model Result: 15

DPI-C Usage Restrictions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The key constraints and restrictions for using the SystemVerilog Direct Programming Interface (DPI-C) as defined by the IEEE 1800-2023 standard.

General Constraints
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
* **No Class Method Imports**: A DPI-C function or task cannot be imported
  directly as a class method. It must be imported at a point where a
  standalone function/task declaration is valid (e.g., in a module,
  interface, or package).
* **Task vs. Function Rules**: In SystemVerilog, functions cannot consume
  simulation time. Consequently, an imported C function cannot call a
  SystemVerilog task that consumes time unless the C function is itself
  imported as a **DPI-C task**.
* **Data Type Mappings**: While many basic types (int, byte, real) map
  directly, 4-state values (logic/reg) require specific DPI-C types and
  API functions from ``svdpi.h`` to be interpreted correctly.

Argument Restrictions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
* **Input Qualifier**: Formal ``input`` arguments in the C code must be
  marked with the ``const`` qualifier and cannot be modified within the
  C function.
* **Output Undefined**: The initial values of ``output`` arguments are
  undetermined and implementation-dependent when they reach the C function
  side.
* **Array Limitations**:
    * Packed/unpacked dynamic arrays are handled as an ``svOpenArrayHandle``
      on the C side.
    * For multi-dimensional or complex arrays, users are encouraged to use
      wrapper functions for conversion.

Contextual Limitations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
* **Context Awareness**: To call a SystemVerilog task/function or to access
  simulation scope from C, the import must be declared with the ``context``
  keyword (e.g., ``import "DPI-C" context function...``).
* **Thread Safety**: By default, many simulators assume DPI-C imports are
  not thread-safe. Special tool-specific flags (e.g., ``--threads-dpi``)
  may be required to enable parallel execution of DPI imports.

Best Practices
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
* **Avoid Scope Access**: Minimize calls that require the ``context`` keyword as they incur higher performance overhead.
* **Data Batching**: When streaming large amounts of data, use arrays to batch values rather than making frequent individual calls.

.. note::
   Highly recommended to keep argument lists as simple as possible (using only 2-state C-compatible types) to maximize performance and avoid the overhead of 4-state logic conversions.

UVM Concrete Example
-------------------------------------------------------------------------------------------------------------------------
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
