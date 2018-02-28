`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/02/26 16:22:20
// Design Name: 
// Module Name: change_type
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
module change_type(clk,SyscallOut,Mdata,PC,all_time,j_change,b_change,b_change_success,pro_reset,in_addr,chose_out,RAM_addr);
input clk;
input [31:0]SyscallOut; //
input [31:0]Mdata;
input [31:0]PC;   //����pc��ֵ
input [31:0]all_time;  //16λ������
input [31:0]j_change;  //��������ָ֧����
input [31:0]b_change;  //��������ָ֧����
input [31:0]b_change_success ;  //��������֧ת�Ƴɹ���
//input reset;  //�ܿ���
input [2:0]pro_reset;   //3�����������ѡ����ֲ���
input [11:0]in_addr;   //12λ��ַѡ�񿪹�

output reg [31:0]chose_out;   //31λ���������ʾ����
output [11:0]RAM_addr;    //����ַ���ͳ�ȥ��

assign RAM_addr=in_addr;    //�ڴ��ַ����ѡ�񿪹صĲ������

always @(posedge clk)
begin
   case(pro_reset)
    3'b001:begin
      chose_out[31:0]<=PC;
    end
    3'b010:begin
      chose_out[31:0]<=all_time;
    end
    3'b011:begin
      chose_out[31:0]<=j_change;
    end
    3'b100:begin
      chose_out[31:0]<=b_change_success;
    end
    3'b101:begin
      chose_out[31:0]<=b_change;
    end
    3'b110:begin
      chose_out[31:0]<=Mdata;
    end
    default:chose_out <= SyscallOut;
  endcase
end

endmodule
