module operating_parameter(rst,clk,halt,total,conditional,unconditional,
    conditional_success,j,jal,jr,blez,beq,bne,correct_b);
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
    output reg [31:0]total;
    output reg [31:0]conditional;
    output reg [31:0]unconditional;
    output reg [31:0]conditional_success;
    reg flag;
    initial begin
        total=0;
        conditional_success=0;
        conditional=0;
        unconditional=0;
        flag=0;
    end
    always @(posedge clk)begin
        if(rst)begin 
            flag=0;
            total=0;
            conditional=0;
            unconditional=0;
            conditional_success=0;
        end
        else begin 
	        if(!halt)begin
	            total=total+1;
	            flag=0;
	        end
	        else if(halt&&flag==0)begin
	            flag=1;
	            total=total+1;
	        end
	        else ;
	        if(j||jal||jr)unconditional=unconditional+1;
	        if(bne||blez||beq)conditional=conditional+1;
	        if(correct_b)conditional_success=conditional_success+1;
	        else ;
	    end
    end
endmodule
