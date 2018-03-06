module PC(clk,pause,rst,pc_in,pc_out);
    input [31:0]pc_in;
    input pause;
    input rst;
    input clk;
    output reg [31:0] pc_out;
    initial begin
        pc_out=0;
    end
    always @(posedge clk) begin
        if(rst)pc_out=0;
        else if(pause)pc_out=pc_out;
        else begin 
            pc_out<=pc_in;
        end
    end
endmodule
