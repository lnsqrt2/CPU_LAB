`timescale 1ns / 1ps

module MUX(p_in,NPC_out,j_bub,pc_in,
    25_21,20_16,EXTOP,//输出ra2
    syscall1,ra1,//输入ra2，02
    rb1,//输入20_16,04；控制syscall1
    15_11,RegDst,rw2,//输入20_16
    jal1,rw1,//输入rw2,1f
    A,w_MEM,A_MEM,A_f1,
    w_RB,A_WB,A_f,
    B,B_MEM,B_f1,
    B_WB,B_f,
    ext_out,ALUsrc,Y,
    p_in2,jal2,R2,
    B2,sh2,data_in,
    R3,data3,MemToReg_WB//w3
    jal,p_in3);

    input j_bub,syscall1,RegDst,jal,jal1,jal2,A_MEM,A_WB,B_MEM,B_WB,ALUsrc,sh2;
    input [1:0] EXTOP;
    input [4:0] 25_21,20_16,15_11;
    input [31:0] p_in,p_in2,p_in3,NPC_out,A,B,B2,ext_out,R2;
    output reg [4:0] ra1,rb1,rw1;
    output reg [31:0] pc_in,A_f,B_f,Y,w_MEM,data_in,w_RB;
    reg [4:0] ra2,rw2;
    reg [31:0] A_f1,B_f1,w3;

    initial begin
        ra1=0;
        rb1=0;
        rw1=0;
        pc_in=0;
        A_f=0;
        B_f=0;
        Y=0;
        w_MEM=0;
        data_in=0;
        w_RB=0;
        ra2=0;
        rw2=0;
        A_f1=0;
        B_f1=0;
        w3=0;
    end

    always @(*) begin
        case(j_bub)
            1'b0:pc_in<=p_in;
            1'b1:pc_in<=NPC_out;
        endcase

        if (EXTOP==2'b10)
            ra2<=20_16;
        else
            ra2<=25_21;

        case(syscall1)
            1'b0:ra1<=ra2;
            1'b1:ra1<=5'h02;
        endcase

        case(syscall1)
            1'b0:rb1<=20_16;
            1'b1:rb1<=5'h04;
        endcase

        case(RegDst)
            1'b0:rw2<=20_16;
            1'b1:rw2<=15_11;
        endcase

        case(jal1)
            1'b0:rw1<=rw2;
            1'b1:rw1<=5'h1f;
        endcase

        case(jal2)
            1'b0:w_MEM<=R2;
            1'b1:w_MEM<=p_in2;
        endcase

        case(MemToReg_WB)
            1'b0:w3<=R3;
            1'b1:w3<=data3;
        endcase

        case(jal)
            1'b0:w_RB<=w3;
            1'b1:w_RB<=p_in3;
        endcase

        case(A_MEM)
            1'b0:A_f1<=A;
            1'b1:A_f1<=w_MEM;
        endcase

        case(A_WB)
            1'b0:A_f<=A_f1;
            1'b1:A_f<=w_RB;
        endcase

        case(B_MEM)
            1'b0:B_f1<=B;
            1'b1:B_f1<=w_MEM;
        endcase

        case(B_WB)
            1'b0:B_f<=B_f1;
            1'b1:B_f<=w_RB;
        endcase

        case(ALUsrc)
            1'b0:Y<=B_f;
            1'b1:Y<=ext_out;
        endcase

        case(sh2)
            1'b0:data_in<=B2;
            1'b1: begin 
                data_in[15:0]<=B2[15:0];
                data_in[31:16]<=0;
            end
        endcase

    end

endmodule
