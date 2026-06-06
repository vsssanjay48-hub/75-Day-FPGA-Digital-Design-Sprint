# Week 3: Sequential Logic & Memory Fundamentals

## Overview
Weeks 1 and 2 focused on Combinational Logic—building circuits where data flows instantly like water through pipes. Week 3 marks the transition to **Sequential Logic**.
 This week introduces the concepts of **Time** and **Memory** into hardware design, utilizing a system Clock to synchronize millions of operations and Flip-Flops to store state.

This repository contains the RTL code and testbenches for foundational sequential components, bridging the gap between basic logic gates and modern CPU architecture.

---

## Major Concepts & Future Applications

### 1. The Hardware Divide: Blocking (`=`) vs. Non-Blocking (`<=`)
* **Concept:** Understanding how the Verilog compiler translates code into physical silicon. 
  * `always @(*)` + `=` evaluates sequentially (like software). 
  * `always @(posedge clk)` + `<=` evaluates simultaneously, taking a snapshot of data and moving it all at once at the exact nanosecond the clock ticks.
* **Future Need:** This is the most critical rule in digital design. Mastering `<=` is required to build **Pipelined Processors** (like ARM or RISC-V cores).
 If you use `=` in sequential logic, data will teleport instantly through the pipeline, bypassing memory stages and destroying the architecture.

### 2. System Stability: Synchronous vs. Asynchronous Resets
* **Concept:** How a chip wakes up from an unknown state (the `X` in GTKWave). 
  * Asynchronous (`posedge rst` in the sensitivity list) wipes memory instantly upon a button press. 
  * Synchronous checks the reset button *only* when the clock ticks.
* **Future Need:** Modern FPGA and ASIC designs heavily rely on **Synchronous Resets**. Asynchronous designs are highly vulnerable to microscopic static electricity glitches.
 Synchronous designs protect the system from crashing by forcing every signal to wait for the official clock heartbeat.

### 3. Data Routing: Universal Shift Registers (USR)
* **Concept:** A multi-tool register capable of Holding, Parallel Loading, Shifting Left, and Shifting Right, driven by a 2-bit multiplexed mode selector.
* **Future Need:** Shifting data is how all modern communication works. 
When you eventually write hardware drivers for **UART, SPI, or I2C protocols** (like plugging in a USB drive), you will use shift registers to serialize parallel CPU data down to a single wire, and reassemble it on the receiving end.

### 4. Memory Protection: PIPO Registers with Byte/Bit Enabling (Masking)
* **Concept:** An 8-bit Parallel-In Parallel-Out register where every single lane has its own independent "toll booth" (an enable bit). The memory only updates if the specific lane's mask is set to `1`.
* **Future Need:** This mimics exact real-world **Register-Mapped Peripherals** in microcontrollers (like Arduino/STM32). 
When writing to a General Purpose Input/Output (GPIO) port to blink an LED on Pin 2, the CPU uses a mask to update Pin 2's memory without accidentally turning off the motors wired to Pins 3 through 7.

---

## Toolchain
* **Simulation:** Icarus Verilog (`iverilog`, `vvp`)
* **Waveform Viewer:** GTKWave

## Repository Structure
* `/src` - Contains all Verilog HDL modules (`.v` files) mapped out day-by-day.
* `/tb` - Contains exhaustive testbenches validating edge cases, memory retention, and clock-edge synchronization.