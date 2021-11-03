module buffer (i_clk, i_ready, r_address, w_address, i_data, o_data, i_rst);
    input [7:0] i_data;
    input i_clk;
    input i_rst;
    input i_ready;
    input [9:0] r_address;
    
    output reg [9:0] w_address = 10'b0;
    output reg [7:0] o_data;
    
    reg [7:0] memory [0:1023];
   
    always @(posedge i_clk) begin

        o_data = memory[r_address];                         // output current data

        if (i_ready == 1) begin                                 // If data recieved
            memory[w_address] = i_data;                         // save data to memory
            w_address = w_address + 1'b1;                          // increment write address by one
        end
        if(!i_rst) begin
            w_address = 10'b0;
        end
    end
endmodule