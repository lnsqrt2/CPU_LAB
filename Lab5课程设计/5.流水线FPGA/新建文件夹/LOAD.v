module LOAD(Rd_EX,ra1,rb1,WE_EX,alusrc1,op1,func1,memtoreg,memwrite,loaduse);
    input [4:0]Rd_EX,ra1,rb1;
    input [5:0] op1,func1;
    input WE_EX,alusrc1,memtoreg,memwrite;
    output reg loaduse;

    initial begin
        loaduse=0;
    end

    always @(*) begin
        if ((((Rd_EX==ra1)&&(Rd_EX!=0)&&(WE_EX)&&(!((op1==6'h2)||(op1==6'h3))))||
            ((Rd_EX==rb1)&&(Rd_EX!=0)&&(WE_EX)&&((op1==6'h2b)||(!alusrc1))&&(
            ((op1==6'h0)&&(func1==6'h20))||//add
            ((op1==6'h0)&&(func1==6'h21))||//addu
            ((op1==6'h0)&&(func1==6'h24))||//and
            ((op1==6'h0)&&(func1==6'h22))||//sub
            ((op1==6'h0)&&(func1==6'h25))||//or
            ((op1==6'h0)&&(func1==6'h27))||//nor
            (op1==6'h2b)||//sw
            (op1==6'h4)||//beq
            (op1==6'h5)||//bne
            ((op1==6'h0)&&(func1==6'h2a))||//slt
            ((op1==6'h0)&&(func1==6'h2b))||//sltu
            ((op1==6'h0)&&(func1==6'hc))||//syscall
            ((op1==6'h0)&&(func1==6'h26))||//xor
            (op1==6'h29)//sh
            )))&&(memwrite||memtoreg)
            ) begin
            loaduse<=1;
        end
        else begin
            loaduse<=0;
        end
    end
endmodule
