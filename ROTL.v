module ROTL (
    input [31:0] a,
    input [4:0] b,       // Since 32-bit rotation, b only needs 5 bits (0-31)
    output [31:0] result
);
    assign result = (a << b) | (a >> (32 - b));
endmodule