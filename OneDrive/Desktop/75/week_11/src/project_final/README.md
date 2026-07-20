# Autonomous UART Transmission Pipeline

A high-reliability, hardware-verified asynchronous speed-matching bridge that interfaces a high-speed parallel data input bus with a
 sequential serial NRZ transmitter.
  Built completely in Verilog, this system manages ingestion, buffering, and transmission autonomously without CPU overhead.

---

## 🏗️ Core Architecture

The pipeline consists of three structurally linked sub-modules:
* **FIFO Buffer (`fifo.v`)**: An 8-deep circular queue using a 4-bit occupancy counter to safely track allocation and assert boundary flags
 (`full`, `empty`).
* **Handshake FSM (`handshake_fsm.v`)**: A 3-state controller (`WAIT`, `READ`, `TRANSMIT`) coordinating zero-latency data transfer between memory
 and transmission stages.
* **UART Transmitter (`uart.v`)**: A sequential serialization engine formatting parallel bytes into standard frames
 (1 Start Bit, 8 Data Bits, 1 Stop Bit).

```mermaid
graph LR
    DATA_IN[data_in] --> FIFO[8-Deep FIFO]
    FIFO -->|data| FSM[Handshake FSM]
    FSM -->|data| UART[UART TX]
    UART -->|Serial Stream| TX_OUT[tx_out]