`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/02 10:06:47
// Design Name: 
// Module Name: sign_extend_32
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


module sign_extend_32(
    input logic [15 : 0] imm,
    input logic ExtendType,
    output logic [31 : 0] signed_imm 
    );
    always_comb begin
        signed_imm[15 : 0] = imm;
        if(ExtendType == 0) begin
            if(imm[15] == 0) begin
                signed_imm[31 : 16] = 16'b0000_0000_0000_0000;
            end else begin
                signed_imm[31 : 16] = 16'b1111_1111_1111_1111;
            end
        end else begin
            signed_imm[31 : 16] = 16'b0000_0000_0000_0000;
        end
    end
endmodule
