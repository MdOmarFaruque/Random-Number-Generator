module QR1 (
    input [31:0] a_in, b_in, c_in, d_in,
    output [31:0] a_out, b_out, c_out, d_out
);

    // Internal signals for each step
    wire [31:0] step1_a, step1_d;
    wire [31:0] step2_c, step2_b;
    wire [31:0] step3_a, step3_d;
    wire [31:0] step4_c, step4_b;

    // Rotate left function
    function [31:0] rotl;
        input [31:0] val;
        input [4:0]  shift;
        begin
            rotl = (val << shift) | (val >> (32 - shift));
        end
    endfunction

    // QR Step 1: a += b, d ^= a, d = ROTL(d, 16)
    assign step1_a = a_in + b_in;
    assign step1_d = rotl(d_in ^ step1_a, 16);

    // QR Step 2: c += d, b ^= c, b = ROTL(b, 12)
    assign step2_c = c_in + step1_d;
    assign step2_b = rotl(b_in ^ step2_c, 12);

    // QR Step 3: a += b, d ^= a, d = ROTL(d, 8)
    assign step3_a = step1_a + step2_b;
    assign step3_d = rotl(step1_d ^ step3_a, 8);

    // QR Step 4: c += d, b ^= c, b = ROTL(b, 7)
    assign step4_c = step2_c + step3_d;
    assign step4_b = rotl(step2_b ^ step4_c, 7);

    // Final outputs
    assign a_out = step3_a;
    assign b_out = step4_b;
    assign c_out = step4_c;
    assign d_out = step3_d;

endmodule
