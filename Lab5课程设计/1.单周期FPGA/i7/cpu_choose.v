`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/02/26 09:42:02
// Design Name: 
// Module Name: cpu_choose
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

//多路选择器
module cpu_choose(
    input clk,
    input [31:0] ROM_D,PC,RegFile_E,index,RF_A,ALU_R,RAM_D,
    input S,Syscall,RegDst,jal,correct_b,j,jr,ALUsrc,sh,MemToReg,
    input [1:0] EXTOP,
    output reg [4:0] out0,out1,out2,out3,out4,
    output reg [31:0] out5,out6,out7,out8,out9,out10,out11,out12,out13,out14,SyscallOut
    );

    wire [31:0]d4;
    wire [31:0]d5;
    wire [31:0]d7;

    extender m_extender(ROM_D,d4,d5,d7);//9:05
    
//    always @ (posedge CLK or negedge RST)
//    begin
//    if(~RST)
//    
//    end
    initial out14 = 0;
    always @(posedge clk)
    begin
    out14<=out13;
    end
    
    always @(*)
    begin
    case(S)
    1'b0:out0<=ROM_D[25:21];
    1'b1:out0<=ROM_D[20:16];
    endcase
    
    case(Syscall)
    1'b0:out1<=out0;
    1'b1:out1<=5'h02;
    endcase
    
    case(RegDst)
    1'b0:out2<=ROM_D[20:16];
    1'b1:out2<=ROM_D[15:11];
    endcase
    
    case(jal)
    1'b0:out4<=out2;
    1'b1:out4<=5'h1f;
    endcase
    
    case(Syscall)
    1'b0:out3<=ROM_D[20:16];
    1'b1:out3<=5'h04;
    endcase
    
    case(EXTOP)
    2'b00:out5<=d4;
    2'b01:out5<=d5;
    2'b10:out5<=d7;
    2'b11:out5<=0;
    endcase
    
    case(ALUsrc)
    1'b0:out6<=RegFile_E;
    1'b1:out6<=out5;
    endcase
    
    case(MemToReg)
    1'b0:out7<=ALU_R;
    1'b1:out7<=RAM_D;
    endcase
    
    case(jal)
    1'b0:out8<=out7;
    1'b1:out8<=PC+1;
    endcase
    
    case(correct_b)
    1'b0:out9<=PC+1;
    1'b1:out9<=PC+1+out5;
    endcase
    
    case(j||jal)
    1'b0:out10<=out9;
    1'b1:out10<=index;
    endcase
    
    case(jr)
    1'b0:out11<=out10;
    1'b1:out11<=RF_A;
    endcase
    
    case(sh)  //out12是数据存储器的输入数据（即RAM_input_D)
    1'b0:out12<=RegFile_E;
    1'b1:begin
        out12[31:16] <= 0;
        out12[15:0] <= RegFile_E[15:0];
    end
    endcase
    

    
    case((!(RF_A==32'ha))&&Syscall)
    1'b0:out13<=out14;
    1'b1:out13<=RegFile_E;
    endcase
    
    case((!(RF_A==32'ha))&&Syscall)
    1'b0:SyscallOut<=out14;
    1'b1:SyscallOut<=out13;
    endcase

    end
endmodule
