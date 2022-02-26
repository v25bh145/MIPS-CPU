`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/04 11:31:04
// Design Name: 
// Module Name: PC_trigger
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


module PC_trigger(
    input logic [31:0] PC_OLD,
    output logic [31:0] PC_NEW,
    input logic sys_clk,
    input logic sys_rst_n
    );
    always_ff @(posedge sys_clk, posedge sys_rst_n) begin
        if(!sys_rst_n) begin
            PC_NEW <= -4;
        end else begin
            PC_NEW <= PC_OLD;
        end
    end
endmodule
