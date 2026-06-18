# Week 5: Finite State Machine (FSM) Encoding Analysis — Binary vs. One-Hot

This repository documents the architectural analysis and implementation of **Binary State Encoding** versus **One-Hot State Encoding** completed during Week 5 of the digital design sprint. Choosing an FSM encoding style directly impacts physical hardware mapping, resource utilization, and power consumption inside the FPGA fabric.

---

## 🏛️ The Core Tradeoff: Silicon Real Estate vs. Speed

An FPGA is primarily composed of two components: **Flip-Flops (FFs)** for sequential storage and **Look-Up Tables (LUTs)** for combinational logic routing. 

### 1. Binary Encoding
* **Resource Impact:** Minimizes **Register** utilization. For a system with `N` states, it requires only `ceil(log2(N))` flip-flops. 
* **Logic Complexity:** High. Because states are compressed into a minimal binary footprint (e.g., `2'b00`, `2'b01`, `2'b10`), the next-state logic must decode multiple bits simultaneously to determine the next transition, consuming more **LUTs**.

### 2. One-Hot Encoding
* **Resource Impact:** Minimizes **LUT** logic while utilizing more **Registers**. It assigns exactly one dedicated flip-flop per state (`N` flip-flops for `N` states). Only a single bit is ever high ("hot") at any given time.
* **Logic Complexity:** Low. Since only one bit is ever active, next-state transitions and output decoding equations evaluate a single wire (e.g., checking `st[2]` instead of decoding `st == 2'b10`), saving significant combinational routing resources.

---

## 📊 Detailed Architectural Comparison

| Metric | Binary Encoding | One-Hot Encoding |
| :--- | :--- | :--- |
| **State Register Width** | Small (`ceil(log2(N))` bits) | Large (`N` bits) |
| **Combinational Logic (LUTs)** | High (Complex multi-bit decoding) | Low (Simple 1-bit checks) |
| **Max Clock Frequency (Fmax)** | Slower | **Blazing Fast** |
| **Output Decoding Complexity** | Requires an extra layer of gates | Completely free (`assign o_red = st[0];`) |
| **Next-State Logic Complexity** | Deep combinational gate paths | Shallow, single-gate transitions |
| **Illegal State Risk** | Minimal (3 states out of 4 possible) | **High** (3 states out of 8 possible) |

---

## ⚡ Performance Metric: Computational Power (Fmax)

In RTL design, processing performance is determined by the **Maximum Clock Frequency (Fmax)**. The system speed is bottlenecked by the **Critical Path**—the absolute longest propagation delay a signal experiences moving from one sequential register, through a sea of combinational LUT gates, to the next sequential register.

* **Binary Bottleneck:** As state counts grow, the next-state logic decoders become deeper, forcing signals through multiple cascaded LUT layers. This introduces propagation delays that lower the maximum achievable clock speed.
* **One-Hot Advantage:** Because decoding depends on individual bits, the next-state logic paths are incredibly shallow (often a single gate layer). This minimal combinational delay optimizes the critical path, allowing the design to run at ultra-high clock frequencies without triggering setup-time violations.

---

## 🛠️ The Implementation Paradigms of "Good RTL"

"Good RTL design" means optimizing your hardware description specifically for your target silicon. The preferred encoding choice changes completely based on the implementation environment:

### 1. The FPGA Philosophy -> Prefer One-Hot
FPGA architectures are inherently **register-rich**. Slices are pre-fabricated with fixed flip-flops that sit idle if unused. Because registers are essentially "free" on an FPGA, **One-Hot is the industry-standard choice** for small-to-medium FSMs (`N < 64`). It maximizes clock performance (Fmax) and unburdens the LUT fabric for data-path processing.

### 2. The ASIC Philosophy -> Prefer Binary / Gray
In custom ASIC design, every single flip-flop translates directly to physical silicon area, structural static power grid loads, and increased manufacturing costs. Combinational gates are vastly cheaper than registers. For ASICs, **Binary or Gray encoding is preferred** to minimize the physical footprint and keep power consumption optimized.

---

## 🛡️ Fault Tolerance: Safe State Recovery

Using a 3-bit register for a One-Hot FSM introduces 8 possible binary combinations (`3'b000` through `3'b111`). However, only 3 configurations are valid (`3'b001`, `3'b010`, `3'b100`). 

If an electrical glitch, noise spike, or radiation event causes a bit-flip on the chip, the register could fall into an illegal state (e.g., `3'b011`, where two lights are active simultaneously).

```verilog
default: st <= red;