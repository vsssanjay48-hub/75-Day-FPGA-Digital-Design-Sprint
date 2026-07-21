# 75-Day FPGA & Digital Design Sprint

A self-driven 11-week hardware design sprint covering RTL fundamentals,
Verilog HDL, and FPGA-based system design — built from scratch before 2nd year.

---

## Overview

[![Project Overview](docs/overview.jpg)](https://drive.google.com/file/d/1bXxQNqFAXtvyJbDncDagC2EPCDllQ6QE/view?usp=sharing)

> Progressed through gates → adders → FSMs → UART → FIFO, simulating every module  
> in Icarus Verilog + GTKWave before transitioning to Xilinx Vivado for synthesis.

---

## Final Project — UART Transmitter + Synchronous FIFO

[![Project Demo](https://drive.google.com/uc?export=view&id=1FOB7Yr5m2n6AUCE5qXEoZ22v8GXiUvY4)](https://drive.google.com/file/d/1RXhqWE-tu-cp0eQSoanIdvX1pX4TT-ZD/view?usp=sharing)

> Parameterized UART TX (9600 baud, 8N1, 4-state FSM) integrated with a  
> Synchronous FIFO (configurable depth/width) via a handshake controller.  
> Fully simulated with self-checking testbenches and verified in GTKWave.

---

## What I Built

| Week | Module |
|------|--------|
| 1–2 | Logic gates, MUX, adders, decoders |
| 3 | Flip-flops, shift registers, registers |
| 4 | Counters — binary, Gray, ring, clock divider |
| 5 | FSMs — Moore, Mealy, traffic light, sequence detector |
| 6 | SRAM, register file, Synchronous FIFO |
| 7 | Advanced testbenches, generate blocks, bug marathon |
| 8 | UART TX — baud generator + 4-state FSM |
| 9 | UART RX — 16× oversampling, loopback test |
| 10–11 | UART + FIFO top-level integration + demo |

## Tools
`Icarus Verilog` `GTKWave` `Xilinx Vivado` `VS Code` `Git`

## Next
UART + FIFO deployed on Basys3 FPGA → FIR Filter / CNN block in RTL (Sem 2-2)
