`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/02/26 14:49:35
// Design Name: 
// Module Name: controller
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


module controller(op,func,Syscall,ALUOP,jr,jal,j,bne,beq,EXTOP,Memwrite,MemToReg,Regwrite,ALUsrc,RegDst);
    input [5:0]op;
    input [5:0]func;
    output reg  Syscall;
    output reg [3:0]ALUOP;//ALU模式控制
    output reg jr,jal,j,bne,beq;//特殊跳转指令信号
    output reg [1:0]EXTOP;//立即数扩展控制
    output reg Memwrite,MemToReg,Regwrite,ALUsrc,RegDst;
    //添加指令及信号，请区分指令类型进行添加
    always @(*)
    begin
        if(op == 6'b000000) begin//13 special instructions
            case(func)
                6'b100000:begin//add
                    jr <=0;
                    jal <=0;
                    j<=0;
                    bne<=0;
                    beq <=0;
                    Memwrite <=0;
                    MemToReg<=0;
                    ALUsrc <=0;
                    Syscall <=0;
                    RegDst <= 1;
                    Regwrite <= 1;
                    EXTOP <= 2'b00;
                    ALUOP <= 4'b0101;
                end
                6'b100001:begin//addu
                    jr <=0;
                    jal <=0;
                    j<=0;
                    bne<=0;
                    beq <=0;
                    Memwrite <=0;
                    MemToReg<=0;
                    ALUsrc <=0;
                    Syscall <=0;
                    RegDst <= 1;
                    Regwrite <= 1;
                    EXTOP <= 2'b00;
                    ALUOP <= 4'b0101;
                end
                6'b100100:begin//and
                    jr <=0;
                    jal <=0;
                    j<=0;
                    bne<=0;
                    beq <=0;
                    Memwrite <=0;
                    MemToReg<=0;
                    ALUsrc <=0;
                    Syscall <=0;
                    RegDst <= 1;
                    Regwrite <= 1;
                    EXTOP <= 2'b00;
                    ALUOP <= 4'b0111;
                end
                6'b100111:begin//nor
                    jr <=0;
                    jal <=0;
                    j<=0;
                    bne<=0;
                    beq <=0;
                    Memwrite <=0;
                    MemToReg<=0;
                    ALUsrc <=0;
                    Syscall <=0;
                    RegDst <= 1;
                    Regwrite <= 1;
                    EXTOP <= 2'b00;
                    ALUOP <= 4'b1010;
                end
                6'b100101:begin//or
                    jr <=0;
                    jal <=0;
                    j<=0;
                    bne<=0;
                    beq <=0;
                    Memwrite <=0;
                    MemToReg<=0;
                    ALUsrc <=0;
                    Syscall <=0;
                    RegDst <= 1;
                    Regwrite <= 1;
                    EXTOP <= 2'b00;
                    ALUOP <= 4'b1000;
                end
                6'b000000:begin//sll
                    jr <=0;
                    jal <=0;
                    j<=0;
                    bne<=0;
                    beq <=0;
                    Memwrite <=0;
                    MemToReg<=0;
                    Syscall <=0;
                    RegDst <= 1;
                    Regwrite <= 1;
                    ALUsrc <= 1;
                    EXTOP <= 2'b10;
                    ALUOP <= 4'b0000;
                end
                6'b000011:begin//sra
                    jr <=0;
                    jal <=0;
                    j<=0;
                    bne<=0;
                    beq <=0;
                    Memwrite <=0;
                    MemToReg<=0;
                    Syscall <=0;
                    RegDst <= 1;
                    Regwrite <= 1;
                    ALUsrc <= 1;
                    EXTOP <= 2'b10;
                    ALUOP <= 4'b0001;
                end
                6'b000010:begin//srl
                    jr <=0;
                    jal <=0;
                    j<=0;
                    bne<=0;
                    beq <=0;
                    Memwrite <=0;
                    MemToReg<=0;
                    Syscall <=0;
                    RegDst <= 1;
                    Regwrite <= 1;
                    ALUsrc <= 1;
                    EXTOP <= 2'b10;
                    ALUOP <= 4'b0010;
                end
                6'b100010:begin//sub
                    jr <=0;
                    jal <=0;
                    j<=0;
                    bne<=0;
                    beq <=0;
                    Memwrite <=0;
                    MemToReg<=0;
                    ALUsrc <=0;
                    Syscall <=0;
                    RegDst <= 1;
                    Regwrite <= 1;
                    EXTOP <= 2'b00;
                    ALUOP <= 4'b0110;
                end
                6'b001000:begin//jr
                    jal <=0;
                    j<=0;
                    bne<=0;
                    beq <=0;
                    Memwrite <=0;
                    MemToReg<=0;
                    ALUsrc <=0;
                    RegDst <= 0;
                    Regwrite <= 0;
                    Syscall <=0;
                    jr <= 1;
                    EXTOP <= 2'b00;
                    ALUOP <= 4'b1101;
                end
                6'b001100:begin//syscall
                    Syscall <= 1;
                    jal <=0;
                    j<=0;
                    bne<=0;
                    beq <=0;
                    Memwrite <=0;
                    MemToReg<=0;
                    ALUsrc <=0;
                    RegDst <= 0;
                    Regwrite <= 0;
                    jr <= 0;
                    EXTOP <= 2'b00;
                    ALUOP <= 4'b1101;
                end
                6'b101010:begin//slt
                    RegDst <= 1;
                    Regwrite <= 1;
                    Syscall <= 0;
                    jal <=0;
                    j<=0;
                    bne<=0;
                    beq <=0;
                    Memwrite <=0;
                    MemToReg<=0;
                    ALUsrc <=0;
                    jr <= 0;
                    EXTOP <= 2'b00;
                    ALUOP <= 4'b1011;
                end
                6'b101011:begin//sltu
                    RegDst <= 1;
                    Regwrite <= 1;
                    Syscall <= 0;
                    jal <=0;
                    j<=0;
                    bne<=0;
                    beq <=0;
                    Memwrite <=0;
                    MemToReg<=0;
                    ALUsrc <=0;
                    jr <= 0;
                    EXTOP <= 2'b00;
                    ALUOP <= 4'b1100;
                end
            endcase
        end
        else begin
            case(op)//11条普通指令
                6'b001000:begin//addi
                    Regwrite <= 1;
                    ALUsrc <= 1;
                    RegDst <= 0;
                    Syscall <= 0;
                    jal <=0;
                    j<=0;
                    bne<=0;
                    beq <=0;
                    Memwrite <=0;
                    MemToReg<=0;
                    jr <= 0;
                    EXTOP <= 2'b00;
                    ALUOP <= 4'b0101;
                end
                6'b001001:begin//addiu
                    Regwrite <= 1;
                    ALUsrc <= 1;
                    RegDst <= 0;
                    Syscall <= 0;
                    jal <=0;
                    j<=0;
                    bne<=0;
                    beq <=0;
                    Memwrite <=0;
                    MemToReg<=0;
                    jr <= 0;
                    EXTOP <= 2'b00;
                    ALUOP <= 4'b0101;
                end
                6'b001100:begin//andi
                    Regwrite <= 1;
                    ALUsrc <= 1;
                    Syscall <= 0;
                    jr <= 0;
                    jal <=0;
                    j <= 0;
                    bne <= 0;
                    beq <= 0;
                    Memwrite <=0;
                    MemToReg <= 0;
                    RegDst <= 0;
                    EXTOP <= 2'b00;
                    ALUOP <= 4'b0111;
                end
                6'b001101:begin//ori
                    Regwrite <= 1;
                    ALUsrc <= 1;
                    Syscall <= 0;
                    jr <= 0;
                    jal <=0;
                    j <= 0;
                    bne <= 0;
                    beq <= 0;
                    Memwrite <=0;
                    MemToReg <= 0;
                    RegDst <= 0;
                    EXTOP <= 2'b01;
                    ALUOP <= 4'b1000;
                end
                6'b000100:begin//beq
                    beq <= 1;
                    bne <= 0;
                    ALUsrc <= 0;
                    Regwrite <= 0;
                    Syscall <= 0;
                    jr <= 0;
                    jal <=0;
                    j <= 0;
                    Memwrite <=0;
                    MemToReg <= 0;
                    RegDst <= 0;
                    EXTOP <= 2'b00;
                    ALUOP <= 4'b1101;
                end
                6'b000101:begin//bne
                    bne <= 1;
                    ALUsrc <= 0;
                    Regwrite <= 0;
                    Syscall <= 0;
                    jr <= 0;
                    jal <=0;
                    j <= 0;
                    beq <= 0;
                    Memwrite <=0;
                    MemToReg <= 0;
                    RegDst <= 0;
                    EXTOP <= 2'b00;
                    ALUOP <= 4'b1101;
                end
                6'b000010:begin//j
                    j <= 1;
                    ALUsrc <= 0;
                    Regwrite <= 0;
                    Syscall <= 0;
                    jr <= 0;
                    jal <=0;
                    bne <= 0;
                    beq <= 0;
                    Memwrite <=0;
                    MemToReg <= 0;
                    Regwrite <= 0;
                    ALUsrc <= 0;
                    RegDst <= 0;
                    EXTOP <= 2'b00;
                    ALUOP <= 4'b1101;
                end
                6'b000011:begin//jal
                    jal <= 1;
                    Regwrite <= 1;
                    ALUsrc <= 0;
                    Syscall <= 0;
                    jr <= 0;
                    j <= 0;
                    bne <= 0;
                    beq <= 0;
                    Memwrite <=0;
                    MemToReg <= 0;
                    ALUsrc <= 0;
                    RegDst <= 0;
                    EXTOP <= 2'b00;
                    ALUOP <= 4'b1101;
                end
                6'b100011:begin//lw
                    ALUsrc <= 1;
                    Regwrite <= 1;
                    MemToReg <= 1;
                    Syscall <= 0;
                    jr <= 0;
                    jal <=0;
                    j <= 0;
                    bne <= 0;
                    beq <= 0;
                    Memwrite <=0;
                    RegDst <= 0;
                    EXTOP <= 2'b00;
                    ALUOP <= 4'b0101;
                end
                6'b101011:begin//sw
                    ALUsrc <= 1;
                    Memwrite <= 1;
                    Regwrite <= 0;
                    Syscall <= 0;
                    jr <= 0;
                    jal <=0;
                    j <= 0;
                    bne <= 0;
                    beq <= 0;
                    MemToReg <= 0;
                    RegDst <= 0;
                    EXTOP <= 2'b00;
                    ALUOP <= 4'b0101;
                end
                6'b001010:begin//slti
                    ALUsrc <= 1;
                    Regwrite <= 1;
                    Syscall <= 0;
                    jr <= 0;
                    jal <=0;
                    j <= 0;
                    bne <= 0;
                    beq <= 0;
                    Memwrite <=0;
                    MemToReg <= 0;
                    RegDst <= 0;
                    EXTOP <= 2'b00;
                    ALUOP <= 4'b1011;
                end
            endcase
        end
    end
endmodule

