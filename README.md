# Lab 6: Hexadecimal Display System

## Overview

In this lab, you will build a hexadecimal display system for the Basys3 FPGA board. The system reads a 16-bit value from the slide switches (four hex digits), uses the direction buttons to select which digit to display, and shows the selected digit on one of the four 7-segment displays.

This lab introduces behavioral Verilog modeling with `always @(*)` blocks and `case` statements. You will work with three modules:

1. **hex_to_7seg** -- Converts a 4-bit hex value to active-low segment patterns
2. **disp_mux** -- Selects which digit to display based on button input
3. **hex_disp_top** -- Top-level wrapper connecting switches, buttons, and display

The hex decoder and display mux are partially complete. You will finish them and then wire everything together in the top-level module. This display system will be reused as a building block in Lab 7.

**Design Hierarchy:**
```
hex_disp_top (top-level wrapper)
├── disp_mux    - Button-based digit selector (YOU COMPLETE)
└── hex_to_7seg - Hex-to-segment decoder (YOU COMPLETE)
```

![RTL Diagram](../Assets/rtl_hex_disp_top.jpg)

Demo video: [Hexadecimal Display Demo](https://www.youtube.com/watch?v=sazMMbFvTlE)

---

## Pre-Lab / Background

1. Review 7-segment display encoding (active-low: 0 = ON, 1 = OFF)
2. Understand the segment layout: `seg = {g, f, e, d, c, b, a}`
3. Review Verilog `case` statements and module instantiation
4. Read the background notes in `background.md` for behavioral modeling concepts

---

## Your Tasks

1. **Complete `rtl/hex_to_7seg.v`** -- Add the four missing case entries for hex digits C, D, E, F
2. **Complete `rtl/disp_mux.v`** -- Add the two missing button cases for btnU and btnL
3. **Complete `rtl/hex_disp_top.v`** -- Declare wires (TODO #1-#3) and instantiate both submodules (TODOs #4-#5)
4. **Complete `tb/hex_disp_top_tb.v`** -- Declare signals, instantiate UUT, and write test cases

---

## Lab Activities

### Step 1: Vivado Project Setup
- [ ] Download the Lab 6 template files
- [ ] Launch Vivado and create a new project
- [ ] Set the project location *outside* of the template directory
- [ ] Add all `.v` files from `rtl/` as **design sources**
- [ ] Add testbench files from `tb/` as **simulation sources**
- [ ] Add the constraint file from `constraints/`
- [ ] Select the Basys3 board as target

### Step 2: Hex-to-7-Segment Decoder
- [ ] Open `rtl/hex_to_7seg.v` and review the provided cases for hex 0-B
- [ ] Complete the four missing cases for C, D, E, F using the segment layout diagram
- [ ] Remember: active-low encoding, segment order is `{g, f, e, d, c, b, a}`
- [ ] Set `hex_to_7seg_tb` as the simulation top module and run simulation
- [ ] Verify all 16 hex digits produce correct segment patterns

**Reference waveform:**

![Hex to 7-Segment Simulation Waveform](../Assets/hex_to_7_seg_simulation_waveform.jpg)

### Step 3: Display Multiplexer
- [ ] Open `rtl/disp_mux.v` and review the provided cases for btnD and btnR
- [ ] Add the two remaining cases following the same pattern
- [ ] Set `disp_mux_tb` as the simulation top module and run simulation
- [ ] Verify all 5 button states produce correct digit and anode outputs

**Reference waveform:**

![Display Mux Simulation Waveform](../Assets/Cursor_and_disp_mux_tb_vcd_—_Lab5_StudentTemplate.jpg)

### Step 4: Top-Level Integration
- [ ] Open `rtl/hex_disp_top.v` and work through TODOs #1-#5
- [ ] Use the RTL diagram (`../Assets/rtl_hex_disp_top.jpg`) as your guide
- [ ] TODOs #1-#3: Declare wires, extract digits from switches, create button vector
- [ ] TODOs #4-#5: Instantiate disp_mux and hex_to_7seg with correct port connections

### Step 5: System Testbench
- [ ] Open `tb/hex_disp_top_tb.v` and complete the 3 TODO sections
- [ ] TODO #1: Declare signals (reg for inputs, wire for outputs)
- [ ] TODO #2: Instantiate hex_disp_top as UUT
- [ ] TODO #3: Write test cases -- set switches, press buttons, call check_button()
- [ ] Run simulation and verify the complete display system works

**Reference waveform:**

![Hex Display Top Simulation Waveform](../Assets/hex_disp_top_simulation_waveform.jpg)

### Step 6: Hardware Implementation
- [ ] Set `hex_disp_top` as the top module for synthesis
- [ ] Synthesize, implement, and generate bitstream
- [ ] Program the Basys3 and test with the button/switch combinations below

---

## Checking Your Work

When you push your code, GitHub Actions will automatically compile and test your modules:

| CI Job | What It Tests | Files Compiled |
|--------|--------------|----------------|
| `test-hex-to-7seg` | Hex decoder in isolation | `hex_to_7seg.v` + `hex_to_7seg_tb.v` |
| `test-disp-mux` | Display mux in isolation | `disp_mux.v` + `disp_mux_tb.v` |
| `test-hex-disp-top` | Full display system | All 3 RTL files + `hex_disp_top_tb.v` |

All three jobs must show **TEST PASSED** for full credit.

---

## File Structure

```
├── rtl/
│   ├── hex_to_7seg.v        # Hex-to-segment decoder (you complete)
│   ├── disp_mux.v           # Button-based display mux (you complete)
│   └── hex_disp_top.v       # Top-level wrapper (you complete)
├── tb/
│   ├── hex_to_7seg_tb.v     # Decoder testbench (provided, CI-tested)
│   ├── disp_mux_tb.v        # Mux testbench (provided, CI-tested)
│   └── hex_disp_top_tb.v    # Integration testbench (you complete, CI-tested)
├── constraints/
│   └── basys3.xdc           # Pin assignments for Basys3
└── .github/workflows/
    └── test.yml              # CI - auto-tests on push
```

---

## Hardware Interface

### Inputs
| Port | Pins | Description |
|------|------|-------------|
| `sw[15:0]` | V17..R2 | 16 slide switches = four hex digits |
| `btnD` | U17 | Down button -> display sw[3:0] on rightmost digit |
| `btnR` | T17 | Right button -> display sw[7:4] on second digit |
| `btnU` | T18 | Up button -> display sw[11:8] on third digit |
| `btnL` | W19 | Left button -> display sw[15:12] on leftmost digit |

### Outputs
| Port | Pins | Description |
|------|------|-------------|
| `seg[6:0]` | W7..U7 | 7-segment cathodes {g,f,e,d,c,b,a} (active-low) |
| `an[3:0]` | U2..W4 | 7-segment anodes (active-low, one-hot) |

### Button-to-Digit Mapping
| Button | Switches | Digit Position | Anode |
|--------|----------|---------------|-------|
| btnD | `sw[3:0]` | Rightmost | `an[0]` |
| btnR | `sw[7:4]` | Second from right | `an[1]` |
| btnU | `sw[11:8]` | Third from right | `an[2]` |
| btnL | `sw[15:12]` | Leftmost | `an[3]` |

---

## Example Test Cases

Set `sw = 16'h1234`, then press each button:

| Button | Expected Digit | Expected seg | Expected an |
|--------|---------------|-------------|-------------|
| btnD | 4 | `0011001` | `1110` |
| btnR | 3 | `0110000` | `1101` |
| btnU | 2 | `0100100` | `1011` |
| btnL | 1 | `1111001` | `0111` |
| (none) | -- | `1111111` | `1111` |

---

## What to Submit

Demo your working hardware to the instructor during lab. Set different switch patterns and use the buttons to display each hex digit.

No code submission is required -- GitHub CI will verify your Verilog automatically when you push.

---

## Common Issues and Troubleshooting

### Synthesis Errors
- **Missing wires in `hex_disp_top.v`**: Make sure you declared all wires (TODO #1) and assignments (TODOs #2-#3)
- **Port mismatch**: Verify port names match between your instantiations and the module definitions
- **Button vector order**: `btn = {btnL, btnU, btnR, btnD}` -- order matters!

### Simulation Issues
- **Wrong segment pattern**: Double-check active-low encoding -- 0 means the segment is ON
- **All displays off**: Make sure you completed the button cases in `disp_mux.v`
- **Testbench won't compile**: Check that you declared all signals in `hex_disp_top_tb.v` (TODO #1)

### Hardware Issues
- **No display output**: Verify constraint file is added and button pins are correct
- **Wrong digit on wrong button**: Check the button-to-anode mapping in `disp_mux.v`
- **Garbled segments for C-F**: Re-examine your segment patterns against the layout diagram
