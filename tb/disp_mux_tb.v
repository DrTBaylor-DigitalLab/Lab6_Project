//============================================================================
// Testbench: Display Multiplexer
//
// Self-checking testbench that verifies all button selections:
//   1. btnD selects d0, enables rightmost display
//   2. btnR selects d1, enables second display
//   3. btnU selects d2, enables third display
//   4. btnL selects d3, enables leftmost display
//   5. No button: all displays off
//============================================================================

`timescale 1ns/1ps

module disp_mux_tb;

    //------------------------------------------------------------------------
    // Signal Declarations
    //------------------------------------------------------------------------
    reg  [3:0] d0, d1, d2, d3;
    reg  [3:0] btn;
    wire [3:0] digit;
    wire [3:0] an;

    // Expected outputs
    reg [3:0] expected_digit;
    reg [3:0] expected_an;

    // Error tracking
    integer error_count;

    //------------------------------------------------------------------------
    // Unit Under Test (UUT)
    //------------------------------------------------------------------------
    disp_mux UUT (
        .d0(d0),
        .d1(d1),
        .d2(d2),
        .d3(d3),
        .btn(btn),
        .digit(digit),
        .an(an)
    );

    //------------------------------------------------------------------------
    // Test Stimulus
    //------------------------------------------------------------------------
    initial begin
        error_count = 0;

        // Set distinct test values for each digit
        d0 = 4'h1;
        d1 = 4'h2;
        d2 = 4'h3;
        d3 = 4'h4;
        btn = 4'b0000;

        $display("================================================");
        $display("Display Multiplexer Testbench");
        $display("================================================");
        $display("  d0=%h  d1=%h  d2=%h  d3=%h", d0, d1, d2, d3);
        $display("================================================");
        $display(" Button | digit | an   | Exp digit | Exp an | Status");
        $display("--------+-------+------+-----------+--------+-------");

        // Test btnD -> d0
        btn = 4'b0001; expected_digit = d0; expected_an = 4'b1110;
        #10; check_output("btnD");

        // Test btnR -> d1
        btn = 4'b0010; expected_digit = d1; expected_an = 4'b1101;
        #10; check_output("btnR");

        // Test btnU -> d2
        btn = 4'b0100; expected_digit = d2; expected_an = 4'b1011;
        #10; check_output("btnU");

        // Test btnL -> d3
        btn = 4'b1000; expected_digit = d3; expected_an = 4'b0111;
        #10; check_output("btnL");

        // Test no button
        btn = 4'b0000; expected_digit = 4'h0; expected_an = 4'b1111;
        #10; check_output("none");

        // Results
        $display("================================================");
        if (error_count == 0) begin
            $display("TEST PASSED - All 5 button states correct!");
        end else begin
            $display("TEST FAILED - %0d errors found", error_count);
        end
        $display("================================================");

        if (error_count == 0)
            $finish(0);
        else
            $finish(1);
    end

    //------------------------------------------------------------------------
    // Output Checking Task
    //------------------------------------------------------------------------
    task check_output;
        input [4*8:1] btn_name;
        begin
            if (digit !== expected_digit || an !== expected_an) begin
                $display(" %0s   |   %h   | %b |     %h     | %b | FAIL",
                         btn_name, digit, an, expected_digit, expected_an);
                error_count = error_count + 1;
            end else begin
                $display(" %0s   |   %h   | %b |     %h     | %b | ok",
                         btn_name, digit, an, expected_digit, expected_an);
            end
        end
    endtask

endmodule
