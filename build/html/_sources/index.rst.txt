*************************************************************************************************************************
Vladimir\'s Presentation
*************************************************************************************************************************

.. grid:: 1

    .. grid-item-card:: Biological vs. Artificial Neuron

       .. figure:: _static/img/biologicalvsartificialneuron.webp

.. admonition:: References

   - `Read the Docs Sphinx Theme <https://sphinx-rtd-theme.readthedocs.io>`__
   - `Sphinx-Needs <https://www.sphinx-needs.com>`__
   - `UVM Verilator <https://antmicro.com/blog/2025/10/support-for-upstream-uvm-2017-in-verilator>`__

AI Neuron (AIN) Design Under Test (DUT)
=========================================================================================================================

The AI Neuron (AIN) SystemVerilog RTL module is Design Under Test (DUT).
The AIN is the building block of Artificial Intelligence (AI) neural networks.

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

    .. grid-item-card:: AIN Testbench Source Code

       .. literalinclude:: tb/directed_tests/simple/ain_tb.sv
           :language: SystemVerilog
           :linenos:
           :emphasize-lines: 14-20

    .. grid-item-card:: AIN Simulation Waveforms

       .. figure:: sim/directed_tests/simple/dump.png

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

.. toctree::
   :maxdepth: 2
   :caption: Contents:
