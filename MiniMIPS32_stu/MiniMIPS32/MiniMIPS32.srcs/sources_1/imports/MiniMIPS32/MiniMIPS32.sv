

module MiniMIPS32(
    input  logic cpu_clk,
    input  logic cpu_rst_n,
    output logic [31:0] iaddr,
    input  logic [31:0] inst,
    output logic [31:0] daddr,
    output logic we,
    output logic [31:0] din,
    input  logic [31:0] dout
    );
    logic [31 : 0] PC_OLD; // no need to init
    logic [63 : 0] PCPlus4; // no need to init
    logic PCSrc; //inited
    logic Zero; // no need to init
    logic Branch; // no need to init
    logic JCondition; // no need to init
    logic [63 : 0] PCBranch; // no need to init
    logic [4 : 0] WriteReg; // no need to init
    logic [31 : 0] WriteReg_val; // no need to init
    logic RegWrite; // no need to init
    logic [31 : 0] reg_val_1; // no need to init
    logic [31 : 0] reg_val_2; // no need to init
    logic MemtoReg; // no need to init
    logic MemWrite; // no need to init
    logic ALUSrcB; // no need to init
    logic ALUSrcA; // no need to init
    logic ZeroOrNot; // no need to init
    logic ExtendType = 0; // no need to init
    logic RegDst; // no need to init
    logic [3 : 0] ALUControl; // no need to init
    logic [31 : 0] SignImm; // no need to init
    logic [31 : 0] SrcA; // no need to init
    logic [31 : 0] SrcB; // no need to init
    logic [63 : 0] ALUResult; // no need to init
//    logic [31 : 0] WriteData; assign WriteData = reg_val_2;
//    logic [31 : 0] ReadData; assign ReadData = dout_l;
    logic [31 : 0] inst_l;
    logic [31 : 0] dout_l;
    logic [31 : 0] din_l;
    logic [31 : 0] din_b;

    big2little INSTTRANS(.big(inst), .little(inst_l));
    big2little DOUTTRANS(.big(dout), .little(dout_l));
    big2little DINTRANS(.big(din_l), .little(din_b));
    
    always_comb begin
        if(daddr[31])
            din = din_l;
        else
            din = din_b;
    end
    
    assign PCSrc = (ZeroOrNot == 0 ? Zero : ~Zero) & Branch;
    
    PC_trigger PCTRIGGER(.PC_OLD(PC_OLD), .PC_NEW(iaddr), .sys_clk(cpu_clk), .sys_rst_n(cpu_rst_n));
    
    alu #(32) PCPLUS4(.A(iaddr), .B(4), .aluop(4'b1011), .alures(PCPlus4));
    
//    mux_2 #(32) PCMUX(.A(PCPlus4[31 : 0]), .B(PCBranch[31 : 0]), .S(PCSrc), .C(PC_OLD));
    always_comb begin
        if(JCondition == 1) begin
            PC_OLD = {PC_OLD[31 : 28], inst[25 : 0] << 2};
        end else begin
            PC_OLD = (PCSrc == 0) ? PCPlus4[31 : 0] : PCBranch[31 : 0];
        end
    end
    
    reg_file_32 REGFILE32(
        .A1(inst_l[25 : 21]),
        .A2(inst_l[20 : 16]),
        .A3(WriteReg),
        .WD3(WriteReg_val),
        .cpu_clk(cpu_clk),
        .cpu_rst_n(cpu_rst_n),
        .WE3(RegWrite),
        .RD1(reg_val_1),
        .RD2(reg_val_2)
    );
    
    control_unit CONTROLUNIT(
        .Opcode(inst_l[31 : 26]),
        .Funct(inst_l[5 : 0]),
        .MemtoReg(MemtoReg),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .JCondition(JCondition),
        .ALUSrcB(ALUSrcB),
        .ALUSrcA(ALUSrcA),
        .ZeroOrNot(ZeroOrNot),
        .ExtendType(ExtendType),
        .RegDst(RegDst),
        .RegWrite(RegWrite),
        .ALUControl(ALUControl)
    );
    
    mux_2 #(5) WRITEREGMUX(.A(inst_l[20 : 16]), .B(inst_l[15 : 11]), .S(RegDst), .C(WriteReg));
    
    sign_extend_32 SIGNEXTEND(.imm(inst_l[15 : 0]), .signed_imm(SignImm), .ExtendType(ExtendType));
    
    alu #(32) PCBRANCH(.A(SignImm << 2), .B(PCPlus4[31 : 0]), .aluop(4'b1011), .alures(PCBranch));
    
    mux_2 #(32) ALUSRCBMUX(.A(reg_val_2), .B(SignImm), .S(ALUSrcB), .C(SrcB));
    
    mux_2 #(32) ALUSRCAMUX(.A(reg_val_1), .B(32'b0000_0000_0000_0001_0000_0000_0000_0000), .S(ALUSrcA), .C(SrcA));
    
    alu #(32) MAINALU(.A(SrcA), .B(SrcB), .aluop(ALUControl), .alures(ALUResult), .ZF(Zero));
    
    assign daddr = ALUResult[31 : 0];
    assign din_l = reg_val_2;
    assign we = MemWrite;
    
    mux_2 #(32) MEMREGMUX(.A(ALUResult[31 : 0]), .B(dout_l), .S(MemtoReg), .C(WriteReg_val));
    
endmodule
