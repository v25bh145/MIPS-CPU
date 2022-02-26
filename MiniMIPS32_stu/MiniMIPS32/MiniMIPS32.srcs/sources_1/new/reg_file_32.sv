`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/02 10:06:47
// Design Name: 
// Module Name: reg_file_32
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
module reg_file_32(
    input logic [4 : 0] A1,
    input logic [4 : 0] A2,
    input logic [4 : 0] A3,
    input logic [31 : 0] WD3,
//    input logic [31 : 0] R3,// unknown
    input logic cpu_clk,
    input logic cpu_rst_n,
    input logic WE3,
    output logic [31 : 0] RD1,
    output logic [31 : 0] RD2
    );
    
    logic [31 : 0] i;
    logic [31 : 0] regs_32_32 [31 : 0];
    
    always_comb begin
        RD1 = regs_32_32[A1];
        RD2 <= regs_32_32[A2];
    end
    
    always_ff @(posedge cpu_clk, posedge cpu_rst_n) begin
        if(!cpu_rst_n) begin
            for(i = 0; i < 31; i = i + 1) begin
                regs_32_32[i] <= 32'd0;
            end
        end else if(cpu_clk) begin
            if(WE3) begin
                regs_32_32[A3] = WD3;
            end
        end
    end
    
endmodule
