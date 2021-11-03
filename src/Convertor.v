`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:50:56 10/12/2021 
// Design Name: 
// Module Name:    morse 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module convertor(
    input clk,
    input rst,
    input [7:0] ascii_in,

    output reg [7:0] morse_out,        // dot => 0 dash => 1
    output reg [2:0] morse_l           // number of characters in morse code
);
    integer i;
    reg [9:0] morse_table [0:127];

    initial begin
                                                                //For N/A refer to following link for potential method https://www.itu.int/dms_pubrec/itu-r/rec/m/R-REC-M.1677-1-200910-I!!PDF-E.pdf
        morse_table[32] =  {7'b0000000, 3'd0};   // SP
        morse_table[33] =  {7'b0101011, 3'd6};   // !
        morse_table[34] =  {7'b0010010, 3'd6};   // "

        morse_table[36] =  {7'b0001001, 3'd7};   // $

        morse_table[38] =  {7'b0001000, 3'd5};   // &

        morse_table[40] =  {7'b0010110, 3'd5};   // (
        morse_table[41] =  {7'b0101101, 3'd6};   // )

        morse_table[43] =  {7'b0001010, 3'd5};   // +
        morse_table[44] =  {7'b0110011, 3'd6};   // , 
        morse_table[45] =  {7'b0100001, 3'd6};   // -
        morse_table[46] =  {7'b0010101, 3'd6};   // .
        morse_table[47] =  {7'b0010010, 3'd5};   // /
        morse_table[48] =  {7'b0011111, 3'd5};   // 0
        morse_table[49] =  {7'b0001111, 3'd5};   // 1
        morse_table[50] =  {7'b0000111, 3'd5};   // 2
        morse_table[51] =  {7'b0000011, 3'd5};   // 3
        morse_table[52] =  {7'b0000001, 3'd5};   // 4
        morse_table[53] =  {7'b0000000, 3'd5};   // 5
        morse_table[54] =  {7'b0010000, 3'd5};   // 6
        morse_table[55] =  {7'b0011000, 3'd5};   // 7
        morse_table[56] =  {7'b0011100, 3'd5};   // 8
        morse_table[57] =  {7'b0011110, 3'd5};   // 9
        morse_table[58] =  {7'b0111000, 3'd6};   // :
        morse_table[59] =  {7'b0101010, 3'd6};   // ;

        morse_table[61] =  {7'b0010001, 3'd5};   // =

        morse_table[63] =  {7'b0001100, 3'd6};   // ?
        morse_table[64] =  {7'b0001100, 3'd6};   // @
        morse_table[65] =  {7'b0000001, 3'd2};   // A
        morse_table[66] =  {7'b0001000, 3'd4};   // B
        morse_table[67] =  {7'b0001010, 3'd4};   // C
        morse_table[68] =  {7'b0000100, 3'd3};   // D
        morse_table[69] =  {7'b0000000, 3'd1};   // E
        morse_table[70] =  {7'b0000010, 3'd4};   // F
        morse_table[71] =  {7'b0000110, 3'd3};   // G
        morse_table[72] =  {7'b0000000, 3'd4};   // H
        morse_table[73] =  {7'b0000000, 3'd2};   // I
        morse_table[74] =  {7'b0000111, 3'd4};   // J
        morse_table[75] =  {7'b0000101, 3'd3};   // K
        morse_table[76] =  {7'b0000100, 3'd4};   // L
        morse_table[77] =  {7'b0000011, 3'd2};   // M
        morse_table[78] =  {7'b0000010, 3'd2};   // N
        morse_table[79] =  {7'b0000111, 3'd3};   // O
        morse_table[80] =  {7'b0000110, 3'd4};   // P
        morse_table[81] =  {7'b0001101, 3'd4};   // Q
        morse_table[82] =  {7'b0000010, 3'd3};   // R
        morse_table[83] =  {7'b0000000, 3'd3};   // S
        morse_table[84] =  {7'b0000001, 3'd1};   // T
        morse_table[85] =  {7'b0000001, 3'd3};   // U
        morse_table[86] =  {7'b0000001, 3'd4};   // V
        morse_table[87] =  {7'b0000011, 3'd3};   // W
        morse_table[88] =  {7'b0001001, 3'd4};   // X
        morse_table[89] =  {7'b0001011, 3'd4};   // Y
        morse_table[90] =  {7'b0001100, 3'd4};   // Z

        morse_table[92] =  {7'b0010010, 3'd5};   // Foward Slash
 
        morse_table[95] =  {7'b0001101, 3'd6};   // Underscore


//        morse_table[37] =  {7'b0010010, 3'd6};   //  % N/A
//        morse_table[39] =  {7'b0001001, 3'd7};   // ' N/A
//        morse_table[42] =  {7'b0001001, 3'd7};   // * N/A 
//        morse_table[60] =  {7'b0000000, 3'd5};   // < N/A
//        morse_table[62] =  {7'b0000000, 3'd5};   // > N/A
//        morse_table[91] // ]
//        morse_table[93] //[
//        morse_table[94] //^
//        morse_table[96] // Grave
//        morse_table[123]  {
//        morse_table[124]  |
//        morse_table[125]  }
//        morse_table[126]  ~
//        morse_table[127]  DEL

     for (i = 96; i < 123; i = i + 1)
        begin
            morse_table[i] = morse_table[i - 32];
        end
        
        
    end


    always @(posedge clk) begin
        {morse_out, morse_l} <= morse_table[ascii_in];
    end
    
endmodule