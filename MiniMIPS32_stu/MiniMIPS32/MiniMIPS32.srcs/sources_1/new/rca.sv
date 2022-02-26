`timescale 1ns / 1ps
// 由于自己的ALU无法扩展至32位，因此使用的是同学写的ALU
module rca #(parameter N = 4)(
    input logic [N-1:0]In1,
    input logic [N-1:0]In2,
    input logic Cin,
    output logic Cout,
    output logic [N-1:0]S
    );
    logic [N:0]Cout_n;
    //initial Cout_n[0]=Cin;
    fulladder fa0(In1[0], In2[0], Cin, Cout_n[1], S[0]);
    genvar i;
    generate
    //for(i=0;i<N;i= i+1) begin
    for(i=1;i<N;i= i+1) begin
        fulladder fa(In1[i], In2[i], Cout_n[i], Cout_n[i+1], S[i]);
        end
    endgenerate
    assign Cout = Cout_n[N];
endmodule
