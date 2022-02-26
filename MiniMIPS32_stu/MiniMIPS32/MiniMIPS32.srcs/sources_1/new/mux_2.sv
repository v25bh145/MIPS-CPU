`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/02 10:06:47
// Design Name: 
// Module Name: mux_2
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


module mux_2 #(parameter N = 15)( 
    input logic [N - 1 : 0] A,
    input logic [N - 1 : 0] B,
    input logic S,
    output logic [N - 1 : 0] C
    );
    always_comb begin
        if(S == 0)  
            C = A;
        else
            C = B;
    end
endmodule
