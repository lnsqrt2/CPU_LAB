module regfile(clk, WE, rW, rA, rB, W, A, B)

input clk, WE;//write enable control
input [4:0] rW, rA, rB;//register addr
input [31:0] W;//data to rW
output [31:0] A, B;//data from rA,rB

reg [31:0] A, B;
reg [31:0] register [31:0];//32 registers

initial
	begin
		register[0] = 32'b0;//No.0 register
	end

assign A = register[rA];
assign B = register[rB];

always @(posedge clk)
	begin
		if ((rW != 0) && (WE == 1))
			begin
				register[rW] <= W;
			end
	end

endmodule