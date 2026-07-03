
## 📂 Week 8 — Advanced TX Features & Receiver Theory

### 📌 Project Overview
Upgraded the UART Transmitter to support dynamic compile-time **Parity Configuration (None, Even, Odd)**,
 conducted an intentional baud rate mismatch stress test, and mastered **16x Oversampling Architecture Theory**
  for the upcoming UART Receiver design.

---

### 🧠 Key Doubts & Clarifications

#### 1. The Crucial Purpose of the `baud_tick` FSM Guard
* **The Doubt:** Why do we need `if (baud_tick)` guarding transitions inside states like `PARITY` or `DATA`?
* **The Clarification:** The FPGA processes your FSM at a blazing 50 MHz speed (every 20 ns). 
Without the `baud_tick` condition guarding state exits, the FSM would instantly jump to the next state on the very next clock cycle. 
The guard forces the FSM to freeze and hold its active bit on the physical `tx_out` pin for the required 104.16 µs window.

#### 2. The Shift Register Serialization Bug
* **The Doubt:** Why did the transmitter continually loop and send the exact same bit over and over?
* **The Clarification:** The assignment line was improperly structured as `tx_out <= {1'b1, tx_shift[7:1]};`.
 This attempted to cram an 8-bit vector into a 1-bit pin, dropping data and leaving the internal storage buffer `tx_shift` completely frozen.
  The correct serialization pattern is:
  ```verilog
  tx_out   <= tx_shift[0];                // Continuously drive the LSB out the door
  tx_shift <= {1'b1, tx_shift[7:1]};       // Shift the actual storage buffer on the baud tick