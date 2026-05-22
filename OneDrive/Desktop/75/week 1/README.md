# 75-Day Hardware Design Sprint: Week 1 Summary

## Overview
Week 1 focused on establishing a solid foundation in digital logic, boolean algebra, and the RTL design flow. The primary objective was to master combinational logic and become comfortable writing, compiling, and simulating Verilog modules using Icarus Verilog and GTKWave.

## 🛠️ Tools & Environment Setup
- **Simulator:** Icarus Verilog (`iverilog`)
- **Waveform Viewer:** GTKWave
- **Editor:** VS Code with Verilog extensions
- **Version Control:** Git & GitHub

## 📂 Modules Built & Verified
The following combinational circuits were implemented this week. Each module includes a corresponding testbench to verify its truth table against the expected waveform output.

### Basic Logic Gates
- [x] `and_gate.v`
- [x] `or_gate.v`
- [x] `not_gate.v`
- [x] `nand_gate.v`
- [x] `nor_gate.v`
- [x] `xor_gate.v`
- [x] `xnor_gate.v`

### Multiplexers
- [x] `mux_2to1.v` (Implemented in two styles to verify identical synthesis behavior)
  - Dataflow modeling (`assign` with ternary operator)
  - Behavioral modeling (`always @(*)` with `case` statement)

### Arithmetic Circuits
- [x] `half_adder.v` (Outputs: Sum = A ^ B, Carry = A & B)
- [x] `full_adder.v` (Constructed using structural modeling by instantiating two `half_adder` modules)

## 🐛 Debugging Training
Conducted intentional fault injection on the `and_gate` module to understand compiler behavior vs. simulation behavior.
- **Logic Error:** Replaced `&` with `|`. The compiler passed without errors, but the GTKWave output showed incorrect OR-behavior.
- **Syntax Error:** Removed a semicolon. The compiler successfully caught the error, often pointing to the line *following* the missing semicolon.
- **Instantiation Error:** Used an incorrect port name in the testbench. The compiler explicitly flagged the missing port prior to simulation.

## ✅ Checkpoint Verification
- [x] Successfully loaded the `half_adder` VCD in GTKWave and verified the exact timestamps where Sum and Carry logic transitioned high based on test vectors.

---
*Ready for Week 2: Carry propagation and the 4-bit adder.*