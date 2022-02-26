`timescale 1ns / 1ps

// 由于自己的ALU无法扩展至32位，因此使用的是同学写的ALU
module fulladder(
    input logic A,
    input logic B,
    input logic Cin,
    output logic Cout,
    output logic S
    );
    assign Cout = (A & B) | (A & Cin) | (B & Cin);
    assign S = (~A&B | A&~B)&~Cin | ~(~A&B | A&~B) & Cin;
endmodule
