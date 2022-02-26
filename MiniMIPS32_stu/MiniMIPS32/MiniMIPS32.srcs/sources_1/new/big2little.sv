`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/04 13:46:43
// Design Name: 
// Module Name: big2little
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


module big2little (
    input logic [31 : 0] big,
    output logic [31 : 0] little
    );
    
    assign little[7 : 0] = big[31 : 24];
    assign little[15 : 8] = big[23 : 16];
    assign little[23 : 16] = big[15 : 8];
    assign little[31 : 24] = big[7 : 0];
    
endmodule
