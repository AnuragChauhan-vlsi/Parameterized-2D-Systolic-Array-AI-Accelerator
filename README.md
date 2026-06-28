# Parameterized 2D Systolic Array AI Accelerator

A parameterized **NxN Systolic Array AI Matrix Multiplication Accelerator** implemented in **Verilog RTL** and verified using **SystemVerilog** and **UVM**.

---

## Overview

This project implements a scalable 2D systolic array architecture for matrix multiplication. The design is parameterized, allowing different array sizes and data widths to be configured through Verilog parameters.

The verification environment includes both a directed **SystemVerilog testbench** and a **UVM-based verification environment** to validate functional correctness.

---

## Features

- Parameterized NxN Systolic Array Architecture
- Processing Element (PE) Based Design
- Matrix Multiplication Accelerator
- Scalable RTL Implementation
- Configurable Data Width
- Directed SystemVerilog Verification
- UVM Verification Environment
- Self-Checking Testbench
- Functional Verification

---

## Project Structure

```
rtl/
│── AXI-independent RTL implementation
│── Processing Element (PE)
│── Systolic Array
│── Testbench

verification/
│── SystemVerilog Verification Environment
│── UVM Verification Environment
│── Project Documentation
```

---

## Verification

The design is verified using two approaches:

### SystemVerilog Verification

- Interface-Based Testbench
- Object-Oriented Verification Classes
- Transaction Class
- Generator
- Driver
- Monitor
- Scoreboard
- Functional Coverage
- Assertions

### UVM Verification

- UVM Transaction
- Sequence
- Sequencer
- Driver
- Monitor
- Agent
- Environment
- Scoreboard
- Functional Coverage
- Self-Checking Verification

---

## Technologies Used

- Verilog HDL
- SystemVerilog
- Universal Verification Methodology (UVM)
- Digital Design
- RTL Design

---

## Documentation

A detailed project report describing the architecture, RTL implementation, SystemVerilog verification environment, and UVM verification environment is available in the **verification/docs** directory.

---

## Future Improvements

- AXI4-Lite Interface Integration
- FPGA Implementation
- Performance Optimization
- Support for Larger Matrix Sizes

---

## Author

**Anurag Chauhan**

PGCP VLSI, CDAC Noida
