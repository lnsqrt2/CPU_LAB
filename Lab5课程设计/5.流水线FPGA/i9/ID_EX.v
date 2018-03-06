module ID_EX(clk,rst,pause,p_in,p_out,
    ALUsrc_in,ALUsrc_out,MemToReg_in,MemToReg_out,
    MemWrite_in,MemWrite_out,blez_in,blez_out,beq_in,beq_out,
    bne_in,bne_out,j_in,j_out,jal_in,jal_out,jr_in,jr_out,
    syscall_in,syscall_out,ALUOP_in,ALUOP_out,sh_in,sh_out,
    RegWrite_in,RegWrite_out,A_in,A_out,B_in,B_out,EXT_in,EXT_out,
    INDEX_in,INDEX_out,RW_in,RW_out,RA_in,RA_out,RB_in,RB_out,
    op_in,op_out,func_in,func_out);

    input clk,rst,pause;
    input ALUsrc_in,MemToReg_in,MemWrite_in,blez_in;
    input beq_in,bne_in,j_in,jal_in,jr_in,syscall_in;
    input sh_in,RegWrite_in;
    input [3:0] ALUOP_in;
    input [4:0] RW_in,RA_in,RB_in;
    input [5:0] op_in,func_in;
    input [31:0] p_in,A_in,B_in,EXT_in,INDEX_in;

    output reg ALUsrc_out,MemToReg_out,MemWrite_out,blez_out;
    output reg beq_out,bne_out,j_out,jal_out,jr_out,syscall_out;
    output reg sh_out,RegWrite_out;
    output reg [3:0] ALUOP_out;
    output reg [4:0] RW_out,RA_out,RB_out;
    output reg [5:0] op_out,func_out;
    output reg [31:0] p_out,A_out,B_out,EXT_out,INDEX_out;

    initial begin
        ALUsrc_out=0;
        MemToReg_out=0;
        MemWrite_out=0;
        blez_out=0;
        beq_out=0;
        bne_out=0;
        j_out=0;
        jal_out=0;
        jr_out=0;
        syscall_out=0;
        sh_out=0;
        RegWrite_out=0;
        ALUOP_out=0;
        RW_out=0;
        RA_out=0;
        RB_out=0;
        op_out=0;
        func_out=0;
        p_out=0;
        A_out=0;
        B_out=0;
        EXT_out=0;
        INDEX_out=0;
    end

    always @(posedge clk) begin
        if(rst)	begin
        	ALUsrc_out=0;
            MemToReg_out=0;
            MemWrite_out=0;
            blez_out=0;
            beq_out=0;
            bne_out=0;
            j_out=0;
            jal_out=0;
            jr_out=0;
            syscall_out=0;
            sh_out=0;
            RegWrite_out=0;
            ALUOP_out=0;
            RW_out=0;
            RA_out=0;
            RB_out=0;
            op_out=0;
            func_out=0;
            p_out=0;
            A_out=0;
            B_out=0;
            EXT_out=0;
            INDEX_out=0;
        end	
        else if(pause) begin
        	ALUsrc_out<=ALUsrc_out;
            MemToReg_out<=MemToReg_out;
            MemWrite_out<=MemWrite_out;
            blez_out<=blez_out;
            beq_out<=beq_out;
            bne_out<=bne_out;
            j_out<=j_out;
            jal_out<=jal_out;
            jr_out<=jr_out;
            syscall_out<=syscall_out;
            sh_out<=sh_out;
            RegWrite_out<=RegWrite_out;
            ALUOP_out<=ALUOP_out;
            RW_out<=RW_out;
            RA_out<=RA_out;
            RB_out<=RB_out;
            op_out<=op_out;
            func_out<=func_out;
            p_out<=p_out;
            A_out<=A_out;
            B_out<=B_out;
            EXT_out<=EXT_out;
            INDEX_out<=INDEX_out;
        end
        else begin
            ALUsrc_out<=ALUsrc_in;
            MemToReg_out<=MemToReg_in;
            MemWrite_out<=MemWrite_in;
            blez_out<=blez_in;
            beq_out<=beq_in;
            bne_out<=bne_in;
            j_out<=j_in;
            jal_out<=jal_in;
            jr_out<=jr_in;
            syscall_out<=syscall_in;
            sh_out<=sh_in;
            RegWrite_out<=RegWrite_in;
            ALUOP_out<=ALUOP_in;
            RW_out<=RW_in;
            RA_out<=RA_in;
            RB_out<=RB_in;
            op_out<=op_in;
            func_out<=func_in;
            p_out<=p_in;
            A_out<=A_in;
            B_out<=B_in;
            EXT_out<=EXT_in;
            INDEX_out<=INDEX_in;
        end
    end
endmodule