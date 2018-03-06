module MEM_WB(clk,rst,pause,p_in,p_out,
    MemToReg_in,MemToReg_out,
    jal_in,jal_out,halt_in,halt_out,
    RegWrite_in,RegWrite_out,R_in,R_out,D_in,D_out,
    RW_in,RW_out);

    input clk,rst,pause;
    input MemToReg_in;
    input jal_in,halt_in;
    input RegWrite_in;
    input [4:0] RW_in;
    input [31:0] p_in,R_in,D_in;

    output reg MemToReg_out;
    output reg jal_out,halt_out;
    output reg RegWrite_out;
    output reg [4:0] RW_out;
    output reg [31:0] p_out,R_out,D_out;

    initial begin
        MemToReg_out=0;
        jal_out=0;
        halt_out=0;
        RegWrite_out=0;
        RW_out=0;
        p_out=0;
        R_out=0;
        D_out=0;
    end

    always @(posedge clk) begin
        if(rst)	begin
        	MemToReg_out=0;
            jal_out=0;
            halt_out=0;
            RegWrite_out=0;
            RW_out=0;
            p_out=0;
            R_out=0;
            D_out=0;
        end	
        else if(pause) begin
            MemToReg_out<=MemToReg_out;
            jal_out<=jal_out;
            halt_out<=halt_out;
            RegWrite_out<=RegWrite_out;
            RW_out<=RW_out;
            p_out<=p_out;
            R_out<=R_out;
            D_out<=D_out;
        end
        else begin
            MemToReg_out<=MemToReg_in;
            jal_out<=jal_in;
            halt_out<=halt_in;
            RegWrite_out<=RegWrite_in;
            RW_out<=RW_in;
            p_out<=p_in;
            R_out<=R_in;
            D_out<=D_in;
        end
    end
endmodule