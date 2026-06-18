`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2026 12:46:29
// Design Name: 
// Module Name: uart_tx
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


module uart_tx(input clk,reset,tx_start,input [7:0] tx_data,output reg tx,tx_busy,output reg[7:0] shift_reg,output [1:0] state_out);

        reg [2:0] bit_count;
        
        reg [1:0] state,next_state;
        
        parameter IDLE=2'b00,START=2'b01,DATA=2'b10,STOP=2'b11;
        
        always @(posedge clk or posedge reset)begin
            if(reset) begin
                state<=IDLE;
                tx<=1;
                tx_busy<=0;
                shift_reg<=0;
                bit_count<=0; end
            else begin state<=next_state;   
                   if(state==START)begin
                        tx<=0;
                        tx_busy<=1;
                        shift_reg<=tx_data;
                        bit_count<=0; end
                    else if(state==DATA) begin
                        tx<=shift_reg[0];
                        tx_busy<=1;
                        shift_reg<=shift_reg>>1;
                        bit_count<=bit_count+1; end
                    else if(state==STOP)begin
                        tx<=1;
                        tx_busy<=1;
                        bit_count<=0;
                    end
                    else begin
                        tx<=1;
                        tx_busy<=0;
                        bit_count<=0; end
         end
         end
         
         always @(*)begin
            case(state)
                IDLE:begin if (tx_start) next_state=START; else next_state=IDLE; end
                START:next_state=DATA;
                DATA:begin if(bit_count==7) next_state=STOP;
                           else next_state=DATA; end
                STOP:next_state=IDLE; 
                default: next_state=IDLE;endcase
                end
                
         assign state_out=state;
                          
            
endmodule
