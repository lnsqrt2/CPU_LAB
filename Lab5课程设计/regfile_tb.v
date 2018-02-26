`timescale 1ns/1ns
module regfile_tb();

reg clk, WE;
reg [4:0] rW, rA, rB;
reg [31:0] W;

wire [31:0] A, B;

initial
	begin
		clk <= 0;
		WE <= 0;
		rW <= 0;
		rA <= 1;
		rB <= 2;
		W <= 0;
	end

always
	begin
	 	#10 clk <= ~clk;
	end
	
always
	begin
		W <= 32'hffffffff;
	 	rW <= 1;//WE = 0, can't write
	end
always
    begin
         #250 WE <= 1;//WE = 1, write enable
    end
always
    begin
         #500 W <= 32'h88888888;
         rW <= 2;
    end
always
    begin
         #750 rW <= 0;//try to write reg[0]
         rA <= 0;
    end
regfile z2(clk, WE, rW, rA, rB, W, A, B);
endmodule