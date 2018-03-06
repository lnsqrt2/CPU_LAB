module NPC_out(j,jal,jr,beq,bne,blez,equ,RF_A,pc1,ext,index,correct_b,NPC_out,jmp);
    input [31:0]RF_A,pc1,ext,index;
    input j,jal,jr,beq,bne,blez,equ;
    output reg jmp,correct_b;
    output reg [31:0] NPC_out;
    reg [31:0] NPC_b,NPC_j;

    initial begin
        jmp=0;
        correct_b=0;
        NPC_out=0;
        NPC_b=0;
        NPC_j=0;
    end

    always @(*) begin
        if (j||jal||jr) begin
            jmp<=1;
        end
        else begin
            jmp<=0;
        end

        if ((beq&&equ)||(bne&&(!equ))||(blez&&(!(RF_A>0))) begin
            correct_b<=1;
            NPC_b <= pc1+ext;
        end
        else begin
            correct_b<=0;
            NPC_b <= pc1;
        end

        if (j||jal) begin
            NPC_j<=index;
        end
        else begin
            NPC_j<=NPC_b;
        end

        if (jr) begin
            NPC_out<=RF_A;
        end
        else begin
            NPC_out<=NPC_j;
        end

    end
endmodule
