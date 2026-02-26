// disp_mux.v - 4-Digit Display Multiplexer
// Lab 6: Hexadecimal Display System
//
// Selects which 4-bit digit to display based on button input.
// Uses one-hot button encoding to choose among four digit inputs
// and enable the corresponding anode (active-low).
//
// Button Mapping:
//   btn[0] (btnD) -> d0 (rightmost)  -> an = 4'b1110
//   btn[1] (btnR) -> d1 (second)     -> an = 4'b1101
//   btn[2] (btnU) -> d2 (third)      -> an = 4'b1011
//   btn[3] (btnL) -> d3 (leftmost)   -> an = 4'b0111
//
// Anode encoding: an[3:0] = {leftmost, third, second, rightmost}
// Active-low: 0 = display ON, 1 = display OFF

module disp_mux(
    input      [3:0] d0,        // Rightmost digit
    input      [3:0] d1,        // Second digit
    input      [3:0] d2,        // Third digit
    input      [3:0] d3,        // Leftmost digit
    input      [3:0] btn,       // Button selection (one-hot encoded)
    output reg [3:0] digit,     // Selected digit output
    output reg [3:0] an         // Anode control (active-low)
);

    always @(*) begin
        case (btn)
            4'b0001: begin  // btnD pressed - select d0
                digit = d0;
                an = 4'b1110;  // Enable rightmost display
            end

            4'b0010: begin  // btnR pressed - select d1
                digit = d1;
                an = 4'b1101;  // Enable second display
            end

            // TODO: Complete the remaining two button cases
            // Follow the pattern above for btnU and btnL:
            //
            // 4'b0100: btnU pressed - select d2, enable third display
            // 4'b1000: btnL pressed - select d3, enable leftmost display

            default: begin  // No button or multiple buttons
                digit = 4'h0;
                an = 4'b1111;  // All displays off
            end
        endcase
    end

endmodule
