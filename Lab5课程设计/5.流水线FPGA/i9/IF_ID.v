module IF_ID(clk,rst,pause,p_in,p_out,i_in,i_out);
	input [31:0]p_in,i_in;
    input pause;
    input rst;
    input clk;
    output reg [31:0] p_out,i_out;

    initial begin
        p_out=0;
        i_out=0;
    end

    always @(posedge clk) begin
        if(rst)	begin
        	p_out<=0;
        	i_out<=0;
        end	
        else if(pause) begin
        	p_out<=p_out;
        	i_out<=i_out;
        end
        else begin
            p_out<=p_in;
            i_out<=i_in;
        end
    end
endmodule