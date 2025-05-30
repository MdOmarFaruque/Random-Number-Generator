module tb_chacha_qr;
    reg [31:0] a, b, c, d;
    wire [31:0] a_out, b_out, c_out, d_out;

    QR uut (
        .a_in(a),
        .b_in(b),
        .c_in(c),
        .d_in(d),
        .a_out(a_out),
        .b_out(b_out),
        .c_out(c_out),
        .d_out(d_out)
    );

    initial begin
        // Initialize with the same values as your C example
        a = 32'h11111111;
        b = 32'h01020304;
        c = 32'h9b8d6f43;
        d = 32'h00000007;

        #10;
        $display("Input:  a=0x%h, b=0x%h, c=0x%h, d=0x%h", a, b, c, d);
        $display("Output: a=0x%h, b=0x%h, c=0x%h, d=0x%h", a_out, b_out, c_out, d_out);
    end
endmodule