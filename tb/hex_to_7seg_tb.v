//============================================================================
// Testbench: Hex-to-7-Segment Decoder
//
// Self-checking testbench that verifies all 16 hex-to-segment mappings.
// Uses a golden model function to compute expected outputs.
//============================================================================

`timescale 1ns/1ps

module hex_to_7seg_tb;

    //------------------------------------------------------------------------
    // Signal Declarations
    //------------------------------------------------------------------------
    reg  [3:0] hex;
    wire [6:0] seg;
    wire [6:0] expected_seg;

    // Error tracking
    integer error_count;
    integer i;

    //------------------------------------------------------------------------
    // Unit Under Test (UUT)
    //------------------------------------------------------------------------
    hex_to_7seg UUT (
        .hex(hex),
        .seg(seg)
    );

    //------------------------------------------------------------------------
    // Golden Model
    //------------------------------------------------------------------------
    function [6:0] golden_seg;
        input [3:0] h;
        begin
            case (h)
                4'h0: golden_seg = 7'b1000000;
                4'h1: golden_seg = 7'b1111001;
                4'h2: golden_seg = 7'b0100100;
                4'h3: golden_seg = 7'b0110000;
                4'h4: golden_seg = 7'b0011001;
                4'h5: golden_seg = 7'b0010010;
                4'h6: golden_seg = 7'b0000010;
                4'h7: golden_seg = 7'b1111000;
                4'h8: golden_seg = 7'b0000000;
                4'h9: golden_seg = 7'b0010000;
                4'hA: golden_seg = 7'b0001000;
                4'hB: golden_seg = 7'b0000011;
                4'hC: golden_seg = 7'b1000110;
                4'hD: golden_seg = 7'b0100001;
                4'hE: golden_seg = 7'b0000110;
                4'hF: golden_seg = 7'b0001110;
                default: golden_seg = 7'b1111111;
            endcase
        end
    endfunction

    //------------------------------------------------------------------------
    // Test Stimulus
    //------------------------------------------------------------------------
    initial begin
        error_count = 0;

        $display("================================================");
        $display("Hex-to-7-Segment Decoder Testbench");
        $display("================================================");
        $display(" Hex | seg     | Expected | Status");
        $display("-----+---------+----------+-------");

        // Test all 16 hex values
        for (i = 0; i < 16; i = i + 1) begin
            hex = i[3:0];
            #10;
            if (seg !== golden_seg(hex)) begin
                $display("  %h  | %b | %b | FAIL", hex, seg, golden_seg(hex));
                error_count = error_count + 1;
            end else begin
                $display("  %h  | %b | %b | ok", hex, seg, golden_seg(hex));
            end
        end

        // Results
        $display("================================================");
        if (error_count == 0) begin
            $display("TEST PASSED - All 16 hex values correct!");
        end else begin
            $display("TEST FAILED - %0d errors found", error_count);
        end
        $display("================================================");

        if (error_count == 0)
            $finish(0);
        else
            $finish(1);
    end

endmodule
