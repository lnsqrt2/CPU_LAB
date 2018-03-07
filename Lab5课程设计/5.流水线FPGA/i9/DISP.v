module DISP(clk,rst,syscall,RF_A,RF_B,syscallout);
    input [31:0]RF_A;
    input [31:0]RF_B;
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
        if (rst) begin
                out2 <= 0;
            end
        else
    	   out2<=out1;
    end
    
    always @(*) begin
        if (rst) begin
            out1 <= 0;
            syscallout<=0;
        end
		else if((!(RF_A==32'ha))&&syscall) begin
            out1 <= RF_B;
			syscallout<=RF_B;
		end
		else begin
            out1<=out2;
			syscallout<=out2;
		end
    end
endmodule
