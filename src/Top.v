module top(clk, leds, rst, uart_rx, uart_tx);
    input clk;
    input uart_rx;
    input rst;

    output reg [2:0] leds = 3'b111;
    output uart_tx;

    wire [7:0] rx_data;
    wire [7:0] data_out;
    wire [9:0] w_address;
    wire rx_ready;
    wire [2:0] morse_l;
    wire [7:0] morse_binary;

    reg tx_ready = 0;
    reg [9:0] r_address = 10'b0;
    reg [25:0] counter = 25'b0;
    reg [2:0] delay = 3'b0;                                             //
    reg [2:0] morse_index = 3'b1;                                       //need to initialize morse index at 1 otherwise the first morse code sequence will have dot on end
    reg [7:0] tx_debug = 8'd0;                                          //output to uart tx module

    reg [30:0] setup = {7'b1000000, 24'd2500};



    localparam PERIOD = 200;
    localparam CLK_DIVIDER = 24_000 * PERIOD;

    always @(posedge clk) begin
        tx_ready <= 0;

        if (counter == CLK_DIVIDER) begin
            if(delay > 3'd1) begin
                leds <= 3'b000;
            end
            else begin
                leds <= 3'b111;
            end
            if(delay > 0)
                delay = delay - 1;
            counter <= 0;
            tx_debug <= data_out;

          
            if (r_address != w_address && delay == 0) begin
                
                if (morse_binary[morse_l - morse_index] == 1) begin
                    delay = 3'd4;
                end
                else begin
                    delay = 3'd2;
                end
                
                if (morse_l == morse_index) begin
                    morse_index = 3'b0;
                    tx_ready <= 1;
                    r_address = r_address + 1;
                end

                morse_index = morse_index + 1;
                
                
            end



        end

        else begin
            counter <= counter + 1'b1;
        end

        if (!rst) begin
            leds <= 3'b111;
            r_address <= 7'b0;
            tx_ready <= 0;
            delay <= 0;
            counter <= 0;
            morse_index <= 3'b1;
        end
    end

        
    
    buffer b0(
        .i_clk(clk),
        .r_address(r_address),
        .o_data(data_out),
        .w_address(w_address),
        .i_data(rx_data),
        .i_ready(rx_ready),
        .i_rst(rst)
    );

    convertor c0(
        .clk(clk),
        .rst(rst),
        .ascii_in(data_out),
        .morse_out(morse_binary),
        .morse_l(morse_l)
    );

    rxuart rx0(
        .i_clk(clk),
        .i_reset(~rst),
        .i_setup(setup),
        .i_uart_rx(uart_rx),
        .o_wr(rx_ready),
        .o_data(rx_data)
    );

    txuart tx0(
        .i_clk(clk),
        .i_reset(~rst),
        .i_setup(setup),
        .i_break(1'b0),
        .i_wr(tx_ready),
        .i_data(tx_debug),
        .i_cts_n(1'b0),
        .o_uart_tx(uart_tx)
    );

endmodule
    



    