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
    //若MemtoReg = 0，则不经过数据存储器
    output logic MemtoReg,
    //若MemWrite = 1，则将数据写入到数据存储器中
    output logic MemWrite,
    //若Branch = 1，则采用PC分支路线((Branch & Zero = 1) | JCondition = 1)则跳转
    output logic Branch,
    //附加，若JCondition = 0，则取原线路（SignImm与PCPlus4相加），否则取{PC_OLD{31 : 28}, Instr[25 : 0] << 2}
    output logic JCondition,
    //附加，若ALUSrcA = 0，则取原线路，否则取32'b0000_0000_0000_0001_0000_0000_0000_0000
    output logic ALUSrcA,
    //若ALUSrcB = 1，则取扩展后的立即数当操作数，否则取寄存器
    output logic ALUSrcB,
    //附加，若ZeroOrNot = 0,则取Zero，否则取~Zero
    output logic ZeroOrNot,
    //附加，若ExtendType = 0，则取符号位扩展，否则取0扩展
    output logic ExtendType,
    //若RegDst = 0，则取inst的20-16位当做寄存器，否则取15-11位当做寄存器
    output logic RegDst,
    //若RegWrite = 1，则向寄存器中写入值
    output logic RegWrite,
    //控制ALU的aluop
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
