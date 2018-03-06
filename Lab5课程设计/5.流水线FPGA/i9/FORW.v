module FORW(Rd,RA,RB,RW,WE,WB,ALUSrc,op,func,A_MEM,A_WB,B_MEM,B_WB);
    input [4:0]Rd,RA,RB,RW;
    input [5:0] op,func;
    input WE,WB,ALUSrc;
    output reg A_MEM,A_WB,B_MEM,B_WB;

    initial begin
        A_MEM=0;
        A_WB=0;
        B_MEM=0;
        B_WB=0;
    end

    always @(*) begin
        if ((Rd==RA)&&(Rd!=0)&&(WE)&&(!((op==6'h2)||(op==6'h3)))) begin
            A_MEM<=1;
        end
        else begin
            A_MEM<=0;
        end

        if ((Rd!=RA)&&(RW==RA)&&(RW!=0)&&(WB)&&(!((op==6'h2)||(op==6'h3)))) begin
            A_WB<=1;
        end
        else begin
            A_WB<=0;
        end

        if ((Rd==RB)&&(Rd!=0)&&(WE)&&((op==6'h2b)||(!ALUSrc))&&(
            ((op==6'h0)&&(func==6'h20))||//add
            ((op==6'h0)&&(func==6'h21))||//addu
            ((op==6'h0)&&(func==6'h24))||//and
            ((op==6'h0)&&(func==6'h22))||//sub
            ((op==6'h0)&&(func==6'h25))||//or
            ((op==6'h0)&&(func==6'h27))||//nor
            (op==6'h2b)||//sw
            (op==6'h4)||//beq
            (op==6'h5)||//bne
            ((op==6'h0)&&(func==6'h2a))||//slt
            ((op==6'h0)&&(func==6'h2b))||//sltu
            ((op==6'h0)&&(func==6'hc))||//syscall
            ((op==6'h0)&&(func==6'h26))||//xor
            (op==6'h29)//sh
            )) begin
            B_MEM<=1;
        end
        else begin
            B_MEM<=0;
        end

        if ((Rd!=RB)&&(RW==RB)&&(RW!=0)&&(WB)&&((op==6'h2b)||(!ALUSrc))&&(
            ((op==6'h0)&&(func==6'h20))||//add
            ((op==6'h0)&&(func==6'h21))||//addu
            ((op==6'h0)&&(func==6'h24))||//and
            ((op==6'h0)&&(func==6'h22))||//sub
            ((op==6'h0)&&(func==6'h25))||//or
            ((op==6'h0)&&(func==6'h27))||//nor
            (op==6'h2b)||//sw
            (op==6'h4)||//beq
            (op==6'h5)||//bne
            ((op==6'h0)&&(func==6'h2a))||//slt
            ((op==6'h0)&&(func==6'h2b))||//sltu
            ((op==6'h0)&&(func==6'hc))||//syscall
            ((op==6'h0)&&(func==6'h26))||//xor
            (op==6'h29)//sh
            )) begin
            B_WB<=1;
        end
        else begin
            B_WB<=0;
        end

    end
endmodule
