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
 output reg intr,
 output reg [511:0] out
    );
    
    reg [31:0] x [15:0];
    reg [31:0] initial_state [15:0];
    wire [31:0] qr_a_out1, qr_b_out1, qr_c_out1, qr_d_out1;
    reg [31:0] qr_a_in1, qr_b_in1, qr_c_in1, qr_d_in1;
  
    reg [31:0] qr_a_in2, qr_b_in2, qr_c_in2, qr_d_in2;
    wire [31:0] qr_a_out2, qr_b_out2, qr_c_out2, qr_d_out2;
    
    reg [31:0] qr_a_in3, qr_b_in3, qr_c_in3, qr_d_in3;
    wire [31:0] qr_a_out3, qr_b_out3, qr_c_out3, qr_d_out3;
    
    reg [31:0] qr_a_in4, qr_b_in4, qr_c_in4, qr_d_in4;
    wire [31:0] qr_a_out4, qr_b_out4, qr_c_out4, qr_d_out4;
        
   
    reg initiate;
    reg [63:0] count_out;
    
    reg valid1; 
    reg [3:0] state;
    integer count;
    integer i;
    
   
    localparam IDLE = 4'd0,
               st1 = 4'd1,
               st2 = 4'd2,
               st3 = 4'd3,
               st4 = 4'd4,
               DONE = 4'd5;
    
     QR1 qr_module1 (
                       .a_in(qr_a_in1),
                       .b_in(qr_b_in1),
                       .c_in(qr_c_in1),
                       .d_in(qr_d_in1),
                       .a_out(qr_a_out1),
                       .b_out(qr_b_out1),
                       .c_out(qr_c_out1),
                       .d_out(qr_d_out1)
                   );
                   
     QR2 qr_module2 (
                                         .a_in(qr_a_in2),
                                         .b_in(qr_b_in2),
                                         .c_in(qr_c_in2),
                                         .d_in(qr_d_in2),
                                         .a_out(qr_a_out2),
                                         .b_out(qr_b_out2),
                                         .c_out(qr_c_out2),
                                         .d_out(qr_d_out2)
                                     );
                                     
      QR3 qr_module3 (
                                                           .a_in(qr_a_in3),
                                                           .b_in(qr_b_in3),
                                                           .c_in(qr_c_in3),
                                                           .d_in(qr_d_in3),
                                                           .a_out(qr_a_out3),
                                                           .b_out(qr_b_out3),
                                                           .c_out(qr_c_out3),
                                                           .d_out(qr_d_out3)
                                                       );
       QR4 qr_module4 (
                                                                             .a_in(qr_a_in4),
                                                                             .b_in(qr_b_in4),
                                                                             .c_in(qr_c_in4),
                                                                             .d_in(qr_d_in4),
                                                                             .a_out(qr_a_out4),
                                                                             .b_out(qr_b_out4),
                                                                             .c_out(qr_c_out4),
                                                                             .d_out(qr_d_out4)
                                                                         );
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
          count_out<= 64'b0;
          
          out <= 512'b0;
          
          //states and variables
          count<=0;
          valid1 <= valid;
          state <= IDLE;
          intr<= 1'b0;
        end 
        else  begin
           
            
            case(state)
               IDLE: begin
                   intr <=0;
                    if(valid) begin 
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
                            
                             initial_state[0]<= 32'h494D5041 ;
                             initial_state[1]<= 32'h43544B59;
                             initial_state[2]<= 32'h4C454F4D;
                             initial_state[3]<= 32'h41523235;
                             initial_state[4]<= key[31:0];
                             initial_state[5]<= key[63:32];
                             initial_state[6] <= key[95:64];
                             initial_state[7]<= key[127:96];
                             initial_state[8]<= key[159:128];
                             initial_state[9] <= key[191:160];
                             initial_state[10]<= key[223:192];
                             initial_state[11]<= key[255:224];
                             initial_state[12] <= 32'b0;
                             initial_state[13]<= 32'b0;
                             initial_state[14]<= 32'h494D5041;
                             initial_state[15] <= 32'h43544B59;
                             
                             count <=0;
                             valid1 <= 1'b0;
                             state <= st1;
                             intr <=1'b0;
                            
                     end
             end
              st1: begin
             
                  qr_a_in1 <= x[0];
                  qr_b_in1 <= x[4];
                  qr_c_in1 <= x[8];
                  qr_d_in1 <= x[12];
                  
                  qr_a_in2 <= x[1];
                  qr_b_in2 <= x[5];
                  qr_c_in2 <= x[9];
                  qr_d_in2 <= x[13];
                  
                  qr_a_in3 <= x[2];
                  qr_b_in3 <= x[6];
                  qr_c_in3 <= x[10];
                  qr_d_in3 <= x[14];


                  qr_a_in4 <= x[3];
                  qr_b_in4 <= x[7];
                  qr_c_in4 <= x[11];
                  qr_d_in4 <= x[15];

                   valid1<= 1'b0;
                   state <= st2;
                   intr <=1'b0;
                  
            end
            
            st2: begin
                  x[0]<=qr_a_out1;
                  x[4]<=qr_b_out1;
                  x[8]<=qr_c_out1;
                  x[12]<=qr_d_out1;
                  
                   x[1]<=qr_a_out2;
                   x[5]<=qr_b_out2;
                   x[9]<=qr_c_out2;
                   x[13]<=qr_d_out2;
                    
                   x[2]<=qr_a_out3;
                    x[6]<=qr_b_out3;
                    x[10]<=qr_c_out3;
                    x[14]<=qr_d_out3;
                    
                     x[3]<=qr_a_out4;
                     x[7]<=qr_b_out4;
                     x[11]<=qr_c_out4;
                     x[15]<=qr_d_out4;
                     
                     valid1<= 1'b0;
                     state <= st3;
                     count= count+1;
                     intr <=1'b0;
               end
               st3:begin
                                                      
                      qr_a_in1 <= x[0];
                      qr_b_in1 <= x[5];
                      qr_c_in1 <= x[10];
                      qr_d_in1 <= x[15];
                      
                      qr_a_in2 <= x[1];
                      qr_b_in2 <= x[6];
                      qr_c_in2 <= x[11];
                      qr_d_in2 <= x[12];
                      
                      qr_a_in3 <= x[2];
                      qr_b_in3 <= x[7];
                      qr_c_in3 <= x[8];
                      qr_d_in3 <= x[13];
    
    
                      qr_a_in4 <= x[3];
                      qr_b_in4 <= x[4];
                      qr_c_in4 <= x[9];
                      qr_d_in4 <= x[14];
    
                       valid1<= 1'b0;
                       state <= st4;
                       intr <=1'b0;
                      
               end
             st4: begin
                       x[0]<=qr_a_out1;
                       x[5]<=qr_b_out1;
                       x[10]<=qr_c_out1;
                       x[15]<=qr_d_out1;
                       
                        x[1]<=qr_a_out2;
                        x[6]<=qr_b_out2;
                        x[11]<=qr_c_out2;
                        x[12]<=qr_d_out2;
                         
                        x[2]<=qr_a_out3;
                         x[7]<=qr_b_out3;
                         x[8]<=qr_c_out3;
                         x[13]<=qr_d_out3;
                         
                          x[3]<=qr_a_out4;
                          x[4]<=qr_b_out4;
                          x[9]<=qr_c_out4;
                          x[14]<=qr_d_out4;
                          
                          valid1<= 1'b0;
                          intr <=1'b0;
                          if (count<19) begin
                              state <= st1;
                              count= count+1;
                          end else begin
                              state <= DONE;
                          end
                end
                DONE:begin
                    for (i=0; i<16; i=i+1) begin
                       out[32*i +:32] <= x[i] + initial_state[i];
                    end
                    intr<= 1'b1;
                    valid1<= 1'b0;
                    state <= IDLE;
                end
        endcase
     end
    end 
    always @(posedge clk) begin
       if (rst) begin
          count_out <=64'b0;
         
       end else if(valid | !intr) begin
          count_out=count_out+64'b1;
          
          
       end
    end
endmodule
