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
    output reg LOCK;
    output reg [31:0]total;
    output reg [31:0]conditional;
    output reg [31:0]unconditional;
    output reg [31:0]conditional_success;
    output reg [31:0]lu_times;
    reg flag;
    initial begin
        LOCK=0;
        total=0;
        conditional_success=0;
        conditional=0;
        unconditional=0;
        lu_times=0;
        flag=0;
    end

    always @(*) begin
        if (rst) begin
            out1 <= 0;
            out2 <= 0;
        end
        else if(halt) begin
            out1 <= 1;
            LOCK<=1;
        end
        else begin
            out1<=out2;
            LOCK<=out2;
        end
    end

    always @(posedge clk)begin
        out2<=out1;
        if(rst)begin 
            LOCK=0;
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
