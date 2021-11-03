module addresser(clk, rst, address_w,data_w, rx_ready, uart_rx);
    input wire clk;
    input wire rst;
    input wire rx_ready;
    input wire [7:0] uart_rx;
    output reg [7:0] data_w;
    output reg [9:0] address_w = 10'b0;


    always @(posedge clk)
        begin
            if(rx_ready == 1) begin
                if(address_w == 10'h3FF) begin                  // test for overflow
                    address_w <= 10'h0;                         // move address back to 0
                end
                data_w <= uart_rx;                              // save rx to memory
                address_w <= address_w + 1;                     // move to next address
            end

            if (rst == 1) begin
                address_w <= 0;
                data_w <= 0;
            end
    end

endmodule