# Week 5: Advanced Synchronous Finite State Machines & RTL Optimization

This repository documents the comprehensive development, debugging, and optimization of synchronous Finite State Machines (FSMs) completed during Week 5 of the intensive hardware design sprint. The primary focus of this week was transitioning from basic sequential logic to industrial-grade RTL optimization, specifically addressing timing delays, proper port declarations, fault tolerance, and pulse-based arithmetic accumulation.

---

## 📌 Weekly Roadmap Overview

| Day | System Designed | Architecture Type | Core Conceptual Focus |
| :--- | :--- | :--- | :--- |
| **Mon** | Structural Blueprints | Paper Analysis | Pen-and-paper state transition mapping for 5 complex systems. |
| **Tue** | Traffic Light Controller | Moore FSM | Multi-module timing separation and state-dependent outputs. |
| **Wed** | `1011` Sequence Detector | Mealy FSM | Same-cycle zero-latency output driving and overlapping streams. |
| **Thu** | Optimized Traffic Light | One-Hot FSM | Register-to-LUT balancing and look-ahead timer derivation. |
| **Fri** | Glitch Injection Lab | Fault Analysis | Recovery modeling, undefined state lockups, and testbench synchronization. |
| **Sat** | Vending Machine Counter | Accumulator FSM | Pulse-driven conditional arithmetic and bit-width overflow budgets. |

---

## 🔍 Wednesday: Mealy `1011` Sequence Detector

### 💡 Resolved Concept Doubts
* **The Serial Input Reality:** Instead of feeding a parallel 4-bit block (like `4'b1011`) all at once, serial sequence detectors process data bit-by-bit over consecutive clock cycles on a single 1-bit input wire (`sequence_in`).
* **Input Port Constraints:** Input ports cannot be declared as storage variables (`reg`). They represent physical signals driven exclusively by external hardware. Therefore, inputs must always default to continuous wires (`wire`), while only internal tracking elements or clocked outputs use the `reg` type.

### Moore vs. Mealy Architecture Differences
* **Moore Machine:** Outputs are isolated functions of the *current state register only*. This inserts a mandatory 1-clock-cycle propagation delay before an output responds to an input shift.
* **Mealy Machine:** Outputs are evaluated *combinationally* using both the current state AND the live input wire. This allows the output to flash high instantly during the exact same clock cycle that the final matching bit arrives.

### Same-Cycle Implementation Architecture
To eliminate the 1-cycle registered delay and maintain a true Mealy setup, the output assignment must live entirely outside the clocked procedural block as a continuous combinational expression:

```verilog
// Zero-latency Mealy output tracking
assign out = (st == g101 && data == 1'b1) ? 1'b1 : 1'b0;