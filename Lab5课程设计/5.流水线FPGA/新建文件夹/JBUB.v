module JBUB(clk,rst,jmp,correct_b,j_bub);
    input syscall;
    input rst;
    input clk;
    output reg [31:0] syscallout;
    reg [31:0] out1,out2;

    initial begin
        out1 = 0;
        out2 = 0;
    end

    always @(posedge clk)
    begin
        out2<=out1;
    end
    
    always @(*) begin
        if (rst) begin
            out1 <= 0;
            out2 <= 0;
            j_bub<=0;
        end
        else if(!(jmp||correct_b)) begin
            out1<=0;
            j_bub<=0;
        end
        else begin
            out1 <= (!out2);
            j_bub <= (!out2);
        end
    end
endmodule
