module HALT(RF_A,syscall,rst,halt);
    input [31:0] RF_A;
    input syscall;
    input rst;
    output reg halt;

    initial begin
        halt=0;
    end

    always @(*) begin
        if (rst) begin
            halt<=0;
        end
        else if((RF_A==32'ha)&&Syscall) begin
            halt <= ~halt;
        end
    end
endmodule
