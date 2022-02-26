`timescale 1ns / 1ps
// 由于自己的ALU无法扩展至32位，因此使用的是同学写的ALU
module alu #(parameter N=4)(
    input [N-1:0] A,
    input [N-1:0] B,
    input [3:0] aluop,
    output logic  [2*N-1:0] alures,
    output logic ZF,
    output logic OF
    );
    
    logic[2*N-1:0] EA;
    logic[2*N-1:0] EB;
    logic[N-1:0] ONES = {N{1'b1}};
    logic[N-1:0] ZEROS = 0;
    
    logic [N-1:0] A1;
    logic [N-1:0] B1;
    logic Cin1;
    logic Cout1;
    logic [N-1:0]S1;
    
     logic [N-1:0] A2;
     logic [N-1:0] B2;
     logic Cin2;
     logic Cout2;
     logic [N-1:0]S2;
    
    rca#(N) rcadder1(A1,B1,Cin1,Cout1,S1);
     rca#(N) rcadder2(A2,B2,Cin2,Cout2,S2);
    
    always @(*) begin
        case(aluop)
            4'b0000:begin alures[N-1:0]=A & B; alures[2*N-1:N]=ZEROS; OF = 0; end //AND
            4'b0001:begin alures[N-1:0]=A | B; alures[2*N-1:N]=ZEROS; OF = 0; end //OR
            4'b0010:begin alures[N-1:0]=A ^ B; alures[2*N-1:N]=ZEROS; OF = 0; end //XOR
            4'b0011:begin alures[N-1:0]=~(A & B); alures[2*N-1:N]=ZEROS; OF = 0; end //NAND
            4'b0100:begin alures[N-1:0]=~A; alures[2*N-1:N]=ZEROS; OF = 0; end //NOT
            4'b0101:begin alures[N-1:0]=A<<B[N-2:0];alures[2*N-1:N]=ZEROS; OF = 0;end //SSL
            4'b0110:begin alures[N-1:0]=A>>B[N-2:0];alures[2*N-1:N]=ZEROS;OF = 0; end //RSL
            4'b0111:begin alures[N-1:0]=$signed(A)>>> B[N-2:0]; alures[2*N-1:N]=ZEROS;OF = 0;end //SRA
            4'b1000:begin alures[2*N-1:0] = A*B;OF = 0;end //MULU
            4'b1001:begin 
                    EA[N-1:0] = A;EB[N-1:0]=B;
                    if (A[N-1]==1)
                        EA[2*N-1:N] = ONES;
                    else
                        EA[2*N-1:N] = ZEROS;
                    if(B[N-1]==1)
                        EB[2*N-1:N] = ONES;
                    else
                        EB[2*N-1:N]=ZEROS;
                   alures[2*N-1:0]=$signed(EA)*$signed(EB);    OF = 0;               
            end //MUL
            4'b1010:begin
                 A1=A;B1=B;Cin1=0;alures[N-1:0]=S1;alures[2*N-1:N]=ZEROS;
                 if(A[N-1]==1&&B[N-1]==1&&alures[N-1]==0 || A[N-1]==0&&B[N-1]==0&&alures[N-1]==1)
                    OF=1;
                 else
                    OF=0;               
            end //ADD
            4'b1011:begin A1=A;B1=B;Cin1=0;alures[N-1:0]=S1;alures[2*N-1:N]=ZEROS; OF = 0;end //ADDU
            4'b1100:begin A1=A;B1=~B;Cin1=1;alures[N-1:0]=S1;alures[2*N-1:N]=ZEROS;
                if(A[N-1]==1&&B[N-1]==0&&S1[N-1]==0 || A[N-1]==0&&B[N-1]==1&&S1[N-1]==1)
                    OF=1;
               else
                    OF=0;  
            end //SUB
            4'b1101:begin A1=A;B1=~B;Cin1=1;alures[N-1:0]=S1;alures[2*N-1:N]=ZEROS;OF = 0; end //SUBU
            4'b1110:begin 
                A1=A;B1=~B;Cin1=1;
                if(A[N-1]==1&&B[N-1]==0&&S1[N-1]==0 || A[N-1]==0&&B[N-1]==1&&S1[N-1]==1)//OF
                    alures[N-1:0]= {ZEROS[N-1:1],~S1[N-1]};
                else alures[N-1:0]=(S1[N-1])?1:0;
                alures[2*N-1:N]=ZEROS; OF = 0;
            end //SLT
            default:begin Cin1=1;
                 if(A[N-1]==0&&B[N-1]==1 || A[N-1]==1&&B[N-1]==0 )
                   begin alures[N-1:0]={ZEROS[N-1:1],B[N-1]};A1=A;B1=~B;end
                 else begin
                    if(A[N-1]==0&&B[N-1]==0)
                        begin A1=A;B1=~B; alures[N-1:0]=(S1[N-1])?1:0; end
                    else
                        begin A1={1'b0,{A[N-2:0]}};B1=~{1'b0,{B[N-2:0]}}; alures[N-1:0]={{ZEROS[N-1:1]},{(S1[N-1])?1:0}}; end
                    end
                 alures[2*N-1:N]=ZEROS;OF = 0;end //SLTU
       endcase
       //assign ZF = ~(alures[0] | alures[1] | alures[2] | alures[3] | alures[4] | alures[5] | alures[6] | alures[7]) ;
       ZF = (alures==0) ;
    end
    
endmodule
