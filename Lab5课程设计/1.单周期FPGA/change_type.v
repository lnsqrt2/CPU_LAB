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
input [31:0]PC;   //输入pc的值
input [15:0]all_time;  //16位周期数
input [15:0]j_change;  //无条件分支指令数
input [15:0]b_change;  //有条件分支指令数
input [15:0]b_change_success ;  //有条件分支转移成功数
//input reset;  //总开关
input [2:0]pro_reset;   //3个开关组合来选择各种参数
input [11:0]in_addr;   //12位地址选择开关

output reg [31:0]chose_out;   //31位的数码管显示数据
output [11:0]RAM_addr;    //将地址输送出去！

assign RAM_addr=in_addr;    //内存地址就是选择开关的拨动情况

always @(*)   //每次时钟上升沿的时候将，看看数码管的显示数据应该是什么类型的
begin
   if(pro_reset==3'b001) //PC的值
     chose_out[31:0]=PC;
     
    else if(pro_reset==3'b010) //总周期数
    begin
    chose_out[31:16]=all_time;
    chose_out[15:0]=0;
    end
    
    else if(pro_reset==3'b011)  //无条件转移数
      begin
      chose_out[31:16]=j_change;
      chose_out[15:0]=0;
      end
     
    else if(pro_reset==3'b100)//有条件分转移成功数
    begin
        chose_out[31:16]=b_change_success;
        chose_out[15:0]=0;
     end
     
      else if(pro_reset==3'b101)//有条件分转移数
        begin
            chose_out[31:16]=b_change;
             chose_out[15:0]=0;
        end
       
       else if(pro_reset==3'b110)  //这个时候查看的是内存的数据
       begin
         //这里应该调用一个模块，将RAM_addr作为输入数据，输入到内存的地址线中作为地址、
         //然后取出数据，再使得chose_out=从内存中输出的32位数据
       end
         
       else  //总开关打开的时候，数码管的数据就是跑马灯的数据
       chose_out=SyscallOut;
end

endmodule
