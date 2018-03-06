`timescale 1ns / 1ps
module TYPEC(clk,SyscallOut,Mdata,PC,all_time,j_change,b_change,b_change_success,lu_times,pro_reset,in_addr,chose_out,RAM_addr);
input clk;
input [31:0]SyscallOut; //
input [31:0]Mdata;
input [31:0]PC;   //����pc��ֵ
input [31:0]all_time;  //16λ������
input [31:0]j_change;  //��������ָ֧����
input [31:0]b_change;  //��������ָ֧����
input [31:0]b_change_success ;  //��������֧ת�Ƴɹ���
input [31:0]lu_times;
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
      chose_out[31:0]<=lu_times;
    end
    3'b111:begin
      chose_out[31:0]<=Mdata;
    end
    default:chose_out <= SyscallOut;
  endcase
end

endmodule
