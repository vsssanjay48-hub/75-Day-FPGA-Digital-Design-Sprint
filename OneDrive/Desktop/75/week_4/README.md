md_content = """# Week 4: Shift-Register Counters, Clock Dividers, and UART Serialization

## Overview
This week marked a major transition from simple mathematical counters to **advanced timing control, multi-module structural design, and serial communication**. 
The ultimate milestone of the week was synthesizing these foundational principles into a fully autonomous, industrial-grade **UART Transmitter (TX) core** driven by a synchronous Finite State Machine (FSM).

---

## Technical Milestones

### 1. Shift-Register Counters (Ring vs. Johnson)
Moved away from arithmetic accumulator counters to pure structural bit-shifting feedback loops using the Verilog concatenation operator `{ }`.
* **Ring Counter:** Implemented as a 4-bit "One-Hot" encoded shifting loop (`1000 -> 0100 -> 0010 -> 0001`). 
Explored the critical requirement of synchronous initialization to inject a single active bit (`1`) into the system, preventing the circuit from deadlocking on zeros.
* **Johnson Counter:** Developed an 8-state modified ring sequence by routing an inverted feedback loop (`~q[0]`).
 This structure optimizes power performance and eliminates intermediate glitches by ensuring only a single bit toggles per clock edge.

### 2. Parameterized Clock Dividers
Designed and validated a reusable, generic clock division module using Verilog parameters (`#(parameter DIVISOR = 2)`). 
This module dynamically scales high-frequency input oscillators down to targeted logic frequencies by tracking a local countdown register against a mathematically calculated terminal limit.

### 3. Structural Multi-Module Integration
Achieved the first major system-level architectural milestone by chaining independent modules together. 
Tied a Modulo-10 binary counter output directly into a 7-segment display decoder using an internal 4-bit interconnection bus (`inta`), mirroring real-world System-on-Chip (SoC) layout practices.

---

## Deep Dive: The UART Transmitter Core (The Final Day)

The culmination of Week 4 involved building a structural **UART Transmitter IP Block (`uart_tx.v`)** capable of converting 8-bit parallel register data into a serial bitstream over a single physical copper line (`tx_out`).

### The Conversion Frame
To communicate asynchronously without a shared clock wire, the parallel byte must be packed inside a rigid 10-bit sequence frame:
1. **Start Bit:** Forces the physical wire line **LOW (0)** for exactly 1 bit duration to synchronize the downstream receiver.
2. **Data Bits:** Serializes the 8 bits of the data byte, transmitting them sequentially (Least Significant Bit first).
3. **Stop Bit:** Pulls the line back **HIGH (1)** to establish the baseline resting potential for subsequent transmissions.

### Architectural Breakdown
* **The Baud Tick Enable Pulse (The Metronome):** To maintain clock domain integrity and avoid hazardous clock skew, the core keeps all logic synchronous to the primary 50 MHz clock line.
 It uses a high-performance terminal comparator that fires an enable pulse (`baud_tick`) for exactly *one clock cycle* every 5208 ticks (50 MHz / 9600 Baud).
* **The Controller FSM:** Coordinates transmission state changes across four dedicated states (`IDLE`, `START`, `DATA`, `STOP`), evaluating bit progress only when a valid `baud_tick` is flagged.
* **The Serialization Assembly:** Utilizes right-shift concatenation (`tx_shift <= {1'b0, tx_shift[7:1]}`) on every metronome click to automatically push out data bits through the `tx_out` pin.

---

## Architectural & Syntax "Gotchas" (The Debug Log)

A significant portion of this week's progress involved identifying, understanding, and resolving complex hardware elaboration errors thrown by the compiler:

### 1. Continuous Assignment Wire Conflict
* **The Blocker:** `error: reg gray; cannot be driven by continuous assignment.`
* **The Resolution:** Reg types represent discrete structural storage flip-flops driven procedurally. The `assign` statement forms permanent combinatorial logic gates driven continuously.
 Any identifier updated via continuous equations outside an edge-triggered block must be strictly declared as a `wire`.

### 2. Procedural vs. Structural Multi-Drivers
* **The Blocker:** `error: macro/port driven by multiple sources during elaboration.`
* **The Resolution:** Inside the testbench `tb_multi.v`, an active procedural loop attempted to inject values directly into the internal interconnect wire bus (`inta`).
 Since the modulo counter's output port was already hardwired to drive that exact line, the compiler halted to prevent an illegal physical short-circuit. Testbenches must remain passive listeners on interconnected wires.

### 3. Trailing Comma Parse Failures
* **The Blocker:** `syntax error: Failed to parse library file / Unknown module type.`
* **The Resolution:** Icarus Verilog treats structural syntax rigidly. Leaving a trailing comma on the very last port definition inside a module parameter or port list right before the closing paren `);` breaks the compiler parse stream.

### 4. Sequential Blocking Race Conditions
* **The Blocker:** Accidentally introducing blocking assignments (`=`) inside an edge-triggered `always @(posedge clk)` block.
* **The Resolution:** Using `=` forces instantaneous execution, bypassing clock cycle alignment and introducing dangerous timing race conditions during simulation. All state registers, shift logic, and accumulators have been hardened to use non-blocking arrow operators (`<=`).

### 5. Terminal Count Threshold Logic
* **The Blocker:** Differentiating between symmetrical divider formulas and cycle-strobe conditions.
* **The Resolution:** Verified the explicit formulas for timing limits:
  * For toggling a symmetrical output square-wave clock: `Ceiling = (DIVISOR / 2) - 1`.
  * For micro-strobe enable triggers mapping an entire bit frame duration from zero index: `Ceiling = DIVISOR - 1`.

---

## Simulation Verification Commands
All hardware modules have been compiled via Icarus Verilog and verified inside GTKWave to confirm perfect frame timing alignment: