`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.06.2026
// Design Name: 
// Module Name: tb_uart_rx
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


module tb_uart_rx(

    );
    reg clk,reset,rx;
    wire rx_done;
    wire [7:0] rx_data;
    wire [7:0] shift_reg;
    wire [1:0] state_out;
    
    uart_rx dut(clk,reset,rx,rx_done,rx_data,shift_reg,state_out);
    
    initial begin 
        clk=0;
        reset=1;
        rx=1;
        end 
        
        always #10 clk=~clk;
        
    initial begin
        #15 reset=0;
        

        #20 rx=0;   // Start bit

#20;        // allow START -> DATA transition

#20 rx=1;   // bit0
#20 rx=0;   // bit1
#20 rx=0;   // bit2
#20 rx=0;   // bit3
#20 rx=0;   // bit4
#20 rx=0;   // bit5
#20 rx=1;   // bit6
#20 rx=0;   // bit7

#20 rx=1;   // Stop
        
        #200;
        $finish;
        end
         
         initial $monitor(
"t=%0t clk=%b reset=%b rx=%b rx_done=%b rx_data=%b shift_reg=%b state_out=%b",
$time,clk,reset,rx,rx_done,rx_data,shift_reg,state_out);
        
        
        
endmodule