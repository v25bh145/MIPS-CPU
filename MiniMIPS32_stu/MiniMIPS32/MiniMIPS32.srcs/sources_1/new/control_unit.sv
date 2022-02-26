`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/02 11:26:40
// Design Name: 
// Module Name: control_unit
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


module control_unit(
    input logic [5 : 0] Opcode,
    input logic [5 : 0] Funct,
    //��MemtoReg = 0���򲻾������ݴ洢��
    output logic MemtoReg,
    //��MemWrite = 1��������д�뵽���ݴ洢����
    output logic MemWrite,
    //��Branch = 1�������PC��֧·��((Branch & Zero = 1) | JCondition = 1)����ת
    output logic Branch,
    //���ӣ���JCondition = 0����ȡԭ��·��SignImm��PCPlus4��ӣ�������ȡ{PC_OLD{31 : 28}, Instr[25 : 0] << 2}
    output logic JCondition,
    //���ӣ���ALUSrcA = 0����ȡԭ��·������ȡ32'b0000_0000_0000_0001_0000_0000_0000_0000
    output logic ALUSrcA,
    //��ALUSrcB = 1����ȡ��չ�����������������������ȡ�Ĵ���
    output logic ALUSrcB,
    //���ӣ���ZeroOrNot = 0,��ȡZero������ȡ~Zero
    output logic ZeroOrNot,
    //���ӣ���ExtendType = 0����ȡ����λ��չ������ȡ0��չ
    output logic ExtendType,
    //��RegDst = 0����ȡinst��20-16λ�����Ĵ���������ȡ15-11λ�����Ĵ���
    output logic RegDst,
    //��RegWrite = 1������Ĵ�����д��ֵ
    output logic RegWrite,
    //����ALU��aluop
    output logic [3 : 0] ALUControl
);
    always_comb begin
        case(Opcode)
            6'b000000:begin//R-type
                RegWrite = 1;
                RegDst = 1;
                ALUSrcB = 0;
                ALUSrcA = 0;
                ZeroOrNot = 0;
                ExtendType = 0;//x
                Branch = 0;
                JCondition = 0;//x
                MemWrite = 0;//x
                MemtoReg = 0;
                case(Funct) 
                    6'b101010: begin//slt
                        ALUControl = 4'b1110;
                    end
                    6'b100001: begin//addu
                        ALUControl = 4'b1010;
                    end
                endcase
            end
            6'b100011:begin//lw
                RegWrite = 1;
                RegDst = 0;
                ALUSrcB = 1;
                ALUSrcA = 0;
                ZeroOrNot = 0;
                ExtendType = 0;
                Branch = 0;
                JCondition = 0;//x
                MemWrite = 0;
                MemtoReg = 1;
                ALUControl = 4'b1010;
            end
            6'b101011:begin//sw
                RegWrite = 0;
                RegDst = 0;//X
                ALUSrcB = 1;
                ALUSrcA = 0;
                ZeroOrNot = 0;
                ExtendType = 0;
                Branch = 0;
                JCondition = 0;//x
                MemWrite = 1;
                MemtoReg = 0;//X
                ALUControl = 4'b1010;
            end
            6'b001111: begin//lui
                RegWrite = 1;
                RegDst = 0;
                ALUSrcB = 1;
                ALUSrcA = 1;
                ZeroOrNot = 0;
                ExtendType = 0;
                Branch = 0;
                JCondition = 0;//x
                MemWrite = 0;//x
                MemtoReg = 0;
                ALUControl = 4'b1000;
            end
            6'b001101: begin//ori
                RegWrite = 1;        
                RegDst = 0;          
                ALUSrcB = 1;         
                ALUSrcA = 0;    
                ZeroOrNot = 0;     
                ExtendType = 1;      
                Branch = 0;    
                JCondition = 0;//x      
                MemWrite = 0;//x     
                MemtoReg = 0;        
                ALUControl = 4'b0001;
            end
            6'b001001: begin//addiu
                RegWrite = 1;       
                RegDst = 0;        
                ALUSrcB = 1;         
                ALUSrcA = 0;    
                ZeroOrNot = 0;     
                ExtendType = 0;      
                Branch = 0;    
                JCondition = 0;//x    
                MemWrite = 0;//x     
                MemtoReg = 0;        
                ALUControl = 4'b1010;
            end
            6'b000100: begin//beq
                RegWrite = 0;       
                RegDst = 0;//x        
                ALUSrcB = 0;         
                ALUSrcA = 0;     
                ZeroOrNot = 0;    
                ExtendType = 0;      
                Branch = 1;     
                JCondition = 0;   
                MemWrite = 0;     
                MemtoReg = 0;//x     
                //sub A - B = 0 => Zero == 1   
                ALUControl = 4'b1100;
            end
            6'b000101: begin//bne
                RegWrite = 0;       
                RegDst = 0;//x        
                ALUSrcB = 0;         
                ALUSrcA = 0;      
                ZeroOrNot = 1;   
                ExtendType = 0;      
                Branch = 1;   
                JCondition = 0;        
                MemWrite = 0;     
                MemtoReg = 0;//x     
                //sub A - B != 0 => Zero == ~1
                ALUControl = 4'b1100;
            end
            6'b000010: begin//j
                RegWrite = 0;       
                RegDst = 0;//x  
                ALUSrcB = 0;//x         
                ALUSrcA = 0;//x      
                ZeroOrNot = 0;//x   
                ExtendType = 0;//x      
                Branch = 0;//x
                JCondition = 1;        
                MemWrite = 0;     
                MemtoReg = 0;//x    
                ALUControl = 4'b0000;//x 
            end
            default: begin
                //not used
            end
        endcase
    end
endmodule
