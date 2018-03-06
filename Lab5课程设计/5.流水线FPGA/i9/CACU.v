module CACU(rst,clk,halt,total,conditional,unconditional,
    conditional_success,j,jal,jr,blez,beq,bne,correct_b,
    loaduse,lu_times,LOCK);
    input rst;
    input clk;
    input halt;
    input j;
    input jal;
    input jr;
    input bne;
    input blez;
    input beq;
    input correct_b;
    input loaduse;
    output LOCK;
    output reg [31:0]total;
    output reg [31:0]conditional;
    output reg [31:0]unconditional;
    output reg [31:0]conditional_success;
    output reg [31:0]lu_times;
    reg flag;
    initial begin
        total=0;
        conditional_success=0;
        conditional=0;
        unconditional=0;
        lu_times=0;
        flag=0;
    end

    assign LOCK = halt;

    always @(negedge clk)begin
        if(rst)begin 
            total=0;
            conditional_success=0;
            conditional=0;
            unconditional=0;
            lu_times=0;
            flag=0;
        end
        else begin
            if(!halt)begin
                total=total+1; 
                flag=0;
            end
            else if(halt&&(flag == 0))begin
                total=total+1; 
                flag=1;
            end
            if(j|jal|jr)unconditional=unconditional+1;
            if(beq|bne|blez)conditional=conditional+1;
            if(correct_b)conditional_success=conditional_success+1;
            if(loaduse) lu_times=lu_times+1;
        end
    end

endmodule
