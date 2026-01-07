******************************
AI Neuron DUT UVM Presentation
******************************

Design Under Test (DUT)
===================================

Basic Artificial Neuron Model
-----------------------------------

.. uml:: puml/neuron.puml

Universal Verification Methodology (UVM)
========================================

The Universal Verification Methodology (UVM) is a standardized methodology for 
verifying integrated circuit designs. It is based on the IEEE 1800.2 standard 
and provides a modular, object-oriented framework.

Key Benefits
------------
* **Reusability**: Standardized components can be reused across different 
  projects and levels of design.
* **Automation**: Features like factory overrides and built-in phases automate 
  testbench construction.
* **Interoperability**: Supported by all major EDA vendors.

Core Components
---------------
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
-----------------
UVM components use standard execution phases to ensure consistent behavior 
across the testbench:

1. **build_phase**: Instantiate and configure components.
2. **connect_phase**: Establish communication links between components.
3. **run_phase**: Execute the main simulation stimulus (time-consuming).
4. **report_phase**: Summarize and display simulation results.


UVM Testbench Hierarchy (Component Diagram)
-------------------------------------------

This diagram illustrates the standard containment of UVM components, from the top-level test down to the driver and monitor.

.. uml:: puml/uvm_tb.puml

UVM Transaction Flow (Sequence Diagram)
----------------------------------------

This example shows the typical "handshake" between a sequence and a driver, which is fundamental for UVM testbench operation.

.. uml:: puml/uvm_seq.puml

.. toctree::
   :maxdepth: 2
   :caption: Contents:
