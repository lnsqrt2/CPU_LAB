module DS(str, clk, clr, mode, address, extra_addr, data_in, data_out, extra_dout);
    parameter AWIDTH = 12;  //��ַ�ֳ������������ֱ���޸�,����4k�����ƣ������ֽڱ�ַӦ�ò�����12
    parameter DWIDTH = 32;  //�����ֳ�
    input   str,    //�źţ�1ʱͬ��д�� 
            clk,    //�źţ�ʱ��
            clr;    //�źţ�1ʱ�첽���
    input   [1:0]   mode;   //�źţ�00ʱ�ַ��ʣ�01ʱ�ֽڷ���,10ʱ���ӷ���
    input   [AWIDTH-1:0] address, extra_addr;   //��ַ������
    input   [DWIDTH-1:0] data_in;   //���ݣ�����
    output   [DWIDTH-1:0] data_out, extra_dout; //���ݣ����
    wire  [DWIDTH-1:0] dout_sum, din_sum;
    reg [DWIDTH-1:0] ram [2**AWIDTH-1:0];   //�洢��
    wire [7:0] dout_3, dout_2, dout_1, dout_0;
    wire word, half, byte, half_sel, byte_sel;
    wire [31:0] shift;
    integer i = 0;

    assign shift = sel_0 ? 32'b0 : (sel_1 ? 32'h8 : (sel_2?32'h10:32'h18));
    assign word = (~mode[1]) & (~mode[0]);
    assign half = (mode[1]) & (~mode[0]);
    assign byte = (~mode[1]) & (mode[0]);
    assign half_sel = address[1];
    assign byte_sel = address[0];
    assign sel_3 = word + (half & half_sel ) + (half_sel  & byte & byte_sel );
    assign sel_2 = word + (half & half_sel ) + (half_sel  & byte & ~byte_sel);
    assign sel_1 = word + (half & ~half_sel) + (~half_sel & byte & byte_sel );
    assign sel_0 = word + (half & ~half_sel) + (~half_sel & byte & ~byte_sel);
    assign din_sum = data_in << shift;
    assign dout_sum = (sel_3?(dout_3<<24):0) | (sel_2?(dout_2<<16):0) | (sel_1?(dout_1<<8):0) | (sel_0?dout_0:0);
    assign data_out = dout_sum >> shift;
    DS_8b DS_3 (str, sel_3, clk, clr, address[11:2], extra_addr[11:2],din_sum[31:24] , dout_3, extra_dout[31:24]);
    DS_8b DS_2 (str, sel_2, clk, clr, address[11:2], extra_addr[11:2],din_sum[23:16] , dout_2, extra_dout[23:16]);
    DS_8b DS_1 (str, sel_1, clk, clr, address[11:2], extra_addr[11:2],din_sum[15:8]  , dout_1, extra_dout[15:8]);
    DS_8b DS_0 (str, sel_0, clk, clr, address[11:2], extra_addr[11:2],din_sum[7:0]   , dout_0, extra_dout[7:0]);
endmodule

module DS_8b(str, sel ,clk , clr, address, extra_addr, data_in, data_out_8b, extra_dout_8b);
    parameter AWIDTH = 10;  //��ַ�ֳ������������ֱ���޸�,����4k�����ƣ������ֵ�ַӦ�ò�����10
    parameter DWIDTH = 8;   //�����ֳ�
    input   str,    //�źţ�1ʱͬ��д��
            sel, 
            clk,    //�źţ�ʱ��
            clr;    //�źţ�1ʱ�첽���
    input   [AWIDTH-1:0] address, extra_addr;   //��ַ������
    input   [DWIDTH-1:0] data_in;   //���ݣ�����
    output   [DWIDTH-1:0] data_out_8b, extra_dout_8b; //���ݣ����
    reg [DWIDTH-1:0] ram_8b [2**AWIDTH-1:0];    //�洢��
    integer i = 0;
    initial begin
        for(i = 0; i < 2**AWIDTH; i = i + 1) begin
            ram_8b[i] = 0;
        end
    end
    always @(posedge clk) begin
        if (clk && str && sel && !clr) begin //������Ƭѡʱ��Ч
            ram_8b[address] <= data_in;
        end
        if (clr) begin             //clr�����������ź�
            for(i = 0; i < 2**AWIDTH; i = i + 1) begin
                ram_8b[i] = 0;
             end
        end
    end
    assign  data_out_8b = ram_8b[address];
    assign extra_dout_8b = ram_8b[extra_addr];
endmodule