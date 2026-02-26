//============================================================================
// Testbench: Hex Display Top-Level (Integration Test)
//
// YOUR TASK: Complete the 3 sections marked with TODO
//
// This testbench verifies the complete hex display system by setting
// switch values and pressing buttons to check that the correct segment
// patterns and anode enables appear.
//
// HINT: Study the provided testbenches (hex_to_7seg_tb.v, disp_mux_tb.v)
//       for examples of signal declaration and module instantiation.
//============================================================================

`timescale 1ns/1ps

module hex_disp_top_tb;

    //------------------------------------------------------------------------
    // TODO #1: Signal Declarations
    //
    // Declare the testbench signals to connect to the UUT:
    //   - reg [15:0] sw;              (inputs are reg in testbenches)
    //   - reg btnL, btnU, btnR, btnD;
    //   - wire [6:0] seg;             (outputs are wire in testbenches)
    //   - wire [3:0] an;
    //------------------------------------------------------------------------
    // YOUR CODE HERE:



    // Error tracking (do not modify)
    integer error_count;

    //------------------------------------------------------------------------
    // TODO #2: Module Instantiation
    //
    // Instantiate hex_disp_top as 'UUT' and connect all ports:
    //   hex_disp_top UUT (
    //       .sw(sw), .btnL(btnL), .btnU(btnU),
    //       .btnR(btnR), .btnD(btnD), .seg(seg), .an(an)
    //   );
    //------------------------------------------------------------------------
    // YOUR CODE HERE:



    //------------------------------------------------------------------------
    // Expected Segment Lookup (do not modify)
    //------------------------------------------------------------------------
    function [6:0] expected_seg;
        input [3:0] hex;
        begin
            case (hex)
                4'h0: expected_seg = 7'b1000000;
                4'h1: expected_seg = 7'b1111001;
                4'h2: expected_seg = 7'b0100100;
                4'h3: expected_seg = 7'b0110000;
                4'h4: expected_seg = 7'b0011001;
                4'h5: expected_seg = 7'b0010010;
                4'h6: expected_seg = 7'b0000010;
                4'h7: expected_seg = 7'b1111000;
                4'h8: expected_seg = 7'b0000000;
                4'h9: expected_seg = 7'b0010000;
                4'hA: expected_seg = 7'b0001000;
                4'hB: expected_seg = 7'b0000011;
                4'hC: expected_seg = 7'b1000110;
                4'hD: expected_seg = 7'b0100001;
                4'hE: expected_seg = 7'b0000110;
                4'hF: expected_seg = 7'b0001110;
                default: expected_seg = 7'b1111111;
            endcase
        end
    endfunction

    //------------------------------------------------------------------------
    // Test Stimulus
    //------------------------------------------------------------------------
    initial begin
        error_count = 0;

        // Initialize all inputs to 0
        sw = 16'h0000;
        btnL = 0; btnU = 0; btnR = 0; btnD = 0;
        #10;

        $display("========================================================");
        $display("Hex Display Top Integration Testbench");
        $display("========================================================");

        //--------------------------------------------------------------------
        // TODO #3: Write Test Cases
        //
        // Test the system with at least two different switch values.
        // For each switch value, press each button and verify the outputs.
        //
        // Example pattern for sw = 16'h1234:
        //   sw = 16'h1234;
        //   #10;
        //   btnD = 1; #10;  // Should display digit '4' (sw[3:0])
        //   check_button("btnD", sw[3:0], 4'b1110);
        //   btnD = 0; #10;
        //
        //   btnR = 1; #10;  // Should display digit '3' (sw[7:4])
        //   check_button("btnR", sw[7:4], 4'b1101);
        //   btnR = 0; #10;
        //
        //   btnU = 1; #10;  // Should display digit '2' (sw[11:8])
        //   check_button("btnU", sw[11:8], 4'b1011);
        //   btnU = 0; #10;
        //
        //   btnL = 1; #10;  // Should display digit '1' (sw[15:12])
        //   check_button("btnL", sw[15:12], 4'b0111);
        //   btnL = 0; #10;
        //
        // Add a second test with sw = 16'hABCD (or another value).
        //--------------------------------------------------------------------
        // YOUR CODE HERE:



        //--------------------------------------------------------------------
        // Results (do not modify below this line)
        //--------------------------------------------------------------------
        $display("========================================================");
        if (error_count == 0) begin
            $display("TEST PASSED - All checks correct!");
        end else begin
            $display("TEST FAILED - %0d errors found", error_count);
        end
        $display("========================================================");

        if (error_count == 0)
            $finish(0);
        else
            $finish(1);
    end

    //------------------------------------------------------------------------
    // Output Checking Task (do not modify)
    //------------------------------------------------------------------------
    task check_button;
        input [4*8:1] btn_name;
        input [3:0]   exp_hex;
        input [3:0]   exp_an;
        begin
            if (seg !== expected_seg(exp_hex) || an !== exp_an) begin
                $display("  %0s | seg=%b (exp %b) | an=%b (exp %b) | FAIL",
                         btn_name, seg, expected_seg(exp_hex), an, exp_an);
                error_count = error_count + 1;
            end else begin
                $display("  %0s | seg=%b | an=%b | ok",
                         btn_name, seg, an);
            end
        end
    endtask

endmodule
