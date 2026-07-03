

## 📂 Week 7 — UART Clock Divider & Base Transmitter

### 📌 Project Overview
Designed and implemented a parameterizable **Baud Rate Generator (BRG)** and a baseline 4-state **UART Transmitter Finite State Machine (FSM)**. 
The core objective was converting a high-speed 50 MHz system clock down to a stable 9600 baud serial stream interface.

---

### 🧠 Key Doubts & Clarifications

#### 1. Generating a Clock vs. Generating a "Tick"
* **The Doubt:** Why can't we just generate a slower 9600 Hz clock signal using a traditional clock divider toggle?
* **The Clarification:** Creating divided clocks using combinational logic or raw registers introduces clock skew and timing hazards across the FPGA fabric.
 The correct hardware pattern is to generate a **1-cycle-wide pulse strobe (`baud_tick`)** that leaves the main system clock unchanged but acts as a dynamic clock-enable gate for the FSM.

#### 2. Register Declaration Enforcement (`wire` vs. `reg`)
* **The Doubt:** Why does the compiler reject `baud_count` when declared as a `wire`?
* **The Clarification:** Any data signal assigned values inside a procedural block (`always @(posedge clk)`) using sequential non-blocking assignments (`<=`) **must** be declared as a variable type (`reg`).
 Wires are strictly reserved for continuous `assign` statements outside of procedural logic.

#### 3. Testbench Clock Period Timing (`#5` vs. `#10`)
* **The Doubt:** Why did `#5 clk = ~clk;` break the expected baud rate timing?
* **The Clarification:** A `#5` delay means the clock flips every 5 ns, creating a total period of 10 ns (which equals a 100 MHz clock). 
To accurately simulate your board's 50 MHz target clock frequency, the period must be 20 ns, requiring a toggle delay of exactly `#10`.

#### 4. Dead Lock Simulation Initialization
* **The Doubt:** Why did the simulation waveform show uninitialized `x` values for the clock indefinitely?
* **The Clarification:** In Verilog simulations, all registers initialize as `x` (unknown). 
Since the inverse of unknown is still unknown (`~x = x`), the clock toggling block stays deadlocked. 
The clock register must be explicitly anchored to `0` at Time = 0 inside an `initial` block.

---
