`timescale 1ns / 1ps

// �����Լ���ALU�޷���չ��32λ�����ʹ�õ���ͬѧд��ALU
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
