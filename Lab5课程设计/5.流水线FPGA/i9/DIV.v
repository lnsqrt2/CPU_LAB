module DIV(clk_in,choose, clk_out);//加了个choose

input clk_in;//system clock, reset button
input choose;
output clk_out;

reg clk_out;
reg [31:0] cnt;//counter

initial
	begin
		clk_out = 0;
		cnt  = 0;
	end

always @(posedge clk_in) begin
			if(choose) begin
				if (cnt>=5)//actually 2500000 times
					begin
						clk_out <= ~clk_out;
						cnt <= 0;
					end
				else
					begin
						cnt <= cnt+1;
					end
			end
			else begin
				if (cnt>=1500000)//actually 2500000 times
					begin
						clk_out <= ~clk_out;
						cnt <= 0;
					end
				else
					begin
						cnt <= cnt+1;
					end
			end
end
endmodule