`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2026 13:53:31
// Design Name: 
// Module Name: tb_uart_tx
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


module tb_uart_tx(

    );
    reg clk,reset,tx_start;
    reg [7:0] tx_data;
    wire [7:0]shift_reg;
    wire tx,tx_busy;
    wire [1:0] state_out;
    
    uart_tx dut(clk,reset,tx_start,tx_data,tx,tx_busy,shift_reg,state_out);
    
    initial begin 
        clk=0;
        reset=1;
        tx_start=0;
        tx_data=0; end 
        
        always #10 clk=~clk;
        
    initial begin
        #15 reset=0;
        #10 tx_start=1;
            tx_data=8'h41;
        #20 tx_start=0;
         #300;
         $finish; end
         
         initial $monitor(
"t=%0t clk=%b reset=%b tx_start=%b tx_data=%b tx=%b tx_busy=%b shift_reg=%b state_out=%b",
$time,clk,reset,tx_start,tx_data,tx,tx_busy,shift_reg,state_out);
        
        
        
endmodule
