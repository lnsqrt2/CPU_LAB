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
module change_type(clk,SyscallOut,PC,all_time,j_change,b_change,b_change_success,pro_reset,in_addr,chose_out,RAM_addr);
input clk;
input [31:0]SyscallOut; //
input [31:0]PC;   //����pc��ֵ
input [15:0]all_time;  //16λ������
input [15:0]j_change;  //��������ָ֧����
input [15:0]b_change;  //��������ָ֧����
input [15:0]b_change_success ;  //��������֧ת�Ƴɹ���
//input reset;  //�ܿ���
input [2:0]pro_reset;   //3�����������ѡ����ֲ���
input [11:0]in_addr;   //12λ��ַѡ�񿪹�

output reg [31:0]chose_out;   //31λ���������ʾ����
output [11:0]RAM_addr;    //����ַ���ͳ�ȥ��

assign RAM_addr=in_addr;    //�ڴ��ַ����ѡ�񿪹صĲ������

always @(*)   //ÿ��ʱ�������ص�ʱ�򽫣���������ܵ���ʾ����Ӧ����ʲô���͵�
begin
   if(pro_reset==3'b001) //PC��ֵ
     chose_out[31:0]=PC;
     
    else if(pro_reset==3'b010) //��������
    begin
    chose_out[31:16]=all_time;
    chose_out[15:0]=0;
    end
    
    else if(pro_reset==3'b011)  //������ת����
      begin
      chose_out[31:16]=j_change;
      chose_out[15:0]=0;
      end
     
    else if(pro_reset==3'b100)//��������ת�Ƴɹ���
    begin
        chose_out[31:16]=b_change_success;
        chose_out[15:0]=0;
     end
     
      else if(pro_reset==3'b101)//��������ת����
        begin
            chose_out[31:16]=b_change;
             chose_out[15:0]=0;
        end
       
       else if(pro_reset==3'b110)  //���ʱ��鿴�����ڴ������
       begin
         //����Ӧ�õ���һ��ģ�飬��RAM_addr��Ϊ�������ݣ����뵽�ڴ�ĵ�ַ������Ϊ��ַ��
         //Ȼ��ȡ�����ݣ���ʹ��chose_out=���ڴ��������32λ����
       end
         
       else  //�ܿ��ش򿪵�ʱ������ܵ����ݾ�������Ƶ�����
       chose_out=SyscallOut;
end

endmodule
