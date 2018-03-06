module DEC(data_in,op,25_21,20_16,15_11,10_6,func,15_0,index);
    input [31:0]data_in;
    output [5:0] op,func;
    output [4:0] 25_21,20_16,15_11,10_6;
    output [15:0] 15_0;
    output [31:0] index;
    
    assign op = data_in[31:26];
    assign 25_21 = data_in[25:21];
    assign 20_16 = data_in[20:16];
    assign 15_11 = data_in[15:11];
    assign 10_6 = data_in[10:6];
    assign func = data_in[5:0];
    assign 15_0 = data_in[15:0];
    assign index[25:0] = data_in[25:0];
    assign index[31:26] = 0;

endmodule
