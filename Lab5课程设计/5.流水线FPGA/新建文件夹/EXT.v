`timescale 1ns / 1ps

module EXT(15_0,10_6,ext_out,EXTOP)
    input [15:0] 15_0;
    input [4:0] 10_6;
    input [1:0] EXTOP;
    output reg [31:0] ext_out;

    integer i;

    always @(*) begin
        case(EXTOP)
            2'b00:begin//sign extend
                for (i = 16; i < 32; i = i + 1)
                    ext_out[i] = 15_0[15];
                ext_out[15:0] <= 15_0;
            end
            2'b01:begin//0 extend
                ext_out[31:16] <= 0;
                ext_out[15:0] <= 15_0;
            end
            2'b10:begin//0 extend
                ext_out[31:5] <= 0;
                ext_out[4:0] <= 10_6;
            end
        endcase
    end
endmodule
