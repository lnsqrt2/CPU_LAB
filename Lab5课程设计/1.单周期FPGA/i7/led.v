`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/02/26 14:11:04
// Design Name: 
// Module Name: led
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
module led(reset,pro_reset,in_addr,leds);
input reset; //�ܿ��أ�����������ʾ
input [2:0]pro_reset;   //3�����������ѡ����ֲ���������PC��ֵ������ʱ������������������֧ת�����ȵ�
//001����鿴pcֵ
//010����鿴������
//011����鿴��������֧ת����
//100����鿴��������֧ת�Ƴɹ���
//101����鿴��������ָ֧����
input [11:0]in_addr;    //��ַ���벦�뿪��,12λ��ֵַ���ܹ�4K���ڴ�
output [15:0]leds;  //16λ��led�Ƶ���ʾ

assign leds[15]=reset;  //����ָʾ��,�����

assign leds[2:0]=pro_reset;   //��ʾ���ֲ����ĵ�led��

assign leds[14:3]=in_addr;  //��ʾ��ֵַ��led��

endmodule
