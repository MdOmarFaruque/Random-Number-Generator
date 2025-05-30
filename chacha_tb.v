`timescale 1ns / 1ps

module chacha_tb();

    // Inputs
    reg clk;
    reg rst;
    reg [255:0] key;
    reg valid;
    
    // Outputs
    wire done;
    wire [511:0] out;
    
    // Instantiate the ChaCha module
    chacha uut (
        .clk(clk),
        .rst(rst),
        .key(key),
        .valid(valid),
        .intr(done),
        .out(out)
    );
    
    // Clock generation (100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // Main test sequence
    initial begin
        // Initialize inputs
        rst = 1;
        valid = 0;
        
        
        // Start simulation
        $display("=== Simulation Start ===");
        $display("Time\tState\tDone\tOutput");
        
        // Reset and start
        #20 rst = 0;
        key = 256'h00000001_00000001_00000001_00000001_00000001_00000001_00000001_00000001;
        valid = 1;
        
       
        
        // Wait for completion
        wait(done == 1);
        // Print final output
                $display("\n=== Final Output ===");
                $display("out[ 0] = 0x%08h", out[31:0]);
                $display("out[ 1] = 0x%08h", out[63:32]);
                $display("out[ 2] = 0x%08h", out[95:64]);
                $display("out[ 3] = 0x%08h", out[127:96]);
                $display("out[ 4] = 0x%08h", out[159:128]);
                $display("out[ 5] = 0x%08h", out[191:160]);
                $display("out[ 6] = 0x%08h", out[223:192]);
                $display("out[ 7] = 0x%08h", out[255:224]);
                $display("out[ 8] = 0x%08h", out[287:256]);
                $display("out[ 9] = 0x%08h", out[319:288]);
                $display("out[10] = 0x%08h", out[351:320]);
                $display("out[11] = 0x%08h", out[383:352]);
                $display("out[12] = 0x%08h", out[415:384]);
                $display("out[13] = 0x%08h", out[447:416]);
                $display("out[14] = 0x%08h", out[479:448]);
                $display("out[15] = 0x%08h", out[511:480]);
        valid =0;
        #1;
        // Print final output
                $display("\n=== Final Output ===");
                $display("out[ 0] = 0x%08h", out[31:0]);
                $display("out[ 1] = 0x%08h", out[63:32]);
                $display("out[ 2] = 0x%08h", out[95:64]);
                $display("out[ 3] = 0x%08h", out[127:96]);
                $display("out[ 4] = 0x%08h", out[159:128]);
                $display("out[ 5] = 0x%08h", out[191:160]);
                $display("out[ 6] = 0x%08h", out[223:192]);
                $display("out[ 7] = 0x%08h", out[255:224]);
                $display("out[ 8] = 0x%08h", out[287:256]);
                $display("out[ 9] = 0x%08h", out[319:288]);
                $display("out[10] = 0x%08h", out[351:320]);
                $display("out[11] = 0x%08h", out[383:352]);
                $display("out[12] = 0x%08h", out[415:384]);
                $display("out[13] = 0x%08h", out[447:416]);
                $display("out[14] = 0x%08h", out[479:448]);
                $display("out[15] = 0x%08h", out[511:480]);
        
        
        
        $display("\n=== Simulation Complete ===");
        $stop;
    end
    
    // Monitor important signals
    always @(posedge clk) begin
        $display("%4t ns\t%d\t%d\t%x", $time, uut.state, done, out[31:0]);
    end

endmodule