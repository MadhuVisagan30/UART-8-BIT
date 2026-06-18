module uart_rx(input clk,reset,rx,output reg rx_done,output reg [7:0] rx_data,
               output reg [7:0] shift_reg,output [1:0] state_out);

        reg [2:0] bit_count;
        
        reg [1:0] state,next_state;
        
        parameter IDLE=2'b00,START=2'b01,DATA=2'b10,STOP=2'b11;
        
        always @(posedge clk or posedge reset)begin
            if(reset) begin
                state<=IDLE;
                rx_done<=0;
                rx_data<=0;
                shift_reg<=0;
                bit_count<=0; end
            else begin
                state<=next_state;
                
                if(state==START)begin
                    rx_done<=0;
                    bit_count<=0; end
                    
                else if(state==DATA) begin
                    shift_reg[bit_count]<=rx;
                    bit_count<=bit_count+1; end
                    
                else if(state==STOP)begin
                    rx_data<=shift_reg;
                    rx_done<=1;
                    bit_count<=0;
                end
                
                else begin
                    rx_done<=0;
                    bit_count<=0; end
            end
        end
         
        always @(*)begin
            case(state)
                IDLE:begin
                    if(rx==0) next_state=START;
                    else next_state=IDLE;
                end
                
                START:next_state=DATA;
                
                DATA:begin
                    if(bit_count==7) next_state=STOP;
                    else next_state=DATA;
                end
                
                STOP:next_state=IDLE;
                
                default:next_state=IDLE;
            endcase
        end
                
        assign state_out=state;
                          
endmodule