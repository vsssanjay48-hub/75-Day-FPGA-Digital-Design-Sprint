# Autonomous UART TX Pipeline with 8-Deep FIFO Buffer

## Project Overview
This project implements a hardware-managed, robust data transmission pipeline in Verilog. It integrates an 8-deep,
 8-bit wide FIFO storage buffer with a sequential UART Transmitter engine, all orchestrated automatically by a
  central Handshake Finite State Machine (FSM). 

The entire system handles clock-domain speed matching dynamically: 
it accepts fast, back-to-back parallel data bursts from external system logic and metered-drips them out bit-by-bit over a single serial wire 
without any CPU or software intervention.

## 🏗️ Architecture & Block Diagram
The top-level wrapper module (`project.v`) instantiates and interconnects three primary sub-modules:
1. **FIFO Buffer (`fifo.v`)**: An 8-byte circular memory queue equipped with strict boundary guards (Overflow and Underflow protection).
2. **Handshake FSM (`handshake_fsm.v`)**: The system controller that manages data handoffs by continuously evaluating
 `fifo_empty` and `tx_busy` status lines to pull data sequentially via `fifo_rd_en`.
3. **UART Transmitter (`uart.v`)**: The serialization engine that accepts an 8-bit parallel byte, 
wraps it in a Start bit and Stop bit frame, and streams it over `tx_out`.