// hex_to_7seg.v - Hexadecimal to 7-Segment Decoder
// Lab 6: Hexadecimal Display System
//
// Converts a 4-bit hex value to active-low 7-segment display signals.
//
// 7-segment display layout:
//       a
//     f   b
//       g
//     e   c
//       d
//
// Segment encoding: seg = {g, f, e, d, c, b, a}
// Active-low: 0 = segment ON, 1 = segment OFF
//
// Provided values (hex 0-B):
//   0: 1000000   1: 1111001   2: 0100100   3: 0110000
//   4: 0011001   5: 0010010   6: 0000010   7: 1111000
//   8: 0000000   9: 0010000   A: 0001000   B: 0000011

module hex_to_7seg(
    input      [3:0] hex,     // 4-bit hexadecimal input (0-F)
    output reg [6:0] seg      // 7-segment output (active-low)
);

    always @(*) begin
        case (hex)
            4'h0: seg = 7'b1000000;
            4'h1: seg = 7'b1111001;
            4'h2: seg = 7'b0100100;
            4'h3: seg = 7'b0110000;
            4'h4: seg = 7'b0011001;
            4'h5: seg = 7'b0010010;
            4'h6: seg = 7'b0000010;
            4'h7: seg = 7'b1111000;
            4'h8: seg = 7'b0000000;
            4'h9: seg = 7'b0010000;
            4'hA: seg = 7'b0001000;
            4'hB: seg = 7'b0000011;

            // TODO: Complete the case statement for hex digits C-F
            // Use the segment layout diagram above to determine the correct patterns.
            // Remember: Active-low encoding (0 = segment ON, 1 = segment OFF)
            // Segment order: {g, f, e, d, c, b, a}
            //
            // 4'hC: seg = 7'b???????;  // Display 'C'
            // 4'hD: seg = 7'b???????;  // Display 'd'
            // 4'hE: seg = 7'b???????;  // Display 'E'
            // 4'hF: seg = 7'b???????;  // Display 'F'

            default: seg = 7'b1111111; // All segments off
        endcase
    end

endmodule
