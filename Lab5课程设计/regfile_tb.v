`timescale 1ns/1ns
module regfile_tb();

reg clk, WE, rW, rA, rB, W;
wire A, B;

initial
	begin
		clk <= 0;
		WE <= 0;
		rW <= 0;
		rA <= 0;
		rB <= 0;
		W <= 0;
	end

always
	begin
	 	#10 clk_in <=clk_in;
	end

regfile z2(clk, WE, rW, rA, rB, W, A, B);
endmodule