`timescale 1ns/1ns
module divider_tb();

reg clk_in,rst;
wire clk_out;

initial
	begin
		clk_in <= 0;
		rst <= 0;
	end

always
	begin
	 	#10 clk_in <=clk_in;
	end 
divider z1(clk_in,rst,clk_out);
endmodule