`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2025 04:39:44 PM
// Design Name: 
// Module Name: chacha
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module chacha(
 input clk,
 input rst,
 input wire [255:0] key,
 input valid,
 output done,
 output wire [511:0] out
    );
    
    reg [31:0] x [15:0];
    reg initiate;
    reg [63:0] count_out;
    reg valid1; 
    reg [3:0] state;
    localparam IDLE = 4'd0,
               st1 = 4'd1,
               st2 = 4'd2,
               st3 = 4'd3,
               st4 = 4'd4,
               st5 = 4'd5,
               st6 = 4'd6,
               st7 = 4'd7,
               st8 = 4'd8,
               st9 = 4'd9,
               st10 = 4'd10,
               st11 =4'd11,
               st12 =4'd12,
               st13 =4'd13,
               st14 =4'd14,
               st15 =4'd15;
    
    
    always @(posedge clk) begin
        if (rst) begin
          x[0]<= 32'h494D5041 ;
          x[1]<= 32'h43544B59;
          x[2]<= 32'h4C454F4D;
          x[3]<= 32'h41523235;
          x[4]<= 32'h0;
          x[5]<= 32'h0;
          x[6] <= 32'h0;
          x[7]<= 32'h0;
          x[8]<= 32'h0;
          x[9] <= 32'h0;
          x[10]<= 32'h0;
          x[11]<= 32'h0;
          x[12] <= 32'h0;
          x[13]<= 32'h0;
          x[14]<= 32'h0;
          x[15] <= 32'h0;
          initiate <= 1'b0;
          valid1 <= valid;
        end 
        else  begin
            if(valid1) begin 
            
            case(state)
               IDLE: begin
              
                    x[0]<= 32'h494D5041 ;
                    x[1]<= 32'h43544B59;
                    x[2]<= 32'h4C454F4D;
                    x[3]<= 32'h41523235;
                    x[4]<= key[31:0];
                    x[5]<= key[63:32];
                    x[6] <= key[95:64];
                    x[7]<= key[127:96];
                    x[8]<= key[159:128];
                    x[9] <= key[191:160];
                    x[10]<= key[223:192];
                    x[11]<= key[255:224];
                    x[12] <= count_out[31:0];
                    x[13]<= count_out[63:32];
                    x[14]<= 32'h494D5041;
                    x[15] <= 32'h43544B59;
                    valid1<= 1'b1;
                    state <= st1;
             end
              st1: begin
             
                   x[0]<= 32'h494D5041 ;
                   x[1]<= 32'h43544B59;
                   x[2]<= 32'h4C454F4D;
                   x[3]<= 32'h41523235;
                   x[4]<= key[31:0];
                   x[5]<= key[63:32];
                   x[6] <= key[95:64];
                   x[7]<= key[127:96];
                   x[8]<= key[159:128];
                   x[9] <= key[191:160];
                   x[10]<= key[223:192];
                   x[11]<= key[255:224];
                   x[12] <= count_out[31:0];
                   x[13]<= count_out[63:32];
                   x[14]<= 32'h494D5041;
                   x[15] <= 32'h43544B59;
                   valid1<= 1'b1;
                   state <= st1;
            end
        endcase
     end
     
    
    generate
         if(initiate) begin
            
            
         end
    endgenerate

endmodule
