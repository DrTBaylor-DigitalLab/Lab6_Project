// hex_disp_top.v - Top-Level Hexadecimal Display Module
// Lab 6: Hexadecimal Display System
//
// Hardware wrapper connecting switches and buttons to the 7-segment display.
// Splits the 16-bit switch input into four hex digits, uses button presses
// to select which digit to display, and drives the segment and anode outputs.
//
// Submodules:
//   1. disp_mux    - Selects digit based on button input
//   2. hex_to_7seg - Converts selected hex digit to segment pattern
//
// Refer to the RTL diagram in Assets/ for signal flow.

module hex_disp_top(
    input  [15:0] sw,           // 16-bit switch input (4 hex digits)
    input         btnL,         // Left button   -> d3 (sw[15:12])
    input         btnU,         // Up button     -> d2 (sw[11:8])
    input         btnR,         // Right button  -> d1 (sw[7:4])
    input         btnD,         // Down button   -> d0 (sw[3:0])
    output [6:0]  seg,          // 7-segment cathodes (active-low)
    output [3:0]  an            // 7-segment anodes (active-low)
);

    // TODO #1: Declare internal wires
    //   - wire [3:0] d0, d1, d2, d3;  // Four hex digits from switches
    //   - wire [3:0] btn;             // Button selection vector
    //   - wire [3:0] digit;           // Selected digit from mux

    // TODO #2: Extract 4-bit digits from the 16-bit switch input
    //   assign d0 = sw[3:0];      // Rightmost digit
    //   assign d1 = sw[7:4];      // Second digit
    //   assign d2 = sw[11:8];     // Third digit
    //   assign d3 = sw[15:12];    // Leftmost digit

    // TODO #3: Create the button selection vector
    //   assign btn = {btnL, btnU, btnR, btnD};

    // TODO #4: Instantiate the disp_mux module
    //   disp_mux mux (
    //       .d0(d0), .d1(d1), .d2(d2), .d3(d3),
    //       .btn(btn), .digit(digit), .an(an)
    //   );

    // TODO #5: Instantiate the hex_to_7seg module
    //   hex_to_7seg dec (
    //       .hex(digit), .seg(seg)
    //   );

endmodule
