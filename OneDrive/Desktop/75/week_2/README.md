# Week 2: N-Bit Systems & Advanced Combinational Logic

## Overview
This week focused on scaling basic digital logic gates into functional arithmetic systems. The primary goal was to transition from single-bit operations to parameterized, N-bit architectures. I successfully built, debugged, and verified a parameterized N-bit Ripple Carry Adder. 

## Directory Structure
* hardware design modules (`half_adder.v`, `full_adder.v`, `ripple_carry_nbit.v`).
* `notes/` - Contains the verification environments using parameterized and randomized stimulus also my examples and workouts.
* `waveforms/` - Contains annotated waveforms (GTKWave) demonstrating carry propagation.

## Key Doubts & Technical Conclusions

Throughout this week's sprint, I encountered several critical differences between software programming (C/Python) and Hardware Description Languages (Verilog). Here is the debugging log:

### 1. The "Passthrough" Bug: Structural vs. Behavioral
* **The Doubt:** I initially tried to build a full adder using simple pass-through assignments (`assign sumout = sum;`) driven by an external testbench, assuming the data would just flow through. 
* **The Conclusion:** Verilog describes physical hardware. You cannot just pass variables around; you must physically instantiate the logic gates. A true 1-bit Full Adder requires structurally wiring two Half Adders and an OR gate together. 

### 2. The "Silent" Ripple Bug & Verification Strategy
* **The Doubt:** I accidentally misrouted the carry wire in a 4-bit adder (bypassing Bit 2 and jumping straight to Bit 3). Surprisingly, the testbench showed perfect results for the first 18 test cases. Why didn't it fail immediately?
* **The Conclusion:** Hardware bugs hide in specific edge cases. Because the lower bits didn't generate a carry during the first few loops ($0+0$, $0+1$), the broken wire stayed at `0` and didn't corrupt the math until exactly $A=1$ and $B=3$. This proved that exhaustive testing is mandatory for small systems, and randomized testing (`$random`) is mandatory for large N-bit systems.

### 3. Debugging the `AX` Waveform (Unknown States)
* **The Doubt:** During N-bit simulation, the GTKWave output showed `AX` (e.g., `A5` where the `5` was replaced by an `X` in red).
* **The Conclusion:** In digital logic, `X` stands for an **Unknown/Floating** state. This was caused by an unassigned initial `carry[0]` wire. Interestingly, the top 4 bits (the `A`) calculated correctly because the `X` was "squashed" by a $0+0$ operation in the middle bits, preventing the unknown state from rippling all the way to the top.

### 4. Software Loops vs. Hardware Generation
* **The Doubt:** I tried to use a standard software `for` loop inside an `initial` block to dynamically build an N-bit adder based on a parameter.
* **The Conclusion:** `initial` blocks are for sequential simulation only. To dynamically stamp down multiple physical chips (like $N$ full adders), you must use a `generate` block with a `genvar`. Furthermore, the block must be named (e.g., `begin : adder_loop`) so the synthesizer and simulator can build a distinct hierarchical folder for each generated chip.

## Git & Version Control Notes
* Learned how to resolve remote/local desyncs. When editing files directly on GitHub (like a README), running `git pull origin main` is required before pushing local VS Code changes. 
* Successfully navigated the Vim merge text editor using the `:wq` (Write & Quit) command.

## Next Steps
Transitioning from Combinational Logic (which has no memory) to **Sequential Logic**. Week 3 will focus on memory elements, specifically the D Flip-Flop, to introduce the concept of Clock domains and state retention.